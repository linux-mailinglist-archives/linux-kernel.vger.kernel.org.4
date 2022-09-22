Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84385E61FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiIVMJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiIVMJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:09:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F06911160
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:09:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s10so10725132ljp.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CVENwWVGXac1UFUJqQbFq5yXNrjbR21/6YF9T4kc5Wc=;
        b=vPq+7BDrfqEBq8z8P89npQ4zMs5pP4bDn5VJTLabSIN4rKGFfdArIOwcugCxNPgEW7
         634140eokdLaJsJ9MSgoLNtcYnSQJ5wN6lSzr22PtpF28T6GNTokKDwATj3xaXrwI7DT
         Ex9AAaIE2TQIpPBHEjknXd6aZU7V+ElIlno5mm1WgwzHqC+65YLH+y9D1XlpLv5UhEkB
         2LmRTqRr2ZF80XkW4HdcYqDem/l6eS1SvrRHWg1MSuol1hUYvbSPh2bmxHrhRkvC7hV5
         cADbRjH7vIWUIJAeS6tDBq/8Sj29MWYm9vjZDVwmj21ZyQNRTxKFBK5kfp9anJeKRaxU
         bO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CVENwWVGXac1UFUJqQbFq5yXNrjbR21/6YF9T4kc5Wc=;
        b=CEZOgLY/gwusss+qk2PBsRd1o6NMWfCPR4+tC45QSnKfMl4S9wCbLKOiHPdfWfJttn
         qXNId9IRLrhsbwFpaFoki52JtuCMnwgAsXIFdlR3n7PKYQocHdFKfVA4cqKx6/dU7XfS
         xkIieboRUl+IHAAxaE7NDWPW8eFYZMactprbKOvA2/Ve+04I21d10vBM3teMQYUN9xim
         XQ8K9EusdF97e9kVdMHq69bnl7DRzvn0coE+UxpA4+EzaRj0eqJCRBsjhXjrXUXrH3Wu
         Hq9f65LzpCxSvxdIm4jgt1SpiIi+72QpnxOPL/bA+U71cLQOncetJAOno3F44FKH8mmb
         c5BQ==
X-Gm-Message-State: ACrzQf3GwsUW9Zlgy1OMJ7vJaIAQagxGIy/vPlr72xJfFRz5jWOk6IpQ
        NFiX0LNEcozm1zwxLEmA/aVxBQ==
X-Google-Smtp-Source: AMsMyM57MJocOschZ+RfLFJ7K5wcdH1+W5eO/p/+h7FJNXUmunysPu2cqAPrfAlbHq+cLi/zhZhpGw==
X-Received: by 2002:a2e:3809:0:b0:26b:e124:4d43 with SMTP id f9-20020a2e3809000000b0026be1244d43mr980317lja.398.1663848574194;
        Thu, 22 Sep 2022 05:09:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b14-20020a056512070e00b004949f7cbb6esm914128lfs.79.2022.09.22.05.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 05:09:33 -0700 (PDT)
Message-ID: <54cb8024-b600-9c1d-a8b6-d56b534de5cf@linaro.org>
Date:   Thu, 22 Sep 2022 14:09:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/4] media: dt-bindings: add bindings for Toshiba
 TC358746
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, jacopo@jmondi.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        kieran.bingham+renesas@ideasonboard.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, hverkuil@xs4all.nl,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-phy@lists.infradead.org,
        mchehab@kernel.org, kernel@pengutronix.de,
        linux-media@vger.kernel.org
References: <20220916134535.128131-4-m.felsch@pengutronix.de>
 <YyZTCsflWtUbo2ld@pendragon.ideasonboard.com>
 <20220919100844.bb7tzbql2vpk76xz@pengutronix.de>
 <YyhDO4ohv47uIij2@paasikivi.fi.intel.com>
 <YyhKoDxFoobY9vBd@pendragon.ideasonboard.com>
 <20220920152632.mjpgpmelvx4ya4k7@pengutronix.de>
 <Yyn5MqqKYH7VpFhw@pendragon.ideasonboard.com>
 <74b6b670-747a-f326-44ea-7588c3989b0e@linaro.org>
 <20220921083513.drt4rggqj7tpaygr@pengutronix.de>
 <8e54e03e-105a-cf3e-242f-796bef77bfe1@linaro.org>
 <20220922110142.qnx6w3qbb6h6grvh@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922110142.qnx6w3qbb6h6grvh@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 13:01, Marco Felsch wrote:
> On 22-09-21, Krzysztof Kozlowski wrote:
>> On 21/09/2022 10:35, Marco Felsch wrote:
>>> On 22-09-21, Krzysztof Kozlowski wrote:
>>>> On 20/09/2022 19:32, Laurent Pinchart wrote:
>>>>>>>
>>>>>>> Explicit bus types in DT indeed makes it easier for drivers, so if a
>>>>>>> device can support multiple bus types (even if not implemented yet in
>>>>>>> the corresponding drivers), the property should be there.
>>>>>>
>>>>>> Okay, I will make it required.
>>>>>>
>>>>>>>> Why do you have hsync-active and vsync-active if both are always zero? Can
>>>>>>>> the hardware not support other configuration?
>>>>>>
>>>>>> Sure the device supports toggling the logic but it is not implemented.
>>>>>> So the bindings needs to enforce it to 0 right now. As soon as it is
>>>>>> implemented & tested, we can say that both is supported :)
>>>>>
>>>>> Bindings are not supposed to be limited by the existing driver
>>>>> implementation, so you can already allow both polarities, and just
>>>>> reject the unsupported options in the driver at probe time. Future
>>>>> updates to the driver won't require a binding change.
>>>>>
>>>>
>>>> +1
>>>
>>> I don't wanna do that because this let the binding user assume that
>>> this mode is already supported. 
>>
>> What do you mean by "not supported"? By which system? By which firmware
>> element? Bindings are used by several operating systems and several
>> projects.
> 
> And they can use it and of course extend it, since the propery is
> available.
> 
>> That's not the argument.
>>
>> Bindings should be complete. Lack of knowledge and datasheets is a good
>> exception from this rule. Looking at Linux driver is not good exception.
> 
> So if I get you right, you are saying that the bindings should always be
> complete and describe all ever possible combinations?

Not necessarily all combinations, but in general be complete as in
describe entire device. Pretty often we skip describing full device
because our job does not include it and we need to move on. Fine. But
the argument is not really one Linux implementation.

Especially that limiting binding to some subset might make it later
non-extendable. Not possible to grow, because author did not think about
these other features.

> I am on your side
> that the properties should be there from day one. But listing all
> possible values regardless of the support.. I don't know and yes, I know
> that other projects using these bindings as well. But if those other
> projects support more than now, they can extend it and send patches.
> Since this is a new binding, the only user is Linux and listing all
> possible values can lead into erroneous assumption. 

So let me rephrase the case - there is no such assumption that one,
particular driver supports entire set of bindings. If anyone makes it,
without actually checking, then it is his/hers mistake.

> No system-integrator
> wants to check the driver why a listed property is not supported instead
> most the time it is the other way. If it is listed, than it should be
> supported.

Bindings are also not the tool for system integrator to figure out these
things.

> 
> Anyway I don't wanna make a big deal out of it. I will add all possible
> values to the binding if that is what you want :)
> 
> Regards,
>   Marco
> 
>>> Adapting a binding is just 1 commit and
>>> since the property is already existing, there is no breaking change.
>> Best regards,
>> Krzysztof
>>
>>

Best regards,
Krzysztof

