Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA2A6A8330
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCBNFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCBNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:05:07 -0500
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7051ABD1;
        Thu,  2 Mar 2023 05:05:05 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-536bbef1c5eso425580197b3.9;
        Thu, 02 Mar 2023 05:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X18LEh0g5lt3E5bs+v6xlkNcEAN9JmhuluP548V82lk=;
        b=7DO5xhlSe6ZWNzdsjYgF7xG5ewOv4U798/W53gc8Pf3U5LbJfi4ySwUGSBjlSojJc3
         XfCmsV/Y4kHe14xFsu99Pw7Ms1dl4WZ4+FF9Ixurg0VaMtxrA9/cUrb6G3fDpkcjhiBr
         KzXcSn5sX+f4n+yMi/Snv/YJ/qU1fFOZfvrAcST3Eos017slOJQ4iPh8ZeiTHwD03rFZ
         81+dZhKf0MYdsmFhwJCkRIFsBvR9J0plIj3atuYomsQ6Q6DHrbMDRJDFki/C5NTM4evc
         /12YiK9SV8sekxvBAKwAz1wzTVjhpmdpdshryt5yqAi6fM8pSdBNk8mQIePDdyaCS7Ae
         gaAg==
X-Gm-Message-State: AO0yUKWRqNRbEJ2u9S+3TVXCARMYWXam/0gF1gvVImVrXkHKhl3LT3lL
        FSruPenDo8YFngyDPc33Tg==
X-Google-Smtp-Source: AK7set99Kml+ZlGBFLIQciIuYyUn/ayyZxT/PJoaMEmLBbf6uluXXipONSdP2IEsSPutmUjyQ1oISw==
X-Received: by 2002:a05:7500:4395:b0:f8:882c:4e5e with SMTP id fn21-20020a057500439500b000f8882c4e5emr246636gab.77.1677762304745;
        Thu, 02 Mar 2023 05:05:04 -0800 (PST)
Received: from robh_at_kernel.org ([209.91.220.210])
        by smtp.gmail.com with ESMTPSA id l4-20020ab053c4000000b0068b8c1fa859sm1977991uaa.26.2023.03.02.05.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 05:05:04 -0800 (PST)
Received: (nullmailer pid 284033 invoked by uid 1000);
        Thu, 02 Mar 2023 13:05:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     richard.leitner@linux.dev
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ladislav Michl <ladis@linux-mips.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        devicetree@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20230302-max9867-v1-1-aa9f7f25db5e@skidata.com>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-1-aa9f7f25db5e@skidata.com>
Message-Id: <167775917220.270950.1253335215666674705.robh@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: maxim,max9867: convert txt
 bindings to yaml
Date:   Thu, 02 Mar 2023 07:05:02 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Mar 2023 12:55:01 +0100, richard.leitner@linux.dev wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Convert from max9867.txt to maxim,max9867.yaml and add missing
> '#sound-dai-cells' property.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  .../devicetree/bindings/sound/max9867.txt          | 17 --------
>  .../devicetree/bindings/sound/maxim,max9867.yaml   | 51 ++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 17 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/maxim,max9867.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
./Documentation/devicetree/bindings/sound/maxim,max9867.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/sound/maxim,max9867.yaml#
Error: Documentation/devicetree/bindings/sound/maxim,max9867.example.dts:18.9-13 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/sound/maxim,max9867.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230302-max9867-v1-1-aa9f7f25db5e@skidata.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

