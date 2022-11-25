Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CAA63885A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiKYLMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKYLMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:12:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF06122B23;
        Fri, 25 Nov 2022 03:12:23 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 538146602B09;
        Fri, 25 Nov 2022 11:12:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669374742;
        bh=yrGzlYyUJPuHN8Ic2oxE9qynptqYof+6qB23kgdmUJM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G+ubczkD8YTiVw5jS7J4Sy4StxTZ7mOtUU4yMZPy4LeiF+B6WWeQO8W1iP/rcRzc2
         5j6rV5MNGp66G89nKFaz/DNMiF3F6noRSrUtAzjRtFpx2uDP9hHbiIAdsJwIEqu2w/
         0IseGaeWs01mmFd2QmN4zPWBDTK2PWILjfXKY1e3rhm1SEGb4htuhd2+ub6WQi/COz
         o/Y+i9R5ESajKuivLjYvCz3mf6YqQjiMk0wWD8S5FtXMNWrOUGZxyDIJ9BpOEIzhgZ
         cvxKpbN7UQhHkwBvy2IHx03sVRRNwXGH7XOIjIxfUAmWYAnXc5aYJpzyaOxtu+PC15
         MrrZ6AwI87SOg==
Message-ID: <375d45fa-fdfc-37a5-9d32-b0412cad7bc0@collabora.com>
Date:   Fri, 25 Nov 2022 12:12:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH RESEND v2] dt-bindings: pwm: mediatek: Add compatible for
 MT7986
To:     Daniel Golle <daniel@makrotopia.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.or,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Zhi Mao <zhi.mao@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
References: <Y39PjU1BqBB8tZ98@makrotopia.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Y39PjU1BqBB8tZ98@makrotopia.org>
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

Il 24/11/22 12:03, Daniel Golle ha scritto:
> Add new compatible string for MT7986 PWM and list compatible units for
> existing entries. Also make sure the number of pwm1-X clocks is listed
> for all supported units.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> Changes since v1: list compatibles, fix pwm1-n clocks for all SoCs
> 
> Rebased on linux-next and re-run scripts/get_maintainers.pl on patch to
> makes sure dt maintainers are included. This has been requested by
> Krzysztof Kozlowski.
> 
>   .../devicetree/bindings/pwm/pwm-mediatek.txt  | 20 +++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index 554c96b6d0c3..952a338e06e7 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -2,14 +2,15 @@ MediaTek PWM controller
>   
>   Required properties:
>    - compatible: should be "mediatek,<name>-pwm":
> -   - "mediatek,mt2712-pwm": found on mt2712 SoC.
> +   - "mediatek,mt2712-pwm", "mediatek,mt6795-pwm": found on mt2712 SoC.
>      - "mediatek,mt6795-pwm": found on mt6795 SoC.
> -   - "mediatek,mt7622-pwm": found on mt7622 SoC.
> -   - "mediatek,mt7623-pwm": found on mt7623 SoC.
> +   - "mediatek,mt7622-pwm", "mediatek,mt8195-pwm", "mediatek,mt8183-pwm", "mediatek,mt7986-pwm": found on mt7622 SoC.
> +   - "mediatek,mt7623-pwm", "mediatek,mt7628-pwm": found on mt7623 SoC.
>      - "mediatek,mt7628-pwm": found on mt7628 SoC.
>      - "mediatek,mt7629-pwm": found on mt7629 SoC.
> -   - "mediatek,mt8183-pwm": found on mt8183 SoC.
> -   - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm": found on mt8195 SoC.
> +   - "mediatek,mt7986-pwm": found on mt7986 SoC.
> +   - "mediatek,mt8183-pwm", "mediatek,mt7986-pwm": found on mt8183 SoC.
> +   - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm", "mediatek,mt7986-pwm": found on mt8195 SoC.

I'm sorry, but all these compatibles make little sense at best.
Each of these PWM controllers have different properties as they may *by hardware*
be featuring more or less channels, they may be a different IP revision and/or
sub-revision requiring even ever-so-slightly different handling (check pwm45_fixup
and has_ck_26m_sel).

If you want to add MT7986, the best thing that you can do is to simply add

+   - "mediatek,mt7986-pwm": found on mt7986 SoC.

this line ^

...and then please don't touch the others.

>      - "mediatek,mt8365-pwm": found on mt8365 SoC.
>      - "mediatek,mt8516-pwm": found on mt8516 SoC.
>    - reg: physical base address and length of the controller's registers.
> @@ -20,11 +21,14 @@ Required properties:
>                   has no clocks
>      - "top": the top clock generator
>      - "main": clock used by the PWM core
> +   - "pwm1"  : the PWM1 clock for mt7629
> +   - "pwm1-2": the two per PWM clocks for mt7986

That's not your fault, but the binding is already wrong (yes it must be fixed!) and
unless my brain is failing somewhere, there's only one clock per pwm (as if there's
any children, it must be parented to .. well, its parent, in the clock driver), and
note that the driver is actually parsing "pwmX" clocks, never "pwmX-Y" clocks.

Relevant snippet:

		char name[8];

		snprintf(name, sizeof(name), "pwm%d", i + 1);

		pc->clk_pwms[i] = devm_clk_get(&pdev->dev, name);

Just... please don't keep doing the same mistake that is already inside of here...

So, coming to an end: I think that this commit should be a one-liner that documents
your "mediatek,mt7986-pwm" compatible and that's it.

A schema conversion would be welcome: in that regard, I can make a conversion
and send it next week, along with that clock-names fix.

Regards,
Angelo
