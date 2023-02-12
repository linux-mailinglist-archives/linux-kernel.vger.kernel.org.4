Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6F6939C2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBLUJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLUJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:09:53 -0500
Received: from mr85p00im-zteg06011501.me.com (mr85p00im-zteg06011501.me.com [17.58.23.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D0CC14
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676232592; bh=EVIRhs3xEq9yHIC3HSiuuFwAfo1kqMaerO2qRCdic1c=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=lWHI7NUS0qI0K7sLa/NzfFUpL2lz2QzU96yanUIhrS3a2SjJh+L1PR7AHYZ3E1in0
         nbIcdRmGdgUPGRonyZzTyySoyPVsTeZxOYpBRmJvBcV9d1Kdsz+lrY9WY2ds/K4lQ/
         JJKGYx/iEmj/C8WsBGNsk2+1hsl95e3sJcBWwljmEGVKnUaIR+Xkg16TaZOSHUMXu0
         C9F2ogRcGsn2vCbDfsss7kZ0hfkszBP76mFHrFkEirZUVsODFe+jWgW3pGfU5c4xdy
         6zaDd2vJbEkc3muj7Gbnic0Jmsjdxs85WbQdTjhfqOddzImLmjzOhltihV2owf5Hs+
         9pTKxLC8mCBgQ==
Received: from imac101 (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id 9EE87480119;
        Sun, 12 Feb 2023 20:09:50 +0000 (UTC)
Date:   Sun, 12 Feb 2023 21:09:45 +0100
From:   Alain Volmat <avolmat@me.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: sti: addition of STi platform
 syscon
Message-ID: <Y+lHiZRDH9brl3FR@imac101>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230211210500.9919-1-avolmat@me.com>
 <e34c139f-3477-8689-af01-29560f8c1265@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34c139f-3477-8689-af01-29560f8c1265@linaro.org>
X-Proofpoint-GUID: XzCK8M9dndBrr7_HBWyoXJV3mrWLCIy0
X-Proofpoint-ORIG-GUID: XzCK8M9dndBrr7_HBWyoXJV3mrWLCIy0
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302120184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On Sun, Feb 12, 2023 at 05:00:24PM +0100, Krzysztof Kozlowski wrote:
> Thank you for your patch. There is something to discuss/improve. Few nits.
> 
> On 11/02/2023 22:04, Alain Volmat wrote:
> > Addition of the various STi platform syscon node description.
> 
> Use imperative.
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> > 
> > Signed-off-by: Alain Volmat <avolmat@me.com>
> > ---
> >  .../bindings/arm/sti/st,sti-syscon.yaml       | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml b/Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml
> > new file mode 100644
> > index 000000000000..e4bbc90694b3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/sti/st,sti-syscon.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: STMicroelectronics STi platform sysconfig entries
> 
> 
> Drop "entries", does not look related to hardware.
> 
> > +
> > +maintainers:
> > +  - Patrice Chotard <patrice.chotard@foss.st.com>
> > +
> > +description: |
> > +  Binding for the various sysconfig nodes used within the STi
> > +  platform device-tree to point to some common configuration
> > +  registers used by other nodes.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - st,stih407-sbc-syscfg
> > +          - st,stih407-front-syscfg
> > +          - st,stih407-rear-syscfg
> > +          - st,stih407-flash-syscfg
> > +          - st,stih407-sbc-reg-syscfg
> > +          - st,stih407-core-syscfg
> > +          - st,stih407-lpm-syscfg
> 
> How about putting them in some order?

Ok, changed to alphabet order

> 
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    syscfg_sbc: sbc-syscfg@9620000 {
> 
> Generic node names, thus usually syscon or system-controller

Ok, changed to syscfg_sbc: syscon@9620000

I also move the file within bindings/soc/sti as mentioned in your other
reply.

> > +...
> 
> Best regards,
> Krzysztof
> 
