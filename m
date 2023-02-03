Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FB6896FC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjBCKhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjBCKhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:37:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FB3D539;
        Fri,  3 Feb 2023 02:37:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F284361ECE;
        Fri,  3 Feb 2023 10:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CE6C433EF;
        Fri,  3 Feb 2023 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675420648;
        bh=3Wmz48fgl19z4byyEs0lSix0KoE1vW61hKlH5UDXIhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P45nY1jB+6uxc21XLPz/QKTQUwwfeDYPcqt+hNksIUdcSI2NFsEPWvH2AivDJr5m1
         3RgQCQqcRRMyS9Zj20Tz66tX2Ip0RCISugWNubXriSgWd2qiAfXursQR9sFYd2m6WD
         UfwnoreOnrOS0WdNATAv0VorwdMpdSzAM3EOetlCLdYy8+OjoSW5z2THqh5KS+aGG2
         0UbLb2+nK1ljNpCdunKgXvADy9j2MvsqX1uhaaVhdRm5flI/R6N7zNhVjYgLeH9yYX
         0tIHNQwAugVGmzh6mz3xY6tZM9p2VsoAjnvkK/KVvZut820Jh8VGZu9hcU5zAYd1M4
         4SVL3xe/bDQyQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNtS6-0001HK-Vl; Fri, 03 Feb 2023 11:37:55 +0100
Date:   Fri, 3 Feb 2023 11:37:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/8] dt-bindings: phy: qcom,qmp-usb: Document SM8550
 compatible
Message-ID: <Y9zkAjm1eNCuaajc@hovoldconsulting.com>
References: <20230202132511.3983095-1-abel.vesa@linaro.org>
 <20230202132511.3983095-4-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202132511.3983095-4-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:25:06PM +0200, Abel Vesa wrote:
> Add the SM8550 compatible to the list.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> The v3 version of this patch was here:
> https://lore.kernel.org/all/20230126131415.1453741-4-abel.vesa@linaro.org/
> 
> Changes since v3:
>  * added Rob's A-b tag
> 
> Changes since v2:
>  * none
> 
> Changes since v1:
>  * moved to sc8280xp bindings
> 
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> index 6f31693d9868..ec00fbc06abe 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc8280xp-qmp-usb43dp-phy
> +      - qcom,sm8550-qmp-usb3-dp-phy
>  
>    reg:
>      maxItems: 1

Subject prefix should be

	dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: 

Looks good otherwise: 

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
