Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C026F72226D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjFEJpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFEJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:45:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA8BD;
        Mon,  5 Jun 2023 02:45:14 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B436660037C;
        Mon,  5 Jun 2023 10:45:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685958313;
        bh=mEfqt1dlBpfVkkk0bVWukCJts1hAaNVDDjN5Ccn0QLg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KDUnQXgkC9ssK+JFoXAIULspaWCPeNInczzPilPctimIMqTZMBvIug63Uy3+ip4CI
         kCslNHgJuqVI8H5CAzB5DmFp8yvwGZZEt37PO8qA1rIjKEz9cijA6nxaTBEXwS5S4B
         NovRUyiHzBBM2n7xDQdP3SlfWWhLXYwmCGA6qYSNIUT7u9JRFh5eftB+KQ5FabO1uA
         wRvs1PJECv+/bXWWJR08AhfL7sP0ZAwwIiQEuuFBdcThi77aIN3evYZm+uVv3T/TRv
         +Ip7IJjbaIBQCqq3sMQmCK6xrLwc7Q45QE4HV3I/vmzJlWWA6lUZHOXvGmHcJbmzBH
         /N8f0NQlpIj3g==
Message-ID: <511269ce-2493-1d21-d8fe-a9d78828e018@collabora.com>
Date:   Mon, 5 Jun 2023 11:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192: Add missing dma-ranges to
 soc node
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Yong Wu <yong.wu@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230601203221.3675915-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230601203221.3675915-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/06/23 22:32, Nícolas F. R. A. Prado ha scritto:
> In the series "Adjust the dma-ranges for MTK IOMMU", the mtk-iommu
> driver was adapted to separate the iova range based on the larb used,
> and a dma-ranges property was added to the soc node in the devicetree of
> the affected SoCs allowing the whole 16GB iova range to be used. Except
> that for mt8192, there was no patch adding dma-ranges.
> 
> Add the missing dma-ranges property to the soc node like was done for
> mt8195 and mt8186. This fixes the usage of the vcodec, which would
> otherwise trigger iommu faults.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> Matthias,
> 
> this is a very simple but important fix for the vcodec functionality.
> Since the vcodec node for mt8192 was just merged, can we please get this
> in in this merge window as well?

+1

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> Thanks,
> Nícolas
> 
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 7ff183c35494..a3612de8e9d1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -401,6 +401,7 @@ soc {
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		compatible = "simple-bus";
> +		dma-ranges = <0x0 0x0 0x0 0x0 0x4 0x0>;
>   		ranges;
>   
>   		gic: interrupt-controller@c000000 {

