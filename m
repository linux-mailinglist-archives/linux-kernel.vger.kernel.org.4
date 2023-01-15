Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F124966AF4B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 05:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjAOEO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 23:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjAOEOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 23:14:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF18A4682;
        Sat, 14 Jan 2023 20:14:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7A5460C60;
        Sun, 15 Jan 2023 04:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B87C433D2;
        Sun, 15 Jan 2023 04:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673756089;
        bh=jshOld5XYZnlYZ5Q1vGZgYzaUHooncGiPJkhdHvwGnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlKDgDw4UK6bis7dDczAhcW0tZpvRZF/4PjNy2XepuS+wgvMDr8Sdy/84GRDFo8c1
         E56yjitEBYf0r4tCYMkG14O5x7ZciKdwmTpq4+EP1Fyp+8BtydX1kT8avdtD3gJW/B
         jLcZSzwY2O3x00CLCQxkVt7pLvqWYgw+PDHaTZ0UuD+nOfcqAkoyAlNpd4hkKoBcm0
         PE8RFxjlYbccyMDABZopGKIhVdpJiUxm1eWbGTidWKWeseX+rQoTh7xUfvHsjQUYLu
         zieAyFZcoY3kMRzaDUp6fTC67Syt12jj6lX5iUXydxidd4Q4VKqaUWLrLxbjmlbHQS
         tvktp6T1mwoIw==
Date:   Sun, 15 Jan 2023 09:44:40 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: mailbox: qcom-ipcc: Add sc8280xp
 compatible
Message-ID: <20230115041440.GE6568@thinkpad>
References: <20221016090035.565350-1-luca@z3ntu.xyz>
 <20221016090035.565350-3-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221016090035.565350-3-luca@z3ntu.xyz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 11:00:32AM +0200, Luca Weiss wrote:
> Document the sc8280xp compatible, and at the same time also make sure
> the list is sorted alphabetically.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> index baca4786ff94..bc599a864637 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> @@ -24,12 +24,13 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - qcom,sc7280-ipcc
> +          - qcom,sc8280xp-ipcc
>            - qcom,sm6350-ipcc
>            - qcom,sm6375-ipcc
>            - qcom,sm8250-ipcc
>            - qcom,sm8350-ipcc
>            - qcom,sm8450-ipcc
> -          - qcom,sc7280-ipcc
>        - const: qcom,ipcc
>  
>    reg:
> -- 
> 2.38.0
> 

-- 
மணிவண்ணன் சதாசிவம்
