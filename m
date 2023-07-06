Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D893674A37B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjGFR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:57:23 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE37BA;
        Thu,  6 Jul 2023 10:57:22 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3461163c0b6so3635235ab.2;
        Thu, 06 Jul 2023 10:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666241; x=1691258241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV1zMg54RJPWlDZe+X9hD1kl6IZTlt7E6/xw4ZsYjnI=;
        b=Y68xvb6unAPDTVfBAedmxUhzOTjOQxsVL7bfWK1uCky+SMSKbdIQF9lUDtLkPYnXgW
         CDopWkpIGPEB+H3kgOyL6eYcWIedc2n8hLMENFSnhmnFhRLnpmAIpUlLz/SZFB3PR8Wb
         LdYaVldyZB5peVmfywKCFnTuvojkCtInD/+A5gAexnG/PClltu/fQhjkGju+Z3Dy6ute
         v3X/rhSy5ugAZeIyiSdYwe9oVOI60jY+pXH0AzYETrWNwp9EbKP7mQVDuMROBNzp1YH0
         sGlcqfWQwIPMwG83AWG4cetiReh8XQQhwuCy5RM9BBLb13xk9rzucv5VA/bWWgFmt7dB
         80cg==
X-Gm-Message-State: ABy/qLbKq3m0eo7OXXjioZhRlUNr+HZMHOi5KEDPqz3G0XJjHyycenc4
        iMBVynDk3mTZbxhZdGLrjA==
X-Google-Smtp-Source: APBJJlFwswbERMy55C04zEpNuMZqN7dDP8aAwJZViP81idcmehEyswZ9IkHk4oBuVoBzoxTREvItGQ==
X-Received: by 2002:a92:dc09:0:b0:345:db54:47ee with SMTP id t9-20020a92dc09000000b00345db5447eemr3137644iln.10.1688666241586;
        Thu, 06 Jul 2023 10:57:21 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n13-20020a02a90d000000b0041fb2506011sm647956jam.172.2023.07.06.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 10:57:20 -0700 (PDT)
Received: (nullmailer pid 64315 invoked by uid 1000);
        Thu, 06 Jul 2023 17:57:18 -0000
Date:   Thu, 6 Jul 2023 11:57:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org,
        conor+dt@kernel.org, jirislaby@kernel.org,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        xianwei.zhao@amlogic.com, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kelvin.zhang@amlogic.com,
        rockosov@gmail.com, khilman@baylibre.com,
        devicetree@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2 6/7] dt-bindings: serial: amlogic,meson-uart: support
 Amlogic A1
Message-ID: <168866621271.63404.12853551833647005497.robh@kernel.org>
References: <20230705181833.16137-1-ddrokosov@sberdevices.ru>
 <20230705181833.16137-7-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705181833.16137-7-ddrokosov@sberdevices.ru>
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


On Wed, 05 Jul 2023 21:18:32 +0300, Dmitry Rokosov wrote:
> Introduce meson uart serial bindings for A1 SoC family.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring <robh@kernel.org>



