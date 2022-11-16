Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7293262BFED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiKPNqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiKPNqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:46:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1C1054E;
        Wed, 16 Nov 2022 05:46:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79445B81D84;
        Wed, 16 Nov 2022 13:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257E3C433B5;
        Wed, 16 Nov 2022 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668606396;
        bh=4Eyz0S2R9mU+xNSyb0CBshZrLiG7Ysc6IhA8sbgt8kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYjYp3XLfit7zRxym2OFPG+NAwT2U+ECLor5O6cLRm0sJ5iqHL3umzzj0VMWd9tfg
         pmfXOghfTiRu7hmUe01VNMiSn5zOOosBUml4Bb9jSn+4Tc59avtYlZkgIJStcqKC09
         X7JzvO63NETaRXF6dn9mgqX86K7mfQtePZvEhcOnMryBH07M+/XsHzazHMikZJc86N
         Jx6MUTQmbp+1co4jYoKZdoMixq1Bf+YYnRqkwmo+HMoGBe+pp/aQrGJ6A309YBZVw6
         q9zkLkxjNuoTJOA2Lc7RD0DmhCm2349mHfvRIOxaSBxAK9B2rqGqHV1tlNIWTh7Gqx
         ejySq7W6fZGhQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovIju-0002jH-G0; Wed, 16 Nov 2022 14:46:06 +0100
Date:   Wed, 16 Nov 2022 14:46:06 +0100
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
Subject: Re: [PATCH 02/10] dt-bindings: phy: Add QMP UFS PHY comptible for
 SM8550
Message-ID: <Y3Tpnsqh5qd8b8R6@hovoldconsulting.com>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
 <20221116120157.2706810-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116120157.2706810-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:01:49PM +0200, Abel Vesa wrote:
> Document the QMP UFS PHY compatible for SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../phy/qcom,msm8996-qmp-ufs-phy.yaml         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
> index be41acbd3b6c..1ea5fcd4a59e 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
> @@ -29,6 +29,7 @@ properties:
>        - qcom,sm8250-qmp-ufs-phy
>        - qcom,sm8350-qmp-ufs-phy
>        - qcom,sm8450-qmp-ufs-phy
> +      - qcom,sm8550-qmp-ufs-phy

As I mentioned in my comment to the dts changes, you should base the
binding on sc8280xp instead. The older ones will probably be converted
too eventually.

Johan
