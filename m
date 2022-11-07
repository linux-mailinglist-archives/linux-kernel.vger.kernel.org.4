Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B98161FA8E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiKGQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiKGQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:52:11 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB28220FD;
        Mon,  7 Nov 2022 08:52:10 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id q83so1047638oib.10;
        Mon, 07 Nov 2022 08:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ64GEaHNoYqaSyJPET6HqEloEtKzKHKFpQ8WjiqbOY=;
        b=K1j3UaNAmK7TXgzFvQVd5yi4X10Q4DsMHao6D23ewVhcK1btH1hFTb4lZfeP2nmFyt
         qXhb95tCo14rMP2EhpShmKk3Xo2gEJKTbhYpTtuJZ0DZMVBEhrf2vJsvxd+nWgGmLXub
         WyjeF9GMTDkAlJaa1WHq/3Q5Y/HXfQLdIe+ovvA5J1BTddV0tLFlKNpMWn3571EVKPJ/
         FfOo87qXLRIBAoEakslT55FCLhyuSYHPC/xmPIIvmzdGVv3MDB6p3xm42/y4Ij6Q2oXu
         txSB8gYVUe3/O+vZ+xXvGf4xvjp40jpy3Ay5BakgZ+v6VJaT6idFQFJblViI9ICB5PuI
         h95A==
X-Gm-Message-State: ACrzQf353hKzy1jxpBE/bXjP8T+V1es0truFtU4+uThPHVnZsEw8RtJV
        85oXDmcyicnmS38IRGfw5Q==
X-Google-Smtp-Source: AMsMyM7ZHh3wfKMz5itrgmKht6rWjBQJpRWxKulZfspcnTiaTzZ/Z14rbOnaTEE8glR459/Ok4a7HQ==
X-Received: by 2002:aca:d0b:0:b0:359:cb6e:809b with SMTP id 11-20020aca0d0b000000b00359cb6e809bmr30548387oin.137.1667839929799;
        Mon, 07 Nov 2022 08:52:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h25-20020a056870171900b0013d9bd4ad2esm3307622oae.12.2022.11.07.08.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:52:09 -0800 (PST)
Received: (nullmailer pid 1229987 invoked by uid 1000);
        Mon, 07 Nov 2022 16:52:11 -0000
Date:   Mon, 7 Nov 2022 10:52:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v4 05/13] dt-bindings: iio: temperature: ltc2983:
 describe matrix items
Message-ID: <166783993054.1229931.10283754977945608290.robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
 <20221103130041.2153295-6-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130041.2153295-6-demonsingur@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Nov 2022 15:00:33 +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Give a little bit of information on what each item in the matrix is
> supposed to be.
> 
> Also, some matrices put the 'minItems' and 'maxItems' keywords in the
> wrong level. They should be on the same level as the 'items' keyword.
> Fix it.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 23 ++++++++++---------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
