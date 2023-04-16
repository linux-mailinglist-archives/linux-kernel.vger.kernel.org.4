Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928B86E3886
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjDPNK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDPNK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF7212E;
        Sun, 16 Apr 2023 06:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F2361AC3;
        Sun, 16 Apr 2023 13:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224CBC433D2;
        Sun, 16 Apr 2023 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681650622;
        bh=LfiZ+5o35dtTGT3sDwTcKuuxb1tn2j+UJ8+wyZpuGjs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aEDtxQzkGBunqrbEekbaUUHChUpAM91W2X5+/EtCCFWYW9IWpdaspWeai9REO/6gM
         /UNdO73Tepx24Pdf9V6vmDFJhEW/lDbhpI7VGxebQ77nrD9vgHajJKL5nmEUmrmmzz
         9KHYa36sgcs+yqGJvE4FBSHHurlN3qLfJWV0u8Ji+VKTh0XhIMSK0Grnq9Ye6xJ9An
         cwWfko9dCXD1E9Rvs2pZuJvIC4kZGqUhUi3btl4giYj/LvKCiTmOpx5+D8AGGFB39+
         UVQ7UKJ63M58Nq0MfugOtN1EhqASw7diHMOwtv9IvFoymccUqt4NQO+I3GtMmw5tiP
         GYcTLEpmueGPQ==
Date:   Sun, 16 Apr 2023 14:10:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: add 16 ratio of
 pre-scaling
Message-ID: <20230416141024.2c09d7c8@jic23-huawei>
In-Reply-To: <20230416123142.299533-1-krzysztof.kozlowski@linaro.org>
References: <20230416123142.299533-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2023 14:31:42 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Document value of 16 for pre-scaling, already used in DTS and supported
> by the Linux driver since long time:
>=20
>   sm7225-fairphone-fp4.dtb: adc@3100: channel@8:qcom,pre-scaling: 'oneOf'=
 conditional failed, one must be fixed:
>     10 was expected
>     16 is not one of [1, 3, 4, 6, 20, 8, 10]
>     81 was expected
>=20
> Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I'm carrying an identical patch (though without the reordering) from Luca W=
eiss.
I thought as the whole series was very late in the cycle that it was unlike=
ly
to be necessary to rush this in.

https://lore.kernel.org/all/20230414-pmi632-v1-5-fe94dc414832@z3ntu.xyz/

I see that patch is for the fairphone-fp3 adn this report is the fairphone-=
fp4.
Is that the reason this is a fix?

I'm also I'd like someone from driver side to confirm the drier supports th=
is.
=46rom a quick glance I'm not seeing 16 in what I think might be the related =
table.
https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/qcom-spmi-va=
dc.c#L126

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yam=
l b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index f30114424b92..42077ca65747 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -101,7 +101,7 @@ patternProperties:
>          oneOf:
>            - items:
>                - const: 1
> -              - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
> +              - enum: [ 1, 3, 4, 6, 8, 10, 16, 20 ]
>            - items:
>                - const: 10
>                - const: 81

