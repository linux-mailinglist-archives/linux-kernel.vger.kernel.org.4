Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E954474323C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 03:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjF3BaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 21:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjF3BaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:30:03 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8562A10E7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:30:01 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a3790a0a48so736914b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688088600; x=1690680600;
        h=content-transfer-encoding:from:content-language:subject:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH4/y2LSJHZ45tBS8eyMfxFly0jF8FdgN1u/o33Nak8=;
        b=m1WhbWyRNpyjj+d9E7ZIg9M+peEbumHIv6ZHuSk5jpRcwHppLhtnOTcw/eCwqi4RFd
         b2Vf8kUOUqQch4xjBLLduEbl5GQURjnyquTk68gpUoO05NkIKxZuiOV6Oq1TXSIELQ2i
         ltP/M+9S3ZiVNAHotpkiN8e/Ap5NKb9rWDR7IyORy86ju22j0ri1l0sKUOQxxZfnPOnR
         ItcBeDwwigWTnMzNSyAsnJvbbzvBOSmpcqvw7L0CZTPGI8NO8feE4Jgip0DkgVSR/mva
         18Ji196HCLOjIuVDx8mZ+HHRBx9w47aj0zBblTApzsCqUUZBmhoVtDIZMjqN0mI63MkW
         KtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688088600; x=1690680600;
        h=content-transfer-encoding:from:content-language:subject:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HH4/y2LSJHZ45tBS8eyMfxFly0jF8FdgN1u/o33Nak8=;
        b=lPBOh91jZ1DU3q6QD9eWRw+qPwEYgF+kPFP/5cLQ/gurvUkD21qijgumebOE6b3Q/e
         Pj/iJqsyHeIvANdSC7HYZymhtdLfp6OydcipEFRBpKliVPH5I35sRQVX/1/D8bgjT8Q2
         pK7Zl6hkEVnoreR9dCKB2RUojzQNcPKNsllJyXMPCXjNi1tKELxCFmSXZLrvWslNi2op
         zNyTgBX0xPU2sWzt9vOzBvl5C9PYSply7iLnpj0UhGWoWoN+MCbp0wF6AUHujXW0lTkm
         q/Wk8O5+OhWTZPEEoQ1C7Vl1xtcJ12yIyy8hNMOYxJgBE/HzsYCE2W1weedE6s5ldEga
         DsJg==
X-Gm-Message-State: AC+VfDyAG7GH98qEvrqTWu8Ypx/FnOYSIf/tfcUhq8UpXCQtPECfQC4F
        nOxjTyIqqm9w1PQ+BmB/cixguQogMwrulg==
X-Google-Smtp-Source: ACHHUZ7PDwpg/HotI/JcFg2jmsMj8b7cZuzhgec904kWZwPD+/wX/dQGLFHyh4H5zOP5p61K46fvYA==
X-Received: by 2002:a05:6808:10d0:b0:3a3:65a8:c12b with SMTP id s16-20020a05680810d000b003a365a8c12bmr1422196ois.49.1688088600431;
        Thu, 29 Jun 2023 18:30:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:36d0:2460::1f? ([2600:1700:36d0:2460::1f])
        by smtp.gmail.com with ESMTPSA id z6-20020a056808028600b003a1f1f48d0bsm3380556oic.44.2023.06.29.18.29.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 18:30:00 -0700 (PDT)
Message-ID: <35a40ad9-19f9-f072-acd4-dd5e51ec062f@gmail.com>
Date:   Thu, 29 Jun 2023 21:29:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Fix 2 Acer FA100 NVMe SSDs from interfering in one PC
Content-Language: en-US
From:   Christopher Lentocha <christopherericlentocha@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In order for 2 Acer FA100s to work in one PC (in the case of myself, a
Lenovo Legion T5 28IMB05), and not show one drive and not the other, and
sometimes mix up what drive shows up, these two lines of code need to be
added, and then both of the SSDs will show up and not conflict when
booting off of one of them, since if you boot off of one of the SSDs
without this patch, you may randomly get into a kernel panic or
initramfs if set up, else if you do merge this patch, there should
never be problems with booting or really anything at all.

Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48c60f7fda0b..4bb521a6b68f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3427,6 +3427,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
-- 
2.38.1

