Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53A67702B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 16:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjAVPbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 10:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjAVPbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 10:31:46 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3126A23322;
        Sun, 22 Jan 2023 07:31:38 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id v17so8414401oie.5;
        Sun, 22 Jan 2023 07:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FZkzDMS1ZlJGneVFTqUpOfvr7Yi2qPmA1JudWoB5Wqg=;
        b=nNKsSB5TugDXqkh8lLiYb739wt+tyIaR7+t9Ab8wFgX6BWz7oWmj8kXnrRujCMIHe+
         qhRZItbGdsVKh0Rc+2yqEV7M5KNbv2CddLlHASGqCOAHxDlEhWqDRCVFgGARnKP9ej7E
         1wEj6hIlEzB+I7Bj0VyjoQicjrw+oq69z2ouLDccmwKhd9zHUJ6lcYQq7hmE92nM5Cn1
         TtAtAGqYEoFfWquQtz6aNlxfWnTgoNj8IH+xqFXEUqCtfjPEfS38mGzpVvHDTkQByBLI
         rErgv6nZJqU71+5j9yod52ebQ7wdRq7C3tqGUFcd3zU07zkBeXdHaSTVGgZDhIyTFfE8
         3a0A==
X-Gm-Message-State: AFqh2kobre0RzGTBx/DiXcsws7po8pfDyi0xWyNrzXkymm3SpwyWisfK
        9K1blrbFoRIPrORYVUq81Q==
X-Google-Smtp-Source: AMrXdXs6x0mubg9C92n0oqZLWm6BQqgv4Go44B2qICGsMrS6njK5eu8A1Orc0x+NYVCJMr9qIjOXdQ==
X-Received: by 2002:a05:6808:189d:b0:364:d523:e138 with SMTP id bi29-20020a056808189d00b00364d523e138mr11734098oib.32.1674401497338;
        Sun, 22 Jan 2023 07:31:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0602000000b0036508145326sm10737337oig.9.2023.01.22.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 07:31:36 -0800 (PST)
Received: (nullmailer pid 2288127 invoked by uid 1000);
        Sun, 22 Jan 2023 15:31:35 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>, janne@jannau.net,
        asahi@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230121153544.467126-3-rayyan@ansari.sh>
References: <20230121153544.467126-1-rayyan@ansari.sh>
 <20230121153544.467126-3-rayyan@ansari.sh>
Message-Id: <167440123887.2283488.2841716718270566192.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple-framebuffer: Document
 physical width and height properties
Date:   Sun, 22 Jan 2023 09:31:35 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Jan 2023 15:35:44 +0000, Rayyan Ansari wrote:
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  .../devicetree/bindings/display/simple-framebuffer.yaml   | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/simple-framebuffer.yaml: properties:width-mm: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/simple-framebuffer.yaml: properties:height-mm: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230121153544.467126-3-rayyan@ansari.sh

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

