Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DEF70B7E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjEVIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEVIoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:44:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E1FB6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:44:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso8085073a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1684745054; x=1687337054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRCMQPba22gphE+yEe+ARCBFhwsSZYsTb9sKXq+NJRM=;
        b=bb/7ytzXxYkGjIUZxdrfHhlMdXTLgbYzgV1N3oWkJnByQMEOccwyCba6RmLgeMNgqo
         OEus+WqbwlfKjNQuLI09Are2Q1km1qtJq+VnVjc8ftLjfW9zCcjahAj//+RPTmKNRIRm
         u4kV8u+Iyj00/ezfPVZp2UIlDYGOjgf/9AFH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745054; x=1687337054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRCMQPba22gphE+yEe+ARCBFhwsSZYsTb9sKXq+NJRM=;
        b=YF7N32QmDq7e0BBm0q9JPbDuUdR5/A997EbZEB8+aKvyrA3CLJRDVXszbaBw2LVb9P
         l8NxuGa99g+y42jyQNqYWXuZRxvGGq5RGA1Lmoh+OKBzDAOHrk+kbfX5M445tsr6m0UG
         X3X4j86vWkkQIDj/mDRnavePG77ZbFlX1JQK8TZUdEWjqPNu2WLNTM2wscMrjxR+r39C
         oeK7ZiyYlgLupQnHiFhnvDeciz1Ev3PjZ5TjmMnZ3dfabpTWM9qjXwoJ6D1svVAqfvBg
         oRzGHBkUVzjLdxRfO4SBCB15bWIpDetHZbd6gqyURhoq2H0S7L1T6vVwX++A6cLAz1UD
         STrA==
X-Gm-Message-State: AC+VfDwxdwUpQf507wHuqr9N9Vjf2c/GL2AC6HLOMVIVIw8shW0QEcWK
        3mytOi5cUcfhhar+IsJ6HeqolZDwzzxBpmh7+j8rRg==
X-Google-Smtp-Source: ACHHUZ799M1ZwNFLAegsyLqUbPymCUgBAvL8CX59OgNWOkquTg+WH1VPOhl1PzKcpHqpj2Hy80yOmA==
X-Received: by 2002:a05:6402:2ce:b0:50b:c4fb:770f with SMTP id b14-20020a05640202ce00b0050bc4fb770fmr7919446edx.34.1684745054601;
        Mon, 22 May 2023 01:44:14 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v22-20020a50d096000000b0050e04125a46sm2840443edd.10.2023.05.22.01.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:44:13 -0700 (PDT)
Message-ID: <822d2741-32ff-fc73-28a5-25575ab3cc52@rasmusvillemoes.dk>
Date:   Mon, 22 May 2023 10:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] iio: addac: ad74413: don't set DIN_SINK for functions
 other than digital input
Content-Language: en-US, da
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230503105042.453755-1-linux@rasmusvillemoes.dk>
 <27fe41e402ea0d6ef42aa0ac80aa3d1488862cd8.camel@gmail.com>
 <6fcf4997-9d88-7e86-70f7-52f9d296bc6e@rasmusvillemoes.dk>
 <20230506191636.3cff4b24@jic23-huawei>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230506191636.3cff4b24@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2023 20.16, Jonathan Cameron wrote:
> On Thu, 4 May 2023 12:08:53 +0200
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> On 04/05/2023 09.28, Nuno Sá wrote:

>>> Can anyone have a working device by specifying that dt parameter
>>> on a non digital channel (or expect something from having that parameter set)?
>>> Or the only effect is to actually have some functions misbehaving?  
>>
>> The data sheet doesn't say that the DIN_SINK should have any effect for
>> other functions, so I'm pretty sure it's only the latter: some functions
>> misbehave.
>>
>>> On the driver side, if it's never right to have
>>> these settings together, then the patch is valid since if someone has this, his
>>> configuration is broken anyways (maybe that's also a valid point for the
>>> bindings)...  
>>
>> Yes, I do believe that it's a broken description (whether or not the
>> bindings specify that), and drivers don't need to go out of their way to
>> validate or fixup such brokenness. But in this particular case, there's
>> really no extra burden on the driver to not put garbage in DIN_SINK when
>> a not-digital-input function has been chosen (the patch is a two-liner
>> with 'git show -w').
> 
> If we can tighten the DT binding to rule out something that should not be
> set than that would be good.  Tightening bindings is fine - we don't mind
> validation of bindings failing on peoples DTs as long as we didn't 'break'
> them actually working.

Well, I'm afraid I don't have any idea how to spell that constraint in
the yaml-language (help appreciated).

And I assume a dt binding update would be a separate patch anyway, so
could you please consider applying this patch?

Thanks,
Rasmus

