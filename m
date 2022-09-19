Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA585BCFED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiISPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiISPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:02:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1059D3136F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:02:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 9so17277676pfz.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=ABeBW3j4LheEPxh2dXzd5D2phXo+h2tgGXGsA2SWW+w=;
        b=JktUDcGC7LRHUgi3fylzvjf+iYKxwHzSDJl57b/iisuYuSJy+7mAOkVw4nno5ZVsI0
         gYp2qUBugBMOVCRjZhm4NCL1N2UJCvEvFAWkb9hFjmkzIHuKTCBSMczIpOAff6qpdzLE
         W9g3vgD9Wc/gtP9/8QXozl/oqul4lXcxMfOLsVHhNse834ZGGkl3WsFtp/r60SHfMS6u
         2OiA03FteyyPnGLRkcqmMlM7MsUi9Nhnt+16cfr4M7a8lFPdqYhCfCUaqF84Vrg7G4Wk
         hFhPZ+NNvU2sb0cYWRpBjGqIilgudOwR4zmq7ytCWd62bTxFJqqrG6XRf33OGrlvTtdI
         zPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ABeBW3j4LheEPxh2dXzd5D2phXo+h2tgGXGsA2SWW+w=;
        b=LPKTXggVzp+Ja674Oo4iFXmMEJnGIM/9Bo/aDbi0AJn8CHWtZscirOoFKfwz4eBY6V
         JEQKvQG/iVeZA/xY+7TuSAH+KAXEuaQfvf9HKc4HPZQ33oNa5vWhCaPd0pdK+S+lhyzr
         QZkCMGRuX6jOCAjCRQOuuORXZC3+paRBi8FA+cV1aO8dVPGeEEC69WSFsJQguSG2s9Ze
         iETNMaNIPgRnDSPcALnOUh/1y7TJPuEgbefvGZzSDbu/nne6SvGsj3/faFT8jzhwX0kV
         psTVEUUOBtpjFWX1TROkyJaUUx3RUZ3suLKWRWRHm6qYTbThtBBpJejfcfgKxJm+zvPn
         OeLw==
X-Gm-Message-State: ACrzQf2QeQvBTLEqaWZkcESLrtbp40yD+EbKB/J2cGazzdSLuOCNbvnb
        rp4Z0Du5P8PUL3/plp6yUJ0=
X-Google-Smtp-Source: AMsMyM5hGaxFyl4F/cofBCrOSQhfSrYbBrHZINFjaXwNmuG14PAYogKcfl4r/qZQzJt4ylQbJ2hRZg==
X-Received: by 2002:a63:f918:0:b0:438:766e:e57a with SMTP id h24-20020a63f918000000b00438766ee57amr15657355pgi.584.1663599764471;
        Mon, 19 Sep 2022 08:02:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b0016f057b88c9sm11551947pln.26.2022.09.19.08.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 08:02:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b5d1beef-a0e8-a061-eccf-cc0e56c23fd4@roeck-us.net>
Date:   Mon, 19 Sep 2022 08:02:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
References: <CAHk-=wi=gtuSO8Yz8LDubkMk7TiMsZxpypt9S10jeZRkyaBFnA@mail.gmail.com>
 <20220919040653.GA1840059@roeck-us.net> <20220919072818.6037f014@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 6.0-rc6
In-Reply-To: <20220919072818.6037f014@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 07:28, Jakub Kicinski wrote:
> On Sun, 18 Sep 2022 21:06:53 -0700 Guenter Roeck wrote:
>> On Sun, Sep 18, 2022 at 01:56:17PM -0700, Linus Torvalds wrote:
>>> So this is an artificially small -rc release, because this past week
>>> we had the Maintainers' Summit in Dublin (along with OSS EU and LPC
>>> 2022), so we've had a lot of maintainers traveling.
>>>
>>> Or - putting my ridiculously optimistic hat on - maybe things are just
>>> so nice and stable that there just weren't all that many fixes?
>>>
>>> Yeah, I know which scenario I'm betting on, but hope springs eternal.
>>>
>>> Regardless, things look fine. I am expecting rc7 to be larger than
>>> usual due to pull requests having shifted one week later, and in the
>>> worst case that might mean that I might feel like we need an extra
>>> rc8, but for now I'm going to assume it's not going to be _that_
>>> noticeable and hope we'll just keep to the regular schedule.
>>>
>>> But it would be lovely if everybody gave this some extra tender loving
>>> care in the form of extra testing...
>>
>> Build results:
>> 	total: 149 pass: 149 fail: 0
>> Qemu test results:
>> 	total: 490 pass: 489 fail: 1
>> Failed tests:
>> 	mcf5208evb:m5208:m5208evb_defconfig:initrd
> 
> Is this also us? I can't find the report.
> 

It is caused by "fec: Restart PPS after link state change",
and reverting that patch fixes the problem.

Guenter
