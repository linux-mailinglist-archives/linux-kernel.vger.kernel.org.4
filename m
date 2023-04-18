Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3E6E6F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjDRWiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjDRWiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:38:03 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D557D8C;
        Tue, 18 Apr 2023 15:38:02 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id w22-20020a4ad036000000b00541e4028218so3720620oor.4;
        Tue, 18 Apr 2023 15:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857482; x=1684449482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhGK1Dt8c3BNi6T7CovkJtccD0IuzfUcGtBtP7hSq0w=;
        b=ZOl6NAQGHclPrxqMqJ0w70A7u5HeYP5tvkILpW7lLxx5u9vNzvca1ZyPyIYlxYf9+O
         FobJtW1SzkOdO+Ug2u3RmbkjLSXpZ3XWiEBiSeO2GcGg8mqAKd9cdLsbFyEBjO12x9sR
         fvjEH/jGYgmQiT9jPHLhnssn2N595eylhuWb4/wLRFJuMUA07IqQR+9VhnO3CfvPeQAq
         0NdS50ghd75AXlrJ03C935cwVh9CNk1HdNu255DhMqpA8Z5w2Y26dnrjSuxbODfq951Y
         kb/LzR9udd0IWxDO4+/+ooOpFuzoiHpXhmKGjvHRmHQQDzkMXrp9sSVciRr6bzziD9UD
         fWvw==
X-Gm-Message-State: AAQBX9d93kDPehKaCGeGr/YGIsKgZydhI4msbIDs7yQ3GQom9ptxI1si
        QzD8rlpNG4MJ0J4ScYBatw==
X-Google-Smtp-Source: AKy350bSY3hXYBd7FYQkBJmuRv3MKhUfZ6+2bsNVLl4JjCoEfWkCTOOroKMihnLO9dIlLUO6NZiKCQ==
X-Received: by 2002:a4a:4951:0:b0:546:4bca:b572 with SMTP id z78-20020a4a4951000000b005464bcab572mr4592831ooa.0.1681857481708;
        Tue, 18 Apr 2023 15:38:01 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t6-20020a4aadc6000000b005252407f6cbsm6353390oon.30.2023.04.18.15.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:38:01 -0700 (PDT)
Received: (nullmailer pid 2452828 invoked by uid 1000);
        Tue, 18 Apr 2023 22:38:00 -0000
Date:   Tue, 18 Apr 2023 17:38:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: sram: Generate unique names for subpools
Message-ID: <20230418223800.GA2447581-robh@kernel.org>
References: <20230417-ux500-sram-v1-0-5924988bb835@linaro.org>
 <20230417-ux500-sram-v1-2-5924988bb835@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417-ux500-sram-v1-2-5924988bb835@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 09:34:57AM +0200, Linus Walleij wrote:
> The current code will, if we do not specify unique labels
> for the SRAM subnodes, fail to register several nodes named
> the same.
> 
> Example:
> 
> sram@40020000 {
>   (...)
>   sram@0 {
>     (...)
>   };
>   sram@1000 {
>     (...)
>   };
> };
> 
> Since the child->name in both cases will be "sram" the
> gen_pool_create() will fail because the name is not unique.
> So let's use of_full_node_name() instead of child->name
> so the name is "sram@0" and "sram@1000" respectively.
> 
> However if there are two or more SRAMs on the system
> with subnodes named the same (that exists on the U8500)
> then this again will not work. So catenate the top node
> name and the subnode full name to form a string that will
> always be unique.

Use the naming platform devices use which has the translated address.
How the addresses are defined should not affect the device name.

Rob
