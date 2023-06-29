Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669E17422AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjF2Iwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjF2IwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:52:09 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBB13A86;
        Thu, 29 Jun 2023 01:51:53 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T8dv15032715;
        Thu, 29 Jun 2023 10:51:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Iz+hQhO6dEojH0eFv013M4o5vsc6rHv4k2nkimlmwAM=;
 b=PdwR5pfs2D/jQIdC/dGfJ1lcD9R8HIfYCiHPf1JIyDsnBSN4yZF7r4cXcaIcRBR/S/AP
 acx8ekRBjHeGDNQDUS/2jTHUcD1091cxUFSjIqDWdU0ovBH70ehEL+ysG+Y5Vwus+3tC
 MxJlk+WsDFd/YqDpiFIWkAuwlCZcaemUwItee0g4kkvbLMm0JmTUpFqAG6UJS//QVMiI
 q0yxidxZniVxB0mNKgSwPRmGmtxLcowIGBTkMRcSgreViKN4A8gmBIJLMsIGqWDXSnW/
 tPZQ95PRSxh46HPNMsnoVr6O26DIl21vFnJRxATkUMwogO34eZAD1cyKEPApFgeTOFHl fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rh299hp5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 10:51:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C0B3A100060;
        Thu, 29 Jun 2023 10:51:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B88692194CE;
        Thu, 29 Jun 2023 10:51:41 +0200 (CEST)
Received: from [10.129.178.187] (10.129.178.187) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 29 Jun
 2023 10:51:40 +0200
Message-ID: <c20287a0-7daf-0867-31d0-fc4057798f68@foss.st.com>
Date:   Thu, 29 Jun 2023 10:51:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] ARM: dts: stm32: support display on
 stm32f746-disco board
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     <michael@amarulasolutions.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230629083726.84910-1-dario.binacchi@amarulasolutions.com>
 <20230629083726.84910-4-dario.binacchi@amarulasolutions.com>
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20230629083726.84910-4-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.129.178.187]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/29/23 10:37, Dario Binacchi wrote:
> Add support to Rocktech RK043FN48H display on stm32f746-disco board.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
> Changes in v5:
> I am confident that framebuffer sizing is a real requirement for STM32 boards,
> but I need some time to understand if and how to introduce this functionality.
> Therefore, I drop the following patches to allow the series to be fully merged:
>  - [4/6] dt-bindings: display: stm32-ltdc: add optional st,fb-bpp property
>  - [5/6] ARM: dts: stm32: set framebuffer bit depth on stm32f746-disco
>  - [6/6] drm/stm: set framebuffer bit depth through DTS property
>
> Changes in v4:
> - Use DTS property instead of module parameter to set the framebuffer bit depth.
>
> Changes in v3:
> - drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
>   Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
>   https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
> - drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
>   Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
>   https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc
>
>  arch/arm/boot/dts/stm32f746-disco.dts | 51 +++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)


Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

Thanks,
Raphaël G.-P.

