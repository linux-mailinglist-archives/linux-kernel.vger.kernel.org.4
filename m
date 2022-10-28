Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C24610A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJ1Ghb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJ1Gh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:37:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC1419C06C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:37:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so2863189wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YB6oy9iPyQ2yGCx//M3l9HQNOZr7fMRdXmEHN9vRGxs=;
        b=ezCj8/pgbobEx97CDTJE8wIGRua7WNHJQfvq//ylU1KfxosyT8seGSaf6ThKBvPq9T
         F0YFLmtTHQlSceaoFI4PsTxZC/AJD/7s/ImXMxsTVeZ/xNcTjPSNOO5CY5AKoSwv9dnT
         Syjo8scfL++LpWrAp+KgxGjnda4fdytYDOORZ2GOpkGZSRff06Kd+Yzr5StN59W8MFm/
         DsSH6v4wTsiES4x8/4twyFmgqL7XqMyKufwizOdLt/uga6VvrttVWT+29OerYoVWWrp7
         prZ7wDb8PfwKQdfS64NVEaOjepOnxBS+TTnTG+yJNkX72g/H/5V6O2Vc75GiDKqYR+g7
         Bpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YB6oy9iPyQ2yGCx//M3l9HQNOZr7fMRdXmEHN9vRGxs=;
        b=AdHiBuBJ7lNuaBWc31BsHQrsp7in5KAEsNrE5jtbkvKV5jOFc1ib1LiWE+y4mJrE4k
         I8C37WMHYk3FnovjKlFvH0UnPGImZJ8kfjKGHDEWWDAgbAhOCOFRpHi9eoFlmvWHI0j1
         F11jmZLUMG2q/bC5P2FduqONmXB0awx2tsK4eOmTJI4jwkep0dTrIU2HpIpZU/NeH9os
         gJNERt5RKhqD1M7m9TRqRvBKBuZR6RKuoyIPZ1obTa8xB9q4wCLf1KHYUMMpYaTDSEA6
         7PMCknpj+UZ+PsvnPoHsj3ifTpUQduBpDjF5jp4W5YVPikUTl/tTQ+ysZXBGNKVRxLyi
         VHHQ==
X-Gm-Message-State: ACrzQf2SC0N/byDmgQDqNfbeL/XUNWlPYZDsnf9p2ZfeU+4T2ULfu4De
        q3KQQ0o5jIGVTE5BzHIW9A8=
X-Google-Smtp-Source: AMsMyM4M7GKIug3hAEXg65ElbagdSwb96RaEvcC5UiLOrayiTaiYvA03SiL1oDMMDZwG4Oz+tQlvKw==
X-Received: by 2002:a05:600c:46c7:b0:3c6:f3e6:1f13 with SMTP id q7-20020a05600c46c700b003c6f3e61f13mr8231687wmo.62.1666939045369;
        Thu, 27 Oct 2022 23:37:25 -0700 (PDT)
Received: from rdm ([41.75.189.203])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c26c400b003b31c560a0csm3218041wmv.12.2022.10.27.23.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 23:37:25 -0700 (PDT)
Date:   Fri, 28 Oct 2022 09:37:11 +0300
From:   UMWARI JOVIAL <umwarijovial@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH] Remove Unnecessary typecast of c90 int constant
Message-ID: <20221028063711.GA35659@rdm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Linux kernel coding style.

Reported by checkpatch:
WARNING: Unnecessary typecast of c90 int constant - '(int)2.412e8' could be '2.412e8'
WARNING: Unnecessary typecast of c90 int constant - '(int)2.487e8' could be '2.487e8'

Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index fdf867a5dd7a..4fc4fb25d8d6 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -41,8 +41,8 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 
 	/* if setting by freq convert to channel */
 	if (fwrq->e == 1) {
-		if ((fwrq->m >= (int)2.412e8 &&
-		     fwrq->m <= (int)2.487e8)) {
+		if ((fwrq->m >= 2.412e8 &&
+		     fwrq->m <= 2.487e8)) {
 			int f = fwrq->m / 100000;
 			int c = 0;
 
-- 
2.25.1

