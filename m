Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FB36E497A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjDQNLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjDQNL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:11:29 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824CFB77B;
        Mon, 17 Apr 2023 06:10:50 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id be20so2604211oib.4;
        Mon, 17 Apr 2023 06:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681737028; x=1684329028;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XGc5GbTW6kZhqyLY58+PiGrV4TzfIzCtj6GSngzzGx0=;
        b=Lc5xMvcAHe6Hj4NCjygMrZEa6RW1PRBMh5dkaq+Zvr4wufgdqodC8g2of3SBjwv4Jl
         xQ+p3JPbtzMs2T+JZJr72nslbUyK34+hWwYTXcmmPQq1H6OQwyLwBNg4ML+BRaew4x6B
         2x7rGXbytBb8zqaN4oh5ry6ZLTVE/6szrxQtSUn7TOrU9gK5pJt4yuPlXfx6rotAeNRk
         INHKQsOKzTFprpWAG/nS8L960K2qVmtaJc9ewYdPG/2EGVjnRM8dcHw19Euiif8IcUNq
         iab9vlFFRcRFBxe07tt301rEvq3Ui1VsyWTBhFB7Pz7/EZofEepr+Z7accOI79kB1VDD
         7LPQ==
X-Gm-Message-State: AAQBX9dLTteALJlJcMNDL0qTUTuUcWTs0MLZ+7+WqIxIoNMwsH1qGtf2
        N63my02ROw+sUxEJat8fguxAJzHmKA==
X-Google-Smtp-Source: AKy350bLOodLTGfu7sS/UE8gZ4DIs15DTghBMqDc5P7PbXHAE80LzdytFuibl1XHbvlxfKHLrIz+Rw==
X-Received: by 2002:a05:6808:23c6:b0:38e:8c6:8793 with SMTP id bq6-20020a05680823c600b0038e08c68793mr1670112oib.2.1681737028477;
        Mon, 17 Apr 2023 06:10:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 63-20020aca0742000000b003896b3269d3sm4570296oih.20.2023.04.17.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:10:28 -0700 (PDT)
Received: (nullmailer pid 2588762 invoked by uid 1000);
        Mon, 17 Apr 2023 13:10:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     David Yang <mmyangfl@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20230414181302.986271-2-mmyangfl@gmail.com>
References: <20230414181302.986271-1-mmyangfl@gmail.com>
 <20230414181302.986271-2-mmyangfl@gmail.com>
Message-Id: <168173527448.2535459.6262053412684555960.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add reg-clock-controller
Date:   Mon, 17 Apr 2023 08:10:27 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Apr 2023 02:12:59 +0800, David Yang wrote:
> Add DT bindings documentation for reg-clock-controller, collection of
> basic clocks common to many platforms.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../bindings/clock/reg-clock-controller.yaml  | 245 ++++++++++++++++++
>  1 file changed, 245 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/reg-clock-controller.example.dtb: reg-clk-ctrl@ffff0000: 'gate-clock@cc-3' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230414181302.986271-2-mmyangfl@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

