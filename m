Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BBE666720
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjAKXZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjAKXZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:25:35 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106693C71D;
        Wed, 11 Jan 2023 15:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/U5bcrGDanLKc62PA+phmWzytWx8BAc4mSGDJUe5s0E=; b=rz2FNkYl+FVT6TsC5LKkpaPIPb
        K55zYA32f2ILfOZQdlYcdLenT1Q9fY+CCFEz3qBDZodc+Mm7hgCdUVtTMyoVyek7Js1Tcft0bMiF4
        TPVmdUdWui+LB4KIHJX1lCppWjFkAPvYBm43Ro6g53G7aDkQbgPCWU+GidX/Njl0d3nI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41168 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pFkTJ-00015P-Vp; Wed, 11 Jan 2023 18:25:31 -0500
Date:   Wed, 11 Jan 2023 18:25:29 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hvilleneuve@dimonoff.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        lars@metafoo.de
Message-Id: <20230111182529.b9a40a24b23bfe0bfe933aac@hugovil.com>
In-Reply-To: <167340066186.3433002.1362198141589296440.robh@kernel.org>
References: <20230110160124.3853593-1-hugo@hugovil.com>
        <20230110160124.3853593-3-hugo@hugovil.com>
        <167340066186.3433002.1362198141589296440.robh@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: add Texas Instruments
 ADS7924
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 19:34:56 -0600
Rob Herring <robh@kernel.org> wrote:

> 
> On Tue, 10 Jan 2023 11:01:24 -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add device tree bindings document for the Texas Instruments ADS7924
> > ADC.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../bindings/iio/adc/ti,ads7924.yaml          | 104 ++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml: 'oneOf' conditional failed, one must be fixed:
> 	'unevaluatedProperties' is a required property
> 	'additionalProperties' is a required property
> 	hint: Either unevaluatedProperties or additionalProperties must be present
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> Error: Documentation/devicetree/bindings/iio/adc/ti,ads7924.example.dts:29.40-41 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/iio/adc/ti,ads7924.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1508: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230110160124.3853593-3-hugo@hugovil.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.

Hi Rob,
I already did specify the base-commit in the first patch of the series (cover letter). Do you also want me to add an additional message in *this* commit to specify the git repos and branch that were used? Or put this comment in the cover letter?

I tried to follow the documentation here:
    https://www.kernel.org/doc/html/v6.2-rc3/process/submitting-patches.html
but it was not clear as to what base branch to use when no "T:" field is found in the MAINTAINERS file.

> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade

I didn't run it for this series, my bad, I now have added it to my automated scripts to not forget it next time.

> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

Done, thank you for your suggestions.

Hugo Villeneuve <hugo@hugovil.com>
