Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67F717724
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjEaGtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEaGtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:49:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C5113;
        Tue, 30 May 2023 23:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1802A63712;
        Wed, 31 May 2023 06:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8659C433D2;
        Wed, 31 May 2023 06:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685515754;
        bh=1xNhr76unyrARJPcBdufPMM+HTaMSKo+HbDxKvgS8VY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sGHmBP1+fOScMQIcsdweRl8DEw6ejOyqY0bMgCSc+wCyV42XqSXjh2CbphayB6TsA
         Xr9WBVzm9/Uwc/+2UsTfNl2MlDeU0hz3wQk1Ej7cVU6GX6oKPQPXUKtqKTk+F/4Guk
         ufkKgnBfoYjUu51V3IEGyvrtJzZAAO5r1uLCdGkv7TKIOv/Ls+QMZyC+JPtL/TnFQR
         JHauymoXMVvCyjs2HUbssxDeWtyiyH9SAZxJUqudcSsjwXpjNR87JhRbRX8XHqaZAv
         lRuwqGLtT3a3ppRPlsa7XsrJhIXfCRk8cK339m7thzZv3uPK6Xo3Rds+CXKd88Wz1C
         xiEw19rKx5VTQ==
Message-ID: <1a267380-c39d-d3a7-9287-61ba632480c3@kernel.org>
Date:   Wed, 31 May 2023 08:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] dt-bindings: rtc: Add Mstar SSD20xD RTC devicetree
 bindings documentation
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230517144144.365631-1-romain.perier@gmail.com>
 <20230517144144.365631-3-romain.perier@gmail.com>
 <669d7b79-71a6-e1f9-8d7a-71c4b64de28d@kernel.org>
 <CABgxDoKaVip=T5=s2Gd8qpX15cLD=_0TZtQoNodK1CCf+GTYZw@mail.gmail.com>
 <ad788d84-48ea-2fdb-607a-a8d49c8fe52c@kernel.org>
 <CAFr9PXmkvunO8mu+n7_YFSixe3k0vzowJzrmEWKcs9W677=WNQ@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAFr9PXmkvunO8mu+n7_YFSixe3k0vzowJzrmEWKcs9W677=WNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 01:12, Daniel Palmer wrote:
> Hi Krzysztof,
> 
> On Tue, 30 May 2023 at 17:01, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> This is
>>> exactly the case for rtc-msc313e and it was not an issue.
>>
>> So that was my question - can it be anything else? There is literally no
>> description of the hardware... Neither in commit msg nor in description:
>> field in bindings.
> 
> This RTC block is a block inside of the SSD201/SSD202D (they are the

But what is SSD201?

> same die with different memory attached) and is only found there.
> The documentation we have for this is literally one page in a PDF that
> says "RTC registers".
> It could be an IP block licensed from somewhere and technically have a
> better name but right now all we know is this RTC block is the one in
> that chip and that chip is the first known instance of it.
> 
> Say we manage to get the ethernet mainlined at some point: That's a
> lot easier as we know already it's a hacked up version of the cadence
> macb so the compatible can be "macb something".
> 
>>>> What about interrupt line?
>>>
>>> There is currently no interrupt right now, we have not yet the irqchip
>>> code for handling the alarm irq of this rtc block.
>>
>> So you are going to change the hardware and add the interrupt line? We
>> do not talk about drivers, but hardware. Whether your driver handles it
>> or not, matters less.
>>
>> Describe the hardware, not the current implementation of one driver.
> 
> We don't really know how the interrupt is wired up in the hardware properly yet.

OK

Best regards,
Krzysztof

