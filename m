Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E90618338
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiKCPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiKCPrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:47:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168901D9;
        Thu,  3 Nov 2022 08:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BF53B828E7;
        Thu,  3 Nov 2022 15:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B1EC433D6;
        Thu,  3 Nov 2022 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667490416;
        bh=vqpeGan61fCkkfwIsVUgRmalvG5s3JdgtRVYenc6G8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+EMfX1w3y8KGdo4G3gGdlS9mjrpxOhGN0NMwIe6RTn4G9IPHn5p+TiR78IX7SqDr
         v9IZilEnW8hKORY0qIOy/KhrlLHhp5b9H9Q21AYY5PCyEjZqfBYCImlm6AVaeJhsb+
         slYw3pOjc76MPGDefU6pzYSQydfH/uvuXSdh2/GW+cteEhcfM86zZ1c8VGIpgRhqMi
         EvbFsMW9+1McsxsJqpUdXlJUt25CwU6rFek4ieUcqbYx6O8bVUFP+Urw4p/QPWL5YZ
         ngZ97k+Ht8OatF5yCDY1Ym93y09q28WR8UXdZwgROaNdm+wg/oJjOjus5EDvm0D2og
         iQCShFZf3N+vg==
Date:   Thu, 3 Nov 2022 10:46:53 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: interconnect: Add sm8350, sc8280xp
 and generic OSM L3 compatibles
Message-ID: <20221103154653.67mgsey57uvdcvx3@builder.lan>
References: <20221028034155.5580-1-quic_bjorande@quicinc.com>
 <20221028034155.5580-6-quic_bjorande@quicinc.com>
 <a364b343-fa19-348c-bc38-e8b44061890b@linaro.org>
 <20221103034410.GB5525@core-thresher1.qualcomm.com>
 <f3882934-9f95-39f1-83e4-6ce9efeb089c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3882934-9f95-39f1-83e4-6ce9efeb089c@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:25:17AM -0400, Krzysztof Kozlowski wrote:
> On 02/11/2022 23:44, Bjorn Andersson wrote:
> > On Fri, Oct 28, 2022 at 06:12:29PM -0400, Krzysztof Kozlowski wrote:
> >> On 27/10/2022 23:41, Bjorn Andersson wrote:
> >>> Add EPSS L3 compatibles for sm8350 and sc8280xp, but while at it also
> >>> introduce generic compatible for both qcom,osm-l3 and qcom,epss-l3.
> >>>
> >>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> >>> ---
> >>>  .../bindings/interconnect/qcom,osm-l3.yaml    | 22 +++++++++++++------
> >>>  1 file changed, 15 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> >>> index bf538c0c5a81..ae0995341a78 100644
> >>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> >>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> >>> @@ -16,13 +16,21 @@ description:
> >>>  
> >>>  properties:
> >>>    compatible:
> >>> -    enum:
> >>> -      - qcom,sc7180-osm-l3
> >>> -      - qcom,sc7280-epss-l3
> >>> -      - qcom,sc8180x-osm-l3
> >>> -      - qcom,sdm845-osm-l3
> >>> -      - qcom,sm8150-osm-l3
> >>> -      - qcom,sm8250-epss-l3
> >>> +    oneOf:
> >>> +      items:
> >>
> >> oneOf expects a list, so this should be "    - items"
> >>
> > 
> > Ahh, thanks. Must have missed running the dt_binding_check on this one.
> > 
> >>> +        - enum:
> >>> +            - qcom,sc7180-osm-l3
> >>> +            - qcom,sc8180x-osm-l3
> >>> +            - qcom,sdm845-osm-l3
> >>> +            - qcom,sm8150-osm-l3
> >>> +        - const: qcom,osm-l3
> >>
> >> The concept is good, but are you sure all SoCs will be compatible with
> >> generic osm-l3?
> > 
> > Per the current implementation yes, worst case if one or more of them isn't the
> > more specific compatible can be used to alter the behavior of that platform.
> > 
> >> Why not using dedicated compatible of one soc, e.g. the
> >> oldest here? We already did like that for BWMON, DMA and few others.
> >>
> > 
> > Because if we say compatible = "qcom,sc8180x-osm-l3", "qcom,sdm845-osm-l3" and
> > there is a quirk needed for "qcom,sdm845-osm-l3" we're forced to add a "special
> > case" every other *-osm-l3 in the driver.
> > 
> > This way we can have a generic implementation for the qcom,osm-l3 and if we
> > realize that we need to quirk something for the oldest platform, we can do so
> > without affecting the others.
> 
> True. This also means we do not really know which one is the generic
> implementation :)
> 

There currently is an implementation without platform specific quirks, I
call that the generic implementation and suggest that we refer to that
using "qcom,osm-l3".

If we instead were to use sdm845 as the generic compatible, and there
turns out to be a need for a quirk for this platform, you:

1) no longer have a generic implementation, but 4 platform-specific
   implementations

2) have 3 platforms claiming to be compatible with the quirked (now
   specialized) implementation, which they clearly aren't anymore

Therefor I favor using generic names for generic compatibles.

Regards,
Bjorn
