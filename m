Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53969FFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjBVXny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjBVXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:43:52 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A709137729;
        Wed, 22 Feb 2023 15:43:50 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z5so798375ilq.0;
        Wed, 22 Feb 2023 15:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w615umHxEk17AwNmh6Rkv++nzAZUwayUgTAtwm+Vzf4=;
        b=oAWVAveDB8TmLjZhNFrVTh5UbQoHVtkmR/M7meKoRyd8sksCgrdzLuZJQtLwLv4hXs
         CBlDWJGdV1++tuShfYkxOppLUjqMladX60zIyfvdaG2kyw00xz+vfZNiguqI84yyUrB5
         3cD8y5v4eNaotid3HAJeEbTWF/TtBFVhJwmsqRko/S9awePxKOr+LXGZEQg9pLy1s03l
         jzPU7EP9+0orU02IlkPBpDAPEuUok6d2lOfMv41TsCabYiD79ZDpCsr9iz+APoeUDQ35
         pvUnopWu5TSwAUYI7Mdyo/HS/LHoyyr3sT4tACpK1kxkiEgFpCi91LyCN2IsCXFY5wBL
         eksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w615umHxEk17AwNmh6Rkv++nzAZUwayUgTAtwm+Vzf4=;
        b=O5q9SsDWCJBNHxBiZO2z+fHWyvb9EKeLHJIKa9b4mLWFQKWb47cadl3P7aQsosXMej
         UrUcXuTOQAcPOb6ef5dt2jgIrr1elo7IoVLyJp2hgUhPbpDmVPChqeS5Z42XgluDMALQ
         A09xFKZJNi+Fw8uu9Hd220Rb9Huh8EDFM5MD0lmtJN/hKMFrUSpO1nHsjUuCf3i4o/eO
         hTbGnCk/uhBK7bW5PCV4P1iUO8h0CcXvGuW+rHylxmDFhntArF5OmO1/lfoxKKse8hty
         LH7QE8S152xCDLHxd6zfSgXQ26iL5vaF+sRDcGFNahk1MPrTmmv/UZYPXSbtoonMq5WE
         xkig==
X-Gm-Message-State: AO0yUKVkHmH1qahDUMMoMd7amzNIMW1LSqYFMS2i+/lzC6mw5bn3Las5
        B1j/gfy5jmOfVOXfkKy7xtk=
X-Google-Smtp-Source: AK7set9zoOCU1uIvr79S0/3UQJYEVqaU/WG1dobXEzOMPPQ/se28I4qpUymBHk9y8d6eyaxg7eTI/w==
X-Received: by 2002:a05:6e02:1d10:b0:315:9749:7a25 with SMTP id i16-20020a056e021d1000b0031597497a25mr8616953ila.17.1677109429922;
        Wed, 22 Feb 2023 15:43:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l25-20020a02cd99000000b003af2cdde559sm2002892jap.35.2023.02.22.15.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 15:43:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b1b1b9db-8356-a43e-a01b-73bbef32d3ce@roeck-us.net>
Date:   Wed, 22 Feb 2023 15:43:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: linux-next: manual merge of the hwmon-staging tree with the i2c
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Wolfram Sang <wsa@kernel.org>
References: <20230220090724.6c3d6f87@canb.auug.org.au>
 <20230223103018.08088e0c@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230223103018.08088e0c@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 15:30, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 20 Feb 2023 09:07:24 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the hwmon-staging tree got a conflict in:
>>
>>    MAINTAINERS
>>
>> between commit:
>>
>>    e8444bb9fd77 ("MAINTAINERS: Add HPE GXP I2C Support")
>>
>> from the i2c tree and commit:
>>
>>    d5f80ff774d1 ("MAINTAINERS: add gxp fan controller and documents")
>>
>> from the hwmon-staging tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>> -- 
>> Cheers,
>> Stephen Rothwell
>>
>> diff --cc MAINTAINERS
>> index a58c22a7adc8,98e16168d6e9..000000000000
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@@ -2232,15 -2280,16 +2232,18 @@@ ARM/HPE GXP ARCHITECTUR
>>    M:	Jean-Marie Verdun <verdun@hpe.com>
>>    M:	Nick Hawkins <nick.hawkins@hpe.com>
>>    S:	Maintained
>> + F:	Documentation/hwmon/gxp-fan-ctrl.rst
>>    F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
>> + F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
>>   +F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
>>    F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
>>    F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
>>    F:	arch/arm/boot/dts/hpe-bmc*
>>    F:	arch/arm/boot/dts/hpe-gxp*
>>    F:	arch/arm/mach-hpe/
>>    F:	drivers/clocksource/timer-gxp.c
>> + F:	drivers/hwmon/gxp-fan-ctrl.c
>>   +F:	drivers/i2c/busses/i2c-gxp.c
>>    F:	drivers/spi/spi-gxp.c
>>    F:	drivers/watchdog/gxp-wdt.c
>>    
> 
> This is now a conflict between the i2c tree and Linus' tree.
> 

I mentioned the potential conflict in my pull request, so Linus should
be aware of it when he applies the i2c changes.

Guenter

