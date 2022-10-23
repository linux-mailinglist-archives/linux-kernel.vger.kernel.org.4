Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E046095FA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiJWUGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJWUGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:06:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D082F5F9B6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:06:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c24so6850591pls.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnolCiMBjl8qX8ASTYaNnJALNGKZaQCXHfWumAnTsTM=;
        b=iYtagsbcU/h0TyJgU4pXRWZSC4sr8vpuy8Tn3ao6ioil6LBbPMIzwZjGjaql/4vVbz
         RiifYv5fBiYrgFc2P2oWJNn/T+vBIVqf9FQc2fNCXMUXL7a6o9BW3G5L1Ql44Ha0MGLi
         FbKjRmtpeIXFP7IadMrxTXTjIV8Ynbz9pHSjvcUm3eQ7AbO6pEVF5+uC1qtCcpo6RidW
         Eq8HzFkUQ612Z/sF9GTYbaav5q06ZkNwUyqWAocx4IUOBRaiim7t7lJQVzvMzDsDxf/1
         ERJsClRVDGY6LtbCSYHTmLftNqyPr+yOUjfpPJloS3RqHW77xMTLz9FR+dRTjcg/cSMf
         RsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnolCiMBjl8qX8ASTYaNnJALNGKZaQCXHfWumAnTsTM=;
        b=Iztkf1WcACF2JSemwGkU9Jc0Wv0JSeFV1bNfq7ySvDiEf/EjFClXKfaefJqmpB7ckZ
         Z7RsL6Hvckj5gRixTQTTvXvFNC3P3oOKyBE4JGj3zerycPN6XM3x9OQIcWGfKDQIGHua
         2x21tLkbMcKMIvrbxIg6JtiVhfjPBXrNIDiNxphycT8meoZndwSj1MXKsfjUuLL2UZ46
         qeA3FI1mnOepkystp/DvSyGCaj2xS1Cqr4zEnmymDvMnKsBUDCJ6379JBSY9XzCblbAe
         lHvmObp5sPyeKHLGpI5KW5u4E5YWvVKR/8MpNTSb8aeVJmtcxKtuWULak20eGqWf+Yyi
         Tdiw==
X-Gm-Message-State: ACrzQf2GAYNw77KHjOptgEwG5TM4yXWkoiO6tNZc78lH51j8Rz/dmLo1
        r8w3Z0r644Cf6xcX/uGaZaM=
X-Google-Smtp-Source: AMsMyM75nzS235WrzxnOC5yv0x+K2rUHyGvTa2pFF6tigetffeJ9YCziWFB/NGTfaSQAq+/Z4oMfQA==
X-Received: by 2002:a17:902:f786:b0:180:6f9e:23b with SMTP id q6-20020a170902f78600b001806f9e023bmr30930599pln.37.1666555558692;
        Sun, 23 Oct 2022 13:05:58 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b0056bc0578c7dsm1130649pfm.110.2022.10.23.13.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 13:05:58 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
Date:   Mon, 24 Oct 2022 05:05:31 +0900
Message-Id: <20221023200532.259276-4-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221023200532.259276-1-tegongkang@gmail.com>
References: <20221023200532.259276-1-tegongkang@gmail.com>
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

Return 0 directly instead of storing it in a variable.
This can prevent cocci warning as follows:

  Unneeded variable: "pull". Return "0" on line 298

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 8e4a5acc0b18..6d1f56d1f9d7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -149,7 +149,6 @@ static void fill_txdesc_phy(struct pkt_attrib *pattrib, __le32 *pdw)
 
 static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bagg_pkt)
 {
-	int	pull = 0;
 	uint	qsel;
 	u8 data_rate, pwr_status, offset;
 	struct adapter		*adapt = pxmitframe->padapter;
@@ -295,7 +294,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	ODM_SetTxAntByTxInfo_88E(&haldata->odmpriv, pmem, pattrib->mac_id);
 
 	rtl8188eu_cal_txdesc_chksum(ptxdesc);
-	return pull;
+	return 0;
 }
 
 /* for non-agg data frame or  management frame */
-- 
2.34.1

