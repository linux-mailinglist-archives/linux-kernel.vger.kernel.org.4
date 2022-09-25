Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71A95E90E8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 05:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiIYDxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 23:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIYDw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 23:52:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3AE286F1;
        Sat, 24 Sep 2022 20:52:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c198so3642724pfc.13;
        Sat, 24 Sep 2022 20:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Z9a6iDTCif8fdKbdrEuT9YbbdZ+TIgyH/gAXMcB/POE=;
        b=W4GVQ/RWODeMNU5ue0j/Cscnvn0xvfLchm6T0G1jvxiQe8bMu5AZ0z2h17cB7BgTTl
         nmsz7+YbQoQ64MXokFpa6dihXRfXe44To71X5cnFbUzCDjMwTfmTe4hXp3BNoaxBhW/u
         WuOFZTfL/QPkzI5EXKW8XthK9aUbDnXFdCfSsCfo7K7t206DVq2I5v8JB+wa1Ry/9Kib
         VOZpW/dOBXsENFWQG/YIlZpAGFzAnTan2uShtWZw8IT+rBI0U3RHPfx82Q+kXxlSDKKu
         NwZCDsNcbZM1wLtlr1zcdx/pyb6xRDz2DZKRnz3b+1Pass6go+2vEnwBeMQygvScL1eo
         xFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z9a6iDTCif8fdKbdrEuT9YbbdZ+TIgyH/gAXMcB/POE=;
        b=7YGxeaUeY7CD81FPEtZe9FjqxUbx/kUayuy4aEDNiXaBr7zhz/l4FrjMRhpXrTBX8V
         kiZiwoMchiVNTuTOmqoWaYjU0TocEOQuwuOdr4Dy3EIhJuZagtF/IvgzkYF3oCqcvyLl
         s//ujmY3Xmo3UBs/A0y3JLTtk88HpjAOU26JPr5R8l8gSQj21SxdivfPOrHUafE/a+xE
         ViQFi06+0mptUVpFVkobyyjIwqCUnTPCshunzG8jjXm+Ruq5+QwaC3Sdg3UhE8W2Z8w8
         MERk/PqVNBchPLIIHSBtBg6+2QH2mbY9gCfJSQEL3TenqhFFoer4eHvydtdbZzd+lbOb
         RAIg==
X-Gm-Message-State: ACrzQf3d2hw3lUoGcp/NbFpCIE64fZ+B+vwItjuf1KZFelzTuN2IJr4p
        6FCzDO9ziMjEUGVJcUcUsZY=
X-Google-Smtp-Source: AMsMyM52+rDOK06HNepPf0ZU272FQn5FSN9x3kEgVpJnk1fJpVgJslLbPe6xIMObNKO9Yv2DUqZ6iw==
X-Received: by 2002:a05:6a00:c86:b0:542:7c38:4a59 with SMTP id a6-20020a056a000c8600b005427c384a59mr17024568pfv.74.1664077977957;
        Sat, 24 Sep 2022 20:52:57 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-10.three.co.id. [180.214.232.10])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79981000000b0053e72ed5252sm9166262pfh.42.2022.09.24.20.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 20:52:57 -0700 (PDT)
Message-ID: <bad0b6f9-2be9-ef82-86dd-466a89e14507@gmail.com>
Date:   Sun, 25 Sep 2022 10:52:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 7/7] docs: put atomic*.txt and memory-barriers.txt into
 the core-api book
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-8-corbet@lwn.net>
 <0ce29b47-1e4b-6c3a-27fa-47e442f1f21e@gmail.com>
 <87a66qp5vn.fsf@meer.lwn.net>
 <e97ff5c9-6ffb-08b0-0da0-8035fe2dc877@gmail.com>
 <e3e32b99-e8a3-ba8d-5d84-3ed99af308c8@infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <e3e32b99-e8a3-ba8d-5d84-3ed99af308c8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/22 10:48, Randy Dunlap wrote:
> 
> 
> On 9/24/22 20:18, Bagas Sanjaya wrote:
>> On 9/23/22 20:39, Jonathan Corbet wrote:
>>>> Shouldn't warning like "This documentation isn't in RST format and included
>>>> as literal block" be added?
>>>
>>> Why?  Who needs that information and what will they do with it?
>>
>> At least readers will not be surprised with the anomaly...
>>
>> But anyway, for consistency, I'd like to see these *.txt docs be converted
>> to proper RST.
> 
> I'm pretty sure that Jonathan knows that those files' owner(s) want them
> to remain in txt format.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara
