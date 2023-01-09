Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED396629B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjAIPSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbjAIPRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:17:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA2AE0F5;
        Mon,  9 Jan 2023 07:17:15 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id h7so2151665pfq.4;
        Mon, 09 Jan 2023 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvwSDO2Hb8MF5gfs0gEgedA6XZqhUj4DenZvxObCMLI=;
        b=C7DzCtUKTqW+u1T9YEktbpgquCjd3AA1+cQIDDBeTNo8bLsRNDTuGK6CzQVU9yf4JR
         z0cuw69nbhT3rst8qSly9m4GnD4VFDqbD5CaCl2ThpbfVqbSBmScmwufoFsyBdulmlQ7
         Osy4zkOPuKIpkoTEUF5/HN6HmfB+5QG5sPiknO9dLmHSF0/3+U8xY+MgO4NVqwn4H9Ev
         7vy17VmHYP2zbqGU+95+QChQDFypvqMnAsbUkYC7ncKw50lxBaCRy7C1TQovVNIXGAvc
         fGfhzyuzXc4lVg2kKSMq4uxet39x+d8VJtCO98PieFAQ2Xmk1xeK3BhPWPfGvrs3v2ra
         FSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvwSDO2Hb8MF5gfs0gEgedA6XZqhUj4DenZvxObCMLI=;
        b=nV2dQ4+HsdNrLrt3nnSTR956TPwOq5lOOBUuqCUWQQIfrPaUq7zqBBFYH4pKxlJQ9b
         TwCo9DSpWFKsOdMSK+UyizjzG/u09Sq/Q6ImR5vpk8+f897cNIKS+xGqtlCrUbnybrPh
         a5hVqrVKAN7LZpSQEffaJTr7ZpUHoFbdGUBqrZs+SbXU4nhTFv4mMSno5fLK2PIX7vTX
         LqrgrR+gFc+JhjCPwWADdwdbv3wj+fAGFCuGOL9HpnXWHAUNroKYhUzA5U1o4SYpPWZk
         0HUEwPKPTkKtu9k/Dj8sHdmO5MGLMMVBvz939qgoULbz95G8Qu8PaMTAV0hOmnrQeiA8
         duVg==
X-Gm-Message-State: AFqh2koNLk5DbRCgTe3mHXDHg3Pp0QogTGWCsyLDzf1gbQOKxhpvXkFZ
        26l+ODxTBuBiJgwBY4orzSw=
X-Google-Smtp-Source: AMrXdXs7xU6YvV/C6kWk1SxEyz4jMmuA9xkZpPvhJN1SQVN6GtopviMS+nXHEtL2+r/wixCBjJekww==
X-Received: by 2002:a05:6a00:4008:b0:582:bb80:58d7 with SMTP id by8-20020a056a00400800b00582bb8058d7mr18195360pfb.26.1673277435017;
        Mon, 09 Jan 2023 07:17:15 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 132-20020a62198a000000b00575caf8478dsm6189172pfz.41.2023.01.09.07.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 07:17:14 -0800 (PST)
Message-ID: <e2d98136-3c4c-8910-d116-93070c48474d@gmail.com>
Date:   Tue, 10 Jan 2023 00:17:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs: Fix the docs build with Sphinx 6.0
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <87wn629ggg.fsf@meer.lwn.net>
 <cb916eae-fdf6-504f-8f38-7928e0fa8344@gmail.com>
 <20230108150135.060b0c7a@coco.lan>
 <6e81b372-d010-fb75-cdfe-b76c6b197f07@suse.cz>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <6e81b372-d010-fb75-cdfe-b76c6b197f07@suse.cz>
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

On Mon, 9 Jan 2023 15:14:46 +0100, Martin Li=C5=A1ka wrote:
> On 1/8/23 15:01, Mauro Carvalho Chehab wrote:
>> Em Sat, 7 Jan 2023 14:17:24 +0900
>> Akira Yokosawa <akiyks@gmail.com> escreveu:
>>
>>> On Wed, 04 Jan 2023 13:45:35 -0700, Jonathan Corbet wrote:
>>>> Sphinx 6.0 removed the execfile_() function, which we use as part of=
 the
>>>> configuration process.=C2=A0 They *did* warn us...=C2=A0 Just open-c=
ode the
>>>> functionality as is done in Sphinx itself.
>>>>
>>>> Tested (using SPHINX_CONF, since this code is only executed with an
>>>> alternative config file) on various Sphinx versions from 2.5 through=
 6.0.
>>>>
>>>> Reported-by: Martin Li=C5=A1ka <mliska@suse.cz>
>>>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>>>
>>> I have tested full builds of documentation with this change
>>> with Sphinx versions 1.7.9, 2.4.5, 3.4.3, 4.5.0, 5.3.0, and 6.0.0.
>>>
>>> Tested-by: Akira Yokosawa <akiyks@gmail.com>
>>>
>>> That said, Sphinx 6.0.0 needs much more time and memory than earlier
>>> versions.
>>>
>>> FYI, I needed to limit parallel slot to 2 (make -j2) on a 16GB machin=
e.
>>> If you are lucky, -j3 and -j4 might succeed. -j5 or more ended up in
>>> OOM situations for me:
>>>
>>> Comparison of elapsed time and maxresident with -j2:
>>>
>>> =C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =C2=A0=C2=A0 Sphinx version elapsed time maxresident
>>> =C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =C2=A0=C2=A0 5.3.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 10:16.81=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 937660
>>> =C2=A0=C2=A0 6.0.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 17:29.07=C2=A0=C2=A0=C2=A0=C2=A0 5292392
>>> =C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Hi.
>=20
> I can confirm the regression, I bisected Sphinx revision that caused th=
at
> and filled an upstream issues:
> https://github.com/sphinx-doc/sphinx/issues/11116

Thank you Martin for looking into this!

>=20
> Cheers,
> Martin
>=20
>>
>> =C2=A0From the changelogs:
>> =C2=A0=C2=A0=C2=A0=C2=A0https://www.sphinx-doc.org/en/master/changes.h=
tml
>>
>> It seems that 6.1 came with some performance optimizations, in particu=
lar:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Cache doctrees in the build environment durin=
g the writing phase.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Make all writing phase tasks support parallel=
 execution.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Cache doctrees between the reading and writin=
g phases.
>>
>> It would be nice if you could also test and check elapsed time
>> there too, as I suspect that 6.0 will have a very short usage, as
>> 6.1 was released just a few days after it.

Here is a table comparing 5.3.0, 6.0.1 and 6.1.2 taken on the same
machine (with 16GiB mem + 2GiB swap):

 =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                     elapsed time
         -----------------------------------
 Sphinx     -j1     -j2      -j4      -j6
 =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D
  6.1.2  15:11.74 18:06.89 16:39.93      OOM
  6.0.1  15:28.19 17:22.15 16:31.30      OOM
  5.3.0  14:13.04 10:16.81  8:22.37  8:09.74
 =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D

Note:
  - The -j1 run needs an explicit option given to sphinx-build by:
      make SPHINXOPTS=3D"-q -j1" htmldocs
  - Once an OOM happens, -j4 runs are likely end up in OOM.

Looks like the non-parallel run is the cheapest option for mitigating
the regression.

        Thanks, Akira

>>
>> Regards,
>> Mauro.
>>
>>
>>
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thanks, Akira

