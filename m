Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198CE61FA69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiKGQti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiKGQtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:49:33 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF39121816;
        Mon,  7 Nov 2022 08:49:32 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id s206so12763740oie.3;
        Mon, 07 Nov 2022 08:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPjkDe7822qFAqBdDVv1imNKgZrp1TqFh5f9JrnIQVY=;
        b=PHrVbrCgGjcQQttO8Br4BcxRAQbCrsZWJhi0AnkaHB5D8stmCfZ4vETwiH8qxcH5uf
         CS6RKreE7Mr+iX8N2W+Go7Xk/KgTHnBlsIs9cKNnsLPc/jTZDe7pgvzf6HN27jNC2JFg
         DEt7v1R3FrNPMwtEB00OQJqf+uQ/aWBxEdeEbMjx1Z2hbBX05JyBU0oEaqoPYNxzj3iN
         56p9PgNHMu1DxtGzw+exR/xPDEaSZGS+PNeXqXSCZKsUoVCDJj3Yq0ZtlMkgS0kJ7yj7
         wwjN10y+sHrKnYt1wUfiVve4lREqRFAql3ROn4gVOGU6XtS/iF4t+XUEBZAql+AXjs3H
         TznQ==
X-Gm-Message-State: ACrzQf0WP2k0LwuUMybpKLaBSewPFfiLXqdlR8m4Xx0jy54QO3sWjCPa
        Divk/GtupamSn6pi/wENNA==
X-Google-Smtp-Source: AMsMyM4AO5xn+o3iM7d3yFN2RXsjuyKAl03I1sKccaumWykVfwy0YJogUb0+CMAYKBioPkXmSIHHbQ==
X-Received: by 2002:a05:6808:1248:b0:354:2c04:c35b with SMTP id o8-20020a056808124800b003542c04c35bmr34492408oiv.143.1667839771974;
        Mon, 07 Nov 2022 08:49:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cm5-20020a056870b60500b0010d7242b623sm3307156oab.21.2022.11.07.08.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:49:31 -0800 (PST)
Received: (nullmailer pid 1227141 invoked by uid 1000);
        Mon, 07 Nov 2022 16:49:33 -0000
Date:   Mon, 7 Nov 2022 10:49:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 04/13] dt-bindings: iio: temperature: ltc2983: remove
 qutations from phandle ref
Message-ID: <166783977286.1227083.1292105951459094583.robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
 <20221103130041.2153295-5-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130041.2153295-5-demonsingur@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Nov 2022 15:00:32 +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Not needed, so why have them?
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml    | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
