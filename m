Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355346CADC3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjC0SqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC0SqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:46:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69826A3;
        Mon, 27 Mar 2023 11:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13CBFB818C4;
        Mon, 27 Mar 2023 18:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220E8C4339E;
        Mon, 27 Mar 2023 18:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679942774;
        bh=HVJfi5yiPTIaQ0FtKRuQnH39lcrjzNl/Toz+HEZVZgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3Kajehyk9S3gttgCUy/JC4ssjpKVjwn215RqP6GeGk6Yhbhx10F4MVZYC6F3O2j3
         vDp1lOZ2YlADjI8LlfS9vkvS6AEJW0JoasH1skwo34yJ1Zqqv0phxfjztHl/5dWX0R
         aZKf2M8dCjPOSqQULv7fAZrZC/NmAv2Rn0mkTpCIJQ6UZM5ZdHQeok/aI6m7zh353x
         RgaHHpOzqhf8JOVFaGE3bd92OsLgonG7H21lG/sOAsEgZEeUxTsGqtX8nHqeEfvJ4W
         mNMjXuZ/A/tggWPU2hC3HPJLTYUsD7U8ieEhh3+7v6WMIPceIQZJsFgAk3Q7Gi7W8M
         91+6hE96r8gNg==
Date:   Mon, 27 Mar 2023 11:46:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: ufs: qcom: Fix sm8450 bindings
Message-ID: <20230327184612.GC73752@sol.localdomain>
References: <20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com>
 <20221209-dt-binding-ufs-v3-3-499dff23a03c@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209-dt-binding-ufs-v3-3-499dff23a03c@fairphone.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:41:30AM +0100, Luca Weiss wrote:
> SM8450 actually supports ICE (Inline Crypto Engine) so adjust the
> bindings and the example to match.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index ebc8e1adbc6f..3af786120fa5 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -113,7 +113,6 @@ allOf:
>                - qcom,sc8280xp-ufshc
>                - qcom,sm8250-ufshc
>                - qcom,sm8350-ufshc
> -              - qcom,sm8450-ufshc
>                - qcom,sm8550-ufshc
>      then:
>        properties:
> @@ -144,6 +143,7 @@ allOf:
>                - qcom,sdm845-ufshc
>                - qcom,sm6350-ufshc
>                - qcom,sm8150-ufshc
> +              - qcom,sm8450-ufshc
>      then:
>        properties:
>          clocks:
> @@ -250,7 +250,9 @@ examples:
>          ufs@1d84000 {
>              compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
>                           "jedec,ufs-2.0";
> -            reg = <0 0x01d84000 0 0x3000>;
> +            reg = <0 0x01d84000 0 0x3000>,
> +                  <0 0x01d88000 0 0x8000>;
> +            reg-names = "std", "ice";
>              interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>              phys = <&ufs_mem_phy_lanes>;
>              phy-names = "ufsphy";
> @@ -278,7 +280,8 @@ examples:
>                            "ref_clk",
>                            "tx_lane0_sync_clk",
>                            "rx_lane0_sync_clk",
> -                          "rx_lane1_sync_clk";
> +                          "rx_lane1_sync_clk",
> +                          "ice_core_clk";
>              clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>                       <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
>                       <&gcc GCC_UFS_PHY_AHB_CLK>,
> @@ -286,7 +289,8 @@ examples:
>                       <&rpmhcc RPMH_CXO_CLK>,
>                       <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>                       <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> -                     <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +                     <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
> +                     <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>              freq-table-hz = <75000000 300000000>,
>                              <0 0>,
>                              <0 0>,
> @@ -294,6 +298,7 @@ examples:
>                              <75000000 300000000>,
>                              <0 0>,
>                              <0 0>,
> -                            <0 0>;
> +                            <0 0>,
> +                            <75000000 300000000>;
>          };

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
