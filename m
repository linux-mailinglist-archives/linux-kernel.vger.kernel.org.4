Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D85641FE9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 22:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiLDVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 16:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiLDVcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 16:32:53 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97296544;
        Sun,  4 Dec 2022 13:32:52 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1442977d77dso10287887fac.6;
        Sun, 04 Dec 2022 13:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kljJ4RzgvM2q+VPiZHXWFDSN1hYWKqhRugd9yYXPieU=;
        b=KvfIlJEJyUBlgHwuV8Y8mtaUUvDhggluwetYO6hydTBYYKmqWNQZ4ewY1gxJpluDHT
         EZb3BAnGNM87Brui3oXpE+FL+dy07vTz0FmeWS5I5TJ/YytNlGJl+Q/ni6N+RjQXtvOe
         ScFcrtmbVilO1oEGiJhF2DBBZrCz91uACNPpZc3t2TJK0vQQ0GbGsZQdXs5ohIXmSKb2
         /c5LmWYrHEJowEi8L7x7NH60ajlbB3ch8xlS2tn55YBo6pCXEl0ZssojOvtmrBl7coeJ
         GSO1dhQzytfAyCzSYE2gByxsPYztkkOwtGn7duM5454eXlq47U9spi5WHWZv6tT5oWga
         e1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kljJ4RzgvM2q+VPiZHXWFDSN1hYWKqhRugd9yYXPieU=;
        b=o6gKrhKe2GMaseXMOJuL/S1vsh++SBeKGePMOy1LswEbFaUiv1rq211jcvf8o41gMi
         j2YxNL++MLscdL7v5bCm8WXWzMVpXETpQIgFJemUttDhopZzmmmaoBWPKZs3FvfJZZIW
         bdtv+DobWVavYQl3dOJFKlfWPXsbfIody5yMqWlAXTPQRIzzJ9FvCcoo67ALEAJtoU1y
         Zw4VxmobPheMxcrTxXs3tqLyRvt9Dg1zLc/tXbvr5LPQ3p/FMm0rYY3dCQjFA0D7Wh1j
         48zQ+IHxTsvZECU6kBUIcFJqXInqU2h3eOP9aKwE8s4UCnL2KFJSmlU4duxcPr2sC64m
         b96g==
X-Gm-Message-State: ANoB5pm8UZAzvnAsBHmH7N0l1g61zHEfHWPXMIEJUgYX+mYnJBItMj7j
        VYw6jq4X05To5wfHsSZ3o+N1BkeEZA0=
X-Google-Smtp-Source: AA0mqf6XzQZ6JTSedBgwXlB1/2vTeOLlHC3tbYCuFE3sI/0Q0DMzOZ5Iqc/oN9t87Lx93cp7H5TlQg==
X-Received: by 2002:a05:6871:4494:b0:142:6cb4:8b3a with SMTP id ne20-20020a056871449400b001426cb48b3amr34785050oab.190.1670189572261;
        Sun, 04 Dec 2022 13:32:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r15-20020a4a964f000000b00499527def25sm5762678ooi.47.2022.12.04.13.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 13:32:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8eadc1cb-3648-b0b8-0250-9b745bb8b71d@roeck-us.net>
Date:   Sun, 4 Dec 2022 13:32:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-hwmon@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <Y4zfBRahZJ0QM758@zn.tnic>
 <1085cc7c-00af-83f3-7da6-7820143b162e@roeck-us.net>
 <Y4zxSEo4OhZUd2OU@zn.tnic>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: CONFIG_SENSORS_OCC_P8_I2C
In-Reply-To: <Y4zxSEo4OhZUd2OU@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/22 11:13, Borislav Petkov wrote:
> On Sun, Dec 04, 2022 at 10:37:09AM -0800, Guenter Roeck wrote:
>> I don't immediately see why this should depend on a P8 configuration.
>> The driver runs on a BMC, after all. My understanding is that a BMC can be
>> of any architecture. Is there a guarantee that there are and never will be
>> any x86 BMCs, and/or that BMCs are limited to a certain subset of
>> architectures ?
> 
> Well, then it should depend on the architectures which are currently
> running BMCs for P8 machines. ARM maybe?
> 
> At least on x86 the majority of BMCs are ARM-based AFAIK.
> 

We are not typically that restrictive in the hwmon subsystem. That isn't done
for many of the other drivers which are typically only used on x86 either.
Why is that suddenly a problem ? Just don't enable it if you don't need it.

Anyway,

commit 58c0399db8bf6bf88c7580b742b0cb45e02f55d5
Author:     Jeremy Kerr <jk@codeconstruct.com.au>
AuthorDate: Mon Oct 24 16:15:27 2022 +0800
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Thu Dec 1 09:21:06 2022 -0800

     hwmon: (occ) OCC sensors aren't arch-specific

     Commit c112d75840fb ("hwmon: OCC drivers are ARM-only") made the OCC
     sensor drivers not selectable on powerpc64:

       These drivers are for a BMC inside PowerPC servers. The BMC runs on
       ARM hardware, so only propose the drivers on this architecture, unless
       build-testing.

     ... but we now have a powerpc64 BMC (still for a powerpc64 host), so
     drop the `depends on` that excludes building for this platform.

     Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
     Acked-by: Joel Stanley <joel@jms.id.au>
     Link: https://lore.kernel.org/r/20221024081527.3842565-1-jk@codeconstruct.com.au
     Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I really don't want to end up in a situation where I constantly have
to deal with changing architecture support, so I would strongly prefer
to keep it that way unless it is a real problem.

Guenter

