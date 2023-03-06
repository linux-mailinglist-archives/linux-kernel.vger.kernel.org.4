Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1203E6AD27E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCFXDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCFXDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:03:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032B732CFC;
        Mon,  6 Mar 2023 15:03:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so14734203pjg.4;
        Mon, 06 Mar 2023 15:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678143811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Faxcnm+gnV6yaEFvioUQPdzwe/7YrA9kfzZX61U9lpo=;
        b=WpthXM2okZuDw48FetvHdPGd++0nvgiHT6aSelJpZJ/pjQR+AT60IelDOi73jmlE5/
         rgYXilGCGa7pHHjPEWmH8YcAi1zy8ExgAuKThawg+wqM51OCLA28Zu3WW6dMkodPB6Sa
         JL/IXir+GMaKG7vTgmrzHDRZMvpNSVxCECnvrwJ+D7sLoKw3Y494PNPgleDtRDwFPb5Z
         br7H8Pbav3ukjsb4rjjtRRem+poIkUAMzymodeWLO9ujgpZekww3fqOIruaYvBSQ7dzv
         tiqZ8oVnvFpInsKrWcNGhIfFH8KkE+a4C3hJ0SY4bbGpAflTD6IJAheKPBMM2gJeKDfb
         z9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Faxcnm+gnV6yaEFvioUQPdzwe/7YrA9kfzZX61U9lpo=;
        b=coKKq0oGfmNINvCaau5kIx70lozxxxcv9/qwXa+g7bnqgnJq6kd0YKOx/uBzYJm205
         XAndnTQcjGwUqbHhH96L9LyR1ZCzjTFJWa40rBcS/pQ7VQe4+A1ayIZxWm3rnHn+aWnW
         BhHeJMANQ3PFbAqgMylsgUIDl1YZ0xFMvfKWrEMfK9sjmJjK8flI/hAsLEoKhUpoNStR
         c+IDJaoXs13yrhCQXo/yvIBeJ6a7d6SfxOcU+XF/8kTGQzHsaHAasFizoNfx2hh6l+WG
         Hzkd4ZdUBR87wnde3zDekmCjtV18V7rTtJT6MJYx7w/wnAhDPtfC/68t9uzhydvgVba3
         d5LQ==
X-Gm-Message-State: AO0yUKWuh9vuJE39TuR3TuPsFNvcdbaHaMPX01O2LP1HL4x+t1QYxi/G
        UbTHkoaBInFlxlQAx7TZwuw=
X-Google-Smtp-Source: AK7set+sT6beC1v6mjrUcP18VgL9BGyqGoRY2d+72btj1X44/blFh7C8dlFaEaV/4L+Ky/rHMPhx0Q==
X-Received: by 2002:a17:902:c103:b0:19e:7611:7162 with SMTP id 3-20020a170902c10300b0019e76117162mr11108693pli.16.1678143811362;
        Mon, 06 Mar 2023 15:03:31 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902b61700b0019c3296844csm7161983pls.301.2023.03.06.15.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 15:03:30 -0800 (PST)
Message-ID: <dbd8ece3-fb92-9ca3-917b-4951af7e1593@gmail.com>
Date:   Tue, 7 Mar 2023 08:03:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] docs/sp_SP: Add process deprecated translation
Content-Language: en-US
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergio.collado@gmail.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230306134420.30210-1-carlos.bilbao@amd.com>
 <38cb9f23-a56a-f420-5942-0bfeb620306e@gmail.com>
 <875b2564-589b-c381-cbf0-f30470d4a5a8@amd.com>
 <6f1d8954-586b-efea-526b-ef461b5624df@gmail.com>
 <2b4f177b-3b8a-fef6-e7a5-692db347679e@amd.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <2b4f177b-3b8a-fef6-e7a5-692db347679e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 09:34:29 -0600, Carlos Bilbao wrote:
> On 3/6/23 09:30, Akira Yokosawa wrote:
>> On 2023/03/07 0:20, Carlos Bilbao wrote:
>>> Hello Akira,
>>>
>>> On 3/6/23 09:13, Akira Yokosawa wrote:
>>>> Hi Carlos,
>>>>
>>>> Minor nits in the Subject and Sob area.
>>>>
>>>> On Mon, 6 Mar 2023 07:44:20 -0600, Carlos Bilbao wrote:
>>>>> Subject: [PATCH] docs/sp_SP: Add process deprecated translation
>>>>
>>>> This summary looks ambiguous to me.
>>>>
>>>> Maybe
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 docs/sp_SP: Add translation of process/depr=
ecated
>>>
>>> This summary follows the same format followed in the past. Some examp=
les:
>>>
>>> docs/sp_SP: Add process coding-style translation
>>> docs/sp_SP: Add process magic-number translation
>>> docs/sp_SP: Add process programming-language translation
>>> docs/sp_SP: Add process email-clients translation
>>
>> Let me explain why "Add process deprecated translation" looks
>> ambiguous.
>>
>> "deprecated translation" can be interpreted as "some translation
>> which is deprecated".
>> Of course you don't need to agree.
>=20
> I see what you mean. I'm sending v2 patch renamed to avoid confusion.
>=20
>>
>>>
>>>>
>>>> ??
>>>>
>>>>> Translate Documentation/process/deprecated.rst into Spanish.
>>>>>
>>>>> Co-developed-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>>> Signed-off-by: Sergio Gonzalez <sergio.collado@gmail.com>
>>>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>>
>>>> To me, Co-developed-by: from the author of the patch looks
>>>> strange, because it is obvious the author did some development on
>>>> the patch.
>>>>
>>>
>>> No, we both worked on this patch so Co-developed-by: is the appropria=
te
>>> tagging. That being said, Sergio translated more than I did, so I put=

>>> him as sole Translator in the document itself.
>>
>> Hmm, anyway I don't think you are following the rule of Co-developed-b=
y:
>> explained in submitting-patches.rst.
>>
>> Again, you don't need to agree... ;-)
>=20
> But, why doesn't it follow the rule?
>=20
> The rule is "A Co-Developed-by: states that the patch was also created =
by another developer along with the original author. This is useful at ti=
mes when multiple people work on a single patch."
>=20
> IMHO this is the case here, but before I send v2 I'll wait to read you =
again in case we agree at that point.

If you put "From: Sergio" as the first line in the Changelog, like
this submission [1], then the Sob chain would make sense.

[1]: https://lore.kernel.org/linux-doc/20230227222957.24501-2-rick.p.edge=
combe@intel.com/

Didn't you forgot to put it there?

Just guessing...

        Thanks, Akira

>=20
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thanks, Akira
>>
>>>
>>>> Which is your intent:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Author: Carlos
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Co-developer: Sergio
>>>>
>>>> , or
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Author: Sergio
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Co-developer: Carlos
>>>>
>>>> ???
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thanks, Akira=

>>>>
>>>>> ---
>>>>> =C2=A0=C2=A0 .../translations/sp_SP/process/deprecated.rst | 381 ++=
++++++++++++++++
>>>>> =C2=A0=C2=A0 .../translations/sp_SP/process/index.rst=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>>> =C2=A0=C2=A0 2 files changed, 382 insertions(+)
>>>>> =C2=A0=C2=A0 create mode 100644 Documentation/translations/sp_SP/pr=
ocess/deprecated.rst
>>>> [...]
>>>
>>> Thanks,
>>> Carlos
>=20
> Thanks,
> Carlos
