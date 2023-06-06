Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE67244E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbjFFNv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbjFFNvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:51:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF5FB1;
        Tue,  6 Jun 2023 06:51:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso3571430b3a.3;
        Tue, 06 Jun 2023 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686059513; x=1688651513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/meAPIsis+AXLZEtvKaqLr9I/b5AhX0Z28qNlrQqqbE=;
        b=Fv8s+7TokXGsfeC2LEaAc+xqng0Ju1MaH/xGf16DNJmcLHaJqjmtJJg+abJka+mdy7
         kCsmQ+exiZ7/tFNT8Weswe3ih7jVFwfhViBOVL2uxwXmDkxmhGO7tJCA4D/7hLKBfat7
         LPtv7+bKZFOkxA2z5aEMk3Z+CegOJtXZ6kKlHEv99oN8JGjcPtMYcnUBEZZ57WIKtAhA
         5gpdjrGpVvBq8TGmkm0yrYKhyGhSoXPNrfmG3uGah03YVqpgqEhaxtMrxJtRGIt0eF5Q
         dlHgNS8douww2BSBYItB5qFHtISgzYZkgeLzAg+GjmBLt3zIDVP1SD0dQApsFCYFweec
         X8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686059513; x=1688651513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/meAPIsis+AXLZEtvKaqLr9I/b5AhX0Z28qNlrQqqbE=;
        b=cNKAh1esbs+44HvKOGCVlawyjGOqqAJukeCo5prHsK17sG8VtJolmp8w7JzWt/tzey
         J1TsfqIBphKj9CvVohiDOlkdF7ep4GYSPD15DqaPNSr6CIt3xs/+FSxw9Xtrj3pLyJR9
         N47w3DYgAuHKBSEJWyCeerr4sF+4jk5ql66X7a0ZfaFGBU0qO3fDzVCB0jhgXIlQ1U4o
         TkBxYDHQpEB0fSghH+4O9/XhQ0YNK7JQKqhF1P5eFA6CjBmT86dOy3B/rkGYCtCEbXIm
         jYAYUIjpaGaXN5HI9PCnBnfXZ2STlljHmIwGDr3P1WuccnVVF9c/OsejZIxfVpPYT3qw
         4grw==
X-Gm-Message-State: AC+VfDwFqlMoWlZxWLIamAOWIOPYhiRB/osS1MYARLa4uuKd0sa7ocyC
        sB4qfnjNCrtF8r0tyCDf7dc=
X-Google-Smtp-Source: ACHHUZ7AdTODNyw4dWQnFLD+N5s+hcbMRMZ3B99ZCAjJ5ZMGxXh5YoMjJk7n85NSxLTQnViRgrWobw==
X-Received: by 2002:a05:6a20:258b:b0:10b:dca5:74e5 with SMTP id k11-20020a056a20258b00b0010bdca574e5mr2224688pzd.0.1686059512635;
        Tue, 06 Jun 2023 06:51:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001b0f727bc44sm8518658plh.16.2023.06.06.06.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 06:51:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e9850b67-6c6f-4079-fa35-862b102c8ddd@roeck-us.net>
Date:   Tue, 6 Jun 2023 06:51:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/2] hwmon: (nct6775) Directly call ASUS ACPI WMI
 method
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     ahmad@khalifa.ws, chunkeey@gmail.com, greg@krypto.org,
        hubert.banas@gmail.com, igor@svelig.com, jaap.dehaan@freenet.de,
        jdelvare@suse.com, jeroen@beerstra.org, jonfarr87@gmail.com,
        jwp@redhat.com, kdudka@redhat.com, kernel@melin.net,
        kpietrzak@disroot.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@rebtoor.com,
        metalcaedes@gmail.com, michael@theoddone.net,
        mikhail.v.gavrilov@gmail.com, mundanedefoliation@gmail.com,
        nephartyz@gmail.com, oleksandr@natalenko.name, pehlm@pekholm.org,
        renedis@hotmail.com, robert@swiecki.net,
        sahan.h.fernando@gmail.com, sebastian.arnhold@posteo.de,
        sst@poczta.fm, to.eivind@gmail.com, torvic9@mailbox.org,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20230111212241.7456-1-pauk.denis@gmail.com>
 <CAMuHMdXGO17cKKvwA5sZQ+WBPzdMvghZkvv1gWvQ00X-N+EF9A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAMuHMdXGO17cKKvwA5sZQ+WBPzdMvghZkvv1gWvQ00X-N+EF9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 03:29, Geert Uytterhoeven wrote:
> Hi Denis,
> 
> On Wed, Jan 11, 2023 at 10:24 PM Denis Pauk <pauk.denis@gmail.com> wrote:
>> New ASUS B650/B660/X670 boards firmware have not exposed WMI monitoring
>> GUID  and entrypoint method WMBD could be implemented for different device
>> UID.
>>
>> Implement the direct call to entrypoint method for monitoring the device
>> UID of B550/X570 boards.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
>> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
>> Co-developed-by: Ahmad Khalifa <ahmad@khalifa.ws>
>> Signed-off-by: Ahmad Khalifa <ahmad@khalifa.ws>
> 
> Thanks for your patch, which is now commit c3b3747d02f571da ("hwmon:
> (nct6775) Directly call ASUS ACPI WMI method") in  v6.3-rc1.
> 
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1516,7 +1516,7 @@ config SENSORS_NCT6775_CORE
>>   config SENSORS_NCT6775
>>          tristate "Platform driver for Nuvoton NCT6775F and compatibles"
>>          depends on !PPC
>> -       depends on ACPI_WMI || ACPI_WMI=n
>> +       depends on ACPI || ACPI=n
>>          select HWMON_VID
>>          select SENSORS_NCT6775_CORE
>>          help
> 
> The recent patches to add support for ACPI on RISC-V caused me to
> see a question about this driver again when running "make oldconfig",
> and I had a closer look at the driver...
> Unless I am missing something, this is a really dangerous driver which
> just bangs blindly into I/O space without doing any platform checks,
> which could cause a crash or system lock-up?
> 
> Does the SENSORS_NCT6775 symbol need a better platform dependenc
> than !PPC?
> 

This is no different than all the other SuperIO drivers.

Guenter

