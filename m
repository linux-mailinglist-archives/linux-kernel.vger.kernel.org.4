Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF25BA5FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIPEkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIPEkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:40:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E4B52804;
        Thu, 15 Sep 2022 21:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A309B82394;
        Fri, 16 Sep 2022 04:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB67C433C1;
        Fri, 16 Sep 2022 04:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663303229;
        bh=FxIIBNOiH+QYHDwcMlk7y0PQANGV3n3aMaOGnUbOzp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PwRb0rUL/sItWHKfdbaDVmHdVq+yL8xKQTP+kP0STMzgYni6v/8TAh56r6FdC9Yc/
         wikzt+JjtI00As4SH6jquYn/vAiof5LlmfbJ3lyNhXNBU7UjB079DMQ2iAr7rle9J8
         z6B8kh8A28c0+DUcVbCIL0aGSfEpb9oJIIO38pv4GeVkNv//bbBmEibQM0gDR1r52k
         c/48Bvx4L3dkH9S0MzX1/RekZrV605Py3j7R3yt9dWY7jEKBc4iXnfOXdt0msj7jH2
         NgKeuSbPDABg/81eLHIMANdmJ5nPcixkdBn8kUHJlG4P4zL9cTUZ4umsjeBIyg77Cq
         4c9z2+tqn6pog==
Date:   Fri, 16 Sep 2022 10:10:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: spmi: Add qcom,bus-id
Message-ID: <YyP+OXD5yPWBCkQb@matsya>
References: <20220914165212.3705892-1-vkoul@kernel.org>
 <20220914165212.3705892-2-vkoul@kernel.org>
 <20220915095103.7qys3ixd6yyngkzs@krzk-bin>
 <20220915115955.GA986622-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915115955.GA986622-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-09-22, 06:59, Rob Herring wrote:
> On Thu, Sep 15, 2022 at 10:51:03AM +0100, Krzysztof Kozlowski wrote:
> > On Wed, 14 Sep 2022 22:22:11 +0530, Vinod Koul wrote:
> > > For PMIC arbiter version 7 and beyond we need to define if we are using
> > > primary or secondary bus, so add a new property of qcom,bus-id
> > > 
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml   | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: Unevaluated properties are not allowed ('dma-channels', 'dma-masters', 'dma-requests' were unexpected)
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
> 
> Ignore this. Unrelated.

Right!

-- 
~Vinod
