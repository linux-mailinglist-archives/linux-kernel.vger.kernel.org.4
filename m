Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28C5E5378
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiIUS6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIUS6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:58:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D51AA1D47
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:58:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a3so10749519lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=i0GvNHAA6HriUK1iwHQhuKbfhvmDlYsJZtxUwtDszrU=;
        b=tyQxrwTx7FC0WMK4iNa0xMT5ZTkUNUXRjuYJ6ngr8504lz1m287MotseKwIv4+vIkw
         t7ydFQuNkDAN8HycVQ460BqRkotr6Dtu2XLxAznWv5gwKqQRTi9apNCAKpX2xeaeagN8
         C0J2zzWG1pdBm7brCVJs+eEAC4hXKE7+J1xJa1y4JrNtdo6H54TdR+ps2n7gQPbCG754
         Qle8zKu4I113dnuI17fY6ZicPB0FC3+nDac3X9PV1A3Of81mKNa+rT2ooMnLvM262f7c
         oCzVykwGdjm/VXCbZxmN4rtgQfZWLfQjLGBkGTeSsz4dBrX6dayd+H+6ptW3DZyWtkw6
         m4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=i0GvNHAA6HriUK1iwHQhuKbfhvmDlYsJZtxUwtDszrU=;
        b=AzVtgYHAKusRvpGT/Jm1bLs6S9ht0OIqIOMMHAYOMETIXHkowRlJxcmxohx7lNFmJ4
         4k5wOd9Q6Kpv6BlKWMgdCkQoIia904Q53yA8csuubKJK5Xniuma1CbrkzCcx+TIlGzCM
         Awf0WFkR0yzPcUZtzGWaPkLBPIiybE1bqo7Y7eaGPa1I+E9Wa6CULejAhySjLIP4fye6
         d3cl5qndbdDQxGpHO3MsiLJ+Aa4XPTSmO5RFYmBQOsanHuTFU3KetEeG6L25Vv41vybl
         yfx+L8nC7/PtdQeVVR0RjfnWS+m1Wn0Zrph8e/TAoldY+IiLfYm+XcpYhQrYhDSot7hE
         VfHg==
X-Gm-Message-State: ACrzQf0EqkbRzyND84OmwXCEfQlVKpyvWX1ZBfx+nKn3I7yw5soEUkEG
        X/029hABvBpMzT0XOGUAKmWWqg==
X-Google-Smtp-Source: AMsMyM7BFiYVamvKMGfRkSVY1bQDxJm0JXW9wMgz8WbyWhMSAHmN5EjwbxsFX4D044b8XvGAD77rwg==
X-Received: by 2002:ac2:5b0f:0:b0:49c:949e:d8f7 with SMTP id v15-20020ac25b0f000000b0049c949ed8f7mr10203910lfn.336.1663786707635;
        Wed, 21 Sep 2022 11:58:27 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l6-20020ac25546000000b00492ce573726sm559891lfk.47.2022.09.21.11.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 11:58:27 -0700 (PDT)
Message-ID: <bba1ed72-d691-b51c-dce8-ab9a2e45fe86@linaro.org>
Date:   Wed, 21 Sep 2022 20:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/4] media: dt-bindings: Document Renesas RZ/G2L CRU
 block
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <29d456ed-620c-8dc9-01f0-54f96b670b94@linaro.org>
 <YysHAkWBfTTAJF3E@pendragon.ideasonboard.com>
 <ba436dd5-2ea2-b2e0-7056-5bae6b4c7bb4@linaro.org>
 <YytJ/oJK9s2mfqPL@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YytJ/oJK9s2mfqPL@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 19:29, Laurent Pinchart wrote:
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: vclk
>>>>> +      - const: pclk
>>>>> +      - const: aclk
>>>>
>>>> Drop the "clk" suffixes. Remaining names could be made a bit more readable.
>>>
>>> These names come from the documentation, isn't it better to match the
>>> datasheet ?
>>
>> If datasheet calls it "vclk_really_clk_it_is_clk_clk", it's not the
>> reason to use it. :)
>>
>> The "clk" is redundant even if the hardware engineer thought different.
>>
>> The same for IRQs ("tx" not "txirq"), for dmas ("tx" not "txdma").
> 
> I'd argue that naming clocks "v", "p" and "a" would be less readable and
> more confusing. Is this a new rule ?

Not really, but also it's only a style issue.

Indeed "v" and "p" are not much better... but still "vclk" does not
bring any additional information over "v". It's redundant.

You can also drop entire entry - unless it helps in particular
implementation.

https://lore.kernel.org/all/20220517175958.GA1321687-robh@kernel.org/
https://lore.kernel.org/all/20210815133926.22860-1-biju.das.jz@bp.renesas.com/
https://lore.kernel.org/all/YYFCaHI%2FDASUz+Vu@robh.at.kernel.org/
https://lore.kernel.org/all/20220830182540.GA1797396-robh@kernel.org/

Best regards,
Krzysztof

