Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65AC722AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjFEPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFEPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:16:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B7AD2;
        Mon,  5 Jun 2023 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rp5lISqZ+lbzhf71v0hSlbE2sjYGt3ZfF7uVi/XekLk=; b=2rBOrWkPniSv1eylw13i89WePy
        GtrLAgPUl/Uk9uFw8d3iV1Q16Kr1vQDIlkqv1tzH9T5UNzPNLOIxXaE/ZN0loQYA5hp7MZKaxKPBP
        dcttdCeYfiHRIwscX4cq6nEGf8h1TQhm7gE35e+3CQwysF3uUUVF9BKXKQ2XLn2XdPrPO3sem3A33
        p2s0avZhQ4zz1aCV7Raar+gtLLIf0lWew/WdvGHUnHfW6zGjX2B6MHkw25djWPff82YPq09xSReW5
        rXyobZsWHyY4KBLpO4HOWmy1dCeyoy6drs09d5t1GumCW4h/JdklO1SMBMqvBylJ70gG7jOopVMK0
        SCdpjCCw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6Bwr-00Fve0-24;
        Mon, 05 Jun 2023 15:16:45 +0000
Message-ID: <24b700bd-5817-db42-ce1d-1f97c8da5c92@infradead.org>
Date:   Mon, 5 Jun 2023 08:16:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v16 01/13] hp-bioscfg: Documentation
Content-Language: en-US
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
References: <20230602131044.3297-1-jorge.lopez2@hp.com>
 <20230602131044.3297-2-jorge.lopez2@hp.com>
 <39a19a0b-610d-52bf-5050-eb870ad2e619@infradead.org>
 <CAOOmCE9jmPpG8Do1h3uaMX9GKoioBLwak_3BeBoGPTtUj0Yj5Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOOmCE9jmPpG8Do1h3uaMX9GKoioBLwak_3BeBoGPTtUj0Yj5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/5/23 06:32, Jorge Lopez wrote:
> On Fri, Jun 2, 2023 at 5:55 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 6/2/23 06:10, Jorge Lopez wrote:
>>
>>>
>>> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
>>>
>>> ---
>>> Based on the latest platform-drivers-x86.git/for-next
>>> ---
>>>  .../testing/sysfs-class-firmware-attributes   | 101 +++++++++++++++++-
>>>  1 file changed, 99 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
>>> index 4cdba3477176..df9904b9f39c 100644
>>> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
>>> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes

>>> @@ -364,3 +393,71 @@ Description:
>>>               use it to enable extra debug attributes or BIOS features for testing purposes.
>>>
>>>               Note that any changes to this attribute requires a reboot for changes to take effect.
>>> +
>>> +
>>> +             HP specific class extensions - Secure Platform Manager (SPM)
>>> +             --------------------------------
>>> +
>>> +What:                /sys/class/firmware-attributes/*/authentication/SPM/kek
>>> +Date:                March 2023
>>> +KernelVersion:       5.18
>>
>> Why 5.18 and that date?
> 
> It is the minimum kernel version where firmware-attributes are
> supported and date when we expected hp-bioscfg driver support to be
> available.
> The driver, kernel versions and date changes weekly so we were placing
> those dates and versions as tentative.
> Any suggestions for Date and KernelVersion fields?
> 

No, sorry. But the different dates and versions are confusing.


Thanks for the answers.

-- 
~Randy
