Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A90C74A0E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjGFP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjGFP01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:26:27 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22527C9;
        Thu,  6 Jul 2023 08:26:22 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 35125862AE;
        Thu,  6 Jul 2023 17:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1688657174;
        bh=2jlDFdx22SzndaSy19h6mEBsUHo5Dt4myuOcYQTEoXc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ChJvo1xJRTH6ASox/dcaWQdM5zg7GfhYy2XV327uY/WeBbjhertjAyiYT6aIIg5K9
         K+e7ltHrJQCvhr2RzT3vFBgFmuXjTNoyU1JaVGowGqrMce0MZjQsBgaAlLbi2h2Fcy
         dHj3V1qLpvYz5TxMml1Azf9ItNWWE4du289nT4IMiuXM9V3dHF8KkvxpezPWKjvihg
         iO8wzMJ2Y6/x4Cn0X9VRKJLbdcAABtg3Lety8lUzw2dlxjnnTIdWSC+BEbkGQlXndF
         YDstcRByfX1QrLS8XstJ2v4T23Fm4/1fqei5hi+5x/dC4xsycKT8tDmTlSy5yx80yD
         Obxm88TYHJ3Jg==
Message-ID: <0d43e653-32cd-b25e-40fa-6f0571048467@denx.de>
Date:   Thu, 6 Jul 2023 17:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
Content-Language: en-US
To:     Paulo Pavacic <pavacic.p@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230607151127.1542024-1-pavacic.p@gmail.com>
 <20230607151127.1542024-4-pavacic.p@gmail.com>
 <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
 <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
 <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com>
 <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com>
 <CACRpkdYXtQwmZR1u-1fwmyC_8Yq4bMkjDBcUCfuGqSz_UhXWJQ@mail.gmail.com>
 <CAO9szn0OuKW+-JZMs3TPUHiwLCe6cUPcsUq+og64K2utMyZpqQ@mail.gmail.com>
 <CACRpkdb5stXKb7FNk_FC-PKduCngRX3sZTbzcxN+kRskz78fuQ@mail.gmail.com>
 <CAO9szn3oTzrrwiyr91H14ep7OPUkA-SDST3CSQAQHvFFnkJWfA@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAO9szn3oTzrrwiyr91H14ep7OPUkA-SDST3CSQAQHvFFnkJWfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 17:18, Paulo Pavacic wrote:
> Hello Linus,
> 
> čet, 22. lip 2023. u 10:22 Linus Walleij <linus.walleij@linaro.org> napisao je:
>>
>> On Wed, Jun 21, 2023 at 5:09 PM Paulo Pavacic <pavacic.p@gmail.com> wrote:
>>
>>> A lot of modifications to st7701 are required. I believe it would
>>> result in a driver that doesn't look or work the same. e.g compare
>>> delays between initialization sequences of panel-fannal-c3004 and
>>> panel-st7701. I think it would be optimal to create st7701s driver and
>>> have special handling for st7701s panels. If there was a flag for
>>> whether panel is st7701 or st7701s it would end up looking like a
>>> mess.
>>
>> What matters is if the original authors of the old st7701 driver are
>> around and reviewing and testing patches at all. What we need is
>> active maintainers. (Added Jagan, Marek & Maya).
>>
>> I buy the reasoning that the st7701s is perhaps substantially different
>> from st7701.
>>
>> If st7701s is very different then I suppose it needs a separate driver,
>> then all we need to to name the driver properly, i.e.
>> panel-sitronix-st7701s.c.
> 
> I had in person talk with Paul Kocialkowski and I have concluded that
> this is the best solution.
> I believe I should rename it to st7701s due to the hardware changes. I
> would like to create V5 patch with driver renamed to st7701s.
> Please let me know if you agree / disagree.

If I recall it right, the ST7701 and ST7701S are basically the same 
chip, aren't they ?
