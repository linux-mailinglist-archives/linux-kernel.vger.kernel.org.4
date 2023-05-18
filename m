Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB036707D13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjERJkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjERJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:40:05 -0400
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2597A1733
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684402783; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jtJ/Tz6IO+7lkwQicqTTmxDqbO432SovARFMw+VOuWtU+0t0UQphpSUXg5Wc/CrhCA
    qf6GPcggmXJjeO64rJeF9imzwVOKUPeawdchqW7eonQq2mKapIhfScbe84PvtiJ8S6er
    g412ymuRmFt4tswUKAllWejA9GAG7ZkH9+i+6GRdw15qAQFMc1Mod5DxATLoGmBGZGvl
    PjEGIJTXnoJyTHlUtFfG614X0BMNJI/lULlJvuOhtSzLkX9AUDBGQ2luttpmKbffsU9z
    IEd4JlO3vtkoePDPLRg52Vx7/qegY9UF5vEAoIaxky79RrxvIXBuOLXY1zxycVxpkxK3
    R13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684402783;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=IOUDQbsoD9/cgoVyN9DKloSCXausHFkZ914EdvgX1q8=;
    b=WGM0ZOWJbkBNoemW674n65V8xURn81X5H4s83Cx8lCaoBy210iSqFSdolTPAnGkyqw
    AONExKV84FQkv4puMAlHJGz7XVG/VsZ1nNrD6M/fZr5fKS4X/0PkBm3706fkSSA2nsqe
    09puHBejxq07JSnABz1Ws2EPnjmZ8eGzKQRcCwUUQnsoFrKd7pmOvAuR42M/z2kqb4Vd
    sLWFFwBc0JZ6XDVVC5nFddwf3C9bTJ/fGnXUrTgwbIEaM56FNJQERaP9wcv5zAkYWo2s
    G/jRPUAO9ARbKPnt9OQZJYXFBEui6ytpLm6nIWW829vPKlfvbq+rjvg96WWwEKbpYMni
    Yj3w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684402783;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=IOUDQbsoD9/cgoVyN9DKloSCXausHFkZ914EdvgX1q8=;
    b=bOO5LSaHjeyK7XFulek98Ai8jBTYBGjCACnSp+lgF5ka66X/zr1jLRePz2goSBdVM8
    eTjfwTtfbbg9k4xuK8xSEpupf157glrpilLIOLcK6JLfVimT8uIKiDwSUC36ruCSPF46
    SaX7Syq4Jr9ALiEtR+S1Wh+bxL98YOwEB05s5pVkekh+qBdrvzDwuo8TyMGXyVh2nXpt
    6BvXYWS3Bx+u72Gnfre8EZqPltqOjD4WATwLVOdw+kDaFA0ZHSUn0tinbrS4xvE/Lcdw
    a/Pzxlwn4aWVsDDQVf2WFz+pWmrAko6OxfDdBwc4YUYrZnn43XQ3XT7RZfZGS9zpWPo6
    e0HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684402783;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=IOUDQbsoD9/cgoVyN9DKloSCXausHFkZ914EdvgX1q8=;
    b=wtZn9KxrKAMnynxiDR0NvZZeQU1o+it6msuo+CKvvW8Osfkx4uZCCl65H2BwqptlPs
    6zHlGTjIH9vnH5v8w/Cw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p1/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4I9dhCHb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 18 May 2023 11:39:43 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 18 May 2023 11:39:36 +0200
Subject: [PATCH] mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230518-msm8916-64bit-v1-1-5694b0f35211@gerhold.net>
X-B4-Tracking: v=1; b=H4sIAFfyZWQC/x2NywqDMBAAf0X27ILxER+/Ij0k6aYuaFqyVgTx3
 7v0OAPDXCCUmQSm4oJMBwu/k4IpCwiLSy9CfipDXdVN1ZkBN9mG0Vi0recdY+dDtC72th9BG++
 E0GeXwqJV+q6ryk+myOd/Mj/u+wdma6LadAAAAA==
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While SDHCI claims to support 64-bit DMA on MSM8916 it does not seem to
be properly functional. It is not immediately obvious because SDHCI is
usually used with IOMMU bypassed on this SoC, and all physical memory
has 32-bit addresses. But when trying to enable the IOMMU it quickly
fails with an error such as the following:

  arm-smmu 1e00000.iommu: Unhandled context fault:
    fsr=0x402, iova=0xfffff200, fsynr=0xe0000, cbfrsynra=0x140, cb=3
  mmc1: ADMA error: 0x02000000
  mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
  mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002e02
  mmc1: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000000
  mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
  mmc1: sdhci: Present:   0x03f80206 | Host ctl: 0x00000019
  mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
  mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
  mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000001
  mmc1: sdhci: Int enab:  0x03ff900b | Sig enab: 0x03ff100b
  mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
  mmc1: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x00008007
  mmc1: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
  mmc1: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x5b590000
  mmc1: sdhci: Resp[2]:   0xe6487f80 | Resp[3]:  0x0a404094
  mmc1: sdhci: Host ctl2: 0x00000008
  mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x0000000ffffff224
  mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP -----------
  mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:  0x60006400 | DLL cfg2: 0x00000000
  mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:  0x00000000 | DDR cfg: 0x00000000
  mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88018a8 Vndr func3: 0x00000000
  mmc1: sdhci: ============================================
  mmc1: sdhci: fffffffff200: DMA 0x0000ffffffffe100, LEN 0x0008, Attr=0x21
  mmc1: sdhci: fffffffff20c: DMA 0x0000000000000000, LEN 0x0000, Attr=0x03

Looking closely it's obvious that only the 32-bit part of the address
(0xfffff200) arrives at the SMMU, the higher 16-bit (0xffff...) get
lost somewhere. This might not be a limitation of the SDHCI itself but
perhaps the bus/interconnect it is connected to, or even the connection
to the SMMU.

Work around this by setting SDHCI_QUIRK2_BROKEN_64_BIT_DMA to avoid
using 64-bit addresses.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/mmc/host/sdhci-msm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8ac81d57a3df..1877d583fe8c 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2479,6 +2479,9 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
 		msm_host->ddr_config = DDR_CONFIG_POR_VAL;
 
 	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
+
+	if (of_device_is_compatible(node, "qcom,msm8916-sdhci"))
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
 }
 
 static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)

---
base-commit: d4ebc9419afbac330e9ec0d2936108742aa4d97a
change-id: 20230518-msm8916-64bit-f5bcf6af7679

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

