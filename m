Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC7C6B5D0F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCKO6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCKO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:58:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD391B2FA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:58:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so5892435wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678546693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHMcirR/d0kseQKUwfhmLV8C1xKi97ZsvINp73wm0WE=;
        b=BFDli0m4yLqGA6cjuaqJUZIXSBMXawkQCw+cH6P4/54xB07/I/M1OtP/b2WfoufIDO
         j00g4aTzYtiO+HYL2a4INamzXPUhEx0JpZC387prnOyaN4tOI0dv0tFNN+5RpM9r7b+J
         J2FGmBMAHSlb/vICDCqFCaGDMcgkDTa3Hb/iyeRn2wiw0R3gA7eA+V4T/ddKd1I1CsPv
         0DAwntz2S876jn5xbwr281svxc5AAOHLrl9b4/W5EKur4iLH4So3oyDMTLxLkCx1sdxO
         n5oV+uPbVyszALE851sgbwnTE3QoyEoq4lHaG3zEnQ1Q3i8Zr4jKyzXIqNtiEFAkAqYp
         TsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678546693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHMcirR/d0kseQKUwfhmLV8C1xKi97ZsvINp73wm0WE=;
        b=2onKo/QwpV74yeID89C9AEYWUtGydcmfeWnrESyFJdK+FXDAf1EFaaiw08rT7cLHri
         yniAGLBBNpgkvyM+BCLP9vRyzCyzIYiM2IqpsmipDcvRgES9RCueqHE+ynTcNox3D4os
         YuctE+6ZUEFUJDv2Mn7AcXrF9S+hDdw+dLlX1FSPBJ/tqmLTeqq65puEQjyzl1FFNzVm
         mg+9uDfs2C+eExwUkBkrQkYQ3QQz4/FSnvm0u8+TbMFuocKZj4wY4Wbqqr0Ujh246W04
         080upLhF8D/TFgJaVd5wQlZtVIWp7QfgFfkQKHijUICipjpCCo71wgLCpP1YgkAN7gL6
         PO7w==
X-Gm-Message-State: AO0yUKU+beBOH7mGrjrroSlEiQ6uJimnq5m5A+gdqGITPj7vCSuKpfJp
        VmY1r5lYh56nLC8F+dFlFu0=
X-Google-Smtp-Source: AK7set+mQmPFifs0KWevNYp+Yp9EVN+4oNFdxjduyjxiOzzeU0Y3yT2QwK/SxBiyf73sBNaN1c1UXw==
X-Received: by 2002:a05:600c:3c8f:b0:3ea:bc08:b63e with SMTP id bg15-20020a05600c3c8f00b003eabc08b63emr6133252wmb.2.1678546692848;
        Sat, 11 Mar 2023 06:58:12 -0800 (PST)
Received: from [192.168.1.16] ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b003e1202744f2sm3205826wmo.31.2023.03.11.06.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 06:58:12 -0800 (PST)
Message-ID: <fe97c33f-536a-5951-73bd-169b67d9b8d8@gmail.com>
Date:   Sat, 11 Mar 2023 16:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] staging: greybus: Fix Alignment with parenthesis
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, vireshk@kernel.org, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303110958250.2802@hadrien>
 <71211670-60f9-11f4-1ee7-f94d4d9df4fb@gmail.com>
 <alpine.DEB.2.22.394.2303111354490.2802@hadrien>
 <61dab579-f10b-5538-8b61-ebe73ae5b4f1@gmail.com>
 <27dfe880-35f7-cbc1-cf8b-7bbd7f1c7301@gmail.com>
 <alpine.DEB.2.22.394.2303111537430.2802@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303111537430.2802@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١١‏/٣‏/٢٠٢٣ ١٦:٣٨, Julia Lawall wrote:
>
> On Sat, 11 Mar 2023, Menna Mahmoud wrote:
>
>> On ١١/٣/٢٠٢٣ ١٤:٥٧, Menna Mahmoud wrote:
>>> On ١١/٣/٢٠٢٣ ١٤:٥٥, Julia Lawall wrote:
>>>> On Sat, 11 Mar 2023, Menna Mahmoud wrote:
>>>>
>>>>> On ١١/٣/٢٠٢٣ ١٠:٥٩, Julia Lawall wrote:
>>>>>> On Fri, 10 Mar 2023, Menna Mahmoud wrote:
>>>>>>
>>>>>>> Fix " CHECK: Alignment should match open parenthesis "
>>>>>>> Reported by checkpath
>>>>>> See the message in the other mail about the log message.
>>>>>>
>>>>>> Also, you should not have two patches with the same subject.  Here,
>>>>>> the
>>>>>> changes are on the same file and are essentially the same, even
>>>>>> involving
>>>>>> the same function call.  So they can be together in one patch.
>>>>>>
>>>>>> julia
>>>>> okay, I will. appreciate your feedback. thanks.
>>>> Please put some blank lines around your response, so it is easier to find.
>>>>
>>>> thanks,
>>>> julia
>>>
>>> Okay, I will.
>>>
>>> thanks,
>>>
>>> Menna
>>
>>
>> Hi Julia,
>>
>> according to Alex feedback
>>
>> " I think this type of alignment is not a major problem,
>> and alignment isn't done this way in general in this
>> driver, it's probably OK to keep it that way. - Alex "
>>
>>
>> ,I won't resubmit these patches, right?
> The existing code indeed looks better to me.  So you can skip this issue.
>
> julia


Okay, thanks Julia.


>
>>
>>   -Menna
>>
>>
>>>
>>>>>>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>>>>>>> ---
>>>>>>>     drivers/staging/greybus/fw-core.c | 2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/staging/greybus/fw-core.c
>>>>>>> b/drivers/staging/greybus/fw-core.c
>>>>>>> index 57bebf24636b..f562cb12d5ad 100644
>>>>>>> --- a/drivers/staging/greybus/fw-core.c
>>>>>>> +++ b/drivers/staging/greybus/fw-core.c
>>>>>>> @@ -89,7 +89,7 @@ static int gb_fw_core_probe(struct gb_bundle
>>>>>>> *bundle,
>>>>>>>                 }
>>>>>>>
>>>>>>>                 connection = gb_connection_create(bundle, cport_id,
>>>>>>> -                        gb_fw_mgmt_request_handler);
>>>>>>> +
>>>>>>> gb_fw_mgmt_request_handler);
>>>>>>>                 if (IS_ERR(connection)) {
>>>>>>>                     ret = PTR_ERR(connection);
>>>>>>>                     dev_err(&bundle->dev,
>>>>>>> --
>>>>>>> 2.34.1
>>>>>>>
>>>>>>>
>>>>>>>
> >
