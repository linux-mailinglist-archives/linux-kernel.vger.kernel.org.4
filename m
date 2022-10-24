Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89A609D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJXItr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJXItm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:49:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787119C20
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:49:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id jo13so4296960plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnolCiMBjl8qX8ASTYaNnJALNGKZaQCXHfWumAnTsTM=;
        b=gm46cR8stv769f/3qrG5mY89pnjak1s16VZzjmmrodfvPJ0t1TxqRTEAzeUemmns9O
         zl49OqL3wnKxo6MhOV53Hnaq/lS0cldqq6ZxQdBjruuvkO52R4OZxw4caNmr3CXA0NAO
         uwLvJoeEtsXEvJjjeJCZ3RSf4ZW0i2GHnp38JwbWol8Ppeo9mPzeXdbFARvpOrUaCzR6
         j2cpfxE4W97id6cWrjzpIafnfIR49aaRHOFXcQXVQ0xyIRJPAAHGZ3dX46E+gTSg2uFU
         h1vyQtrt5bfWPK6NlBlPC1XIILP4TFTWH/+DaN4nxJbOt+fvEdapGmM3rSxprpdyouFy
         Z/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnolCiMBjl8qX8ASTYaNnJALNGKZaQCXHfWumAnTsTM=;
        b=6C4hXNpNmVJoGiyrIN5mK+N6F3R2yo9t1k4tEHV/+UE+w/aEogAJM4SZQGVVwXshf3
         9udjY67M4/a8r7bZmFzzWgw6zcyVRKkgUzGTdNS/TIuhduKFFClQOvR7FcCNkfr4pdJC
         NkLM+pj6QnNlcB5D5FXq9z6QEkE1cFbarvN3A5jqNYELdWnkJm+OL9cqHM4BqfoTe2W8
         OHB7ZYnU3mbB211SWRfiRy3T6ief8cRWEltM/CkJPexbAqaimJBZIgtatFck9TyDl/pq
         dUUokNK2FFp3aI72/lCmS8Zt3nv2yN407Pt0KnimtgtPmkt3sB6N2yoxr+7LKwaWNAKb
         0PSw==
X-Gm-Message-State: ACrzQf3Frj2RuL0ldLR61xvfy1NMXWHfT+1i5mHqcl5YIaqcnWvwPVvL
        MTj1Rq5FZpm7Cz51AwaNoFw=
X-Google-Smtp-Source: AMsMyM74znPayAddrI2+CSTk5wXaI+z62KCXc9qxsLsYFeyzdCfgZMKIK3SI+7qWwF4sMamU2Z/qhw==
X-Received: by 2002:a17:90b:1804:b0:213:1a9c:5ae with SMTP id lw4-20020a17090b180400b002131a9c05aemr3094555pjb.81.1666601380700;
        Mon, 24 Oct 2022 01:49:40 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id r2-20020a63a542000000b00434e1d3b2ecsm17245124pgu.79.2022.10.24.01.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 01:49:40 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v2 3/4] staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
Date:   Mon, 24 Oct 2022 17:49:24 +0900
Message-Id: <20221024084925.262289-4-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024084925.262289-1-tegongkang@gmail.com>
References: <20221024084925.262289-1-tegongkang@gmail.com>
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

