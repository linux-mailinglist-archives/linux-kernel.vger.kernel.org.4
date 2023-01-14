Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46366A7EF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjANBGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjANBGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:06:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAA34D4B3;
        Fri, 13 Jan 2023 17:06:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o13so20524174pjg.2;
        Fri, 13 Jan 2023 17:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ov8wEfyGG2nWN7b01CPIh7BqEH1wqXhlK99+GfKu0bs=;
        b=gvL6RDV4waR2wIkZlb3McCBihU706uvVwhgAqP12kPXGQ97PVCJMrSDk0vzUGUzVhM
         h1Uh6Yb1Epg4qKWr7EEoAnwQjxP98tnJmWWyOadgmjggVE2aKKsb5Y0i9yUXTtvywC3u
         oIQiZoCOfIq+/rLwyeLwTCK1fJbuRPW4MvCweDUOlDeNbT2YOrMcAsl4RrPUznvtQZCb
         UKfxGU983P9fDww3PRge6+f8lczEjuAVRvnpt6oNqmmf7UGOxBkLekfo+XCinz1RgsDL
         fHjL0pVV8d7rXgiJ/fDeuPkzf6ylMphFZ74IWQVuZsp/VXXrM4wDcG5a4ifiDqZl7QsX
         Z/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov8wEfyGG2nWN7b01CPIh7BqEH1wqXhlK99+GfKu0bs=;
        b=L2kt9DHNrgYnqo73R36y7zDcNE3IX5rcbKfWPRPitws9EJvd4/axFkNsWQmznxma69
         6fQsiepc3cZZIAZzRTOl2/nPTdWAvnwIcqRz+ZKGrdpadWeNQXSj8evdVqxiktcWiOyq
         1EU6KdR+T48DmG7GKLu6fi+nI92RJqWjxCieYkE18K6qNys87AaJy4zOynf87Q/LE5mi
         VdLYJ6GRJbZB1kzYYZe8lppqtZhO2lHBOVqhKqKnFaFS6Uc8WZ3qn66QoyidcABwYWXE
         yz3w2A4WDQ/Lvrbuc0NLWinCHYwhLzS1mbJHMUsANEozE1CUalLOrDScFdCnqOPege17
         nZzg==
X-Gm-Message-State: AFqh2krvXj89HqBkKjGoXhLU6qYkUnUJ9y1A+fOdErANlIkPVdUt9V2R
        5i7nCEtnNeZ4wWQXpNmFeOs=
X-Google-Smtp-Source: AMrXdXunnZ/fWN3btLzBC2yH9qJx5o9LMGcJx28haLciN1DDZWfF7cUcqpbKWNAIau6siawhAZmxWA==
X-Received: by 2002:a05:6a20:bf23:b0:a5:798c:f929 with SMTP id gc35-20020a056a20bf2300b000a5798cf929mr90233225pzb.10.1673658402170;
        Fri, 13 Jan 2023 17:06:42 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b7-20020a63eb47000000b00460ea630c1bsm12174067pgk.46.2023.01.13.17.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 17:06:41 -0800 (PST)
Message-ID: <530a54b6-25b2-4892-40bc-809371689aae@gmail.com>
Date:   Sat, 14 Jan 2023 10:06:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs: Fix the docs build with Sphinx 6.0
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <87wn629ggg.fsf@meer.lwn.net>
 <cb916eae-fdf6-504f-8f38-7928e0fa8344@gmail.com>
 <20230108150135.060b0c7a@coco.lan>
 <6e81b372-d010-fb75-cdfe-b76c6b197f07@suse.cz>
 <e2d98136-3c4c-8910-d116-93070c48474d@gmail.com>
 <bdd04f2e-64a4-e3ef-eb4c-3681c6f52c2f@gmail.com>
 <c84fe7eb-27b7-aca7-24a6-09ca67dca43f@suse.cz>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <c84fe7eb-27b7-aca7-24a6-09ca67dca43f@suse.cz>
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

On Thu, 12 Jan 2023 17:22:42 +0100, Martin Li=C5=A1ka wrote:
> On 1/12/23 00:13, Akira Yokosawa wrote:
>> On Tue, 10 Jan 2023 00:17:11 +0900, Akira Yokosawa wrote:
>>> On Mon, 9 Jan 2023 15:14:46 +0100, Martin Li=C5=A1ka wrote:
>>>> Hi.
>>>>
>>>> I can confirm the regression, I bisected Sphinx revision that caused=
 that
>>>> and filled an upstream issues:
>>>> https://github.com/sphinx-doc/sphinx/issues/11116
>>>
>>> Thank you Martin for looking into this!
>>
>> Thanks to Martin's inputs on the github issue, Sphinx 6.1.3 has releas=
ed
>> and the issue is resolved for parallel builds.
>=20
> You're welcome.
>=20
>>
>> However, for non-parallel builds, the memory hog still remains.
>> Again, this is a table comparing 5.3.0, 6.1.2, and 6.1.3.
>>
>>  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>>                      elapsed time                       maxresident
>>          -----------------------------------  ------------------------=
-------
>>  Sphinx     -j1     -j2      -j4      -j6       -j1     -j2     -j4   =
  -j6
>>  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
>>   6.1.3  15:03.83 11:31.99  9:35.15  8:49.01  2949056 1059516  978232 =
 967400
>>   6.1.2  15:11.74 18:06.89 16:39.93      OOM  2961524 5548344 5255372 =
     --
>>   5.3.0  14:13.04 10:16.81  8:22.37  8:09.74   711532  937660  846016 =
 800340
>>  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>=20
> I thank you for the nice numbers you provided.

You are welcome.

>=20
>>
>>     Note:
>>       - The -j1 run needs an explicit option given to sphinx-build:
>>         make SPHINXOPTS=3D"-q -j1" htmldocs
>>
>> I naively assumed that the memory hog would be resolved all together,
>> but that's not the case.
>=20
> Yep, I would expect that same.
>=20
>>
>> Martin, could you report the remaining issue to upstream Sphinx?
>=20
> Sure: https://github.com/sphinx-doc/sphinx/issues/11124

Thanks!

>=20
> Btw. do you have an Github account I can CC?

I have reacted with an emoji and subscribed to the issue.

        Thanks, Akira

>=20
> Cheers,
> Martin
>=20
>>
>>         Thanks, Akira
>>
>>
>=20
