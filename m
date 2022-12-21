Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17A065375D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiLUUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiLUUJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:09:44 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E83226AD3;
        Wed, 21 Dec 2022 12:09:43 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id d2-20020a4ab202000000b004ae3035538bso1993354ooo.12;
        Wed, 21 Dec 2022 12:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7hY8G8o4GP1gTqYrBQoBdXzTjanx+NXgVGTmmfwXwXs=;
        b=77cDXUw5wB9tIVZUvaIgqdgsJ+nYkuuAZUE6ONMh2rfFE7uHL1ZkorR9IAeaszBxFJ
         STfmRo1/O+vFdpdM+cSVLrCQZ5qKpcsrySUmzPiKGYVaOPOWsEMqxxsMUjZYgQf9U9Vu
         2KCQPVcgSozLhYrwtZO/TWKTCT72g+0Pe5kFIWsTB86WB7mzpaM9NoQZnNyYDklHDDJl
         eHvhMPahbF/HDXT5l/WSWwiT8gr6X4THa8JFOsM/zOrJC7bJvxiu+EXm4rCJ6xOtxPqb
         H/bJCzCdIT54KoDtK/hwU1rzYlDWNn1/UYmznFzead6SEn9c0bbcSKW/uEzPH7+bUe0U
         NblA==
X-Gm-Message-State: AFqh2kqzl9XHfsBlXVPP8FjaydBX2y+Mf7hlyu0slJxwJI5bwi5vwA+j
        OjQXTSzjxgDKANbW+tYEKrXFssZ5UA==
X-Google-Smtp-Source: AMrXdXveW3JoX6VWWBCCN4Q7iiVTUWg23bq1ov+RfxpKJ/SnFEaIJTtMr3mHKg7dfWRpEyJaD1BcIg==
X-Received: by 2002:a4a:e7cf:0:b0:4a3:51a2:f8ba with SMTP id y15-20020a4ae7cf000000b004a351a2f8bamr1438923oov.6.1671653382279;
        Wed, 21 Dec 2022 12:09:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r15-20020a4a964f000000b004a085ddc771sm6463496ooi.6.2022.12.21.12.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 12:09:41 -0800 (PST)
Received: (nullmailer pid 3506211 invoked by uid 1000);
        Wed, 21 Dec 2022 20:09:41 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        loic.pallardy@st.com, linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        Oleksii_Moisieiev@epam.com, arnd@arndb.de
In-Reply-To: <20221221173055.11719-3-gatien.chevallier@foss.st.com>
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-3-gatien.chevallier@foss.st.com>
Message-Id: <167165333929.3500496.17240347378760070278.robh@kernel.org>
Subject: Re: [RFC PATCH 2/7] dt-bindings: bus: add STM32 System Bus
Date:   Wed, 21 Dec 2022 14:09:41 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2022 18:30:50 +0100, Gatien Chevallier wrote:
> Document STM32 System Bus. This bus is intended to control firewall
> access for the peripherals connected to it.
> 
> Signed-off-by: Loic PALLARDY <loic.pallardy@st.com>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  .../devicetree/bindings/bus/st,sys-bus.yaml   | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/st,sys-bus.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/bus/st,sys-bus.yaml:7:8: [warning] too many spaces after colon (colons)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,sys-bus.yaml: $id: 'http://devicetree.org/schemas/bus/stm32,sys-bus.yaml' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/st,sys-bus.yaml: properties:#feature-domain-cells: 'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
./Documentation/devicetree/bindings/bus/st,sys-bus.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/bus/st,sys-bus.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221221173055.11719-3-gatien.chevallier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

