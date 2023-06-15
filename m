Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F71B73207C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjFOTrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFOTrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:47:45 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF7A268A;
        Thu, 15 Jun 2023 12:47:44 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-777a4926555so2387839f.0;
        Thu, 15 Jun 2023 12:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686858463; x=1689450463;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BoanQllugvdpQeDJKzQh2Vhxrm51worbUy3JNVYOXfY=;
        b=ldF/f6BJFxCS/Mh+fLs64v8zZt0onz0uCfOfvutSckHvCs3iojFmemoey6gNmqFET0
         NrtYFucudXjQ2mdcFk4TChHsotHNTkC5wDOxePBOZmjVqklz67lxrhcFzgsnM5zrPoIE
         uREdh7B44dCeFCkVCVF+cObImydM2MUuhnMoQl9ymBIOBKAO25Hr1HLo76hROQmpARO5
         VSoBHgE0jhHxoVk2OUYjdJoTFnq5HRA2eBOlWITGauxFus9T2249qu8JjkgxKllI7pug
         C+y8P0VFU12xwSpwArXE6Un++p5JqvTfWXcBi54SUkbURsaAbOlHbCvVtZJyWI0Zigby
         K6/g==
X-Gm-Message-State: AC+VfDxSp9BANQYs3t63xDILrn+CMkUyYVg3lXw78ZA+EQU27zNKYmfz
        Hy3CNbtZLWwAOwHUu7jKcQ==
X-Google-Smtp-Source: ACHHUZ7d3DvP7l3zfWutNtmjbI34IfXHzMgmlTEjZRNw9Rnk5sVkcDsBlAlRpDu33vLwLk+wRDNwjQ==
X-Received: by 2002:a05:6602:2d87:b0:774:9415:bed8 with SMTP id k7-20020a0566022d8700b007749415bed8mr4195831iow.10.1686858463454;
        Thu, 15 Jun 2023 12:47:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l17-20020a056638221100b0041f4da30787sm5696946jas.167.2023.06.15.12.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:47:42 -0700 (PDT)
Received: (nullmailer pid 1560576 invoked by uid 1000);
        Thu, 15 Jun 2023 19:47:40 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     linux-amlogic@lists.infradead.org, Artem <art@khadas.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-serial@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Nick <nick@khadas.com>, Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230615182938.18487-3-tanure@linux.com>
References: <20230615182938.18487-1-tanure@linux.com>
 <20230615182938.18487-3-tanure@linux.com>
Message-Id: <168685846058.1560559.10275388482372807124.robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: clock: Bindings for Meson T7 clock
 controller
Date:   Thu, 15 Jun 2023 13:47:40 -0600
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


On Thu, 15 Jun 2023 19:29:34 +0100, Lucas Tanure wrote:
> Add documentation for T7 the clock controller.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  .../bindings/clock/amlogic,mesont7.yaml       |  69 +++
>  include/dt-bindings/clock/mesont7-clkc.h      | 487 ++++++++++++++++++
>  2 files changed, 556 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
>  create mode 100644 include/dt-bindings/clock/mesont7-clkc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/clock/amlogic,mesont7-clk.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
Documentation/devicetree/bindings/clock/amlogic,mesont7.example.dts:18.32-28.11: Warning (unit_address_vs_reg): /example-0/clock-controller: node has a reg or ranges property, but no unit name
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,mesont7.example.dtb: clock-controller: reg: [[0, 0], [0, 1180], [0, 32768], [0, 800], [0, 57408], [0, 188]] is too long
	from schema $id: http://devicetree.org/schemas/clock/amlogic,mesont7-clk.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230615182938.18487-3-tanure@linux.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

