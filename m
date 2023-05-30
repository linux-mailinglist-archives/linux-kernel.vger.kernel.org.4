Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2925E7157D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjE3IB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjE3IBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:01:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9B118;
        Tue, 30 May 2023 01:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DECC262901;
        Tue, 30 May 2023 08:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BCDC433D2;
        Tue, 30 May 2023 08:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685433703;
        bh=dVnNYFeOe8bYZ0kkyN7qk+7ollcpFAuTm5euN9ZMmtk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=akSLrHLgxJfyL51neES4C4w6W3/I+AYA5O0vGEADptFBH4hsvLo0f+zg8qCDNxLgJ
         5BJprPK8v3OP1BgMzMu8prWIHoyyEoy6TZYtCGrLRXaVOuEgwMkXokf8q7oRiLd25r
         +EiOFSuyVy2dJ0f+oValEDS0y3HjmF0lKJvxJjFChRiCALi0UBSuWoqHAQUOliuxjd
         tpjzLrmy5f524uM68ILReMj3vNO8IWZ9DyiTMD1vn2db5d3R56waEuCu+/6KXn/cdy
         CyJTuTR3ct2rtvARSOPahLJY2qD1qSgMGnqTAtbggigaxwgKmwZ+XbsYcYdTCLoyK6
         G/em+f9V9wEwA==
Message-ID: <ad788d84-48ea-2fdb-607a-a8d49c8fe52c@kernel.org>
Date:   Tue, 30 May 2023 10:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] dt-bindings: rtc: Add Mstar SSD20xD RTC devicetree
 bindings documentation
Content-Language: en-US
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230517144144.365631-1-romain.perier@gmail.com>
 <20230517144144.365631-3-romain.perier@gmail.com>
 <669d7b79-71a6-e1f9-8d7a-71c4b64de28d@kernel.org>
 <CABgxDoKaVip=T5=s2Gd8qpX15cLD=_0TZtQoNodK1CCf+GTYZw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CABgxDoKaVip=T5=s2Gd8qpX15cLD=_0TZtQoNodK1CCf+GTYZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 13:27, Romain Perier wrote:
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - mstar,ssd20xd-rtc
>>
>> Why rtc suffix? Can it be anything else?
> 
> Well, it is the dt-bindings for an RTC block ? suppose tomorrow we
> have an ethernet block specific to the SoC SSD202D, it should be
> "mstar,ssd202d-ethernet" , how do you make
> the difference if you just put "mstar,sd202d" ? Plus a lot of rtc
> dt-bindings have this suffix (when it is not an IP name).

There are a lot of bad design choices or bugs - are you going to
implement the same mistakes because someone did it?

> This is
> exactly the case for rtc-msc313e and it was not an issue.

So that was my question - can it be anything else? There is literally no
description of the hardware... Neither in commit msg nor in description:
field in bindings.

What is SSD202D? SoC? RTC?


> 
>>
>> Missing blank line
> 
> ack
> 
>>
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  start-year: true
>>
>> Drop
>>
>> What about interrupt line?
> 
> There is currently no interrupt right now, we have not yet the irqchip
> code for handling the alarm irq of this rtc block.

So you are going to change the hardware and add the interrupt line? We
do not talk about drivers, but hardware. Whether your driver handles it
or not, matters less.

Describe the hardware, not the current implementation of one driver.


Best regards,
Krzysztof

