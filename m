Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530C061FD0C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiKGSOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiKGSOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:14:31 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB19FD7;
        Mon,  7 Nov 2022 10:13:28 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13b23e29e36so13574609fac.8;
        Mon, 07 Nov 2022 10:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97ci6S/gLJDO/qKBMDkpSH+GCXePyoWEkk7z2wGZAQQ=;
        b=in7XUFkjcGU4nBCXY+Q0fAEx7sdFp0QWQ8ZIEEqrT7Hq9Syp1OZ+xvMbqySjaH/Eag
         2oYYKrNE7RU0QvLqGxZJ19eKdNrgc7we0FvDzWWqCx1Bv5Z4Yylow3gam80+HU97nK0y
         Wu1dpfFakN1HruDosqHWHiqwGMqfRFNJeZ3NGHnZ/OEscQC4d1RfahQHj2/iQ6rg8HlR
         U/wmFFyNF9wTPfl0R8LWa2cuOs4DcgDhbrglkxgBwejFkI3sTeX8Wo0FfzH2IInL+9p8
         FXI2miswbGkw5X4QdnFBpT7ZoIfBG1O0c4gCZIgUJ/TpXDeI80xGLxr3Yr/yhyFnuGsL
         gmsg==
X-Gm-Message-State: ACrzQf0PLjJiHMeeQe979kakEYWMQMCE1A34TP5vvpDcNJE2XTyem5KK
        mUB40ENOnnkZEAOum9JJOw==
X-Google-Smtp-Source: AMsMyM5Yu7ne9W4o1AA/931DotPnhoT+0j0Ka4VYwMWNajj/OgySqx3COipraxfZu47Twpu2YJQtdQ==
X-Received: by 2002:a05:6870:7886:b0:13c:12cf:17e8 with SMTP id hc6-20020a056870788600b0013c12cf17e8mr598398oab.21.1667844807157;
        Mon, 07 Nov 2022 10:13:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a33-20020a05687046a100b00136f3e4bc29sm3445900oap.9.2022.11.07.10.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:13:26 -0800 (PST)
Received: (nullmailer pid 1378910 invoked by uid 1000);
        Mon, 07 Nov 2022 18:13:28 -0000
Date:   Mon, 7 Nov 2022 12:13:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v4 11/13] dt-bindings: iio: temperature: ltc2983: use
 generic node name in example
Message-ID: <20221107181328.GA1354289-robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
 <20221103130041.2153295-12-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130041.2153295-12-demonsingur@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 03:00:39PM +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Examples should use the generic IIO node name. Fix it.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> index 467e165e9b0b..bd357ff28e65 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -420,7 +420,7 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        sensor_ltc2983: ltc2983@0 {
> +        temp@0 {

The DT spec defines 'temperature-sensor'.

>                  compatible = "adi,ltc2983";
>                  reg = <0>;
>  
> -- 
> 2.38.1
> 
> 
