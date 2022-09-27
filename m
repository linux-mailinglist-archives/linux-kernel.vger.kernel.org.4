Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073D35EBFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiI0KgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiI0KgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:36:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230C5E674;
        Tue, 27 Sep 2022 03:36:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d10so8186648pfh.6;
        Tue, 27 Sep 2022 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=2IJ0GUrWSfVuXvjku1aZYWTTFoICjkcjAz4qRr8Pokg=;
        b=G+GLpRcaDYyeYSjg+lm6dRsVDaEJke+ToAbc4BJnbwmNCu7Gpm/Oq6DrdvNAgAw65p
         b1dfIoB7+TRi/Du52w843IuwOFN8rQ1Wy71WsX/QG+OdmCO6dUa/WYyseMBBAklU1/QC
         0OPV4dJxzDCed3jT3hvSjqk+YrVt1suDO75kb0LF1REmW3A0FexPsG/ir1ebTpXsFXPx
         ivrEbsn0xLe/WNRZUAMUzEfzLTfSCeBoR9kOkW1zl6WSnKQvSJI7uYx7SXhPTG07CVof
         EohWqGtioCxXitoYuUMvLiS23/5ySpS6hqwRiTr4cFQnAOIFLtOn8t+o1ve3GRtdsOuQ
         W20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2IJ0GUrWSfVuXvjku1aZYWTTFoICjkcjAz4qRr8Pokg=;
        b=ztG6ykf55C+KMnOuptheOWYasuxi5s0kxEqGgwz/3RuBIst63vDC5VjD46kHwlUdnT
         wdbpt04/VImrxWE9Cnn2MZ42o2nvNHALkAb/UQkKRxeyuppdRq078iE2b86yqAFDbVfD
         RhAuMInIJpMzg9m53WxC9Y3bvESbNlVtyys6pQTnQFXaKpLBfbaDuP2HDxYhRIB7rVsZ
         mVjJu9i5up8/aQ3cjcKZp45TxutJr/komVvLIzqzfDXZZPzZpInAFpXLYNj6Xj81o8uN
         4GFC2R37sqBm7l1deM/lc2DQP+6/HgL536jDkZ5eCfdu7yxFdWKhyOxiBHWCBhAxSbc9
         DKEw==
X-Gm-Message-State: ACrzQf2dukJye69KHb0Ti9ylXItSepRz+7pFOxBex+qeM5x2n+W8jrJa
        negvY2k1/1WBOENUZlvJCys=
X-Google-Smtp-Source: AMsMyM54ou2TtGKukpmfWvtabIrcijf70iFeioZQMw64840b5golUIUyHYO2fU3JoU9g7kRmCoVVvw==
X-Received: by 2002:a65:44c1:0:b0:428:ab8f:62dd with SMTP id g1-20020a6544c1000000b00428ab8f62ddmr24173397pgs.211.1664274960504;
        Tue, 27 Sep 2022 03:36:00 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k129-20020a628487000000b0053e5daf1a25sm1401933pfd.45.2022.09.27.03.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 03:35:59 -0700 (PDT)
Message-ID: <69fc1b11-d26b-de44-ebee-cbb17cc2c893@gmail.com>
Date:   Tue, 27 Sep 2022 19:35:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] overflow: Fix kern-doc markup for functions
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20220926194713.1806917-1-keescook@chromium.org>
 <YzIUS/+H2YA7RBvA@casper.infradead.org> <202209261408.59F78C0D@keescook>
 <ada70afe-64d5-ccab-242e-9a3c3c85e6c4@gmail.com>
 <202209261959.A202D045@keescook>
Content-Language: en-US
In-Reply-To: <202209261959.A202D045@keescook>
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

