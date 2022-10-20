Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6B6059B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJTI2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJTI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:28:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1FD18982F;
        Thu, 20 Oct 2022 01:28:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 55D9D66023A3;
        Thu, 20 Oct 2022 09:28:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666254485;
        bh=Dm2sSpcy/WPT5qaMKRDCmxl/L7RXt0Zoucvbb30uh6g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q0pak6ywHzVJvhN8eGTE2FfIQO1kLkFxLeg3dP2mvNeHMiNAhPJiH6dHxHpl12qTS
         J+8nY/2EVFTQgzz9+8s8R+lpiGRdx3sFVnpvKHLr+zDlEJi97gP7pcMbkRVYoah7tZ
         Fpo912yLr/OKsUnex8YjcPEk9IH6tz597jXROLsb/CbNTkoMlg+thZ57HGmyBoSKtA
         0dJPuRZZDHr5UUx54YNNFpEc/7e8LJ48W8fIK0g79/hRW+OUfi7gEidO6uzzg2biCO
         BbE2ThRTNpQ/cQD87churaTOiy/4WhJHjnKdWi/iYUwyNJlokS/mxqQSAfs5RfiLr6
         NaLDOuU07xU7w==
Message-ID: <b33b9d2a-f6d5-b2a7-bcb8-1ed2303c04b4@collabora.com>
Date:   Thu, 20 Oct 2022 10:28:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: mediatek,mt2701-auxadc: new
 32k clock
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <f98ed7f3fc15a0614443a57427d46ce17ec2e0cc.1666190235.git.daniel@makrotopia.org>
 <dbe88fd2f7ea5b2f419dce6ecb48c20e96e2e634.1666190235.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <dbe88fd2f7ea5b2f419dce6ecb48c20e96e2e634.1666190235.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/10/22 16:38, Daniel Golle ha scritto:
> Newer MediaTek SoCs need an additional clock to be brought up for
> AUXADC to work. Add this new optional clock to
> mediatek,mt2701-auxadc.yaml.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml          | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> index 7f79a06e76f596..c2a1813dd54152 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> @@ -44,10 +44,14 @@ properties:
>       maxItems: 1
>   
>     clocks:
> -    maxItems: 1
> +    maxItems: 2
> +    minItems: 1
>   
>     clock-names:
> -    const: main
> +    items:
> +      - const: main
> +      - const: 32k

You're adding this for MT7986, and I don't see any 32KHz ADC clock on that SoC.
I suppose that your '32k' clock is CLK_INFRA_ADC_FRC_CK, currently parented to
'csw_f26m_sel', so that's 26MHz, not 32KHz.

Since you'll need the same changes for thermal as well, I would consider setting
"infra_adc_frc" as a parent of "infra_adc_26m", like so:

	GATE_INFRA1(CLK_INFRA_ADC_26M_CK, "infra_adc_26m", "infra_adc_frc", 20),
	GATE_INFRA1(CLK_INFRA_ADC_FRC_CK, "infra_adc_frc", "csw_f26m_sel", 21),

...just because there's apparently no reason to have one of them enabled but not
the other or, at least, it looks like we *always* need ADC_26M_CK enabled when
ADC_FRC_CK is enabled.

Regards,
Angelo
