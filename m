Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4FD735CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFSRRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSRRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:17:46 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7F1B2;
        Mon, 19 Jun 2023 10:17:45 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77e2df49a91so98703639f.2;
        Mon, 19 Jun 2023 10:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687195065; x=1689787065;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QWcThq/h02+s+wcg2Hr4AaoQzShvDZL/nv4qKzi7L/0=;
        b=WXK/SyKek7uTLjaEOrkMcKOuW9YCuD8Fjrqfl4dXgKAN9cpbJIQ6t3hvyZ/Cu8qO4j
         61YQaBy2MI6a+u6+Y6vxcc2Wng9xBlqlw5FmuWjAVOQ8SIfG0pBxVflCIJ0XZxsmasIN
         +Y0ieBWp0OuH/Qp8yL3BNiLxzEfNrn8B2EnGtsnoF1IUKJy6Um8ThjOoL4NIykT7ELZ0
         ruKmHAsyv8VzBhNy7S6TIYMSV5G6mnqv8ZUUbqNyFvUzShmOzvAh1bgECCw4yzuCXVcW
         xrYpFVZ2EtwEk0BFcvdaMZfoeE7bkx2Og6lZFPZTE95y+CEUykaRaeLJijPIhdgV7prA
         7cvQ==
X-Gm-Message-State: AC+VfDxajauu08SGP2umksi50dJwBuWsyaV+c47+DD2mxRxJQuc7dugL
        klHUXoKZvm8TdpXNlCazHg==
X-Google-Smtp-Source: ACHHUZ6rYV4VuZykUXSkm0tKMSUKMNa10Ofovryp4YB+E712Rgarm82iPHFXZnH0jReYkDPABmnYmw==
X-Received: by 2002:a5e:880b:0:b0:774:84f4:6ea with SMTP id l11-20020a5e880b000000b0077484f406eamr6600673ioj.11.1687195064770;
        Mon, 19 Jun 2023 10:17:44 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h4-20020a02b604000000b0040fadba66b0sm101906jam.58.2023.06.19.10.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 10:17:44 -0700 (PDT)
Received: (nullmailer pid 1420938 invoked by uid 1000);
        Mon, 19 Jun 2023 17:17:42 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dri-devel@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org, michael@amarulasolutions.com
In-Reply-To: <20230619165525.1035243-5-dario.binacchi@amarulasolutions.com>
References: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
 <20230619165525.1035243-5-dario.binacchi@amarulasolutions.com>
Message-Id: <168719506209.1420922.17702142182740385412.robh@kernel.org>
Subject: Re: [PATCH v4 4/6] dt-bindings: display: stm32-ltdc: add optional
 st,fb-bpp property
Date:   Mon, 19 Jun 2023 11:17:42 -0600
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


On Mon, 19 Jun 2023 18:55:23 +0200, Dario Binacchi wrote:
> Boards that use the STM32F{4,7} series have limited amounts of RAM. The
> added property allows to size, within certain limits, the memory footprint
> required by the framebuffer.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  .../devicetree/bindings/display/st,stm32-ltdc.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml: properties:st,fb-bpp:maxItems: False schema does not allow 1
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230619165525.1035243-5-dario.binacchi@amarulasolutions.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

