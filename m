Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB328736894
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjFTKAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjFTJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:59:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598101FD0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:57:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f9002a1a39so28999035e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687255060; x=1689847060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MH9D+mQhZm8PpudHO85Ayb+hsCyNy+fsukwFMssT1jI=;
        b=vVFuXtdrWAOVCYVlh/T1biiu2EDnmZi6ZdzmmPrM4VpaIEv3V6LvStP5vbjR/cnlK4
         4hUPiNVznI4kQPuX3DQVoN5+ksJFv3O/qBBiga7L+Vq7pYNQzu1ey9jr3Rh4khrDXjK4
         9WWDdvMWP8UFlh0hwwKQ104VDOz6BkaMQe/gVYabj9zdzL880NrwejRrYQGkpohWZrsf
         stsYgM3Hcvs8EcYjRkih0LVnhAO8JNWDkQ1xGRs95trF4A091e1e5rAhTrv30o27P8e2
         CQ+1T+LNZ0g8d5NsaRWZJJWD8kj2/18SFTQDpwRonKjiJDJ/av/QGYYInpTQBYzyQSCC
         E/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255060; x=1689847060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MH9D+mQhZm8PpudHO85Ayb+hsCyNy+fsukwFMssT1jI=;
        b=L3nVW0vWTbW5qfjVstG3/SQo4DFBbmjR8BdsPM6GPiPglpiT/cI4bNR1dIXX4Rc0KV
         hEWr2FAbsSkI/vi88DpsmJ7AyqO4Fw8DCWL09d+AkEtTwaTXENvE7mlWaUsPPfiIoTaH
         +rGHV9SjBsRJ7WQTIQe1WynuZjh4TZm4nPnVqwhmo7ImyEbSzXol1xG/bWfW3nr7L0sk
         b7QJj75MP8gE3GqeLbY5ArxLkyIAeCch9ij479w4H1CTj+wiFf6XUg7ZzXaD6Ioxbbbi
         k2kPdsswItqfx7q8rvyXDEH3wh0uGw/llCYWPlWYQxFv8GulTi+uoRdx2SyXJUYLBUoT
         o+dg==
X-Gm-Message-State: AC+VfDye7WolEgsGGlEYC3VfFSLgke6zpRwuv3oOwDlyq9+/s8RiSnMw
        2etyixWBzn0bQK+GJCEFn5Rm86sASq8jr+i5uC8=
X-Google-Smtp-Source: ACHHUZ762RAzC9Zhy1FUQOwLjOUTafH1ivbIetKFDtyJbGDF2V9t3hMAhBThFgMKlIInHnH19/41EA==
X-Received: by 2002:a05:600c:2189:b0:3f6:7e6:44ea with SMTP id e9-20020a05600c218900b003f607e644eamr8251250wme.18.1687255059776;
        Tue, 20 Jun 2023 02:57:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bcb8c000000b003f9b66a9376sm1804286wmi.42.2023.06.20.02.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 02:57:39 -0700 (PDT)
Message-ID: <f068e601-52ec-2dbf-d117-4164863d58ab@linaro.org>
Date:   Tue, 20 Jun 2023 11:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: timer: add Ralink SoCs timer documentation
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
References: <20230620093409.1411399-1-sergio.paracuellos@gmail.com>
 <9b0d5439-24dd-2c32-f13a-110f758591fb@linaro.org>
 <CAMhs-H9L0GybDOdmx5_RCw-=PaO3DYUOZPswiRErRRg5Fi57tQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H9L0GybDOdmx5_RCw-=PaO3DYUOZPswiRErRRg5Fi57tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 11:51, Sergio Paracuellos wrote:
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    const: timer
>>
>> Names matching the module name are not really helpful, so drop it,
>> unless any existing user needs it.
> 
> I am ok with dropping this. If you meant with an existing user
> something that is already mainlined in the kernel tree then I would

Yes.

> say there is no need for this 'clock-names'. I don't know about other
> places since these SoCs are pretty old and almost with nothing
> documented. I am doing the effort of trying to document all the stuff
> before porting some openWRT device tree files to the kernel (this
> timer driver is already included in 'arch/mips/ralink' so I am
> documenting already in-tree things). So I guess I should send v2
> removing this?

Yes, please.

Best regards,
Krzysztof

