Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50455BA6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiIPGTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIPGTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:19:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC644CA25
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:19:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso763175pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=avEn3txHBu3dTZu+mmCEsPcvkg2cCwT/97qBAx7lojg=;
        b=ec7QuVfnIZLQ88jHZoUqWHmt5Tz6VnOx+4TTQPJqAmjTWBV6Z4evvgj89nxPR/PnKv
         FxGznEljYvSw7kwOhi4jr7CxCiEY0Blo+TX/8Ta2xgp+ubxoMYeNbMGYJk4/KbQ4iAD5
         gOKxPIQg9fALFSIViKsJu6Fx2WC+d/r4/TPfMvYICGTDOiCvFQxsEMEt4suhqcN5+Upq
         vw0Easd/AnS0FnAKtSDGBcj/8in/IGWZqe39ihXqzObr5F9ZM7XmTLEexvQBMD89Ympz
         fm2GO6piOH4WnyN9IlLydw8Af0oBZngODg50dXPjoLKXsIL0X/p6XYKObS5sKeb68CnH
         C9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=avEn3txHBu3dTZu+mmCEsPcvkg2cCwT/97qBAx7lojg=;
        b=vHdkegzXb05c8VCe7QfQUgb/EGdjYlPvThEve8KGxdzP6nrn6iiof7S7tH1R/HcSVL
         ben/HSIEVX5fb8qoqMCbgS3zKp3O1yT/lKw+zP4gsC2YRBDjkxmbub4bIIjtm+8u8Puf
         bGJO6BCFqsbkjGsIfcrW9vJFNAN37jBQ+wWTXbtlbLgNQUXm6fbPVmx8PeEzFLCQ3evj
         Ygqs01I4rQonFv87i0x8+gMoQ0w/JrbWSwiLHcrRCfcCa4ma2ORBLZwgQgxaLokpqpAq
         aZbgez7Fc3iAvKA5s3pNg3SVydJ+Y3GpjWtvJJWyZZCmnI8fHgCvawZwuCrPxaC4dNFU
         qaGA==
X-Gm-Message-State: ACrzQf0hjDL1DpD3XoJWplLqKJ9waFVwuwDtFJ8bJKyaJZDhdiE1jUac
        qAHJIQDRbmFfyQlE3tGK//zpdSPQmEo=
X-Google-Smtp-Source: AMsMyM7/HKAkkyHeAgmYan5gFHmSSBU5HgXDevyu/H/LYekwOwKnnaNMciTFeBFlUC/E0cTeDOZ5kA==
X-Received: by 2002:a17:90a:c258:b0:202:b93b:cb89 with SMTP id d24-20020a17090ac25800b00202b93bcb89mr14265611pjx.126.1663309152205;
        Thu, 15 Sep 2022 23:19:12 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r18-20020a170902c7d200b001745662d568sm13741358pla.278.2022.09.15.23.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:19:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        yangyingliang@huawei.com, venkataprasad.potturu@amd.com,
        Vijendar.Mukunda@amd.com, Vsujithkumar.Reddy@amd.com,
        AjitKumar.Pandey@amd.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: amd: acp: use devm_kcalloc() instead of devm_kzalloc()
Date:   Fri, 16 Sep 2022 06:19:06 +0000
Message-Id: <20220916061906.152434-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Use 2-factor multiplication argument form devm_kcalloc() instead
of devm_kzalloc().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 sound/soc/amd/acp/acp-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index ef2ce083521e..a0c84cd07fde 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -107,7 +107,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		goto unregister_dmic_dev;
 	}
 
-	res = devm_kzalloc(&pci->dev, sizeof(struct resource) * num_res, GFP_KERNEL);
+	res = devm_kcalloc(&pci->dev, num_res, sizeof(struct resource), GFP_KERNEL);
 	if (!res) {
 		ret = -ENOMEM;
 		goto unregister_dmic_dev;
-- 
2.25.1
