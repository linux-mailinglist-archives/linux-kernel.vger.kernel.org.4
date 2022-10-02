Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B955F20C2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 02:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJBA2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 20:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJBA2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:28:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176F5721C;
        Sat,  1 Oct 2022 17:28:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r5so2188618pjq.1;
        Sat, 01 Oct 2022 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=WB4sj3vFMJvf9+kFEuhjklnfHLLbja4yM5JLwxCPsi0=;
        b=FMKmoo6UtOmF7XZLbnTH5fAnwLliuKWtZ2j9KgPR0TUYT6ewiFI35U1TShiL7YW+hF
         g1SwaZNOfd+lLfyTZUJn9I14HCMibzq0gQpVasPDHQCygBqDvd72HMzvZUxlZpWZwEpn
         WcW0cK75B+6kXML5Dj4akLsp/StLngRwlyPicXv245wVlsup8dQW//6vK+sZNrcN/hz8
         +OcFcEvEyvxK6jEa3JkgJsxPtL0K5fS094os5nn6MhuAUDOtTrIxMX73wY7ffWiS/HB8
         yKAn7teK8OxGM+zvLDJ7xQ9DWIMw8DmquGNsjlSPoZ9jTqJ2qNaf4nMuJClBNTli2CE/
         vJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WB4sj3vFMJvf9+kFEuhjklnfHLLbja4yM5JLwxCPsi0=;
        b=2IoUH2YQ4zyTA97EJBRo1nhbh4OtPKLmsaQh24OaFGlGwnB2Y5Utjoiuukvk1U+TCL
         gWwkknXz5TWcLkskLIPI3WBVpzNygBT7jRqNf0DClCaUYkhfJL6f2oJQk9MYCm1TM9kj
         pAFmiGudiPeQFk4fD5TR0IXjgotzmK1AT8zGU1TH+gpspqWW7MnXmx+3lR60zI2/NU9m
         +lULa9O0aA9pzAHYbIyxiTDw32ndjLiOxwXa//jeGrWNO4wFzsaQXvdLsmYfHTQNAjv8
         e0aJnC0fEUqvvGsV2XH67M5BysOfQdfFAVLslrDn0/TT/DaZgdPq2Mnj9AlH+jlXQTNZ
         kogw==
X-Gm-Message-State: ACrzQf3mtnYZ9MqUTkMk7AhmBCyXSz2Jg/CmP0evumInuZ+pZvY5sD1E
        saKlZs4eeR53DhuiIkbT10PRXcbzGFA=
X-Google-Smtp-Source: AMsMyM7oyuqaIUWyUOPCw9S451fYU00uYjclDsjBDvbJJEs/jb0AMfvI+kHhqoB1TCUPV8yjW3/FPQ==
X-Received: by 2002:a17:90b:1c0d:b0:202:61d0:33c with SMTP id oc13-20020a17090b1c0d00b0020261d0033cmr5459270pjb.90.1664670484016;
        Sat, 01 Oct 2022 17:28:04 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id h15-20020aa79f4f000000b0053e75395705sm4303138pfr.127.2022.10.01.17.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 17:28:03 -0700 (PDT)
Message-ID: <71599eac-04ef-66d1-50d5-ebc564a6bf1d@gmail.com>
Date:   Sun, 2 Oct 2022 09:27:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate supporters
 should be mailed
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     corbet@lwn.net, konstantin@linuxfoundation.org,
        krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@leemhuis.info,
        Theodore Ts'o <tytso@mit.edu>
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
 <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
 <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org> <Yzen4X1Na0MKXHs9@mit.edu>
 <70759d05-2646-57e5-0b87-3a196488f622@linaro.org>
Content-Language: en-US
In-Reply-To: <70759d05-2646-57e5-0b87-3a196488f622@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 11:37:03 +0100, Bryan O'Donoghue wrote:
> On 01/10/2022 03:37, Theodore Ts'o wrote:
>> FWIW, I actually think the output of get_maintainer.pl is pretty
>> broken in this regard.=C2=A0 (Then again, I've never thought all that
>> highly of get_maintainer.pl,*especially*=C2=A0 because of the bogus gi=
t
>> fallback, but that's another story.)
>>
>> Consider:
>>
>> % ./scripts/get_maintainer.pl --file=C2=A0 drivers/acpi/power.c
>> "Rafael J. Wysocki"<rafael@kernel.org>=C2=A0 (supporter:ACPI)
>> Len Brown<lenb@kernel.org>=C2=A0 (reviewer:ACPI)
>> linux-acpi@vger.kernel.org=C2=A0 (open list:ACPI)
>> linux-kernel@vger.kernel.org=C2=A0 (open list)
>>
>> I'm sorry, but that's just*wrong*.=C2=A0 Rafael is the*maintainer*=C2=A0=
 of the
>> ACPI subsystem, and the term "supporter" is rarely if ever used
>> anywhere in our docs.=C2=A0 As I said earlier, trying to treat S: fiel=
d to
>> say anything about the entitles listed under the M: field of the
>> Maintainers file is a category error.
>=20
> I agree, I made exactly this error.
>=20
> I wasn't sure how people would necessarily feel about having
> get_maintainer produce the string 'maintainer' for both Maintained and
> Supported but, IMO it is more consistent to have it do so, since we ref=
er
> to maintainers all throughout the doucmentation and as you say above Ra=
fael
> is the person you *need* to mail there because he's the maintainer.

You'd better CC Joe Perches, who is the maintainer of get_maintainer.pl.
You might want to start a new thread with a different subject.
The main point becomes the behavior of get_maintainer.pl.

>=20
> Lets consider
>=20
> - maintainer as a string for "S: Supported"
> - Documentation update to reflect Krzysztof's point on git-fallback

Sounds reasonable to me.
Good luck!

Thanks,
Akira

>=20
> ---
> bod
