Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331B368A5FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjBCWSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjBCWSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:18:04 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0F991C1;
        Fri,  3 Feb 2023 14:17:41 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-15fe106c7c7so8320604fac.8;
        Fri, 03 Feb 2023 14:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUrr0IRNP888NJVJRikfFM8e8Hjhl/dyleNefwL6jZM=;
        b=D7Wb1VmqAQLzzLX6/lWJpjqPzeG89LaI9CTn9C/01R1YU2kaCaMYQMwOYVRm3gFIVf
         gbxscrWnvYnc2E9DhkBPNDNqKoHpqbS3Eo3VJJT67I4jkoHWMs382qqZLk4ayLgRZQC1
         83zi8NXlF7K+SmYL1sdV7dvrsbMnrO7HqaPGTYqiVbHN9YwM+qqjO73j71HucaIUl6z9
         Kh4wa6brOM62DD2Pt3YR61h9Z6IWazbSNgl6rHIn0dKZ2cd61nCmU496F2yNj5xigccA
         aIStItdH1KtA4INiYAAbDUx9xZyJqpoIfkiLr0cYt3q6VIkrLjDN0kzjXZhBga1JWfkb
         vi7Q==
X-Gm-Message-State: AO0yUKWBDabW0xWPVQ4p2arbT1yIHimIKbHxZWnadNOYOChVt8vTcDAL
        NmH0gJAoZ0mIK4UwAc22Hw==
X-Google-Smtp-Source: AK7set9BDbXlIrsix7B+Xn6jevwpsyBraI89SA/kv+GpUb3JC6Tktlxd8yo09/X3EqVdoQT6WFgRBQ==
X-Received: by 2002:a05:6870:e0cf:b0:163:8f96:9b28 with SMTP id a15-20020a056870e0cf00b001638f969b28mr6068171oab.38.1675462660712;
        Fri, 03 Feb 2023 14:17:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ea48-20020a056870073000b00143824af059sm1299797oab.7.2023.02.03.14.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:17:40 -0800 (PST)
Received: (nullmailer pid 972273 invoked by uid 1000);
        Fri, 03 Feb 2023 22:17:39 -0000
Date:   Fri, 3 Feb 2023 16:17:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/5] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: correct
 GPIO name pattern
Message-ID: <167546265881.972223.14637122018009341404.robh@kernel.org>
References: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
 <20230203164854.390080-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203164854.390080-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Feb 2023 17:48:52 +0100, Krzysztof Kozlowski wrote:
> The SM8450 LPASS pin controller has GPIOs 0-22, so narrow the pattern of
> possible GPIO names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

