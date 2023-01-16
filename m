Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1FD66B8D3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjAPILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjAPILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:11:34 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EFD6592
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:11:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id cf18so59779091ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4ymnYKhsS5iGv9bsc4wQY9ntYFsPX+jp5KzAaLzQD4=;
        b=xWuVPpbqSPdKQoVpn+evZUOz92Ak0AkA2LERHD4T1TTO28wKqxKz+bFsrqX98liYZF
         fjdr/eMRiJVOss4qNo+G76S+TTDHjGBMM9DAuvnm/GGJXfjrJ2xlUz4kP4qXGxN53s1E
         xFiK8JauJxOfzcqUK9wQa7qzhLMDUhDg3XV+CdjZdxKNUmvOxI+jzq2UWgRk29a7NuPj
         GdTdXacEmxT4M5N/oSjUAtwyz8dEkrKFRW5gRpVnQLX9ijd6jRxMDH9pfuedkr2TGG9M
         yP+FmlEeTcD+UhTP+xPqLIVtLJegrmApSkNpggApjFjAVpWpcQckA+yT6lT5BlqVB4SF
         ta2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4ymnYKhsS5iGv9bsc4wQY9ntYFsPX+jp5KzAaLzQD4=;
        b=uocqcxx4YAYUMkEzltJqDD9BG0YfU1ncVRDIuMcCSczDKxcHnhGhxr/uMH5/DLE05P
         xXkwqilvwkPJ8p9v1/fwxXdpcpve7Mv+kt1GNZrlIv38lnwYam9aWW8Ie3JuMJ6ezCZ6
         EZoYW2L9ZhrRbo0eZdflXRnOBnr6UnWm7PTZ8/jqagOd0bp2Ch8Eiz8FtPUzlK4gKyoH
         WFJFn+NQctLptOgAb+2Mcuu7NZ9NCp+MzDXorhFoLL5GlcN+rL0kpntoxKuq0s/A2oMN
         w+kM/+pcQKypXrSrpusGiS1EOWwTAUb1uzBqstQdLe+W8jdUj1g36Lka9zTPTeQkhXz5
         /GGQ==
X-Gm-Message-State: AFqh2kp3VNQkhg4QyEDaetOUBt5YZu5dj8CxBehL+FkrQoK7fI2KDqaO
        Tw5Dj9upiTfUMQU05wD6NpusjA==
X-Google-Smtp-Source: AMrXdXsBdP72AkcKF65oxwlJ7ZJRCVcEpKDcRDmYVyokU253P4At6lvgwyuEbeN/2E/ruNFGCMa3rQ==
X-Received: by 2002:a17:906:b00d:b0:7c1:8ba6:6eb3 with SMTP id v13-20020a170906b00d00b007c18ba66eb3mr81757639ejy.35.1673856692269;
        Mon, 16 Jan 2023 00:11:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7cd52000000b0047eeaae9558sm3158160edw.60.2023.01.16.00.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:11:31 -0800 (PST)
Message-ID: <63f3d41a-1aa3-396a-b515-bc805f4a19b4@linaro.org>
Date:   Mon, 16 Jan 2023 09:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND v3 02/13] arm64: dts: mediatek: mt8195: add MDP3 nodes
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230116032147.23607-1-moudy.ho@mediatek.com>
 <20230116032147.23607-3-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230116032147.23607-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 04:21, Moudy Ho wrote:
> Add device nodes for Media Data Path 3 (MDP3) modules.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 420 +++++++++++++++++++++++
>  1 file changed, 420 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 206dd534c3f6..d2d1ba71222d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1706,6 +1706,133 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		mdp3-rdma0@14001000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

0 is definitely not generic

Isn't this dma-controller? or if not then just rdma?

> +			compatible = "mediatek,mt8195-mdp3-rdma";
> +			reg = <0 0x14001000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x1000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP0_MDP_RDMA_SOF>,
> +					      <CMDQ_EVENT_VPP0_MDP_RDMA_FRAME_DONE>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>,
> +					<&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +			iommus = <&iommu_vpp M4U_PORT_L4_MDP_RDMA>,
> +				 <&iommu_vpp M4U_PORT_L4_MDP_WROT>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_RDMA>,
> +				 <&topckgen CLK_TOP_CFG_VPP0>,
> +				 <&topckgen CLK_TOP_CFG_26M_VPP0>,
> +				 <&vppsys0 CLK_VPP0_WARP0_ASYNC_TX>,
> +				 <&vppsys0 CLK_VPP0_WARP0_RELAY>,
> +				 <&vppsys0 CLK_VPP0_WARP0_MDP_DL_ASYNC>,
> +				 <&vppsys0 CLK_VPP0_WARP1_ASYNC_TX>,
> +				 <&vppsys0 CLK_VPP0_WARP1_RELAY>,
> +				 <&vppsys0 CLK_VPP0_WARP1_MDP_DL_ASYNC>,
> +				 <&vppsys0 CLK_VPP0_VPP02VPP1_RELAY>,
> +				 <&vppsys1 CLK_VPP1_DL_ASYNC>,
> +				 <&vppsys1 CLK_VPP1_VPP0_DL_ASYNC>,
> +				 <&vppsys1 CLK_VPP1_VPP0_DL_RELAY>,
> +				 <&vppsys0 CLK_VPP0_VPP12VPP0_ASYNC>,
> +				 <&vppsys1 CLK_VPP1_VPP0_DL1_RELAY>,
> +				 <&vppsys1 CLK_VPP1_SVPP2_VDO0_DL_RELAY>,
> +				 <&vppsys1 CLK_VPP1_SVPP3_VDO1_DL_RELAY>,
> +				 <&vppsys1 CLK_VPP1_SVPP2_VDO1_DL_RELAY>,
> +				 <&vppsys1 CLK_VPP1_SVPP3_VDO0_DL_RELAY>;
> +			mboxes = <&gce1 12 CMDQ_THR_PRIO_1>,
> +				 <&gce1 13 CMDQ_THR_PRIO_1>,
> +				 <&gce1 14 CMDQ_THR_PRIO_1>,
> +				 <&gce1 21 CMDQ_THR_PRIO_1>,
> +				 <&gce1 22 CMDQ_THR_PRIO_1>;
> +		};
> +
> +		mdp3-fg0@14002000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

"0" suffix is definitely nothing generic. Drop such suffixes everywhere.
Drop also "mdp3" prefix everywhere.


Best regards,
Krzysztof

