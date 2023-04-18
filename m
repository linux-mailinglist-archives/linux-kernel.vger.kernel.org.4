Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985216E5987
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjDRGkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDRGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:40:07 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3DF138
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:40:05 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id fw30so17651978ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681800004; x=1684392004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTdwnxfwvIfrsUC5dnONRMBXOk9zTo/BEfi7gockUjU=;
        b=iJiL2oNJ7ETBtr9nuMK/zvyyFbWtFBjdAfFqk/g7yQUNEEYjS+Rg/mHgSvHAWeixdV
         KcDniolO7cD8vTyG3Eb1LZ1UnxP8w4KkePBVCywWue7E6BBnGidiYf78+rMfGvWXcxHe
         ajcgVDcDEL6TH7TgeqbftO9dhI+OcVangwMeoOs8yGypXZW+LIPxA3kMt7SYnbgandBp
         ZsG36RQhDor03iWYZAQqz1ibOFkcLLoz56Aad5smN128H2I8W84Ep6UY/JB7TwFFG0UZ
         QsCLfl56qk0Gpb1KfygC9BV4ih14sUA3c4kFiUKJZf2fvliXMGNSOC8sSZ99aS6Vf7Lm
         1bRg==
X-Gm-Message-State: AAQBX9fUQCnWavoLuOgQpuUSt2P9vnlhljNM3wJCw4WpHn4VYQOMuzzd
        2ZQbKI+sP9eYmQhZyq1t4ZQAL1ne4NA=
X-Google-Smtp-Source: AKy350aZceeo2NIOgQlBylMkt8QjF7LSlhUi0Fh0XyOQEk1TlO8af5FAUWQVleYV1ugdYvGlo6b5Sg==
X-Received: by 2002:a17:907:91d5:b0:94f:39b4:e32c with SMTP id h21-20020a17090791d500b0094f39b4e32cmr6894519ejz.43.1681800003922;
        Mon, 17 Apr 2023 23:40:03 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906349100b0094eeea5c649sm5793536ejb.114.2023.04.17.23.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 23:40:03 -0700 (PDT)
Message-ID: <97fd3a9a-1fe6-658f-5fee-8541abccb300@kernel.org>
Date:   Tue, 18 Apr 2023 08:40:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Lenovo
 Ideapad Z470
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230417104817.30254-1-jirislaby@kernel.org>
 <CAJZ5v0iYRxGLWgiTD5ouWLy84YN4ddnVshCNgiYJMbLdpK_ZRA@mail.gmail.com>
 <ab900b77-5e8f-4a4f-7e0f-c3358b784c01@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <ab900b77-5e8f-4a4f-7e0f-c3358b784c01@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 04. 23, 15:09, Hans de Goede wrote:
> Hi,
> 
> On 4/17/23 13:40, Rafael J. Wysocki wrote:
>> On Mon, Apr 17, 2023 at 12:48 PM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>>>
>>> From: Hans de Goede <hdegoede@redhat.com>
>>>
>>> The Lenovo Ideapad Z470 predates Windows 8, so it defaults to using
>>> acpi_video for backlight control. But this is not functional on this
>>> model.
>>>
>>> Add a DMI quirk to use the native backlight interface which works.
>>>
>>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1208724
>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Hans, can you please give your S-o-b for this one?
> 
> Hmm, I do not believe that I wrote this patch
> (also see the suse bugzilla link in the comment it adds) ?
> 
> I guess it started as a copy of my "ACPI: video: Add
> backlight=native DMI quirk for Acer Aspire 3830TG" patch
> and that is why I was kept as the author ?
> 
> Anyways I'm fine with me being the author, or with Jiri
> being the author. Pick a tag depending on the answer:

Huh, sorry. I forgot to --reset-author. Let me fix this mess up.

Thanks.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
>>
>>> ---
>>>   drivers/acpi/video_detect.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>>> index 69ef2d9710c2..af5cea005f54 100644
>>> --- a/drivers/acpi/video_detect.c
>>> +++ b/drivers/acpi/video_detect.c
>>> @@ -459,6 +459,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>>>                  DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
>>>                  },
>>>          },
>>> +       {
>>> +        /* https://bugzilla.suse.com/show_bug.cgi?id=1208724 */
>>> +        .callback = video_detect_force_native,
>>> +        /* Lenovo Ideapad Z470 */
>>> +        .matches = {
>>> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> +               DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Z470"),
>>> +               },
>>> +       },
>>>          {
>>>           /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
>>>           .callback = video_detect_force_native,
>>> --
>>> 2.40.0
>>>
>>
> 

-- 
js

