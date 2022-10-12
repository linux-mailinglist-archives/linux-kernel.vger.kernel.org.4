Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0207D5FC927
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJLQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJLQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:22:57 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B941F4191;
        Wed, 12 Oct 2022 09:22:37 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so12476217ooi.5;
        Wed, 12 Oct 2022 09:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF616PFiM3a+4SBOR6qRryxHACAfp+96mQUr4nWBRVM=;
        b=KNttITCxWRPkoSlsNKSMj33nc3FmAd8POeN3IRuzmUZVnKtgKwcVNWwrhiVc9Dr6A9
         B/2m4IRKJD7WPB/u5MQEa8/swm+Zq5FQW9gOA0FDCiFfSvPXEvQn1q2mFfgjBZ/6Zycd
         x+lQZ2RCZ+Y95EHgiVS+2ZNhQo8y9WLRNQvwl1OzNEayINrmpXhQdjVrnQihN375L9/7
         smBQDikPwsI64OB9v5GC2mZwCAJiDDhmYzHPkHIbE23zDVHdWEbFsUGII8tLflOnaHOV
         AXrGRyV2fNEIRxA0tcVGg22kAkc5MbJ2BGeH22MaKSJ/qMlStPCmdqllUE0SxwzaQ6Ab
         JPTQ==
X-Gm-Message-State: ACrzQf2SflTFTc8TydGvMTkKXPJxcqTftbgsSJXDaVRy+I9hn0UFHqu/
        mEuMoFfijyCEnNhptutQytZBDwxTYA==
X-Google-Smtp-Source: AMsMyM5YR9G+IoiB8RVUl5Mw0iIY8ze/NZWuJb2yC5K7gVYAFmXIh3+94GEkL5N/H9ZkPjiS8eHpuQ==
X-Received: by 2002:a05:6830:1644:b0:661:8b9f:16c3 with SMTP id h4-20020a056830164400b006618b9f16c3mr10940674otr.235.1665591751648;
        Wed, 12 Oct 2022 09:22:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cy24-20020a056870b69800b00131c3d4d38fsm1361683oab.39.2022.10.12.09.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:22:31 -0700 (PDT)
Received: (nullmailer pid 2283425 invoked by uid 1000);
        Wed, 12 Oct 2022 16:22:32 -0000
Date:   Wed, 12 Oct 2022 11:22:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hai Pham <hai.pham.ud@renesas.com>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car V4H
 support
Message-ID: <166559175196.2283372.14409157945762538966.robh@kernel.org>
References: <c268cb4497cbe79773bb6568f36c37adc6fb5bbe.1665582645.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c268cb4497cbe79773bb6568f36c37adc6fb5bbe.1665582645.git.geert+renesas@glider.be>
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

On Wed, 12 Oct 2022 15:51:46 +0200, Geert Uytterhoeven wrote:
> From: Hai Pham <hai.pham.ud@renesas.com>
> 
> Document support for the SPI Multi I/O Bus Controller (RPC-IF) in the
> R-Car V4H SoC.
> 
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/memory-controllers/renesas,rpc-if.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
