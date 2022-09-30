Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222995F0B53
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiI3MH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiI3MHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:07:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B219157FE8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:07:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l12so4569007ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xYoUsAvXhuDV9Hv97ovHM6bRu6VbknOSFPnIdjEZnwo=;
        b=fBZvS89+eVxzJe8xRtbBl5VdwwSnxJUtLPTBkU9Tii+utA++C6vdPZKXN/Ak9Z8GgG
         CsR7k8b+Eo4HnPe3TIh91dOaVh1b826ThZBAk0N0uwADvDtF8XNzrNgqBT8TIAznn5ss
         3prxp9G7ereEyQNSM3pF77/VZFtTk3FWtEd5yk5HAqSX/NWv0zL9ZCaToIxBgoKCvQAP
         UYbn/cFE9+y3/UAlWl8FjkTdmKqi/iiy7qeoUNSyV651/af3WrrABEXQ+zx+qfxjvsrT
         4xnzAh8cd2g8eb+xqcSgWsrrcTbsgHoP3e24I31dZZ+aOffHrsxURBUh9VFq9Q2ZLALT
         Xr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xYoUsAvXhuDV9Hv97ovHM6bRu6VbknOSFPnIdjEZnwo=;
        b=A1eCa8UCv9DIi/bbtgCZ0rUMdj/zCHI7Ngryy8x90JX+4ikT/vVDJ7Pph63Oqse/vQ
         H8YHeDPkaE4Cr1IP8+MuJIfM+uA/l7VQmAqhkgluoQ5S4BTQQ9kyaUBcRN+DwSer/Z6I
         MExR2h7qJPKjaax0/f+YopkC+YwzIcc+4nnFBa0QMYeKwoUTOyXUug05YC3Sb+6BgEPg
         ALeO94NTTJmTiTVtjqNx57XYP1IWD2dgPI7uxYsZYVCyTA0fZxA+RrI3cgEiwUhU2mfQ
         5zSRp2f2kAQYx0fu2RzpRSt+/iIrmKvfZX2RgEh60TplzvUCUD6ZV9flDjpiyGNw52N7
         uCfw==
X-Gm-Message-State: ACrzQf0ID41Mfl+j6w9khf79Sxv/gWOEIKJmumQYu2ktgqsZhH/GbJX9
        zjTY7NH1oYIBkyG61LRHHRKvwg==
X-Google-Smtp-Source: AMsMyM4ta/2mmSPg4EgDMf+L0/KVTvVhdfbeYG+EbkN/4uW5p29tCyGKZcFdtIKrbZjock1sbevLRw==
X-Received: by 2002:a2e:b712:0:b0:26a:d1d9:f8d1 with SMTP id j18-20020a2eb712000000b0026ad1d9f8d1mr2976103ljo.271.1664539670488;
        Fri, 30 Sep 2022 05:07:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be43-20020a056512252b00b00499cf3e3edcsm268267lfb.296.2022.09.30.05.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 05:07:50 -0700 (PDT)
Message-ID: <dc35bb16-3edb-6369-ad8d-9a95a3066746@linaro.org>
Date:   Fri, 30 Sep 2022 14:07:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/4] media: dt-bindings: Document Renesas RZ/G2L CRU
 block
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <29d456ed-620c-8dc9-01f0-54f96b670b94@linaro.org>
 <YysHAkWBfTTAJF3E@pendragon.ideasonboard.com>
 <ba436dd5-2ea2-b2e0-7056-5bae6b4c7bb4@linaro.org>
 <YytJ/oJK9s2mfqPL@pendragon.ideasonboard.com>
 <bba1ed72-d691-b51c-dce8-ab9a2e45fe86@linaro.org>
 <YyxnJ/Ho5rZQzDDN@pendragon.ideasonboard.com>
 <CA+V-a8vaHPbXQWyMeVWsFaf3mUSAECcJiiww5xmhC99+zm3SuQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+V-a8vaHPbXQWyMeVWsFaf3mUSAECcJiiww5xmhC99+zm3SuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 12:49, Lad, Prabhakar wrote:
> I have got the below details from the HW  team:
> 
> CRU_SYSCLK -> System clock for CSI-2 DPHY
> CRU_VCLK -> video clock
> CRU_PCLK -> APB clock
> CRU_ACLK -> AXI clock
> 
> So I'll rename the clocks to below respectively:
> 
> +  clock-names:
> +    items:
> +      - const: system
> +      - const: video
> +      - const: apb
> +      - const: axi
> 
> Does the above sound good?

For me sounds awesome! Thank you.

Best regards,
Krzysztof

