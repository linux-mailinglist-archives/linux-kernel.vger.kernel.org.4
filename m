Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413C0609D19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJXIti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJXItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:49:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C73711834
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:49:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pb15so7611264pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+s6WZgeKaPfeQHcekkW8Ox7ZRAZvlVZ2Z557UTtxdk=;
        b=Xjhv4+BfmtiQqKzLdyZt2chX1y1vr6iFD9xqFMS0L2XzozrhputSf+9xH6/p1YmSrr
         BnaUeuXuVCRFZj8UkEzeiQQW9udTbSuMGqQhIex3q2rCrT5rG6R8Bee92gySstNkxPz3
         PW2O25T9O+k+yGOCA7kMbpQi9s3z61l/RSwkqxgXO2cld6aA/m+TEZLiD6sroVcrjyD5
         oBcBzYORhP2XZWdSeSOPkboCP5v1vs0cJ/1ffJRN/nOjrSw4K7MUdoZVk2wWEPF7s528
         6SXvArfkBTgke1X2vd6H4DzmB7wEZLtPk9sH77TpZUiRpZRpl0lA+sThvrmSJVWRGRsj
         S7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+s6WZgeKaPfeQHcekkW8Ox7ZRAZvlVZ2Z557UTtxdk=;
        b=O/80X/qw2hM0MiXEGid4uRZg/Wye960ZEmEaiBS25w9mYk8P+zFbG/1fB7ab0FP7AX
         kNfLXrsX01R8XIndJGgUL6xzkD9/iaQGCo8nLD/Qber1tjOyMQO444qIy9dz8O/NMYf5
         X5IlYGN2pLy1RW/bemStZFSYEIpIuUOWSLJZG1UjoR0MvpDxNEd/gu7oCjMQ/Swq4I03
         3HDhY+0q4Adr4Obsxah7MGiI+1d2CIVTuahog3MOkmtUL4hvZtmmeC9yifBstnNq5KSU
         BMgxmPnhIC3en0zPRNjBEsLkOEQcuTls25TyFxf9k7le1TzQZbiY0aOAtNW6OFW4Krjm
         vVmA==
X-Gm-Message-State: ACrzQf27eFBXdgH4dGtv3XMel1PYO+mhB1sLewmuyxIWfkyJoBvhAKZ8
        fY4CJpWUVLOzw/wRU9VpaPY=
X-Google-Smtp-Source: AMsMyM4jDEauWeYK6sBISqpDmbUgxT9fVFb1s3oYUQOqMjQoJn/OyABs8Xkk17efbv3H4Rg4hG6F8Q==
X-Received: by 2002:a17:90a:3e81:b0:212:cc3c:b02f with SMTP id k1-20020a17090a3e8100b00212cc3cb02fmr20029696pjc.67.1666601371746;
        Mon, 24 Oct 2022 01:49:31 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id r2-20020a63a542000000b00434e1d3b2ecsm17245124pgu.79.2022.10.24.01.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 01:49:31 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v2 0/4] staging: r8188eu: cleaning up unused variables
Date:   Mon, 24 Oct 2022 17:49:21 +0900
Message-Id: <20221024084925.262289-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cleans up unused variables in r8188eu
causing coccicheck warnings. 

Difference between v1 and this patch is that this patch series
include making function amsdu_to_msdu in /r8188eu/core/rtw_recv.c 
into void function.

Kang Minchul (4):
  staging: r8188eu: remove unnecessary variable in ioctl_linux
  staging: r8188eu: make amsdu_to_msdu void function
  staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
  staging: r8188eu: remove unnecessary variable in rtw_ap

 drivers/staging/r8188eu/core/rtw_ap.c        | 5 ++---
 drivers/staging/r8188eu/core/rtw_recv.c      | 5 +----
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 4 files changed, 5 insertions(+), 12 deletions(-)

-- 
2.34.1

