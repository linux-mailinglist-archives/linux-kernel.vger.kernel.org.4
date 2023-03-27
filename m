Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F2F6CA67C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjC0Nv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjC0Nvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:51:31 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329576E9D;
        Mon, 27 Mar 2023 06:50:39 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id o26-20020a4ad49a000000b0053964a84b0fso1328320oos.7;
        Mon, 27 Mar 2023 06:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679925038;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdu8kvcOTirGrWj69vMN2+TEmBise2kmxyOqDHaHDbI=;
        b=tEOC6fAtjCweZ4dAUM4ubUm86ICa2t8MLCNNnz7bAS+jRoPPw76Z0FlVBf5JHCr+QB
         WdBhnOULd7NrvZ+bkLQZkv0Fy6OQkIOpRCLilsdkuOUT0LXL5fY768OTHHs6jo2Yq1mg
         TuqlTEL9QWDZwhmQ2SG0ftLa6O68M8sbET9TYJw2j2MhSRt+G2W9NU2p0EjyftljMYhf
         txUd69EiKlyKZCGjlJ6Pwzy/NzpYic/W92o12kDo9F161Nx8je/ZIOD/5i86wwUp3PgY
         7AZ9wqZN2dKS4jQVXerBhNVg6kUm6JX25srEhzXH+XsvtOX4Q3ZlBC1Rpd3EGhkns8R7
         f6ew==
X-Gm-Message-State: AO0yUKU/3t0Np78wrEETCVVJUNhSOR2Ebapp5KzCM/bzmNfEkD6TFpUL
        fZKvFy7K/3/gPJQf46f4FA==
X-Google-Smtp-Source: AK7set+n+luM2eu7l4E5E0Hgk4BF/OO51E9s+Wat4P4mUYaZLYFoh/1u9PtpBb7dgARKwpy6PC2EMQ==
X-Received: by 2002:a4a:58c9:0:b0:538:243:2191 with SMTP id f192-20020a4a58c9000000b0053802432191mr5989631oob.7.1679925038362;
        Mon, 27 Mar 2023 06:50:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j4-20020a4aab44000000b0052569fb1cfesm11288215oon.28.2023.03.27.06.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:50:37 -0700 (PDT)
Received: (nullmailer pid 3484373 invoked by uid 1000);
        Mon, 27 Mar 2023 13:50:37 -0000
Date:   Mon, 27 Mar 2023 08:50:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH V5 2/3] dt-bindings: nvmem: convert base example to use
 NVMEM fixed cells layout
Message-ID: <167992503682.3484320.7287063657241924701.robh@kernel.org>
References: <20230321102418.4190-1-zajec5@gmail.com>
 <20230321102418.4190-3-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230321102418.4190-3-zajec5@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Mar 2023 11:24:17 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With support for the "fixed-layout" binding it's possible and preferred
> now to define fixed NVMEM cells in the layout node. Do that for the
> example binding.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/nvmem/nvmem.yaml      | 42 +++++++++++--------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

