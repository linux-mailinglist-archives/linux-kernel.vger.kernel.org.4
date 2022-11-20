Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6B631364
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKTKmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKTKmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:42:02 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC26776DD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:42:01 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id d20so11630477ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+5N0pkOjScN/Ao+IwQra3FduvJZ9s4atoSpkPxjW0g=;
        b=OX0QN4FcMzvJqw1Acb4lbEaCiASIfpsUmGgO/uD7diiSl3/q27ujnTRUDc06O3T7yS
         FppQtc2kPLzFgaHiPK+xAynMPZMBpPLzyUtoBGHVyqPcVcpO/+WE+58wcOJVYVO20E1z
         Lj5+SjYiyefP/NVAvVvfVPIBk4aJCYgWyTEeNYlG0XbVU04PnwCLuABo+cLiP2yewjF+
         CVez272raUl24nJjK29TvEvZNKXp6jS+QdIeIfrKR6SfrhF0yjrRxwJV5fxDeFmsLf8z
         Nk9LrTiNnZLiLLMezKuU3G7dF50wLPKnkALVTlR3x8HsFUcLQGrKKpfxbCOcubZYNkgC
         QEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+5N0pkOjScN/Ao+IwQra3FduvJZ9s4atoSpkPxjW0g=;
        b=5L/Oo0KY1bvdMa1E8O0mzn6HpGqgCowYKT8fBdMhn8QMbexS36nEGzG0SjcssEVkJ+
         hHp77ppSc/MlFevTQfR8IoU4QTEzKZJtggtvaWqbzHcrOZX5f1SSanZ5QL8tJt850TuQ
         F4zCZ8+YYQ/fJHgM9wC3/+w+51N9K0yRGAWsuzBupdiFGWnckHELTlmfptiDrb/z5pQz
         wJr/lvpIIEGcsjS3wuCS/EBfRT9q9fFnen5yccRjQXZskXu40UCvm8ORiuFf3HvVj3Mg
         WhTvZvnX+Q9MA4SWBaDG/8HRGNxbLvq4Sqn4c4r/unrPkoiswRLTZdt1nKm4n1+ZDDcr
         lBQw==
X-Gm-Message-State: ANoB5pmF7uO6cAjBuBSmsYsZ5KjOkOClpfo7iuvpqcKXfl50gRxUYyEd
        f32FciJdYl0aBcgZggua3Sg/Jw==
X-Google-Smtp-Source: AA0mqf44vIeKbqxUNJCmzEWNr/HvLPcCO+Csm8bNrTotxiewRQh8XlbSuKG36uhmQXT0DdKbqFHCWw==
X-Received: by 2002:a05:651c:1a07:b0:277:11ae:d44e with SMTP id by7-20020a05651c1a0700b0027711aed44emr1241095ljb.458.1668940919692;
        Sun, 20 Nov 2022 02:41:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o7-20020ac25e27000000b004b48c977d8dsm1497974lfg.125.2022.11.20.02.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:41:59 -0800 (PST)
Message-ID: <71f97720-37bc-7940-57de-4667b2204132@linaro.org>
Date:   Sun, 20 Nov 2022 11:41:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: add binding for SOPINE on
 Pine64 Clusterboard
Content-Language: en-US
To:     Renze Nicolai <renze@rnplus.nl>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andre Przywara <andre.przywara@arm.com>,
        Conley Lee <conleylee@foxmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <3007229.e9J7NaK4W3@werkpc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3007229.e9J7NaK4W3@werkpc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2022 13:31, Renze Nicolai wrote:
> The Pine64 SOPINE Clusterboard is a mini-ITX sized board capable
> of hosting up-to 7 SOPINE modules. It is largely compatible
> with the SOPINE baseboard but it omits most of the in- and
> output interfaces. Also The Clusterboard needs a tx delay
> of 500ps for ethernet to work.
> 
> Add a binding for SOPINE on the Pine64 Clusterboard.
> 
> Reviewed-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Renze Nicolai <renze@rnplus.nl>

1. Only this patch made to the lists - second is missing. You need to
resend.
2. This looks like v2 or resend, so please mark it appropriately in the
subject [PATCH] part. (git format-patch -v2 or --subject-prefix).

Best regards,
Krzysztof

