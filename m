Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A65F7D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJGSpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:45:10 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC1E3643E;
        Fri,  7 Oct 2022 11:45:08 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id l19so3624503qvu.4;
        Fri, 07 Oct 2022 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6xzJo6d2ytl3d7yl/tDWSMw9C4o+516TqkQvkc9k0U=;
        b=THcU9AZdc/AyEbbl7tVbRkHqvR/Jsuj5HPafpiMgmPLu7fNZvvXlpLDIz41ZFRFezd
         kF4ksupvQXh5HNYfmub5sVQtJHkm9vGQKAgaNBhlSNjCIjVi34rL29eTTlmd4XIkggLy
         64zvvJ9iOePtF/EPdUWscYLADPA+pm9H5CtMXqWoCpHYBI9ilFYCGl2J+KCwWxJ0JoPP
         MEkctw2EpUbvbHYTFC6teGYkCPLbyi4oOAnBkKyQSA468xyWGE59VgZUqeifF9f/gfHb
         QqhoPq45DStnixJztlRq4Oy0IMxbBSdGDc/raXSnHndQV1j2qipAdGB+AeIwqejJzH1W
         N3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6xzJo6d2ytl3d7yl/tDWSMw9C4o+516TqkQvkc9k0U=;
        b=x68/P+6v3sf6cOxvMeAqSQkVw0FkrvzvL2kn2M+GKi1wgzclRLOiAxvVflg4CHvyAR
         wcf0CjkcVOuKddB8YPX12yDiSNc+uOrrXAbV8Jf9eQUTmEW4pMrVDqPBF7fxFmFsGW6l
         Gxi1h2BwN8AkCNZu7PHTc6uRW4od/cDpzBSn4f8HHxkLbIVLRxO5lR0OZ9nk5IRJ4+v0
         MpkyHc8y4vFZoryNAUoDNBeGJvcS9s08B9CZoy5I5pfcQ/IlnE1jsAgsxDP6ZPzBgfZC
         TKoRifRLA7n+KVY5kwJbzhNtKbobeTi8r3Al/yGo+pNk+kpTmCMGACmbX5IcAuMz5l75
         mOgw==
X-Gm-Message-State: ACrzQf1EroBhvWskeZZJl5S0B5i1oh+N7vYbgFWaUJA5qHTRZgnI2LzF
        UOmk261SKq0jsiHtHCZ4B/E=
X-Google-Smtp-Source: AMsMyM4nkM//a0heL4aINM2sqXyl4CM/+Y9+SBNuBTVBZPEG4GmwTqLX2nbjJEEa6N8iDytCqqOtLw==
X-Received: by 2002:a0c:8dca:0:b0:4ad:6e03:c906 with SMTP id u10-20020a0c8dca000000b004ad6e03c906mr5228666qvb.74.1665168307250;
        Fri, 07 Oct 2022 11:45:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id dm5-20020a05620a1d4500b006bac157ec19sm2176931qkb.123.2022.10.07.11.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 11:45:06 -0700 (PDT)
Message-ID: <3d74b5cf-0f50-ac27-aa21-210507f41858@gmail.com>
Date:   Fri, 7 Oct 2022 11:45:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for broadcom USB
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Justin Chen <justinpopo6@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, linux-phy@lists.infradead.org,
        f.fainelli@gmail.com, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com
References: <1665098469-19008-1-git-send-email-justinpopo6@gmail.com>
 <Yz/G0jQxc4c2gzhl@kroah.com>
 <CAJx26kUTzBeNkV_=gEeUYaatBwugT1uFH_b_ggq-fXaJDRBMqQ@mail.gmail.com>
 <Yz/Oik0uXXo0uGk6@kroah.com>
 <CAJx26kVL4nYL2fbHd31ZqpXxEos-nyQ2-GSZbL6FUa5ztAbxXw@mail.gmail.com>
 <Yz/UqtGD/dthxYJ2@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Yz/UqtGD/dthxYJ2@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 00:26, Greg KH wrote:
> On Fri, Oct 07, 2022 at 12:19:01AM -0700, Justin Chen wrote:
>> On Thu, Oct 6, 2022 at 11:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Thu, Oct 06, 2022 at 11:46:45PM -0700, Justin Chen wrote:
>>>> On Thu, Oct 6, 2022 at 11:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>
>>>>> On Thu, Oct 06, 2022 at 04:21:09PM -0700, justinpopo6@gmail.com wrote:
>>>>>> From: Justin Chen <justinpopo6@gmail.com>
>>>>>>
>>>>>> Al Cooper is no longer the downstream maintainer for broadcom USB.
>>>>>> I will be taking his place as downstream and as an additional
>>>>>> upstream maintainer.
>>>>>
>>>>> What do you mean by "downstream" here?
>>>>>
>>>> Downstream as in internal to Broadcom. Apologies for the confusion.
>>>
>>> Ok, but then why are these all gmail.com addresses?  Why not use your
>>> proper work addresses instead so that we can at least validate that the
>>> patches are coming from a broadcom.com domain?
>>>
>> I believe the idea is we can continue to support as maintainers even
>> if we are no longer part of broadcom without having to change emails.
>> I believe Florian should be able to comment more. :)
> 
> So in other words, broadcom email servers do not allow sending patches
> out without mangling the text?  :)

That was definitively the case years ago due to IT using a Microsoft 
Exchange SMTP server and which had us switch to our gmail.com accounts. 
The "continuity" aspect of not having your email change does matter IMHO 
in that we should always be reachable, at expense of not immediately 
disclosing our employer. Other reasons I heard was that people posting 
publicly with a @broadcom.com email grew tired of being asked when they 
would get a working WLAN driver for their card.

Now we supposedly have a special SMTP server that would not mangle the 
patches and also not add the annoying legalese footer at the end telling 
you to destroy the email.

Does it matter though as long as Jonathan Corbet knows about our 
employer at the time for his lwn.net stats :)?
--
Florian
