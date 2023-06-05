Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA1722DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjFERtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFERtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:49:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E8C7;
        Mon,  5 Jun 2023 10:49:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b1b30445cfso44100041fa.1;
        Mon, 05 Jun 2023 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685987343; x=1688579343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lZaMEIb/cg//QeG1KKh9RYsT0ydbhBJp/5745nF6Jw=;
        b=XQwM5k3TP3w9G6T5kSA8sGJHtTjBFV6kSlC8wXaroHqUs6jq/GZ09+VcNBMTVgzPrp
         ESnI0KlpAqTXbGt2Ea/QSTAfg/NSyWaGc159Ml52xxpNcLKgGJglUjy5itcJDiGlmirB
         lnScRWAF3+Eg1jfGO4FJ42V1LVVNdoz9t+IU7hm3hCDWYqi6Uo3RviY0ZsEPbvQFbhST
         qknJnGqNBl7dFAgD4OVl2wyYi/J9PG3FE0PTYbNuz3+qmei+5FSSHEG58PfhvSS2I4aC
         dtrUWLYRmpbte8qZyJIH2ZvDJiqz9UYbHUVaBuUURUMjZxFi5tgDvTI03hbcVcgNBTWn
         ym4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685987343; x=1688579343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lZaMEIb/cg//QeG1KKh9RYsT0ydbhBJp/5745nF6Jw=;
        b=ffoKmnDpC13Fm4cSgjRwNx5ZwvfH1jwHQlTV8D38acQ/LiAMoAc7464ZJVxSlEUUAF
         yQiju72lEQTEaQrNoM+9WUkFW0Jn0oiIiV9hyeizdQqBxSlqqsaJAYdxxlpf0djsp4TZ
         4kFA8TftRTjZypnq3bHNJwM1RvnMhFcBG+ggkcglJZD8pcjp2C7RD2AerfwcCxLn6j79
         opoVl2sUeJzQohEuFLeR2nEPtjIrGGohjRZyoAXGIq5AH+nzPSMJbRnkPJTThLTwH8jL
         GzTqAK/pgaYUwUexpniSZ/FAquIY93LgDyi6avF8F0CRFfjYvquh622fwzUh6YgzjWRj
         36pA==
X-Gm-Message-State: AC+VfDwlKmMknoPLqCfsHi75QB0TD2QruEE62unf+PBEv7iE6ZOpb8h+
        sqFgaPTy6MmXC2X43LfrSqo=
X-Google-Smtp-Source: ACHHUZ6MwAQlGymEenlS64yE+wnIVIdFz3qNmXIBklMPlHEC6e04gtdK1IBVX4GdsXn2grBqk2SMbg==
X-Received: by 2002:a2e:8887:0:b0:2b1:bdf0:baa4 with SMTP id k7-20020a2e8887000000b002b1bdf0baa4mr3836491lji.51.1685987343116;
        Mon, 05 Jun 2023 10:49:03 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1520842ljk.94.2023.06.05.10.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 10:49:02 -0700 (PDT)
Message-ID: <4e27af47-2a4a-a976-32a9-bb0f0868cec1@gmail.com>
Date:   Mon, 5 Jun 2023 19:49:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V6 0/3] nvmem: add fixed cells layout
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230327141611.25131-1-zajec5@gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230327141611.25131-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 27.03.2023 16:16, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> NVMEM bindings received a new feature recently: layouts. They allow
> defining NVMEM device content in a separated DT node named
> "nvmem-layout". That improvement results in cleaner and more generic
> bindings.
> 
> New bindings & drivers should use layouts design. If possible we should
> also try converting existing bindings & drivers to layouts.
> 
> This patchset allows defining NVMEM cells in a new way (using NVMEM
> layout feature).
> 
> This deprecates support for defining NVMEM cells as direct DT device
> node subnodes but IT DOESN'T drop support for that.
> 
> PLEASE understand what this patchset handles. It adds new & preferred
> way of defining NVMEM cells. This patchset does NOT meant to:
> 1. Convert ALL existing bindings or drivers (it's a task for later)
> 2. Add support for new extra features (like multiple layouts)
> 3. Break any backward compatibility (it WON'T happen)
> 
> V5:
> Support "fixed-layout" internally in NVMEM core (see PATCH 3/3)
> V6:
> Rename function & add unevaluatedProperties

This patchset seemed ready for 6.4 but I guess it has missed your window

I see you already picked some stuff into your for-next:
https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/log/?h=for-next
but I don't see those changes.

Can you pick this work too, please? I would like to avoid waiting
another month before getting this upstreamed.


> Rafał Miłecki (3):
>    dt-bindings: nvmem: layouts: add fixed-layout
>    dt-bindings: nvmem: convert base example to use NVMEM fixed cells
>      layout
>    nvmem: core: add support for fixed cells *layout*
> 
>   .../bindings/nvmem/layouts/fixed-cell.yaml    | 31 ++++++++++
>   .../bindings/nvmem/layouts/fixed-layout.yaml  | 50 +++++++++++++++
>   .../bindings/nvmem/layouts/nvmem-layout.yaml  |  5 +-
>   .../devicetree/bindings/nvmem/nvmem.yaml      | 61 ++++++++-----------
>   drivers/nvmem/core.c                          | 32 +++++++++-
>   5 files changed, 137 insertions(+), 42 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
>   create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> 

