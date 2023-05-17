Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183DB706394
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjEQJF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQJF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:05:26 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD4F4EC9;
        Wed, 17 May 2023 02:05:00 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BFF40C000A;
        Wed, 17 May 2023 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684314299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gc/ykMJgF896xHb9tBmtxw9aKhzQAk9UOB5iv7nc/Dw=;
        b=oJaV1qENwrA5SZsq1tDtT0AngyzBMxX7okvJgV7hVXIwY0Jbe3qzriXQhSA9C6HIHghw+w
        zY+ULQbKbA5LzZmNi07DjZsc/EhgDyJc3n7nDE3SzyvjGhD7HHEENBHrgRBXvFkXI8hXpz
        CX9orDg4gKJ3jIR28Hel6SY4VFiRCWs0g3GK6HTgnuKQ01hB1ywTpAysQAe6c/UlzXxUIL
        ShF7zyMNVf5Jkbxi/CS047JRwB6/aOhYTa4QWFfDPiKScur814xBmXf8AyAnj5OJNp4Nme
        LHvaXEL0y/H06C2Y7U2DYrhc0fEySGQv7rEzEjgjXPz5J5h0aWPivA+Hg63mGg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: marvell: add missing cache properties
In-Reply-To: <b2d8cb74-9675-d449-971d-016a1df66ba6@linaro.org>
References: <20230421223159.115412-1-krzysztof.kozlowski@linaro.org>
 <b2d8cb74-9675-d449-971d-016a1df66ba6@linaro.org>
Date:   Wed, 17 May 2023 11:04:58 +0200
Message-ID: <877ct7xr9h.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Spam-Score: 200
X-GND-Status: SPAM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 22/04/2023 00:31, Krzysztof Kozlowski wrote:
>> As all level 2 and level 3 caches are unified, add required
>> cache-unified properties to fix warnings like:
>> 
>>   ac5-98dx35xx-rd.dtb: l2-cache: 'cache-unified' is a required property
>> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> 
>> ---
>> 
>> Please take the patch via sub-arch SoC tree.
>
> Hi Andrew and Gregory,
>
> Could you grab this one?

Applied on mvebu/dt64

Thanks,

Gregory

>
> Best regards,
> Krzysztof
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
