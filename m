Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE586A881B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCBRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCBRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:51:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B443241DA;
        Thu,  2 Mar 2023 09:51:05 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u5so72363plq.7;
        Thu, 02 Mar 2023 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677779465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j92Pt+qg1XhGhBM4uAKf7EF8pTS8F9JmlkWkZo6TAdw=;
        b=dgG9vfDRqFBOYUt4RZ9wv+C9d+JwGHNhsQPWebAwqhYPTbqBTD40xPvl0cvt2Gw97w
         zNxJPbSLf3DJQqCOjD3PMYzR/Qj1rxoV0UsR7Qdrx6b5pPsypV3gUCYoV/eGV/+DnPRd
         zx/BchgC8aeWdSz37SByqDi4U1H1eih2CaBNKLkS5zX+dk8swiQQt3EPWim5bC3DGJxS
         m/TgIg75ZRU4EKmU/qf5A8jtNSefdbnGqtOxk7OdiQoRUlPEZGrjDS35XyMWEseh7n95
         ozZU7X1VgoVvVKGjAZv4TmwJ4Q4A6mfag2QudPCdyDLsgVoqu8o3ABiF7JXQ0/Dh5Esf
         e3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677779465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j92Pt+qg1XhGhBM4uAKf7EF8pTS8F9JmlkWkZo6TAdw=;
        b=EoCZZo0rCM6qmBsnOjUO3tXHFHXjZm1N8FmAaa1wpXvktfikuT5zfxYNIXhHi0WizA
         Sur5H1b6ySvWDF7BYqvkg1sKQLxukVTi2x1+P5J9dkgE3Qe3LorlQMwIofdTGlCiIPmO
         56CyDyrrFKf5HtHJCuUmRN+amIWuKIV7a8RmphyjoOjaDfG7GT+BxHYdIYVbiNbhpcnY
         4NHt2eoQpeEDQVyBTxFhfAqMOhhrjY6yame2KGFMdKUUbGVVrlNgEXw4mu7KZzyK95Oh
         lcAB1uRVut8hHMsSmKELRjizdnWWKPxMglsO3pCxAOlvTVklxgfO9AVhMmeHgQXv0gOY
         VJDQ==
X-Gm-Message-State: AO0yUKX+5EVoOFAxZGrNvjOGnxtumkWqtfcW6L3E21ZrfuLT+ykPt/Ti
        5EKza5NVspDnj45zYKmYsZc=
X-Google-Smtp-Source: AK7set/whDk+C5dY01SBOS2ePvK+X5nTEbZMKtL956f43H19UcGyzFiwrYgDk0TacK/xAx4PF/VpZg==
X-Received: by 2002:a17:903:230a:b0:19c:c961:ac15 with SMTP id d10-20020a170903230a00b0019cc961ac15mr13129053plh.0.1677779464881;
        Thu, 02 Mar 2023 09:51:04 -0800 (PST)
Received: from [10.69.40.170] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ka15-20020a170903334f00b0019c61616f82sm637410plb.230.2023.03.02.09.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 09:51:04 -0800 (PST)
Message-ID: <faad8810-7aa4-e122-f497-73553feb8bcd@gmail.com>
Date:   Thu, 2 Mar 2023 09:51:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel-team@android.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302023509.319903-1-saravanak@google.com>
 <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
 <CAGETcx_nCdm2WYLC7h1s8i9tnHc_LcHk2oZUQ0sUDr-PBsUWDg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAGETcx_nCdm2WYLC7h1s8i9tnHc_LcHk2oZUQ0sUDr-PBsUWDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/2023 9:20 AM, Saravana Kannan wrote:
> On Thu, Mar 2, 2023 at 9:01 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>
>> Hi Saravana,
>>
>> Am 02.03.23 um 03:35 schrieb Saravana Kannan:
>>> This allow fw_devlink to do dependency tracking for serdev devices.
>>>
>>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
>>> Link: https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
>>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>
>> since this fixes an issue on Raspberry Pi 4, shouldn't this be mentioned
>> in the commit message and providing a Fixes tag?
> 
> So RPi 4 was never creating a device links between serdev devices and
> their consumers. The error message was just a new one I added and we
> are noticing and catching the fact that serdev wasn't setting fwnode
> for a device.
> 
> I'm also not sure if I can say this commit "Fixes" an issue in serdev
> core because when serdev core was written, fw_devlink wasn't a thing.
> Once I add Fixes, people will start pulling this into stable
> branches/other trees where I don't think this should be pulled into
> older stable branches.

That is kind of the point of Fixes: tag, is not it? It is appropriate to 
list a commit that is not specific to serdev, but maybe a particular 
point into the fw_devlink history. Given this did not appear to have a 
functional impact, we could go without one.
-- 
Florian
