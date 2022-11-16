Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6A62BFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiKPNtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiKPNs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:48:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467183B9;
        Wed, 16 Nov 2022 05:48:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976A361E11;
        Wed, 16 Nov 2022 13:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013DFC433C1;
        Wed, 16 Nov 2022 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668606505;
        bh=ykLJzDbZ0kLjeXVlSh0iMDNUh5L05twFQdQJECK6oD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKplzgjgN7NEtioBogzf7iLbgGXq5f2YbUKP9+VfrxBALv9PWGXO/V26m4/YnCl3t
         i0lqiSdjaBiBrahsvFOUFjIsAWHcmSm+C2TEYujcv//IBnbm22G+QRWMlb+qLfTdiS
         jbmERyYDq/m9KS3Stl4iGfEz0xXMTvk5yrZwoV2Aqd5hjwlP+W2RZiJFV4o0kPYgX2
         cU+bzbKMaHqz3wfZA9JUXh+zPI2BLIW9ghlLBjm7/DeJF5f18ZIq1yppNzhepQsFza
         gxOMqd1Z9aELNQ9EAjmU42ehPpH1M0CiF+MhKzZffSmYPj0MvsEWTr8viCFfQCmJr3
         7Ed2YEnFAgfnQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovIlf-0002kn-Fh; Wed, 16 Nov 2022 14:47:55 +0100
Date:   Wed, 16 Nov 2022 14:47:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 06/10] dt-bindings: phy: qcom,qmp-pcie: Document SM8550
 compatible
Message-ID: <Y3TqCx2aQDswgFBb@hovoldconsulting.com>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
 <20221116120157.2706810-7-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116120157.2706810-7-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:01:53PM +0200, Abel Vesa wrote:
> Add SM8550 both G4 and G3 dual lane compatible strings, also add the
> qref supply, the power domains, the reg entries and increase the number
> of allowed clocks needed to support the mentioned platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        | 38 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
> index 62045dcfb20c..e5752ad93f0a 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
> @@ -32,6 +32,8 @@ properties:
>        - qcom,sm8250-qmp-modem-pcie-phy
>        - qcom,sm8450-qmp-gen3x1-pcie-phy
>        - qcom,sm8450-qmp-gen4x2-pcie-phy
> +      - qcom,sm8550-qmp-gen3x2-pcie-phy
> +      - qcom,sm8550-qmp-gen4x2-pcie-phy

Here too, don't add new compatibles to the legacy bindings, but rather
base it on the sc8280xp binding.

Johan
