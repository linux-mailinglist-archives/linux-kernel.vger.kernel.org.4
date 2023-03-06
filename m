Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC3E6AC509
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCFPa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCFPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:30:51 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37863029E;
        Mon,  6 Mar 2023 07:30:32 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so13580039pjh.0;
        Mon, 06 Mar 2023 07:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678116631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgnHRZuclFDvVIrvDgeaHSgtjEQTEgbeuOqe17W26Mo=;
        b=oq9Ar7t0Mvoywd5S+t8dP+o5iDdOh4+eRymeMTxb1yBsE9uS1TgZojcPsEQScp/4L+
         t0eiAqTp6ofX4l4XXsO8LpXg2COmbrWCNf44fO0cmsb/yfUuQY0ZExGNCtwJEOolFrH2
         iOBskkxB6JKXjq58nCrK+OhsZZGdEb2UC18twKckWifsXv5FaVRODxWPluAAZJj/0cAU
         PnLnFi5wdTr+FBfhWjO6EqkLxt/6agE3Fv4S8lbrTkuZJLYJyye2q1xlagfbGE+/4Heq
         DyCTl0+d56I/2UWuW5q983eBcXMKYwcfb5ClSa7Kj4MkJJYt1VpcCYCcrzWmsqmI+hpz
         EJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgnHRZuclFDvVIrvDgeaHSgtjEQTEgbeuOqe17W26Mo=;
        b=0DaCTd75vZ+4AImjHbzzjfVn7NG1J8uyGJe8ijqWIJtzpuaz1GUj9fr3l6vvLGiJ6g
         UaWXbstovZQpr74Iwo4pDZFaCGqOMqQ72ekatNqvvVlYe97NSnOR4Ej9dWAq6boraPD7
         Rk3ngzKNIh/saqPj8p02RE0QADWaqA8Rhl2zGn7fxrQgqNXnIUT29GGY8fkbi6AHyVRk
         FPLNLVhdEFFINjFdTU5e2MKhA1ov7y34oFZDynMM81i67SZeIzO2WUxXHvRB2h4/qfn3
         nFrZujJXZH/ExVF/VODxfAiw36DmEwZ7nWZtDGsyJ3dIBW2+UJAMc+rPaXXVLXFobQwf
         oM2Q==
X-Gm-Message-State: AO0yUKWbvijhe//S4SANpfgblHOb8/z00Cv5rDJvE9nD+YoYcyjGdCOZ
        owFLt0YZM8+HPrIxFvE0uUJflx82KwSFNw==
X-Google-Smtp-Source: AK7set90g1DG0N2ObWlFvZQ8fh0A385L8EdhXiA0XeSB5Qrnb5WXxe58gxjN15GtCMNOScE4In3Bew==
X-Received: by 2002:a05:6a20:6d27:b0:be:ed2a:b2dd with SMTP id fv39-20020a056a206d2700b000beed2ab2ddmr9072326pzb.6.1678116631273;
        Mon, 06 Mar 2023 07:30:31 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e18-20020a62ee12000000b005d3399efd80sm6436817pfi.136.2023.03.06.07.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 07:30:30 -0800 (PST)
Message-ID: <6f1d8954-586b-efea-526b-ef461b5624df@gmail.com>
Date:   Tue, 7 Mar 2023 00:30:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] docs/sp_SP: Add process deprecated translation
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergio.collado@gmail.com
References: <20230306134420.30210-1-carlos.bilbao@amd.com>
 <38cb9f23-a56a-f420-5942-0bfeb620306e@gmail.com>
 <875b2564-589b-c381-cbf0-f30470d4a5a8@amd.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <875b2564-589b-c381-cbf0-f30470d4a5a8@amd.com>
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

On 2023/03/07 0:20, Carlos Bilbao wrote:
> Hello Akira,
>=20
> On 3/6/23 09:13, Akira Yokosawa wrote:
>> Hi Carlos,
>>
>> Minor nits in the Subject and Sob area.
>>
>> On Mon, 6 Mar 2023 07:44:20 -0600, Carlos Bilbao wrote:
>>> Subject: [PATCH] docs/sp_SP: Add process deprecated translation
>>
>> This summary looks ambiguous to me.
>>
>> Maybe
>>
>> =C2=A0=C2=A0=C2=A0 docs/sp_SP: Add translation of process/deprecated
>=20
> This summary follows the same format followed in the past. Some example=
s:
>=20
> docs/sp_SP: Add process coding-style translation
> docs/sp_SP: Add process magic-number translation
> docs/sp_SP: Add process programming-language translation
> docs/sp_SP: Add process email-clients translation

Let me explain why "Add process deprecated translation" looks
ambiguous.

"deprecated translation" can be interpreted as "some translation
which is deprecated".
Of course you don't need to agree.

>=20
>>
>> ??
>>
>>> Translate Documentation/process/deprecated.rst into Spanish.
>>>
>>> Co-developed-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>> Signed-off-by: Sergio Gonzalez <sergio.collado@gmail.com>
>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>
>> To me, Co-developed-by: from the author of the patch looks
>> strange, because it is obvious the author did some development on
>> the patch.
>>
>=20
> No, we both worked on this patch so Co-developed-by: is the appropriate=

> tagging. That being said, Sergio translated more than I did, so I put
> him as sole Translator in the document itself.

Hmm, anyway I don't think you are following the rule of Co-developed-by:
explained in submitting-patches.rst.

Again, you don't need to agree... ;-)

        Thanks, Akira

>=20
>> Which is your intent:
>>
>> =C2=A0=C2=A0=C2=A0 Author: Carlos
>> =C2=A0=C2=A0=C2=A0 Co-developer: Sergio
>>
>> , or
>>
>> =C2=A0=C2=A0=C2=A0 Author: Sergio
>> =C2=A0=C2=A0=C2=A0 Co-developer: Carlos
>>
>> ???
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thanks, Akira
>>
>>> ---
>>> =C2=A0 .../translations/sp_SP/process/deprecated.rst | 381 ++++++++++=
++++++++
>>> =C2=A0 .../translations/sp_SP/process/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 2 files changed, 382 insertions(+)
>>> =C2=A0 create mode 100644 Documentation/translations/sp_SP/process/de=
precated.rst
>> [...]
>=20
> Thanks,
> Carlos
