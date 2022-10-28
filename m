Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC64611A06
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJ1STD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJ1SS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:18:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93091242CBC;
        Fri, 28 Oct 2022 11:18:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a14so7663363wru.5;
        Fri, 28 Oct 2022 11:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTd7QHpRwaFlwM3D6sCRxq+myWnOhn/dTLU+GwmNwfk=;
        b=itB+P1b1zBZGfDEpZN8M9NNhLm57lG05jZqTWw+FVQ7ERHFIP62aeSs+hLS8U2D+Oh
         uItUtbTv2mgTAgRrb0VUeL6Vm1yjEbB4mxTQOBlb0+KjC+vzrKkLpbSHDJDfdcMWqhe8
         8LxQZtrKl/cVRPF78JYHiGkz4IkvB1eir6kAk/bhpk5+kLcfg5zemUQhK1hTcvt91Xyi
         T8PZpQEqoWwjmysDQU0LgAFvGQlM3XF0CRroq7BfBGVTp8Gz52nu34g/73Tf8SVr1rvt
         OsG1Ciri2xVHoS7GxLP0PuMSP75eQXyGDNfedxXg63MMLCkDGT1aJubJ7YMke0oJpqwW
         aNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTd7QHpRwaFlwM3D6sCRxq+myWnOhn/dTLU+GwmNwfk=;
        b=1j8/z/FR4UzPFiYQGid8s0PJzpX4jnLUhwpCQ8SMLuk0QdbWVnpok7JHNCg+N/y1Wf
         Lfn/3VbdblbEzHXaD3ijnlDnpo/87wC2SOfMoYfFoJQ8x5DCfqACpGXY08eAM892Fwkz
         Z/XpGHazwV/8rOiIief4wq1iq0gn+nPvT4hSaC+Sxf6YCjPGfB2jKDLVwYsB9tjAQCst
         RsR5EGn0MnZGg9nHL0XmcSnv/AMRK5q/KDFQIH5Lt5/awZbdCy9XhIXDRgQrgS+PjnrF
         b4k396lX85zYpw7r9e2C9PRUShkZ61TofZktnBjZvCXuHkBxHWKvGS+P66EysxNOAg3X
         10xw==
X-Gm-Message-State: ACrzQf0tm1EATSRYMwTVWRNIYXEVHnIljTE5/AXeFtFcWAlgvL/zTIQg
        f9Yd6Bx61lpb6zl7syg14nU=
X-Google-Smtp-Source: AMsMyM76JTY/PtQ3imnoTKBLTf988R7i0RUukewLRwDKDKIC7zqHN2Vh+67mMrM2aEjgavyIf2WcJA==
X-Received: by 2002:adf:e3cc:0:b0:235:95b1:2124 with SMTP id k12-20020adfe3cc000000b0023595b12124mr380838wrm.693.1666981134010;
        Fri, 28 Oct 2022 11:18:54 -0700 (PDT)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id iv9-20020a05600c548900b003cf483ee8e0sm8689221wmb.24.2022.10.28.11.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:18:53 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        chad@redpilled.dev, davidgow@google.com,
        linux-input@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/1] HID: input: map battery system charging
Date:   Fri, 28 Oct 2022 20:18:48 +0200
Message-Id: <20221028181849.23157-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This patch adds support for reporting battery status (charging/discharging)
for devices with a charging usage in their HID descriptor:

	0x05, 0x85,         /*      Usage Page (Battery System),    */
	0x09, 0x44,         /*      Usage Page (Charging),          */

I tested it on Apple hardware (mouse, trackpad and keyboard) as well as
on UCLogic tablets with battery [1].

On other hardware (HID_DC_BATTERYSTRENGTH or digitizers with battery)
discharging should be reported for backwards compatibility.
I did my best to keep the old behaviour by adding KUnit tests; However,
I don't own any of those devices, so I'd appreciate any help testing
the patch from someone with the actual hardware.

Best wishes,
José Expósito

[1] https://lore.kernel.org/linux-input/20221028082348.22386-1-jose.exposito89@gmail.com/T/

José Expósito (1):
  HID: input: map battery system charging

 drivers/hid/.kunitconfig     |  1 +
 drivers/hid/Kconfig          |  1 +
 drivers/hid/hid-input-test.c | 80 ++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-input.c      | 36 +++++++++++++++-
 include/linux/hid.h          |  2 +
 5 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/hid-input-test.c

-- 
2.25.1

