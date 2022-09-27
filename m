Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FA75EB800
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiI0C61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiI0C5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:57:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F54DB4C;
        Mon, 26 Sep 2022 19:53:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so8813528pjk.2;
        Mon, 26 Sep 2022 19:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uVSDX283H5TLgkOzDymE7tG05Kgkflu8UK7iAbsdboU=;
        b=c/RqcdJoO27QwlNbfMvLMb7gmXT6fAo6t6bl6Cqlh3sxssmDGtvTt4s3LqkqX0A/0o
         S1bUEfXxTjLpMUP3t3mIUcXXSTx66VoJYOrTHgle0H54/o1XEawTJHPS2q86SuFghjV2
         hatIXXP5uZoF1ug5+MykghIUKvlDsZDOqqewiICSfGvhUQVG8POWyZO3Plu5AS+x/3zC
         qOgwQlFez/RDeRiRdnDe7JNReOG3fGui4OXmHMJiCHTvS5sUWjyidlrG7fHaSWb17UNv
         Zbm5sFuMwVEd8giDvACuHAlw4rmUyMDP45piY66CsrUcaXqu3W3ybS9stpISvfxAu6qF
         0mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uVSDX283H5TLgkOzDymE7tG05Kgkflu8UK7iAbsdboU=;
        b=hwNGErtK1MupCXkADcyT9LRzQHW9puK9FIju7ltnaXoHS6d+mGWY5tqolN5P/swcDb
         olq1nycCcOTo/eRbl6LKFA7FppFlAcGUhp11VNYy/hF4pvlkr0DY0408kTPBmUnL2GNF
         4dkV4CIZh6wGHkXeL39XoxcKB7fQC4k8bdnU+t7+3D0T8peRqV/0I+BJgSQIYvjR50Rn
         Xl/pkDG96f4kj0qzXub4pMX4MVE/67cYoCYRWyQXKtpBXaqKlOV3HO3JLCZkPAveI1/X
         dDX/uUPN21ZhVZ4CW22JyW9bV8PqFieOs9KrnwNDXk34FfnleG9yvdc7Gpi4gPAa+X1m
         cIwQ==
X-Gm-Message-State: ACrzQf0f8iDGmQa2jWM0ep4jOADZu7kT+UsxB2LUn6GhXLwEIbBpg6Ht
        iqhV2eGc4s+ZBFn2kbx7uS8=
X-Google-Smtp-Source: AMsMyM6urwfUhEEHFDBjIwyD6Xpc4CWvA1/+3nhlQv60PYzbz4oIT0y+KCAWsdNda0o5nwFE9Q2S5w==
X-Received: by 2002:a17:90b:1e01:b0:202:ee2b:c856 with SMTP id pg1-20020a17090b1e0100b00202ee2bc856mr2005411pjb.29.1664247222263;
        Mon, 26 Sep 2022 19:53:42 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027e4400b00173cfaed233sm189404pln.62.2022.09.26.19.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 19:53:41 -0700 (PDT)
Message-ID: <ada70afe-64d5-ccab-242e-9a3c3c85e6c4@gmail.com>
Date:   Tue, 27 Sep 2022 11:53:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] overflow: Fix kern-doc markup for functions
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926194713.1806917-1-keescook@chromium.org>
 <YzIUS/+H2YA7RBvA@casper.infradead.org> <202209261408.59F78C0D@keescook>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <202209261408.59F78C0D@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Somehow Kees added me in Cc:, so let me comment.  :-)

On Mon, 26 Sep 2022 14:09:10 -0700, Kees Cook wrote:
> On Mon, Sep 26, 2022 at 10:06:19PM +0100, Matthew Wilcox wrote:
>> On Mon, Sep 26, 2022 at 12:47:13PM -0700, Kees Cook wrote:
>>> -/** check_add_overflow() - Calculate addition with overflow checking
>>> +/**
>>> + * check_add_overflow - Calculate addition with overflow checking
>>>   *
>>>   * @a: first addend
>>>   * @b: second addend
>>
>> Why did you remove the ()?  And why didn't you delete the blank line?
>> According to our documentation, the canonical form is:
>>
>>   /**
>>    * function_name() - Brief description of function.
>>    * @arg1: Describe the first argument.
>>    * @arg2: Describe the second argument.
>>    *        One can provide multiple line descriptions
>>    *        for arguments.

Matthew, you call it the "canonical form", my take is more of a "template
that is known to work".

>>
>> I don't usually complain about people getting that wrong, but when
>> people correct it to be wrong ...

I'd say "wrong" if "./scripts/kernel-doc -v -none include/linux/overflow.h"
complained or the resulting reST doc didn't rendered properly, but that's
not the case here.

> 
> Hunh, everywhere I'd looked didn't have the "()" (which seems
> redundant). The blank line was entirely aesthetics for me. If it's
> supposed to be without a blank, I can fix it up everwhere.

So, I think this is more of a territory of preference or consistency
rather than that of correctness.  Those extra blank lines can be confusing
as most people expect it in front of description part.

get_maintainer.pl says Kees is the sole maintainer of overflow.h, so
it's his call, I guess.

        Thanks, Akira
> 