On Mon, 26 Sep 2022 20:02:16 -0700, Kees Cook wrote:
> On Tue, Sep 27, 2022 at 11:53:38AM +0900, Akira Yokosawa wrote:
>> Hi,
>>
>> Somehow Kees added me in Cc:, so let me comment.  :-)
>>
>> On Mon, 26 Sep 2022 14:09:10 -0700, Kees Cook wrote:
>>> On Mon, Sep 26, 2022 at 10:06:19PM +0100, Matthew Wilcox wrote:
>>>> On Mon, Sep 26, 2022 at 12:47:13PM -0700, Kees Cook wrote:
>>>>> -/** check_add_overflow() - Calculate addition with overflow checking
>>>>> +/**
>>>>> + * check_add_overflow - Calculate addition with overflow checking
>>>>>   *
>>>>>   * @a: first addend
>>>>>   * @b: second addend
>>>>
>>>> Why did you remove the ()?  And why didn't you delete the blank line?
>>>> According to our documentation, the canonical form is:
>>>>
>>>>   /**
>>>>    * function_name() - Brief description of function.
>>>>    * @arg1: Describe the first argument.
>>>>    * @arg2: Describe the second argument.
>>>>    *        One can provide multiple line descriptions
>>>>    *        for arguments.
>>
>> Matthew, you call it the "canonical form", my take is more of a "template
>> that is known to work".
> 
> Out of curiosity, why is the trailing "()" part of the standard
> template? Isn't it redundant? Or is trying to help differentiate between
> things that are non-callable? (i.e. a variable, etc.)

I don't know the historic background of this template and I have done
some digging of Git history. I'm afraid this won't be straight answers
to your questions.

This template originated from commit 0842b245a8e6 ("doc: document the
kernel-doc conventions for kernel hackers") back in 2008 and is more
or less unchanged with later additions of "Context:" and "Return:" keywords.

As far as I can see, the kernel-doc script removes "()" in the early phase
of parsing kernel-doc comments. So yes, "()" is redundant.

Up until v5.17 (ever since the epoch of v2.6.12-rc2), there was a comment
block on the format of function comments in the kernel-doc script and there
was no mention of "()", as quoted below:

    # So .. the trivial example would be:
    #
    # /**
    #  * my_function
    #  */
    #
    # If the Description: header tag is omitted, then there must be a blank line
    # after the last parameter specification.
    # e.g.
    # /**
    #  * my_function - does my stuff
    #  * @my_arg: its mine damnit
    #  *
    #  * Does my stuff explained.
    #  */
    #
    #  or, could also use:
    # /**
    #  * my_function - does my stuff
    #  * @my_arg: its mine damnit
    #  * Description: Does my stuff explained.
    #  */
    # etc.

Which suggests "()" has always been redundant since early days.

(Note: Nowadays, the first example without brief description will cause
a warning.)

This comment block was removed in commit 258092a89085 ("scripts:
kernel-doc: Drop obsolete comments"). Its changelog says:

    4. The "format of comments" comment block
    
    As suggested by Jani Nikula in a reply to my first version of this
    transformation, Documentation/doc-guide/kernel-doc.rst can serve as the
    information hub for comment formatting. The section DESCRIPTION already
    points there, so the original comment block can just be removed.

It sounds to me like the removal was premature at that time, because some
of those format variations were (and still are) not properly covered in
kernel-doc.rst.

> 
>>> Hunh, everywhere I'd looked didn't have the "()" (which seems
>>> redundant). The blank line was entirely aesthetics for me. If it's
>>> supposed to be without a blank, I can fix it up everwhere.
>>
>> So, I think this is more of a territory of preference or consistency
>> rather than that of correctness.  Those extra blank lines can be confusing
>> as most people expect it in front of description part.
>>
>> get_maintainer.pl says Kees is the sole maintainer of overflow.h, so
>> it's his call, I guess.
> 
> Well, maintainer or not, I want to make sure stuff is as readable as
> possible by everyone else too. :) I'm happy to skip the blank lines!

Yeah, that sounds nice to me!

        Thanks, Akira

> 
