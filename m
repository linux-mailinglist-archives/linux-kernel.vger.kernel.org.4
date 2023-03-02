Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253286A841C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCBOZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCBOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:25:05 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CCA37548;
        Thu,  2 Mar 2023 06:25:01 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id s1so22537052vsk.5;
        Thu, 02 Mar 2023 06:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8wDVKoxnSqfBIh2KA9I69m23GfuDCaWRKYYk9CbtV28=;
        b=s965aUpIY1lbFNd9bzIr6F2lcdwZ1KNwXBG0x7nMUGvm8oKNl00CKi6bu11HLr7zhH
         ycVEN0MBWYDNvTiLfpcykrYwNtcIBexEoqPQta3CREOZG8gQsN7IGy1gZy/Q89d1JK4Q
         8ZOOYYtXSI/K0uSBIVI7Ane4XFAp0yAT6O5e0LSdBemxKtj1Wk0wS4z+TNW0/PYwwy7O
         JU9PxiLgQbw0Cw5f+Np53HSOTRh5DNLOE3tpuLzzKE6rvuMk6F6iU6IsBk91FhN47qZY
         PRgllyYcr64WHyOWPzCwwjn0lGaRxLUR53HzktU04SZI4kxZb9Att9GmnI7uTvcHhOH5
         WIoQ==
X-Gm-Message-State: AO0yUKXMvc+QpMjsthyzK5dgr7hlcOpPCBzgyMzPp0EJ6sJfYqJGWGO8
        2jsSzfoDJy86z7UfsrAKNc3LvFum76Bo
X-Google-Smtp-Source: AK7set8DcBKW2UHTl1N3Sx8zSZmipJcIPDcIoj4LHB6kl8FBAn53qpN6vh65KHTjOPO0RDA1pWLv/A==
X-Received: by 2002:a67:e3ac:0:b0:412:4d64:8c00 with SMTP id j12-20020a67e3ac000000b004124d648c00mr4442928vsm.15.1677767100159;
        Thu, 02 Mar 2023 06:25:00 -0800 (PST)
Received: from robh_at_kernel.org ([209.91.220.210])
        by smtp.gmail.com with ESMTPSA id t5-20020a675f05000000b0041f5ee512d7sm1681653vsb.3.2023.03.02.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 06:24:59 -0800 (PST)
Received: (nullmailer pid 427877 invoked by uid 1000);
        Thu, 02 Mar 2023 14:24:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230302134922.1120217-2-linux@rasmusvillemoes.dk>
References: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
 <20230302134922.1120217-2-linux@rasmusvillemoes.dk>
Message-Id: <167776666863.418220.8691645201749142592.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: ad74413r: allow setting sink
 current for digital input
Date:   Thu, 02 Mar 2023 08:24:58 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Mar 2023 14:49:20 +0100, Rasmus Villemoes wrote:
> Depending on the actual hardware wired up to a digital input channel,
> it may be necessary to configure the ad74413r to sink a small
> current. For example, in the case of a simple mechanical switch, the
> charge on the external 68 nF capacitor (cf. the data sheet's Figure
> 34) will keep the channel as reading high even after the switch is
> turned off again.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../devicetree/bindings/iio/addac/adi,ad74413r.yaml    | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: patternProperties:^channel@[0-3]$:properties:drive-strength-microamp: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230302134922.1120217-2-linux@rasmusvillemoes.dk

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

