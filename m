Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB1E7079DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 07:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjERFvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 01:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjERFvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 01:51:02 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA431721;
        Wed, 17 May 2023 22:51:01 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so2484609a12.1;
        Wed, 17 May 2023 22:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684389060; x=1686981060;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9ckLhnT7f+F5f3sVepp4DQEBBJBxBHHs0SvNprQsj4=;
        b=RNY4Og7jh8aVEHHzTra3xoE0FwFfQlSPP8WQ/9ay+ojMHWYEqCCStgWrDwEKC+BFtl
         p8UK6pbQfnq2TqVGkf6rpc6v5LV5Y8pYl8qf1O2vPr1YQ+dZRWqrVYqghcNN9+N+lFVC
         4w7ynnuKBud3V3v1sVqJHvZ/mYhIOLm07GLHPYgWSWacdFKcfDlFqnrPORzZVV2c/Ggl
         Sggo10KXYpzg0CtKjrvEZv1pv8RtK3AVN3PeO9LMYrU9rUXMc93NBcUXVfTwdd598bVP
         GcIlmhxgscEispxdbAG1z6JylXCBST9ypb0HVIDmxMaRss0YkgCownZ2HSmL1g5/gKmC
         eFsA==
X-Gm-Message-State: AC+VfDy/wl9FAEzyCB41RDlmMYuC60BlmAVYwKtsGQgdqbcWjRdmVtW2
        4CZzBQ5FrYMQ+OQA8759RMgTEz/G5wc=
X-Google-Smtp-Source: ACHHUZ6SeENPZQmXvKbPQCSUWG18HqX6WXVzr7ylZjN/dq04S1fNOF6M9F6G9W4A7vw2OZ+Hk7UdWw==
X-Received: by 2002:a17:907:6e9e:b0:931:ad32:79ed with SMTP id sh30-20020a1709076e9e00b00931ad3279edmr48768760ejc.12.1684389060358;
        Wed, 17 May 2023 22:51:00 -0700 (PDT)
Received: from [10.223.1.187] ([195.39.106.162])
        by smtp.gmail.com with ESMTPSA id fx11-20020a170906b74b00b00969e9fef151sm496332ejb.97.2023.05.17.22.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 22:50:59 -0700 (PDT)
Message-ID: <c6074764-c254-e6f2-2cac-39081e3593a9@kernel.org>
Date:   Thu, 18 May 2023 07:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: Tree for May 15 (config SERIAL_CPM)
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
References: <20230515141235.0777c631@canb.auug.org.au>
 <1538d954-864e-3a07-594a-dfe6d3178a72@infradead.org>
 <b16040e8-06f4-5c0e-7379-daa8226dc2a1@kernel.org>
In-Reply-To: <b16040e8-06f4-5c0e-7379-daa8226dc2a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 05. 23, 7:49, Jiri Slaby wrote:
> On 16. 05. 23, 4:51, Randy Dunlap wrote:
>>
>>
>> On 5/14/23 21:12, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20230512:
>>>
>>
>> commit e3e7b13bffae
>> Author: Jiri Slaby <jirislaby@kernel.org>
>> Date:   Thu Apr 21 12:17:08 2022 +0200
>>
>>      serial: allow COMPILE_TEST for some drivers
> 
> That commit should be reverted

* partially. The rest appears to be OK. I will send a fix shortly.

-- 
js
suse labs

