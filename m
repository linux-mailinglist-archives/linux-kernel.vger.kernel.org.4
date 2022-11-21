Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855A3631AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiKUIHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKUIHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:07:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F95FF58B;
        Mon, 21 Nov 2022 00:07:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45DEB60EF8;
        Mon, 21 Nov 2022 08:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D821C433C1;
        Mon, 21 Nov 2022 08:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669018055;
        bh=JUZxOMccjGBqhxXgnzu5UUE3t55AOpU4fuF6iENXJVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7MMghyWerVrHyBAzc/S5wRhLzYhd7exfpqeiwKzZxTZTTxET6hK5R6nHfib2K+j/
         cLOXcE8TGu7jMOvIUREzYC0SxQyxoMlwkWzisARrPTKIEeMx/UdaaC/6Ax6o752qGP
         FP0FlDBzXsCbMnrKH9ZWw9BBCVR20bFVU6IhnpBFi1nxmNvf4At+ot3nMOzMJrhl4Y
         T69Zq1lfr/Z0ilvEFyMjvoxLwmO76qRmOqEukXTVLsf1FEILQvh81KWyec0OJy6I4U
         1YwV6ecI5wEIhV+hjc592jKhL4P40FbJeKgBZiMpugucY9EBZOxRlAyW6AFxn97rdT
         kmzSfXukj4Fig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ox1pZ-0006OI-Ka; Mon, 21 Nov 2022 09:07:05 +0100
Date:   Mon, 21 Nov 2022 09:07:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,qmp-usb3-dp: Add sm6350
 compatible
Message-ID: <Y3sxqUu0dnaQfdFY@hovoldconsulting.com>
References: <20221121075358.76582-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121075358.76582-1-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 08:53:55AM +0100, Luca Weiss wrote:
> Add the compatible describing the combo phy found on SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> index 97a7ecafbf85..68aecb638870 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> @@ -18,6 +18,7 @@ properties:
>        - qcom,sc8180x-qmp-usb3-dp-phy
>        - qcom,sc8280xp-qmp-usb43dp-phy
>        - qcom,sdm845-qmp-usb3-dp-phy
> +      - qcom,sm6350-qmp-usb3-dp-phy
>        - qcom,sm8250-qmp-usb3-dp-phy
>    reg:
>      items:

The current USB3-DP bindings are broken and we should no be adding
further compatibles here. Please consider rebasing on:

	https://lore.kernel.org/all/20221115144005.2478-1-johan+linaro@kernel.org/

Johan
