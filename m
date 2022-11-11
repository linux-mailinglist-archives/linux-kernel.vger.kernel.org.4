Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40706260E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiKKSI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiKKSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:08:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8172F11172;
        Fri, 11 Nov 2022 10:08:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF37CB826C6;
        Fri, 11 Nov 2022 18:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF649C433D6;
        Fri, 11 Nov 2022 18:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668190132;
        bh=1LwbWLiM0eqVngc+n5UKw3OXRN8eN1ijL20vt5kIfvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQJUR4QerNZHhDnRP7Laix+cZafg1YpBOLxx7wPkLceEDUQOZFS4TNQvtRrE90sa7
         CjJ7UfMtiXjon7StgiZOBKiQaOikJsp4D8ujESpsZiXlfyh2WBMeT+/Rt4sKAUtb58
         OqVfmcpk7VnLvx5aYeDjIu5fJd/JMMDSziXi/Seb0FwnbA6UyEXQnk+Op8YCaFyW7W
         ifR/N6f4dd/cL/o4mQwNVywKm/LqSmQMA8bbnlRqVWJIgkCofb8UVIJnBzjdlur39Q
         NTfv5qIElFI0LjvcGzqyZ548P73zxN/OTnfLL3lBNfFc+mbE4PD0xzXK0S9kl6A8N5
         qkK2PpdIWB41w==
Date:   Fri, 11 Nov 2022 12:08:49 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] dt-bindings: interconnect: Add sm8350, sc8280xp
 and generic OSM L3 compatibles
Message-ID: <20221111180849.hegnho4qeaewuzwz@builder.lan>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
 <20221111032515.3460-6-quic_bjorande@quicinc.com>
 <d738cdd8-1963-78d4-2c6f-6597b3b02d0f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d738cdd8-1963-78d4-2c6f-6597b3b02d0f@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 04:02:42PM +0530, Sibi Sankar wrote:
> 
> 
> On 11/11/22 08:55, Bjorn Andersson wrote:
> > Add EPSS L3 compatibles for sm8350 and sc8280xp, but while at it also
> > introduce generic compatible for both qcom,osm-l3 and qcom,epss-l3.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > Tested-by: Steev Klimaszewski <steev@kali.org>
> > ---
> > 
> > Changes since v1:
> > - Fixed oneOf to be valid schema
> > - Fixed example to follow schema
> > 
> >   .../bindings/interconnect/qcom,osm-l3.yaml    | 24 ++++++++++++-------
> >   1 file changed, 16 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> > index bf538c0c5a81..aadae4424ba9 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> > @@ -16,13 +16,21 @@ description:
> >   properties:
> >     compatible:
> > -    enum:
> > -      - qcom,sc7180-osm-l3
> > -      - qcom,sc7280-epss-l3
> > -      - qcom,sc8180x-osm-l3
> > -      - qcom,sdm845-osm-l3
> > -      - qcom,sm8150-osm-l3
> > -      - qcom,sm8250-epss-l3
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - qcom,sc7180-osm-l3
> > +              - qcom,sc8180x-osm-l3
> > +              - qcom,sdm845-osm-l3
> > +              - qcom,sm8150-osm-l3
> > +          - const: qcom,osm-l3
> > +      - items:
> > +          - enum:
> > +              - qcom,sc7280-epss-l3
> > +              - qcom,sc8280xp-epss-l3
> > +              - qcom,sm8250-epss-l3
> > +              - qcom,sm8350-epss-l3
> > +          - const: qcom,epss-l3
> 
> isn't it incorrect to describe qcom,epss-l3 as a working
> backup compatible for sc7280-epss-l3 and sm8250-epss-l3?
> Shouldn't we just add another items list with those 2 as
> enums?
> 

I was about to agree, but the difference between the two sets are which
registers we use to request the speed.

And per our recent discussion, I was under the impression that this
would be a property of BIT(0) in 0xb0 being set, not which platform
we're running on.

If that's the case then they are indeed compatible and we should adjust
.ref_perf_state based on per-core DCVS being set or not.


So I do think this description is appropriate...

Regards,
Bjorn

> >     reg:
> >       maxItems: 1
> > @@ -56,7 +64,7 @@ examples:
> >       #define RPMH_CXO_CLK        0
> >       osm_l3: interconnect@17d41000 {
> > -      compatible = "qcom,sdm845-osm-l3";
> > +      compatible = "qcom,sdm845-osm-l3", "qcom,osm-l3";
> >         reg = <0x17d41000 0x1400>;
> >         clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
