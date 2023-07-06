Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB374A437
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjGFTIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjGFTIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:08:36 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF21FDB;
        Thu,  6 Jul 2023 12:08:33 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7836164a08aso40571239f.1;
        Thu, 06 Jul 2023 12:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688670512; x=1691262512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Itwax76YnyojIQJLz79e5RUWj30r3AOwHBsYmcyrKf8=;
        b=h3ze9329Evz5ZWAAs2vdSPqTxjo0G+rc2sJcdRYl6wvBqgo794EmeCuY3XLVQm7i0b
         UiLJsqHeeytAprMAOJZwOqJosMQbDh7XrHjoOtMrP81+jMW5N0ErUBV7NCuyPIENy/06
         IdQuNYwznYwg7DTVqFLwt+3TgadQ/r3PyXLW9G9FCSqEPaYefhJt2rWwPynnMzM1VnN8
         edBVkSY0ksmKXRukrCSIglqWw6C1zyh2AH+95ITgn5GqRjuCSma7Me8z6S/7NeQd9tow
         OZLMUeyu5Fo3Vviv+vbh5cYEDd+BrDL+eqOTrEFLCmdTPQVkJIKHJshWnsTStQ93my5m
         YjpA==
X-Gm-Message-State: ABy/qLZbbvgfrZvNmG79wZ0iQZmhmb7DZKuhepNkiUAmvFIq60GT5KHL
        HkcTY+tMfGfVkmYiUm6OUuu6gvEVNA==
X-Google-Smtp-Source: APBJJlHFhdTk+xqOGmEno8+1bLtlEjUG1mfQ9YrWoHF2NuJtBJMKXqpF6dYJ4OUONDLFmPmx63WqWQ==
X-Received: by 2002:a5d:8488:0:b0:783:74c0:54ae with SMTP id t8-20020a5d8488000000b0078374c054aemr2879342iom.21.1688670512370;
        Thu, 06 Jul 2023 12:08:32 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w6-20020a02cf86000000b0042b21e8853bsm690551jar.36.2023.07.06.12.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:08:31 -0700 (PDT)
Received: (nullmailer pid 163648 invoked by uid 1000);
        Thu, 06 Jul 2023 19:08:29 -0000
Date:   Thu, 6 Jul 2023 13:08:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: amlogic,meson-pinctrl-common:
 allow gpio hogs
Message-ID: <168867050887.163590.877379254232081515.robh@kernel.org>
References: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-0-fa442d5aae91@linaro.org>
 <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-2-fa442d5aae91@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-2-fa442d5aae91@linaro.org>
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


On Thu, 06 Jul 2023 09:42:27 +0200, Neil Armstrong wrote:
> Allow gpio hog subnodes to the gpio subnode.
> 
> Fixes: 94df03a45276 ("dt-bindings: pinctrl: Convert Amlogic Meson pinctrl binding")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

