Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6BB63C3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiK2PhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiK2PhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:37:23 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3611060EBF;
        Tue, 29 Nov 2022 07:37:20 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7C3CB82163;
        Tue, 29 Nov 2022 16:37:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669736238;
        bh=Wh3qIb4vW6t1qeCDx8nY/HjD0VFBMqpD4ET83slHvnQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jzvCwUO5fpnBEWzWjZNOPRAFV59n7OuGELxXic6xK2hYNCObs+vWwK9ztgOIMCCQH
         oJ3meeCUEjcndnnU5hzOx9X/PJxrjZ8CxuF538fJZpzTw46V/RZBNjmuQNUHYJXmNk
         SHOSoFdI6hFizuGbBSi/FRbs1gc3PW3sFrSvPkphP5lfIZYok4ZrZu9YY5XvpUtWU8
         i8jKAKEUM7UUDIqz4lOskH/9+8JR84vNCR1NKtXLwgBUWk5wMxiPJ0TDTVpiuq2Fru
         peOBYCr7kw+q3qtJC4hkARyKnn6DBNE1szPgAYiJGl2a+gGab3lEy8E2Vm+ofNU72F
         7lUXIyfHxxrqg==
Message-ID: <12b41c65-0692-3b6d-2406-991e26966f76@denx.de>
Date:   Tue, 29 Nov 2022 16:37:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: mmc: Make comment on wakeup-source less
 confusing
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@dh-electronics.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-3-cniedermaier@dh-electronics.com>
 <55c29f92-4c6b-266f-2004-ae633a658963@linaro.org>
 <CAPDyKFparoXMJ-sRxgqi8zDGn5AoNDLfsAF9YkdoaKpTU3EchQ@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAPDyKFparoXMJ-sRxgqi8zDGn5AoNDLfsAF9YkdoaKpTU3EchQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 16:30, Ulf Hansson wrote:
> On Tue, 29 Nov 2022 at 13:36, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 22/11/2022 12:11, Christoph Niedermaier wrote:
>>> The current comment on wakeup-source is a bit confusing, because it isn't
>>> clear at first sight which property is actually deprecated.
>>> Change the comment to one that is less confusing.
>>
>> It's still confusing - you mention some non-existing property. I don't
>> think it's worth to touch it. If you insist, drop entire comment...
> 
> Hmm, it doesn't look that easy to me. The "enable-sdio-wakeup" is
> indeed a deprecated wakeup property [1], but it seems like it's not
> really described somewhere. I wouldn't mind removing it (as it seems
> to add some confusions), but in that case it needs to be entirely
> removed from the DT docs, right?
> 
> Another option, would be to add a proper description of the property
> and mark it with "deprecated: true".

There are no in-tree DTs which use the property, so maybe we should just 
drop it altogether from the bindings ?

next-20221128$ git grep enable-sdio-wakeup
Documentation/devicetree/bindings/mmc/mmc-controller.yaml:  # 
Deprecated: enable-sdio-wakeup
Documentation/devicetree/bindings/power/wakeup-source.txt:1. 
"enable-sdio-wakeup" 
Documentation/devicetree/bindings/mmc/mmc.txt
drivers/mmc/core/host.c:            device_property_read_bool(dev, 
"enable-sdio-wakeup")) /* legacy */
drivers/mmc/host/sdhci-pltfm.c:     device_property_read_bool(dev, 
"enable-sdio-wakeup")) /* legacy */
