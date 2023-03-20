Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754656C0F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCTKmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCTKmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:42:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE5283E4;
        Mon, 20 Mar 2023 03:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C049B80DF4;
        Mon, 20 Mar 2023 10:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E42C433A7;
        Mon, 20 Mar 2023 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679308804;
        bh=b/HGnMlXeuHvPae1x52H670xDuHDuYpTJN0Rl8TuTuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRaIRabUskl2RpkaJgvjV+RL80IVFsZL5ud/3JEyvB1lyaQDpvdkMoWDap16n4wrc
         HP6OvGsFUX5Nu6qHKFbtcyYtLiVIUS9t845WvUKLhhl6Pwhvexr2cUZ5VnRWr9gRZA
         CfNzsFR17w6mZza9u1AQ4Zv3yJnAOH7kwS/D/xrniCE7lmhvRhqHO7BxgxP+oMl+8E
         1LR2wnJSnpSgmiQlpeFxV225fVQkxgIa6JOJo/yXfy+JxNSSOWAs9coc9hggeOKyBK
         BEV2Z4zJiU3yrvKEUqhopn+IhZjp1w87jKVj2FDWdflxOG9im5n79I/ADB46JCWDJR
         giX4B+uC0gPjA==
Date:   Mon, 20 Mar 2023 16:09:56 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/13] dt-bindings: mailbox: qcom,apcs-kpss-global:
 correct SDX55 clocks
Message-ID: <20230320103956.GE4564@thinkpad>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
 <20230314080917.68246-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314080917.68246-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:09:05AM +0100, Krzysztof Kozlowski wrote:
> SDX55 and SDX65 DTS takes clocks in a bit different order.  Adjust
> bindings to the DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> index d888ead09282..2992227631c4 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> @@ -97,14 +97,14 @@ allOf:
>        properties:
>          clocks:
>            items:
> +            - description: reference clock
>              - description: primary pll parent of the clock driver
>              - description: auxiliary parent
> -            - description: reference clock
>          clock-names:
>            items:
> +            - const: ref
>              - const: pll
>              - const: aux
> -            - const: ref
>    - if:
>        properties:
>          compatible:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
