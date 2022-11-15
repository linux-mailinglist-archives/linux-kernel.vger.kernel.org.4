Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BE362A193
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiKOSzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiKOSza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:55:30 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3779527167
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:55:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n12so38330837eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/HKW+IBNa8pWOy4yMffEAraQs9LDCl6tE8zOCFA9Jo=;
        b=iu6aGXZ5JUnKXPO/0OmaHU5wgsgN4NXi8MlrJ3ncVFsulB/dqcaD9yPhWhqpDQhv31
         L8km3/PMSRhzap6uamWAucjIGw5/zmQ6q70AWGl/xVitx+FunKP24vQY31YZMtOYmwJk
         JFT7aTOhOf5S8aSWmd+Oj95tD7n0pJLxwe6WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/HKW+IBNa8pWOy4yMffEAraQs9LDCl6tE8zOCFA9Jo=;
        b=fYD8rZn5wipm0T09UAbp+UzKRPNcgQNx5ZWUETuYtaNW3kL/KeBBhyKXqAwroijbAk
         ncKRQ9q+2hbUK9YHz05Z31Zo6ZRS15xxiqlO89PYIgz43HseozAjAtEawFVmd1lHuQBI
         nIDbrL5PythNGtJoNLFj3THxETO0nv9OE3gUJ+yyoVLUHrtmNEp09eUuCrKTKVlwqJvX
         CF+InsIx+b2+2TmQR+TmXHHuEsqYbktjIKL/a1cXFJpRSjPqCHLqnFbkXfjOublroFrg
         rtEUSn5wW0wLMN5Mvp6MF3Vki172XHkOgrg3oZz8QcpvXFDYA2gbupJ1NLQJyNlmcw31
         nHgA==
X-Gm-Message-State: ANoB5pmH1fDDh+pPJMAdobrXHWqn1hMKlM6UOJKpxKD1idSWxM6Us9RY
        xoegjM37A2Mo41utxi1DT6cbng==
X-Google-Smtp-Source: AA0mqf59hGS6heF/IQyOMSZgrHch4FVbPi6hc8sOjvMbYixMuAIPtnyVI26lW0GmyKAd18yQK89iRg==
X-Received: by 2002:a17:906:3c9:b0:7af:a2d4:e95c with SMTP id c9-20020a17090603c900b007afa2d4e95cmr4071754eja.666.1668538526505;
        Tue, 15 Nov 2022 10:55:26 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402401200b004580862ffdbsm6569490eda.59.2022.11.15.10.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 10:55:26 -0800 (PST)
Message-ID: <708663f3-8e48-5e0d-a988-8d66ede02543@rasmusvillemoes.dk>
Date:   Tue, 15 Nov 2022 19:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] net: dsa: use more appropriate NET_NAME_* constants
 for user ports
Content-Language: en-US, da
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221111161729.915233-1-linux@rasmusvillemoes.dk>
 <20221115074356.998747-1-linux@rasmusvillemoes.dk>
 <20221115083828.06cebab1@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221115083828.06cebab1@kernel.org>
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

On 15/11/2022 17.38, Jakub Kicinski wrote:
> On Tue, 15 Nov 2022 08:43:55 +0100 Rasmus Villemoes wrote:
>> +	if (port->name) {
>> +		name = port->name;
>> +		assign_type = NET_NAME_PREDICTABLE;
>> +	} else {
>> +		name = "eth%d";
>> +		assign_type = NET_NAME_ENUM;
> 
> Per Andrew's comment lets make the change in two steps.
> Which one should come first is a judgment call :)

OK. I think I'll actually do it in three steps, with the first being
this patch but with NET_NAME_UNKNOWN kept in both places (i.e. pure
refactoring), and the latter two just changing one assign_type at a
time, so they can be reverted independently.

Rasmus

