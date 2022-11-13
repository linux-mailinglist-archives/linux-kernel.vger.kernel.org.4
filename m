Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100BA627266
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 21:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiKMUD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 15:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiKMUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 15:03:56 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A4D2BE0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:03:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d6so16131970lfs.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNZiPVV38BD+NXjcSGrGQb5Ha258QJwOowf6kKzcr/g=;
        b=Na5gUfo3ZLiN0ZNYydgqfKfqVoPdWKCWW8ouk7+N7pD50cUGc1WD7bZTkcdQsX3Dh3
         eZ85wjHbwYgnOPUKscwVFhn0ROpkHzo4GN47imxkesVyj6Xl1+Ol0J5VBoqcR2EZYJ7u
         9HXPg7DsvCidpC8A67Dp7OIgoiFkhpJepdCak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNZiPVV38BD+NXjcSGrGQb5Ha258QJwOowf6kKzcr/g=;
        b=WxCGMCIndDHIo0ICYfHqmo9lWpRYeDdMaovf1KvgnJ48QvJJWrTr0pUTiKaG+sQRcj
         NacgcroT6tMlVEqPf4ayvXWniN8z7FqI4kShulQ4ANBfuyLQAKcN3pNdiHNor0PGw8bx
         uYBH8kWCtyAQUZMvn9PvbjlL6UU4diQLaRgmcrjxk20IQjoo1roqiaXX3oUIUH+qPbVb
         dRRfSijXQsV4NPMjx5u6t0YhWvKrYUIeHqIyS4YLIvXkEFryNvgdAJ+iPf/tAJwTFf8s
         ZIwRTWx4Ghkjalj6rssNxZjJ0fzaBB36xHZgmoTT4A5jYgB25rfPSHCjS29usgw2eDhN
         C1Fg==
X-Gm-Message-State: ANoB5pnMlMvZt9kc/UZNauCaff8mtQLowVKCMz+O+k4etFlBHdZtfWDz
        q6vE8Y2J5s91lRnK/3L8JSu8wA==
X-Google-Smtp-Source: AA0mqf53XtKzUTXrYt9v/fnVnq2k1Cl513Z3Y1xcF8LydNg0MnQuZdmMxcBYU2Me5Jgdnr2ZGCM8bg==
X-Received: by 2002:ac2:4d19:0:b0:4a6:ea05:73fe with SMTP id r25-20020ac24d19000000b004a6ea0573femr3146161lfi.181.1668369833088;
        Sun, 13 Nov 2022 12:03:53 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b6-20020a196706000000b004a4754c5db5sm1495332lfc.244.2022.11.13.12.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 12:03:52 -0800 (PST)
Message-ID: <26d3b005-aa4e-66d3-32eb-568d3dfe6379@rasmusvillemoes.dk>
Date:   Sun, 13 Nov 2022 21:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] net: dsa: use NET_NAME_PREDICTABLE for user ports with
 name given in DT
Content-Language: en-US, da
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221111161729.915233-1-linux@rasmusvillemoes.dk>
 <Y26B8NL3Rv2u/otG@lunn.ch>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Y26B8NL3Rv2u/otG@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 18.10, Andrew Lunn wrote:
>> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
>> index a9fde48cffd4..dfefcc4a9ccf 100644
>> --- a/net/dsa/slave.c
>> +++ b/net/dsa/slave.c
>> @@ -2374,16 +2374,25 @@ int dsa_slave_create(struct dsa_port *port)
>>  {
>>  	struct net_device *master = dsa_port_to_master(port);
>>  	struct dsa_switch *ds = port->ds;
>> -	const char *name = port->name;
>>  	struct net_device *slave_dev;
>>  	struct dsa_slave_priv *p;
>> +	const char *name;
>> +	int assign_type;
>>  	int ret;
>>  
>>  	if (!ds->num_tx_queues)
>>  		ds->num_tx_queues = 1;
>>  
>> +	if (port->name) {
>> +		name = port->name;
>> +		assign_type = NET_NAME_PREDICTABLE;
>> +	} else {
>> +		name = "eth%d";
>> +		assign_type = NET_NAME_UNKNOWN;
>> +	}
> 
> I know it is a change in behaviour, but it seems like NET_NAME_ENUM
> should be used, not NET_NAME_UNKNOWN. alloc_etherdev_mqs() uses
> NET_NAME_ENUM.

I don't really have any strong opinion on the case where we fall back to
eth%d, as its not relevant to any board I've worked on.

> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/netdevice.h#L42
> says that NET_NAME_UNKNOWN does not get passed to user space, but i
> assume NET_NAME_ENUM does. So maybe changing it would be an ABI
> change?

Well, the name_assign_type ABI is kind of silly. I mean, userspace knows
that when one gets EINVAL trying to read the value, that really means
that the value is NET_NAME_UNKNOWN. But I won't propose changing that.

However, what I do propose here is obviously already an ABI change; I
_want_ to expose more proper information in the case where the port has
a label, and just kept the NET_NAME_UNKNOWN for the eth%d case to make
the minimal change. But if people want to change that to NET_NAME_ENUM
while we're here, I can certainly do that. I can't think of any real
scenario where NET_NAME_ENUM would be treated differently than
NET_NAME_UNKNOWN - in both cases, userspace don't know that the name can
be trusted to be predictable.

Rasmus

