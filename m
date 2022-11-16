Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8362CB40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiKPUlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKPUlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:41:18 -0500
Received: from smtpcmd0642.aruba.it (smtpcmd0642.aruba.it [62.149.156.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08CBA220F6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:41:16 -0800 (PST)
Received: from [192.168.50.220] ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vPDfousiuEclovPDfoJfGd; Wed, 16 Nov 2022 21:41:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668631276; bh=ua4Hct9zgOjT9Ac685aAx6spkrDlHZGn59ZRs5eaYP0=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=jKjnFGcRyeZJ8+3/LauE7ThKXsIBtvJmfbj4n020e6kUu7hTuyMnqRCUzQNvd/pnR
         bSZkq6vBJfJRQANaxJrD3tQW1A2Lt2HOjI/tAuyOn8QY06Ol1UEUywS/rdEGQGZzU4
         ImexpHOdcsVfJqNePa10tSkhRwneJXIxbiGiF/I8sYMBJPj21ccpu+kPOSVQcYP3yC
         HW6F/fS1u/xrL9NYFt2U2KrX915YywKvEugziM6jtfwvByEt+lUZVY7rNzRrbig+I5
         ceHelVRPgWOfmRndQ9QhoRKl2xIeXS2/V220Z1jqnAT4voGzm/NES+MZNV/BH054Hv
         mhazheT2kGAcA==
Message-ID: <3149ce35-14bb-7df0-b578-b426b8e365fa@benettiengineering.com>
Date:   Wed, 16 Nov 2022 21:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/4] ARM: dts: imxrt1050: increase mmc max-frequency
 property
Content-Language: en-US
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>
References: <20221116203520.8300-1-giulio.benetti@benettiengineering.com>
 <20221116203520.8300-3-giulio.benetti@benettiengineering.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20221116203520.8300-3-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPVpncSEOCCHpzyD8TvUG1v+Q4+0n/jgcG/RkU/q3r1jBC4VIBiGT9ANThQyvIMtxM6agnBjalzv3sYR8xWmpVtvKfyAY4J3+DdPF28FhLW3D73/x2Jt
 WbCypBvZfIg+inE5SunvSuoHSmfhG0Rbh/Wrj+Qv35iXBWwRv0Hf37gNyceMvoM0jVB69kkdHJfqXEOESDjg2MDA32vJCmMp7j5WeT1S7HWMaihZZkqaSGts
 7kwmbtQ12auHH05PgI/iy3lk/gXny06MupIirDs73nhokfbfljAK1j8NagcuilFySOrzPYxonBDcBkRjiVV/TIgA1wG4D3NuEYatNBPmgPfSBCtkiVHuDa8K
 gZqGJIXvWTNviNG+wf0jkHcvBpgQKBvrLYX8udm/KrfYwl/yzOsY4Ey12gIKFaIRHjEpRkvZc1gPHoIThxPUjakg5uepFD5HNYtiBR9Rt1WJze8mMgLdiPGj
 H2nuauIp4KhOmzRyxd5m16wCWTF6CVIrNnd89HoerhOWQdAYuJ6+n5vOjiymaHrNl34SRk7WW/RpVQ82XJKftuNYkoZtxnnilMyp48FFRpkpJ9CTV2+kvimK
 EGOUXJnUhP4OTljepZ5QPT4cGisKGKYH7HZma2TjHj9XfZVIM9qYRvNBwKlbel4S75WYkDoAM60C1W1aCRZ+VJoobx/usJW+m40/MkamtuzSJs9c7CThBjuW
 H4G5lsOy0+4BbUt7kOnzU4G6tI1J7dXcIRBA6f64dLmmytAMquRoyw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/22 21:35, Giulio Benetti wrote:
> According to i.MXRT1050 Datasheet usdhc supports up to 200Mhz clock so
> let's increase max-frequency property to 200Mhz.
> 
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Acked-by: Jesse Taube <mr.bossman075@gmail.com>
> ---
> V1->V2:
> * nothing done

Pardon:
V1->V2:
* set max-frequency to 200Mhz instead of removing it as suggested by
   Bough Chen

-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas

> V2->V3:
> * added Jesse Taube's Acked-by:
> ---
>   arch/arm/boot/dts/imxrt1050.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
> index 114465e4dde6..5b1991c32748 100644
> --- a/arch/arm/boot/dts/imxrt1050.dtsi
> +++ b/arch/arm/boot/dts/imxrt1050.dtsi
> @@ -93,7 +93,7 @@ usdhc1: mmc@402c0000 {
>   			bus-width = <4>;
>   			fsl,wp-controller;
>   			no-1-8-v;
> -			max-frequency = <4000000>;
> +			max-frequency = <200000000>;
>   			fsl,tuning-start-tap = <20>;
>   			fsl,tuning-step = <2>;
>   			status = "disabled";

