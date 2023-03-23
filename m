Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B186C6933
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCWNK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjCWNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:10:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E028A5C;
        Thu, 23 Mar 2023 06:10:47 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32NDASFF042529;
        Thu, 23 Mar 2023 08:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679577028;
        bh=E2LsplN8mOoLliilNxa+eaPJXN9cMAgbcbDytf0S5kQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gv8JkLnJ0OPd3Zd/nVNcqctUpRa51iLkca5doJrCrjfdbC1ZZ6XwoRNThzQJVjnag
         yh5Hu4kjYoGSzopeaj96dJMYSUmMKa5IvyQlLKwQN1ybldQVSwNe/vflyYdzEfjl/5
         37vftJ7OwyUPoebhY31B/Hwn7iYYG4uSx5rfTwPs=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32NDASVs086934
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Mar 2023 08:10:28 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Mar 2023 08:10:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Mar 2023 08:10:27 -0500
Received: from [172.24.145.199] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32NDANu3017791;
        Thu, 23 Mar 2023 08:10:23 -0500
Message-ID: <01bb42f4-45c0-baba-6b9b-6ca874dc09a2@ti.com>
Date:   Thu, 23 Mar 2023 18:40:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 1/6] arm64: defconfig: Enable audio drivers for TI K3
 SoCs
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
References: <20230313-mcasp_upstream-v6-0-77685d7cbeb8@ti.com>
 <20230313-mcasp_upstream-v6-1-77685d7cbeb8@ti.com>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v6-1-77685d7cbeb8@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai,

Thanks for the patch.

On 15/03/23 14:33, Jai Luthra wrote:
> TI's K3 platform uses McASP as the digital audio interface on the SoCs.
> AM62x and AM62A based starter kits also use the TLV320AIC3106 codec with
> a 3.5mm jack for analog audio input and output.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7790ee42c68a..7e0ce1833904 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -898,6 +898,8 @@ CONFIG_SND_SOC_LPASS_WSA_MACRO=m
>  CONFIG_SND_SOC_LPASS_VA_MACRO=m
>  CONFIG_SND_SOC_LPASS_RX_MACRO=m
>  CONFIG_SND_SOC_LPASS_TX_MACRO=m
> +CONFIG_SND_SOC_DAVINCI_MCASP=m
> +CONFIG_SND_SOC_TLV320AIC3X_I2C=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD2=m
> 
