Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD29C6B7A47
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCMOZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCMOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:25:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9122D157;
        Mon, 13 Mar 2023 07:25:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n2so15898744lfb.12;
        Mon, 13 Mar 2023 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678717544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SHpLJa0u5hyApQxjJSPeeFKiQmK+wyov1Bhna2PuZE=;
        b=ZXZgMENpvuQxGw2IYRYCW2u3pJfPvKwBFfcHijagmhZlP1sc7+92uT/9WwFw8QZi5H
         Y3xM2oPuvEBc3y9hWxtEkC6aMnxL0DgSGDfUMqLVez6ppMZGN/aKNwWgjZ/QhgGl7wRJ
         8R+B7VJcdwgYT1BBtpa9TUVKWeX0oymb55zpxlHXobwsbBocV5IH7qzVxAhVgcVz+kb6
         gpH90nwm152iypSfeEg8CkPvFgoteDs7LdigPnc+1cJja9of/97CPt1ycpP3N4jz/fAn
         d+VE7f9ICtEonr+f/eD+Dv4ePTSRCjrVpa1rge5tLGDEELcNEQXqHK0uJzWTQLw6TbZk
         44iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678717544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SHpLJa0u5hyApQxjJSPeeFKiQmK+wyov1Bhna2PuZE=;
        b=KIBgGfaRBSXVAlmn456vvETXeU3CzrytZj6gsFLuhvFDGWfOmiBxjX6WEiOjLfjD+V
         UgRR2DPbhN3GMBw8QxuqQCZtfBA3LyKORw1ZGEp2+oR7lkJq1SxusPkTXp6fnmodFmnO
         ZqxTFzQSqq+fdzMNjy0lJTNmIeKcPQ1mT7R/UacPPW2oTP1lT4g+cuNCJRVtUTaaBs1r
         eqLwli0AlIBFvcsNQJLR9Hdy71FvZ2YEvuxWpKYGsZMnvTf8M7yY8fS4wJCzTku2kkNL
         SDice8sN4hcpgNIoKi/4Cpd+jih8mVOXME3AMU0vO/5KBkQ+ULYmVT8BcJAInOp7HmgS
         +2oQ==
X-Gm-Message-State: AO0yUKXOfs9Xip2VWnJc38MdTMQlMeGHRvYZQtg51HBLcukcK51qgBvg
        TA2aEsVuPtqwcqCLRTFuuaw=
X-Google-Smtp-Source: AK7set9BMlDKIQYmzu2QcxNlMdnMKqyielpbKEWp5QcgRveH1nJbYaKwkEcKYXN53Ey7N2PWRllD1g==
X-Received: by 2002:ac2:54bb:0:b0:4b4:f9df:c6ab with SMTP id w27-20020ac254bb000000b004b4f9dfc6abmr8707783lfk.60.1678717543876;
        Mon, 13 Mar 2023 07:25:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id f3-20020ac25083000000b004d85789cef1sm989527lfm.49.2023.03.13.07.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 07:25:43 -0700 (PDT)
Message-ID: <6f94e186-2a65-15b0-be8f-7b610a28dfff@gmail.com>
Date:   Mon, 13 Mar 2023 16:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
 <e507c171-bebc-84f6-c326-ff129b42fb7f@gmail.com>
 <ZA8kTx4exvGwUfNn@smile.fi.intel.com>
 <b4bf8587-d3cd-ff88-0276-7e394c110757@gmail.com>
 <ZA8wkMhShRbyE/wm@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZA8wkMhShRbyE/wm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 16:17, Andy Shevchenko wrote:
> On Mon, Mar 13, 2023 at 03:59:03PM +0200, Matti Vaittinen wrote:
>> On 3/13/23 15:25, Andy Shevchenko wrote:
>>> On Mon, Mar 13, 2023 at 02:47:45PM +0200, Matti Vaittinen wrote:
>>>> On 3/6/23 14:52, Andy Shevchenko wrote:
>>>>> On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:
> 
> ...
> 
>>>>>> +	if (ret && gts->avail_all_scales_table)
>>>>>
>>>>> In one case you commented that free(NULL) is okay, in the other, you add
>>>>> a duplicative check. Why?
>>>>
>>>> Sorry but what do you mean by dublicative check?
>>>>
>>>> Usually I avoid the kfree(NULL). That's why I commented on it in that
>>>> another case where it was not explicitly disallowed. I'll change that for v4
>>>> to avoid kfree(NULL) as you suggested.
>>>
>>> So, and with it you put now a double check for NULL, do you think it's okay?
>>> I don't.
>>
>> I don't see the double check. I see only one check just above the kfree()?
>> Where is the other check?
> 
> 	if (... gts->avail_all_scales_table)
> 
> is a double to one, which is inside kfree(). I.o.w. kfree() is NULL-aware
> and you know that.

Ah. I thought you suggested I had double check in the code I wrote. Now 
I see what you meant.

Yes, I think that check should be dropped.

-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

