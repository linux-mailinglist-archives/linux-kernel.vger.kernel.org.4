Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41661FCFF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiKGSMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiKGSMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:12:02 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB2B98;
        Mon,  7 Nov 2022 10:10:39 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id c129so13053798oia.0;
        Mon, 07 Nov 2022 10:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xf3knMb4Px1p0FXco3JbCeRWszZMM/MwAqzsuVMwUy8=;
        b=K18/adrNe6FIwkHeIa65H35+JJyAmZ4BP7k06DZrOg4xrAAymfqehtlshz1pe/W9+9
         6BKjgdHhCtF6UJXWOn2ThX8YD6i8mRNUHMJfpQNtq+fLGrrCYOhBfpf+oDl39xmQ4fYu
         JW8GFhjS+sMtNETVOISg9jhg3gblNoXWKiEO5+S/D55q3MRpDD/AeUYKt0ekDRpS4d9h
         qkiCMkaFa0Ie4qWU9JKXoQjGBEgKQmT8D+5zC6YJGh4UxPOauIFjOhb7Z31mk0fuwBeT
         PR5gnfrEyeMvIbRVCuB7RlvGq4SOcvhCjvKVvQWOPoBWGoHfwDge/71R6K9Ct+AhxwNn
         k2Jg==
X-Gm-Message-State: ACrzQf2z7xnxgugpM0fPoBgt+Ae+winckazpLdPh6m2Pxi606kZztLxR
        UK412HZzWzM/PXNaUvSh/A==
X-Google-Smtp-Source: AMsMyM7kKAznIB9Xb/wHWeZJWNaniXqbKTugH1HiRYqdeHBQfBFxr3xPXuWx6Boa65ynn+MZzrQ9EQ==
X-Received: by 2002:a05:6808:221c:b0:35a:668d:868a with SMTP id bd28-20020a056808221c00b0035a668d868amr8988614oib.257.1667844638446;
        Mon, 07 Nov 2022 10:10:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i13-20020a056870890d00b0013b09a56d59sm3407413oao.27.2022.11.07.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:10:37 -0800 (PST)
Received: (nullmailer pid 1347619 invoked by uid 1000);
        Mon, 07 Nov 2022 18:10:39 -0000
Date:   Mon, 7 Nov 2022 12:10:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 09/13] dt-bindings: iio: temperature: ltc2983: refine
 descriptions
Message-ID: <166784463648.1345316.10954612644525767482.robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
 <20221103130041.2153295-10-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130041.2153295-10-demonsingur@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Nov 2022 15:00:37 +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Some descriptions are too verbose, while others are too succint.
> Rewrite them all.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 163 +++++++-----------
>  1 file changed, 65 insertions(+), 98 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
