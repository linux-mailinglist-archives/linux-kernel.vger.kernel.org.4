Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309C668F1FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjBHP2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjBHP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:28:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79FD72A0;
        Wed,  8 Feb 2023 07:28:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E05CE616FC;
        Wed,  8 Feb 2023 15:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8823AC433D2;
        Wed,  8 Feb 2023 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675870115;
        bh=HU9yDg0ckhjoVsidarnY13PzpvlqPHX5wbjSDIULsGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYomd0n8PB9/6/WZnQv2uVjcs5UKrELeLnk6ayos2rqUnMVE2h3FUPzQdF/1L7vzs
         IvTqnCYWZTtD6Kb5y9vCOCoBl6KWbQnHZuE3E7lYPjgrOlVE+NF1g/eaIsoYjlfswp
         6rsA2Kb4MEnQA0z7vwvl5AhuDSavgkfql40R8tVcGaDSzBMJEvvC/KpPJKDwAbKhXp
         qpdWoeSIR5q2XXQ6dr1I+8l+JVtA/LAOeX6z3ieY4vmM3DICtU7Hgb9tWQ1ZOVmJMg
         OT3NYHetABtwlJwtJQLpa5HpB39jDBF0PK4Zl21TsuZ3p/dFWmzm36JR6P5qvBArU9
         K+hCq4poApCpg==
Date:   Wed, 8 Feb 2023 20:58:26 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: ufs: qcom: Add SM8550 compatible
 string
Message-ID: <20230208152826.GA13510@thinkpad>
References: <20230119151406.4168685-1-abel.vesa@linaro.org>
 <20230119151406.4168685-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119151406.4168685-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 05:14:06PM +0200, Abel Vesa wrote:
> Document the compatible for the UFS found on SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index 54f5f8dc5c87..108c281e9d09 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -33,6 +33,7 @@ properties:
>            - qcom,sm8250-ufshc
>            - qcom,sm8350-ufshc
>            - qcom,sm8450-ufshc
> +          - qcom,sm8550-ufshc
>        - const: qcom,ufshc
>        - const: jedec,ufs-2.0
>  
> @@ -106,6 +107,7 @@ allOf:
>                - qcom,sm8250-ufshc
>                - qcom,sm8350-ufshc
>                - qcom,sm8450-ufshc
> +              - qcom,sm8550-ufshc
>      then:
>        properties:
>          clocks:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
