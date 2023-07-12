Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998A2750B82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjGLO5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLO5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:57:33 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC62EBB;
        Wed, 12 Jul 2023 07:57:32 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3457a3ada84so34763345ab.1;
        Wed, 12 Jul 2023 07:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173852; x=1691765852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQpNG1b7wMLR5twQRHrEFSWGNQ5hbqj3LiEbepk0pAs=;
        b=Qm9sgB1EyervI+L5tlZZwpLvgCeJPTHC8iOxx/ZKlOnxChlO1JkDCWsuoAY7/bGCQV
         3sEkgfggHhuMQ4bQj6DFtuoCB3/nJzQOCll63jglYG4Nf1nYNpfsLB6wxM+xAHxkwe8a
         ldHn7qltksafUnzeHwEMM28IIChTZizKm5tju7YKshzyzyQLj50YiJouZOP2YySXFedd
         9olufL5b//pmbcuX8yGQCIF5ZCT7t8rmXRHFcStPOaPlvWcvP6pwLlzXmnYtJkq8Ysnj
         Tj3BpFQ3j9MfmNreAyWTO2xHncrFgt/AEV2R4xTICjb12vkcWG59AzjM3B2EeFwU9I6y
         xjZg==
X-Gm-Message-State: ABy/qLYgkK+xldjgZidN5f0TU1osBW7mZNiZXAs4ujg35Z0XtF7v+M6m
        kNwmB7fx8LuGNf0o39XeYA==
X-Google-Smtp-Source: APBJJlHhBlEatXy+TeA0p640WcROEFN0Ctcfb+9Lz7BCpURusUfHQ+/RgjXT/eepAKQk9oWG5c9s5A==
X-Received: by 2002:a92:d201:0:b0:346:b5d:c0ee with SMTP id y1-20020a92d201000000b003460b5dc0eemr16683818ily.0.1689173851928;
        Wed, 12 Jul 2023 07:57:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i10-20020a02b68a000000b0042b3dcb1106sm1289071jam.47.2023.07.12.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:57:31 -0700 (PDT)
Received: (nullmailer pid 183580 invoked by uid 1000);
        Wed, 12 Jul 2023 14:57:29 -0000
Date:   Wed, 12 Jul 2023 08:57:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adi,ad74115: remove ref from -nanoamp
Message-ID: <168917384908.183505.328888758911691646.robh@kernel.org>
References: <20230712080512.94964-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712080512.94964-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jul 2023 10:05:12 +0200, Krzysztof Kozlowski wrote:
> dtschema v2023.06 comes with support for properties with -nanoamp
> suffix, thus bindings should not have a ref for it:
> 
>   adi,ad74115.yaml: properties:adi,ext1-burnout-current-nanoamp: '$ref' should not be valid under {'const': '$ref'}
> 
> Cc: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

