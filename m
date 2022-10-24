Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79F660B353
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiJXRDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiJXRC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:02:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2735819898A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:39:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o4so8642456wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hS9JG4WHdO3CwJJioolnxCNpR8bEZ9L4YEaSVpziqPU=;
        b=bDi/RSWZVeIXfBuRToCjVbt2mtGGydHkFP+VlOJJ4UKLf1pxznyIP6bjv4R4TlL4wA
         BsABe1Agh4I+Hy4tYs48bPzbZS+zxMJ2hmo82NUnnkZ98/MMBVXtg6cbjM3YJ37C7SaK
         MVKCEe88KU3KhTJQgQNHZgBXUIr+TkOOcUZhDoc0Vo3+jl8tcMyJtrszTres0de7q7AG
         ZQGmyfIvbYVSBHAMwH82gc9YUDsg/zh1ZDTQzclMkwAkAAXBiKGrYZLX05qggiaRQoK+
         6PH5GVfUH4XdIJrlFJ3WOzoOdnGY1YQkfE1EjFusX37ckZ7nKZ83Fc68XgBUi5HArimK
         UP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS9JG4WHdO3CwJJioolnxCNpR8bEZ9L4YEaSVpziqPU=;
        b=FYP3wIV+pHisWWydlbS3JHtbXDvvNku97zWYZP6s7M6Bp4adKzeS/XojQQL0WjNqXD
         AapV+9XkIA7im3ktCYj8ZNORSeqnWZay1iIE54UF+yoqBJmNGRct3XQTNd7nMBeeQ7QX
         vPnt6zo2OoJhzLC6H67/6wBZVXgy+lYjd3U0YFFKvVVYQzh8CI8xxl+PfGaItPWF/OFX
         b3hvTjTZ+w5Iym1SfdqUETn9zLymOOQhaK1Ib3uIkWTHGtlvljzzd5/Sg93YfrNgUSMQ
         1lhnbZHzIC410jogBFVxlqMZsbEx1YRNW4SMtaeEJOg+TONkHIHCr7mVAseDWB1ggo61
         /5rw==
X-Gm-Message-State: ACrzQf2hey7cUlkeyF6LSVgnAUrOFE93iFej6CGvb4RjzfPWZ1Hdh17G
        YSBChecp/W5DnKnszCl4ggPAzlGpZ1mzrQ==
X-Google-Smtp-Source: AMsMyM7ycCSSePYyPxj705uthaHEwcRKtdoXCS3YaRl1Rmu7oS5hS3l6kfEEtFwhEoE+RazQaoqnMQ==
X-Received: by 2002:a05:6000:1287:b0:236:712d:2545 with SMTP id f7-20020a056000128700b00236712d2545mr3175939wrx.52.1666614441006;
        Mon, 24 Oct 2022 05:27:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:416:9ea1:405b:86ea? ([2a01:e0a:b41:c160:416:9ea1:405b:86ea])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b003b505d26776sm8853533wmb.5.2022.10.24.05.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:27:20 -0700 (PDT)
Message-ID: <5af190a8-ac35-82a6-b099-e9a817757676@6wind.com>
Date:   Mon, 24 Oct 2022 14:27:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFE net-next] net: tun: 1000x speed up
Content-Language: en-US
To:     Ilya Maximets <i.maximets@ovn.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20221021114921.3705550-1-i.maximets@ovn.org>
 <20221021090756.0ffa65ee@kernel.org>
 <eb6903b7-c0d9-cc70-246e-8dbde0412433@6wind.com>
 <ded477ea-08fa-b96d-c192-9640977b42e6@ovn.org>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ded477ea-08fa-b96d-c192-9640977b42e6@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/10/2022 à 13:56, Ilya Maximets a écrit :
> On 10/24/22 11:44, Nicolas Dichtel wrote:
>> Le 21/10/2022 à 18:07, Jakub Kicinski a écrit :
>>> On Fri, 21 Oct 2022 13:49:21 +0200 Ilya Maximets wrote:
>>>> Bump the advertised speed to at least match the veth.  10Gbps also
>>>> seems like a more or less fair assumption these days, even though
>>>> CPUs can do more.  Alternative might be to explicitly report UNKNOWN
>>>> and let the application/user decide on a right value for them.
>>>
>>> UNKOWN would seem more appropriate but at this point someone may depend
>>> on the speed being populated so it could cause regressions, I fear :S
>> If it is put in a bonding, it may cause some trouble. Maybe worth than
>> advertising 10M.
> 
> My thoughts were that changing the number should have a minimal impact
> while changing it to not report any number may cause some issues in
> applications that doesn't expect that for some reason (not having a
> fallback in case reported speed is unknown isn't great, and the argument
> can be made that applications should check that, but it's hard to tell
> for every application if they actually do that today).
> 
> Bonding is also a good point indeed, since it's even in-kernel user.
> 
> 
> The speed bump doesn't solve the problem per se.  It kind of postpones
> the decision, since we will run into the same issue eventually again.
> That's why I wanted to discuss that first.
> 
> Though I think that at least unification across virtual devices (tun and
> veth) should be a step in a right direction.
Just to make it clear, I'm not against aligning speed with veth, I'm only
against reporting UNKNOWN.

> 
>>
>> Note that this value could be configured with ethtool:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4e24f2dd516ed
> 
> This is interesting, but it's a bit hard to manage, because in order
> to make a decision to bump the speed, application should already know
> that this is a tun/tap device.  So, there has to be a special case
But this should be done by the application which creates this tun interface. Not
by the application that uses this information.

> implemented in the code that detects the driver and changes the speed
> (this is about application that is using the interface, but didn't
> create it), but if we already know the driver, then it doesn't make
> sense to actually change the speed in many cases as application can
> already act accordingly.
> 
> Also, the application may not have permissions to do that (I didn't
> check the requirements, but my guess would be at least CAP_NET_ADMIN?).
Sure, but the one who creates it, has the right to configure it correctly. It's
part of the configuration of the interface.

Setting an higher default speed seems to be a workaround to fix an incorrect
configuration. And as you said, it will probably be wrong again in a few years ;-)

> 
> For the human user it's still one extra configuration step that they
> need to remember to perform.
I don't buy this argument. There are already several steps: creating and
configuring an interface requires more than one command.


Regards,
Nicolas
