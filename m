Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA56F8AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjEEVWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjEEVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:22:30 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABE859C3;
        Fri,  5 May 2023 14:22:29 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-192d5ab4d40so1641650fac.0;
        Fri, 05 May 2023 14:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321748; x=1685913748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwoP/+8b6zAjCMeTxbqehxYB5yBB0LdRCf6+FiPR3IQ=;
        b=AJYUy4PaZ3OfOwPVZKcUXgPdTzOcv2ULcKDCTLCgjQGDH4kBnUM3qWzz/xxNM/lhvo
         KhfamhncTDtBhxXggrqUCpaHR+xrTToNyxuRQb5OfthPH5SD+fhfYMuJvddFzGVeCgsd
         s5SUkP7JblzyQhJRbzBY7AVmcCzpuFPzqiqnATdqD4f7qUEwHDTG7cUoqTrAMFtb2WDZ
         tXs19qHreVwukermEigSmJQOcK2jn/ihjKXG9ru7PUPBMhM1bZ0t0bj+IYPIJeVh3Dow
         jriVHp7tr2cNrEE1qit5YYvVV34PDGGZ/pnNth3gjewDBdzC71kwRXZmiTxXUgfO7Peo
         gd2A==
X-Gm-Message-State: AC+VfDwvw9H9FFWoOdYDgzmi7jLZP8kwNP7fcVFMKQnfmvLnLdcsem4h
        nyaK9bBwr36dCFZSPpWdYnmzDJVlAQ==
X-Google-Smtp-Source: ACHHUZ5ZRzdUeOyqq1S99aUVt0hx17J3fTRbjv5c83Uk8yVfqgeNw1DVmrx7S6J1CpA4sIYESCFdtQ==
X-Received: by 2002:a05:6870:b302:b0:18e:2b7e:a849 with SMTP id a2-20020a056870b30200b0018e2b7ea849mr1471295oao.22.1683321748332;
        Fri, 05 May 2023 14:22:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zh27-20020a0568716b9b00b0017ae1aede32sm2276399oab.46.2023.05.05.14.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:22:27 -0700 (PDT)
Received: (nullmailer pid 3585596 invoked by uid 1000);
        Fri, 05 May 2023 21:22:26 -0000
Date:   Fri, 5 May 2023 16:22:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     alison@she-devel.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        achaiken@aurora.tech, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Message-ID: <168332174619.3585538.12725820674982563427.robh@kernel.org>
References: <20230501170124.1218603-1-alison@she-devel.com>
 <20230501170124.1218603-3-alison@she-devel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501170124.1218603-3-alison@she-devel.com>
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


On Mon, 01 May 2023 10:01:24 -0700, alison@she-devel.com wrote:
> From: Alison Chaiken <achaiken@aurora.tech>
> 
> Add support for the U-Blox Zed-F9P GNSS device.
> 
> Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
> ---
>  Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

