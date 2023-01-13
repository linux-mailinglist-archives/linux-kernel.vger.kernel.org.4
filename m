Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C303C668927
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjAMBaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAMBaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:30:03 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95137C72;
        Thu, 12 Jan 2023 17:30:02 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1322d768ba7so20861687fac.5;
        Thu, 12 Jan 2023 17:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62OqEN8MpjbRZAbcHwexZwsjzXPsezGMzQ34w4U81tA=;
        b=wOr2kphWvwJ1G5zGw7TtnQVRAwF0YN1XAkatKtb8Yw7ROYGF++6gNJ5CoGGDNPa/vy
         UGJkIg0e02VAwlm4t4Lu73emBpLe5nHmXEVZWtmO50x5RLo+w9wReNV9y/gYvv1bUTxQ
         +VOTsYwwd7RJ5Y9SohIUh1eNBIFSS8gQgogTS25xfH4kNSqOJNmdRdqWB7T/r3P8+TLI
         IJW7Kp/ZlaDll+oiO48tYmyHjdvNXu3WduaZhGoxo9ReADtN2pwQurX25wGMncgTmJcg
         8UPC0BS+JB1OYYnAIYkUpLFll7CT5xmzqKONxblNhlCSApJEgntqJjH//d2qfuNbhBq8
         aiSw==
X-Gm-Message-State: AFqh2kqLNEj1kez1kWJeo5b2dKznfdqqtkUTgieBXxO/Vkc+dAuJuTj6
        owepl7NSo0rVme3kGviRTUGl2bbhwQ==
X-Google-Smtp-Source: AMrXdXt91SoxuQ8LI9eYslX0Ij+0Ty9Mjg8I5DF3vMwyh6GZk8XMX+Tuwovlh3A/sfNPoZGdLqNZIw==
X-Received: by 2002:a05:6870:b97:b0:144:efca:99f3 with SMTP id lg23-20020a0568700b9700b00144efca99f3mr4059079oab.3.1673573401815;
        Thu, 12 Jan 2023 17:30:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g18-20020a056870a71200b001428eb454e9sm9890457oam.13.2023.01.12.17.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 17:30:01 -0800 (PST)
Received: (nullmailer pid 589242 invoked by uid 1000);
        Fri, 13 Jan 2023 01:30:00 -0000
Date:   Thu, 12 Jan 2023 19:30:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 3/6] dt-bindings: arm: msm: Rework kpss-gcc driver
 Documentation to yaml
Message-ID: <167357340002.589187.8338617302523243292.robh@kernel.org>
References: <20230110183259.19142-1-ansuelsmth@gmail.com>
 <20230110183259.19142-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110183259.19142-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jan 2023 19:32:56 +0100, Christian Marangi wrote:
> Rework kpss-gcc driver Documentation to yaml Documentation and move it
> to clock as it's a clock-controller.
> The current kpss-gcc Documentation have major problems and can't be
> converted directly. Introduce various changes to the original
> Documentation.
> 
> Add #clock-cells additional binding as this clock outputs a static clk
> named acpu_l2_aux with supported compatible.
> Only some compatible require and outputs a clock, for the others, set
> only the reg as a required binding to correctly export the kpss-gcc
> registers. As the reg is shared also add the required syscon compatible.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ----------
>  .../bindings/clock/qcom,kpss-gcc.yaml         | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
