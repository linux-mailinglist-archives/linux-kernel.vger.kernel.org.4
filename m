Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C39677D13
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjAWNwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjAWNwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:52:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7123DAD;
        Mon, 23 Jan 2023 05:52:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso11067070pjf.1;
        Mon, 23 Jan 2023 05:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKpg9flnN+chPIMCPl0+2Z6yendwSMhVVKXNRKER7mE=;
        b=gEuQs96KzRvjAOZjftDCtm34oFblZUcGjQubuPvLFrAyuMPh2VLwUZ6KCCtSBVlBIW
         CAHdeax9Ou7gIhKMxYUVu3ONMOTNTSV2/IO1CJr3n1ZexIfxhO4Wqs0/q1Y6WqawYnzb
         XuJ080R76gBYpoakRROXjZ5O/k6nGGw9On/j6ZqOniWQk8cklyfbeWSiMlFkMILeCya6
         wNe2YwQKaiyPvMAZyigCxHZZfccH+klfanS2TyMSvBtZ13Ev75/CNYB+LmKyfB88Xi7d
         oO6ct1u1olS54Nyq3BY2OjnDnxN1+jmv7rwlaX+ILLKKef85qyuzLwENkZppr6KAyVNQ
         j0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKpg9flnN+chPIMCPl0+2Z6yendwSMhVVKXNRKER7mE=;
        b=AZBVcQAlUr40n1tzIKXgwtUiQfR5S3bui/8IhhWlMWe7u3zzrA4i2oacJE7ZQ7fzRy
         GtzaU+GcpXmRyzBcJjp1SpWsyRmp1GT7katsqcofy1UOy2yccmOxyThFgJ9a4KqB6laQ
         Kw9ufR5o6QADGnDITJEisBgn2cyiooiWznBPoblHMexGUirNwLuOzC0rLvwEXH5i5MAt
         OXFHnhwdM1Q1VZtCfMKQx9SiLAxtu5ahE0uBrclpcz8j81HMIJ9/WViDIVWow2zK2GUM
         G9pt58b0EhmDHuNYHGxqGLmHTVVG/r68OKmsfx+At8beBVCWMK7jDbw6+KTC29EnXnl2
         z3Cw==
X-Gm-Message-State: AFqh2krf7k4zLcPBGNt3ZtKkWUy4liCu7tgfs3tjRlzcOPk05V4mz+S/
        864c0NYIRAuEo2S/5MmldU0=
X-Google-Smtp-Source: AMrXdXunsM3ZFMr+g19557ktUbRyWA/D+HKokpRk19HOTVTctW0BNUXMYEFHeMObVyHQBb3RGifeDg==
X-Received: by 2002:a17:903:2442:b0:195:f06f:84ff with SMTP id l2-20020a170903244200b00195f06f84ffmr13563443pls.50.1674481921844;
        Mon, 23 Jan 2023 05:52:01 -0800 (PST)
Received: from [192.168.43.80] (subs09b-223-255-225-233.three.co.id. [223.255.225.233])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b00192fc9e8552sm4526940plb.0.2023.01.23.05.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:52:01 -0800 (PST)
Message-ID: <c9d6291f-8b50-bd37-f48c-d96834d990dd@gmail.com>
Date:   Mon, 23 Jan 2023 20:51:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] docs: rv: Fix full name of the GPL
Content-Language: en-US
To:     Diederik de Haas <didi.debian@cknow.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230122181224.53996-1-didi.debian@cknow.org>
 <Y83ts1TVZnwyZjnH@debian.me> <111677351.cJcasWOL3y@prancing-pony>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <111677351.cJcasWOL3y@prancing-pony>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 19:48, Diederik de Haas wrote:
> On Monday, 23 January 2023 03:15:15 CET Bagas Sanjaya wrote:
>> Similar response as [1].
> 
> Please disregard this patch.
> I'm now sending a similar response as I'm sending to my other patch 
> submissions, which is the following:
> 
> I now consider my initial view of the issue as a spelling error, incorrect. I 
> would be changing the license and IANAL. I'm also not the copyright holder 
> which I believe is needed to change the license.
> 
> Apologies for the noise.

Glad to reply, but I see your reply above as if it is written by
a bot. Care to vary your sentences?

-- 
An old man doll... just what I always wanted! - Clara

