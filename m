Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C236BEF8A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCQRVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCQRV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:21:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BA1E6DAD;
        Fri, 17 Mar 2023 10:21:09 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.156.231])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4974566030B7;
        Fri, 17 Mar 2023 17:21:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679073667;
        bh=I+Gvi5bzAnoJMxokQ84k9j+H+aFc/IN+XvqBbP6wpvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=durtctia6ys5ahpIvt7urL9eaWQyHgUoJkCI/3sUZz+Cz60FX1D6+GjNICq2duwN1
         xZRgyxlKfz+V1Amu3xsfbnZ5TCoifrJHIDWxHV55eBpfNc61nV9yFIsxGnDnFbZfL2
         jYOSnI0gYZwIc/w9qHpoBRNEA7zjzTWC1zI2/mjj65/yNAfIgtvCRFU9Wo67hfWk66
         K5R+RDs/sD9q/OPpiZpz1oJqo3LYu/m3v3JqXR6K5O9UJsURGl8aes3t5ZRZ5kNCs8
         ZHUrK6VT9Euy6HTz+SS0RdaMhV37DWSBfmRncbIsjROD8ggD8T5h1hwSW1Cpv2v9d4
         UdRzr7Qu4U2iA==
Message-ID: <793d6c43-d71e-3ffc-17c2-26062e40b4bc@collabora.com>
Date:   Fri, 17 Mar 2023 19:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 01/11] dt-bindings: firmware: arm,scmi: Document
 assigned-clocks and assigned-clock-rates
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-2-cristian.ciocaltea@collabora.com>
 <20230316203417.GA3833267-robh@kernel.org>
 <20230316222619.r4jzk3lzdxzamr2s@bogus>
 <d5881d9f-90cc-f7a2-72a3-0701348a03fe@collabora.com>
 <CAL_JsqL_EogoKOQ1xwU75=rJSC4o7yV3Jej4vadtacX2Pt3-hw@mail.gmail.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAL_JsqL_EogoKOQ1xwU75=rJSC4o7yV3Jej4vadtacX2Pt3-hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 16:27, Rob Herring wrote:
> On Fri, Mar 17, 2023 at 4:59 AM Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>>
>> On 3/17/23 00:26, Sudeep Holla wrote:
>>> On Thu, Mar 16, 2023 at 03:34:17PM -0500, Rob Herring wrote:
>>>> +Stephen
>>>>
>>>> On Wed, Mar 15, 2023 at 01:47:56PM +0200, Cristian Ciocaltea wrote:
>>>>> Since commit df4fdd0db475 ("dt-bindings: firmware: arm,scmi: Restrict
>>>>> protocol child node properties") the following dtbs_check warning is
>>>>> shown:
>>>>>
>>>>>     rk3588-rock-5b.dtb: scmi: protocol@14: Unevaluated properties are not allowed ('assigned-clock-rates', 'assigned-clocks' were unexpected)
>>>>
>>>> I think that's a somewhat questionable use of assigned-clock-rates. It
>>>> should be located with the consumer rather than the provider IMO. The
>>>> consumers of those 2 clocks are the CPU nodes.
>>>>
>>>
>>> Agreed. We definitely don't use those in the scmi clk provider driver.
>>> So NACK for the generic SCMI binding change.
>>
>> According to [1], "configuration of common clocks, which affect multiple
>> consumer devices can be similarly specified in the clock provider node".
> 
> True, but in this case it's really a single consumer because it's all
> CPU nodes which are managed together.
> 
>> That would avoid duplicating assigned-clock-rates in the CPU nodes.
> 
> Wouldn't one node be sufficient?

Yeah, that should be fine.

> Thinking more about this, why aren't you using OPP tables to define
> CPU frequencies. Assigned-clocks looks like a temporary hack because
> you haven't done proper OPP tables.

Right, this is currently not possible since it depends on some work in 
progress.

Thanks,
Cristian
