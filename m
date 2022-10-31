Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8A614061
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJaWFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJaWFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:05:54 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339D14033;
        Mon, 31 Oct 2022 15:05:53 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id c129so2384522oia.0;
        Mon, 31 Oct 2022 15:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g911tlmgvN5ufOFb9qyP/qkib0bVxpbZxc7IFgmkXZg=;
        b=yl/t5NE/Rk8qqm2ofJbOVVPnXoXQYcc9rkMMP/EAq104ipgQyyRtjTu8+e4V8mMZQy
         9pQrHzvkckLEko6hfl+2bhFzyl1XZA2X8kr3HxEOHSPue82ANrXOYfDew/ZP2tTFvlI+
         XbU9W1GEhLOcSakKgdTZh5T8Vbompb5utELPj6k9SFs7Wvhe0qcOSzsj30xxD7edDuf+
         1bl1V+vLEtcLqEilPg5/aEazqrt3XqFQni5VBwG/KULn1tskJkA/micvxGrqpdW3JrmP
         FUM6ySMa7MAz9BKzxAPnVifEFPJ6osDhgszHYKoN7C4BGn1xpdHlht5g8Crf2w9ifKaI
         nDYQ==
X-Gm-Message-State: ACrzQf3ULCGq0SgYPaPcdL9gf5Xj9zzruVKtl607HBk2UX414AjpgRpd
        rXpN8aA6TBHjAqXNzB/Hlw==
X-Google-Smtp-Source: AMsMyM66qoL2OgLtgzN5Q8sOmcXp17lptXkhAHxy1Rrkuzj/LcsXTI9p4SdAXPPI8FsBwx+6Egs75w==
X-Received: by 2002:a05:6808:189d:b0:354:cf1f:a426 with SMTP id bi29-20020a056808189d00b00354cf1fa426mr16282255oib.219.1667253952738;
        Mon, 31 Oct 2022 15:05:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fp42-20020a05687065aa00b0013bc95650c8sm3613744oab.54.2022.10.31.15.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:05:52 -0700 (PDT)
Received: (nullmailer pid 3649865 invoked by uid 1000);
        Mon, 31 Oct 2022 22:05:54 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
In-Reply-To: <20221031190159.1341027-2-lis8215@gmail.com>
References: <20221031190159.1341027-1-lis8215@gmail.com>
 <20221031190159.1341027-2-lis8215@gmail.com>
Message-Id: <166725358721.3638147.11464755727689545438.robh@kernel.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: adc-joystick: add valid-range
Date:   Mon, 31 Oct 2022 17:05:54 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Oct 2022 22:01:58 +0300, Siarhei Volkau wrote:
> The valid-range property aims to cover detachable/lock-able
> joysticks where measured value goes outside valid-range.
> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  .../bindings/input/adc-joystick.yaml          | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/input/adc-joystick.example.dts:82.28-104.11: ERROR (duplicate_label): /example-1/joystick: Duplicate label 'joystick' on /example-1/joystick and /example-0/adc-joystick
ERROR: Input tree has errors, aborting (use -f to force output)
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/input/adc-joystick.example.dtb] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

