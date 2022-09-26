Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B325EB261
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiIZUjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiIZUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:38:58 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E2A74C2;
        Mon, 26 Sep 2022 13:38:52 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id d64so9696747oia.9;
        Mon, 26 Sep 2022 13:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZbnWvjw/aiiNtUOqqKoDs7YVw66w7gmDI6r2Vs2RN2I=;
        b=3ZsB50yKm93jyh8LKlW11SewuPeo12l7eEK85lF7Wj1WRgQ9s4GX4TVAHV/jTTngsz
         ZrbZHk8WlxbNc8v74zJOk3cbIVsKZ52kvOMX2ZLFUjwU6beY+rERumTd+m9trL0IidgX
         jpJYtnpolk1/9g7InrsI5Rk5FU+1ZyVUh16BiAqmde7ql4lsnrZOoT2hakX7C2pzjNzG
         VH+TfA6oxNlecPTbJDVNaZ/QSR28sB4bC37nqtVQBPdiDRjzn4sNtpNdVlazxhIZtGe8
         BLE/LfHm3jfaM9xFaaWBgLISdapN6OjyU1e94D4zVgNsZIxzwi9Y9Cs51kpLwpXJsoZe
         HuWw==
X-Gm-Message-State: ACrzQf1F1VvJHhejkQV6pOA8U6YO/sSyc6e57jINxDBS04RsB5n8SrQw
        7qPWLbI7RsL8anCl0XeeeQ==
X-Google-Smtp-Source: AMsMyM41Nov/P38Wt9ZZ8LLqRuHzHWy8dgcDJMpUtn4P5H2flkRoOHJoPd2KnGdKnZJ522xF4H01bQ==
X-Received: by 2002:aca:90a:0:b0:350:20a0:52ff with SMTP id 10-20020aca090a000000b0035020a052ffmr284377oij.94.1664224730953;
        Mon, 26 Sep 2022 13:38:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z37-20020a4a9868000000b0046e8d284170sm6875082ooi.41.2022.09.26.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:38:50 -0700 (PDT)
Received: (nullmailer pid 2769732 invoked by uid 1000);
        Mon, 26 Sep 2022 20:38:49 -0000
Date:   Mon, 26 Sep 2022 15:38:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 07/12] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: add
 bias-bus-hold
Message-ID: <20220926203849.GA2769699-robh@kernel.org>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
 <20220922195651.345369-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922195651.345369-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 21:56:46 +0200, Krzysztof Kozlowski wrote:
> The existing SC7280 LPASS pin controller nodes use bias-bus-hold, so
> allow it.  Squash also blank lines for readability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml      | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
