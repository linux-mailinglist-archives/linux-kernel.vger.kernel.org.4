Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD56C51FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjCVRO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjCVROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:14:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39F63BDA2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:14:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b20so42918628edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505290; x=1682097290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5yXLlkqZjanh8KqT4LvmjNz0D0TSKdSJZ7tz2Svtzk=;
        b=oJLTd8fI9szo/ArYmHGfkghADYvD50mkT97sMs/nDa3rKdFQ3Ymptg4shDMr3Evrip
         c/2gaRQ52RplMdiKqBKVroalHbiVat1eP8k7Fjor3RPgL9Fw5q4LkT1MSzhMDpG2ylQb
         HLxLTbAAQ0F46R844UDpap7Qvz5UfRWJtltnxO4lQ39Bybu+e+H5zIhrUa68+sKJPSgQ
         eSNIR8c00mBrvR5sVWjl+xTW43Tt4j3K3dfPNj8r/1jOF7zuDr1PMM9BGfpxhSJoFLGX
         9u5S+a2VK+d+QknW/G3a24BQfhahv8jfvnTDZQtRGzEK1+SvKaYjnQFqC7+NSp2Wxm30
         xCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505290; x=1682097290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5yXLlkqZjanh8KqT4LvmjNz0D0TSKdSJZ7tz2Svtzk=;
        b=L3kxEauiE2gv35oRxmLqNiVnmuAUDIoiSGeSL4zoS4SIINTgJhSUTXANex0rpQQXPX
         LgN0CkUcNP9sjivHdCsMyIZkmq4taIyFoyxi/nOO9SKip580iBPMoYcBQjsk/y/7vxLg
         eOn/JMMzrW0R6lwLaMRGbsIO6Yx0MDSV1kZbclEt9UKWMUavuEHdvqIAgo5EGbNx5fbM
         ZBQdHzcjzQ+xwUMQjZtDSl+V07ECtAA9gVYlnP8644R1aRioPrWMeIE54zGLJAQgbfxj
         2iV836JhFqPgKTUvShsYwLsqzWWn3sGgg2hgpsLCm5eK8hxLrL9Tn9PhHTpdVPd8vg7G
         Da6w==
X-Gm-Message-State: AO0yUKXkEeAGwBuq1OuEwKz/NBkzSdLCbJZO1+Y2+pwLl8TF4jTm7YK/
        16CABM7KCrNZgiGE8+ZObrk=
X-Google-Smtp-Source: AK7set/6G4WQ2yF5e0YfTFolmbs6T+2hHmWTQFupI20p/baBDuQ7Q2eOLOQoxQeg4OEhRFe3RhRS4w==
X-Received: by 2002:a05:6402:2803:b0:4fa:6137:cbf2 with SMTP id h3-20020a056402280300b004fa6137cbf2mr8442724ede.1.1679505290403;
        Wed, 22 Mar 2023 10:14:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id x21-20020a50d615000000b004bb810e0b87sm8096916edi.39.2023.03.22.10.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:14:49 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:14:48 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] staging: rtl8192e: Remove double defined constants
 bMaskBytex and more
Message-ID: <3f31664d8751ebb8b78cbd7d019f002fb2ba4c3c.1679504314.git.philipp.g.hortmann@gmail.com>
References: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove double defined constants.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Changed subject line to be without ..
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index fd34756e450f..498da6be3e4e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -25,14 +25,6 @@ enum rf90_radio_path {
 	RF90_PATH_MAX
 };
 
-#define bMaskByte0                0xff
-#define bMaskByte1                0xff00
-#define bMaskByte2                0xff0000
-#define bMaskByte3                0xff000000
-#define bMaskHWord                0xffff0000
-#define bMaskLWord                0x0000ffff
-#define bMaskDWord                0xffffffff
-
 void rtl92e_set_bb_reg(struct net_device *dev, u32 dwRegAddr,
 		       u32 dwBitMask, u32 dwData);
 u32 rtl92e_get_bb_reg(struct net_device *dev, u32 dwRegAddr, u32 dwBitMask);
-- 
2.39.2

