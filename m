Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72EE61520E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiKATPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKATPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:15:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D0318344
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:15:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ud5so39571966ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bh/vb258a85waAX85aoxt5/0nDK0TrUQ5LPFD52UgPA=;
        b=Lu9O3ACO2fkVQQg7P2DynITZmIloWlIb6e4XM3rcu3PeX/Su5aPDqY/R24Q3r4H3Fq
         N8nUkdA1MWtb9iumVDOwCy0PTzDRp5uBhLrFt8tAG8shZ2eErCYvTDyHPf8Puq+iIpBL
         a3dO3DbUCNc7OSu9OTLcybcCfM/tFDeQSn/9RqCAconcGd8GbN3P7zW57HkOhDT6ZVE8
         qeeGuz7QpwsauwT8+Bm/tMXvN8CK9tHxFL0a4C1XcfVy6qM/3jDdQIyX26/5wCzv9Ejc
         FcQJF7d5hbDut6lfeS4Ye8Wa/B0mlkKmhUAXZckDvy8m3h3lOU+MpH7tkDxarocyey4l
         Wu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bh/vb258a85waAX85aoxt5/0nDK0TrUQ5LPFD52UgPA=;
        b=y5BK4fD8IOBPo5MX2+U0VcVfhbU0UVC2nKS3mMlA06fR2nf8TqjRZVtBKARGMzNl3b
         C9bIRkcNVNTMVmWfnZ8bLTh4nkUIfwCojHASExXIVHTUQZyG7qWlI63h6pM5T/WOc1yt
         arWvl+/mWaqwy3hbIdj8ZdvvB9pZfyVdCdSpmpNTv9TW+ORbHvimoRPeZ/b9/UNZ+z9M
         iyXpOYspb8hgh62LCDk7PmIzS7MMinmPWzV3/8whVN9tpQ1K6SbMpxtOqA5zsMLFwP/s
         IYXpnmqmQWGzxecvAcBaq70xzVZlVH7L63QxXD8sun5Q3ke0SewbkMncad85VT0hvYyj
         3JHQ==
X-Gm-Message-State: ACrzQf2PzO2dj6/0gzDsm693ZxJRl2/eYbtP9Mn7jLdiHmwzepGeWsWz
        wJ92wcz0MFvTEHjlk28MoSg=
X-Google-Smtp-Source: AMsMyM4a2dWzxMe/fpwr9NVsBr+fP6KZUEpMJTIJORIBfVkUzF9XIw97i+WhqhbR3qJRGW+jv1svyw==
X-Received: by 2002:a17:906:db0e:b0:77b:82cf:54a6 with SMTP id xj14-20020a170906db0e00b0077b82cf54a6mr19470626ejb.691.1667330103172;
        Tue, 01 Nov 2022 12:15:03 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb7a.dynamic.kabel-deutschland.de. [95.90.187.122])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b007ade5cc6e7asm1643853ejc.39.2022.11.01.12.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 12:15:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: two simple cleanups
Date:   Tue,  1 Nov 2022 20:14:56 +0100
Message-Id: <20221101191458.8619-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.0
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

This series contains two simple cleanup patches.
Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (2):
  staging: r8188eu: remove extern from function prototypes
  staging: r8188eu: convert rtw_free_stainfo() to void

 drivers/staging/r8188eu/core/rtw_sta_mgt.c     |  8 ++------
 .../staging/r8188eu/include/osdep_service.h    |  2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  4 ++--
 drivers/staging/r8188eu/include/sta_info.h     | 18 +++++++++---------
 4 files changed, 14 insertions(+), 18 deletions(-)

-- 
2.38.0

