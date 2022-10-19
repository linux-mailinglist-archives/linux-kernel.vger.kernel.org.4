Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C63A603B76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJSI3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJSI3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:29:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB30D7CAA7;
        Wed, 19 Oct 2022 01:29:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D3D016602388;
        Wed, 19 Oct 2022 09:29:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666168142;
        bh=ocWrVQMR3Z9kZzLMg8BVFlJNcN/HGEjR1aguO3cp0bc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JslCHyyIYsNdzm6vEIetBjO8qkDZ/ptAL3uvjqbctSrFPeXp6ycqYEeYvuQ/rk3SE
         m1vLNqJp0WOvN/qqMhIHUHGe+HO0NmOI7OcLVf0Mwm3li8sTr+h3xLZwiBdqYKBeuA
         MytITpObucpWuclzLgmsf4eLGlxzpm1WgINdmBIo/uWbiGbokxPQ8kbvMRsHP+Hdwx
         aJ1Bc+cN5c54wCsVIVhlnHsOXqmF+musNmIUniJQdOWyNX8H9CabdT5fh2VoDOD64X
         6SoMfuVAF5hsoAfjGpHpsVsobEHrAmv/M1uLd0Hr4kn2O63JeTFY+Vac8yMRxaFyBW
         tiL5rtbl75dQA==
Message-ID: <97916360-a24b-0e7d-cc86-9b801fadf869@collabora.com>
Date:   Wed, 19 Oct 2022 10:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC v1 02/12] dt-bindings: PCI: mediatek-gen3: add support for
 mt7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20221017104141.7338-1-linux@fw-web.de>
 <20221017104141.7338-3-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221017104141.7338-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/10/22 12:41, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string for mt7986.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> mt7986a.dtsi misses clock-names which are now required since support of
> MT8192/MT8188/MT8195. This change also introduces a 6th clock which is
> now needed for all pcie-gen3 dts.
> 
> i do not know how to map the clocks to the names...
> 
> mediatek-pcie-gen3.yaml:
> 
>    clock-names:
>      items:
>        - const: pl_250m
>        - const: tl_26m
>        - const: tl_96m
>        - const: tl_32k
>        - const: peri_26m
>        - enum:
>            - top_133m        # for MT8192
>            - peri_mem        # for MT8188/MT8195
> 
> mt7986a.dtsi:
> 
> 	clocks = <&infracfg CLK_INFRA_PCIE_SEL>,
> 		 <&infracfg CLK_INFRA_IPCIE_CK>,
> 		 <&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
> 		 <&infracfg CLK_INFRA_IPCIER_CK>,
> 		 <&infracfg CLK_INFRA_IPCIEB_CK>;

If this SoC has a different clock tree... then you should add bindings for this
kind of clock tree.

CLK_INFRA_IPCIER_CK is *not* a peri clock: "peri" means PERICFG, which does not
seem to be present in this SoC... so no, you can't assign it to "peri_26m", nor
you can assign it to tl_32k, as that's not a 32KHz clock.

CLK_INFRA_PCIEB_CK can be a "top_133m" clock... as it is gating "sysaxi_sel",
which is a topckgen clock.

CLK_INFRA_IPCIE_CK is your "tl_(something)" clock, as that's effectively gating
"pextp_tl_ck_sel" (which is the PCIe Transaction Layer clock mux).

CLK_INFRA_IPCIE_PIPE_CK seems to be parented to "top_xtal", frequency = 40MHz,
so I don't see how can this be a pl_250m? Looks like being a 40m clock and I
wish we didn't have clock frequencies specified in the names, as "pl" would fit,
but "pl_250m" does not.
I wonder if we can change the clock names and reflect the changes to the mt8192
devicetree (mt8195 does not have any pcie node yet), and if that would be a good
idea right now.

...and I've left the first for last, because...

CLK_INFRA_PCIE_SEL: I have no datasheet for this SoC, but if you're sure that
this clock is selecting the source clock to CLK_INFRA_IPCIE_CK, then the clock
driver is wrong...

Right now, I see the following:

static const char *const infra_pcie_parents[] __initconst = {
	"top_rtc_32p7k", "csw_f26m_sel", "top_xtal", "pextp_tl_ck_sel"
};

GATE_INFRA2(CLK_INFRA_IPCIE_CK, "infra_ipcie", "pextp_tl_ck_sel", 12),

MUX_GATE_CLR_SET_UPD(CLK_INFRA_PCIE_SEL, "infra_pcie_sel",
		     infra_pcie_parents, 0x0028, 0x0020, 0x0024, 0, 2,
		     -1, -1, -1),

....so if you're right, we should instead have:

GATE_INFRA2(CLK_INFRA_IPCIE_CK, "infra_ipcie", "infra_pcie_sel", 12),

....with this meaning that adding CLK_INFRA_PCIE_SEL in devicetree is useless.

This clock tree looks a bit unclear (because again, there's no datasheet around),
but that's what I understand with a rather fast look in the clock drivers and
with some experience on other MTK SoCs.

Then again, if this tree is effectively incompatible with the one from MT8192 and
MT8195, you should have different clock names... and just as a fast idea:

clock-names = "axi", "tl", "pl", "top";

with clocks, in order:
CLK_INFRA_PCIEB_CK, CLK_INFRA_IPCIE_CK,
CLK_INFRA_IPCIE_PIPE_CK, CLK_INFRA_IPCIER_CK.

...but feel free to reiterate that :-)
Hope that was helpful.

Cheers,
Angelo

