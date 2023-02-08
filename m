Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB2A68EFCE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjBHNby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:31:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E995849415
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:31:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p26so51111341ejx.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 05:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Rx7S8/paqMgxnm4kF6q5iAl3Vj6zs20TVGfjzUx8/E=;
        b=gH0VzWqwU2ciD0VxkelSv1zh10sO+YmyLMlpkxr8a/YSCygNEhMzJRSllXhGDQ83Fx
         cp+TU1zG3vAHs+3I7Y7WTsAHgVMnKjp5wcBCUEn6AqJFervPA9mBwav69DYLp+bFHyG+
         d+7KlJ4HHsEjgNGh6pLgzqbioGwjwy5ZUweM8dcPrWLBdATNK4hTrZ6qAdH/RVr+Q0tL
         cGt+X18LJFOetDJEvLQFmode+hTeDNILZrIuidQN4tSiHKUjhWshxZAQjJd43JZV2uXx
         Rui2WGB5GVFCy9shinbo7jweXA9wcQ8AwJ+hzDicpi8mpWCCnuNVxZQ+NduUi9Z39+6h
         C6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rx7S8/paqMgxnm4kF6q5iAl3Vj6zs20TVGfjzUx8/E=;
        b=lcmcxuyIb51A2SOQviXzecCTSnSsJd9zzvaGjCFyw4+foJeOwJZ92whgxAKnkFb63u
         FGNevoBuLcUghIYKp6+oCHdKg3U6r4+RujpoRIEQrsWk0HZ5WM2HZW4Imrkug/O8LH/U
         GtANZIzLHHIc6BQHq6A7DDgOJ4Q6qdWUM6nLoc4GpCtqRQDJRrFuF5ENmQbT1DKgCKvO
         rw4OPmg0fdtSDQpuuKXAc0PxpYnnlpCDh9JJvAiNVmxzBCGh/KkxVdOtc4y9ydXYQafZ
         AZ221JLW8SRQy7Ku3I1dvDyOJYrxyluy2af851yoMZ26Hz3nZZG86TUbQ4zwb7QbItmd
         1SYQ==
X-Gm-Message-State: AO0yUKXeEwyFsX3ygaO2wQCzWGNOwUjF6xsdLMLnaVuGU5LC6hCp2xiP
        yYnkXBIcEhht60LZGSDef4aHGw==
X-Google-Smtp-Source: AK7set9uaUW7hPWy2l0WGLbFt9xIMpLfBchg6B9ZENnzRjHiMr9GrUljkz442D2cn4jLVoGSwkRBmw==
X-Received: by 2002:a17:907:c23:b0:8aa:b526:36b3 with SMTP id ga35-20020a1709070c2300b008aab52636b3mr7584661ejc.14.1675863100407;
        Wed, 08 Feb 2023 05:31:40 -0800 (PST)
Received: from [192.168.3.225] ([81.6.34.132])
        by smtp.gmail.com with ESMTPSA id q19-20020a17090622d300b0088a2397cb2csm8382641eja.143.2023.02.08.05.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 05:31:40 -0800 (PST)
Message-ID: <4e9705d5-c6f7-0b08-6e45-b19bae1d248d@blackwall.org>
Date:   Wed, 8 Feb 2023 14:31:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] net: bridge: clean up one inconsistent indenting
Content-Language: en-US
From:   Nikolay Aleksandrov <razor@blackwall.org>
To:     Simon Horman <simon.horman@corigine.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        roopa@nvidia.com, pabeni@redhat.com,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20230208005626.56847-1-yang.lee@linux.alibaba.com>
 <Y+OdyiQpz7lIBfh3@corigine.com>
 <1a71f6f8-09f6-9208-7368-6b2e3bb4af87@blackwall.org>
In-Reply-To: <1a71f6f8-09f6-9208-7368-6b2e3bb4af87@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/23 15:30, Nikolay Aleksandrov wrote:
> On 2/8/23 15:04, Simon Horman wrote:
>> On Wed, Feb 08, 2023 at 08:56:26AM +0800, Yang Li wrote:
>>> ./net/bridge/br_netlink_tunnel.c:317:4-27: code aligned with 
>>> following code on line 318
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3977
>>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>>
>> As you may need to respin this:
>>
>> Assuming this is targeting net-next, which seems likely to me,
>> the subject should denote that. Something like this:
>>
>> [PATCH net-next] net: bridge: clean up one inconsistent indenting
>>
>>> ---
>>>   net/bridge/br_netlink_tunnel.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/bridge/br_netlink_tunnel.c 
>>> b/net/bridge/br_netlink_tunnel.c
>>> index 17abf092f7ca..eff949bfdd83 100644
>>> --- a/net/bridge/br_netlink_tunnel.c
>>> +++ b/net/bridge/br_netlink_tunnel.c
>>> @@ -315,7 +315,7 @@ int br_process_vlan_tunnel_info(const struct 
>>> net_bridge *br,
>>>               if (curr_change)
>>>                   *changed = curr_change;
>>> -             __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
>>> +            __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
>>>                               curr_change);
>>
>> I think you also need to adjust the line immediately above.
> 
> You meant below, right? :) i.e. "curr_change)", that seems to get
> misaligned after the change and needs to be adjusted as well.
> 

Oh I need coffee, I somehow was thinking about the line being changed
instead of literally the line above your statement. :))

Anyway, ack.

>>
>>>           }
>>>           if (v_start && v_end)
>>> -- 
>>> 2.20.1.7.g153144c
>>>
> 

