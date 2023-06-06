Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E749723837
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjFFGwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjFFGww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:52:52 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A593;
        Mon,  5 Jun 2023 23:52:50 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-514924b4f8cso8694117a12.3;
        Mon, 05 Jun 2023 23:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686034368; x=1688626368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bD/cv+4u6UA/Mv15jOTb6k3jF8vZk7ftMwVtzeYdAis=;
        b=ROTKMik8z7C1QW8FTbKAi1oTN2IbgD1yohijen+8QaadjAOyDxn0UP8m/KzF8V8De9
         ft7/GeDFd/7NtVZZb9bntWIFzhrAEVvwerEXPlMxBUyqnPVMS4JUbnmzRDucqsGKQEpg
         TYcTTxJO4cqr+zlJDBBsuSxrP60imNjsK27seFBELKmMLrxCya+2z8e+K9gzNqy95/ip
         3P2/E9LW3E3hGl6ugWpAFJtALzpmoIWn8Kg/dSXErL6oq4MNa6mKOFA32c7EO8N5oQCL
         dvlH8Po6PSYK2p3Y2sRK6CjXfESfTdw/VUKiUZ2xgpT3sq5RFJTogf2FKaWbHy+rKTne
         Al5w==
X-Gm-Message-State: AC+VfDz0ZVBe4H70cvbyPgZrB742rmdzkfp23utC/GTityNE5wGRlrZm
        cFq0RNUmYqKG+hgLWyprsH3+Q+AD0b4=
X-Google-Smtp-Source: ACHHUZ4zlhaaKdX8FkvMXNim5I5Tr/rXOWlHL3uiBgWRPNY4LecEkmb7vD4JvXi9pdp3SjAVL8qgJQ==
X-Received: by 2002:aa7:c515:0:b0:515:4043:476f with SMTP id o21-20020aa7c515000000b005154043476fmr1158843edq.36.1686034368469;
        Mon, 05 Jun 2023 23:52:48 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id d13-20020a05640208cd00b0051643d71ce9sm4175064edz.26.2023.06.05.23.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:52:47 -0700 (PDT)
Message-ID: <0d2a3964-8011-d8d6-8017-1f64bb117ac7@kernel.org>
Date:   Tue, 6 Jun 2023 08:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: make localmodconfig doesn't work for thunderbolt
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, USB list <linux-usb@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <4cb758c7-f4f5-820c-c7e7-5b900ccc2534@kernel.org>
 <CAK7LNATn=8a0F=4Rq2q3vz6-eupkVy6LvYUBLSiGeshujEu0zw@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAK7LNATn=8a0F=4Rq2q3vz6-eupkVy6LvYUBLSiGeshujEu0zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 06. 23, 6:16, Masahiro Yamada wrote:
> On Wed, May 10, 2023 at 8:01 PM Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>> Hi,
>>
>> if I use localmodconfig for example like this:
>> mkdir /tmp/tb/
>> echo thunderbolt >/tmp/tb/lsmod
>> make O=/tmp/tb LSMOD=/tmp/tb/lsmod localmodconfig
>>
>> I get:
>> using config: '.config'
>> thunderbolt config not found!!
>>
>> $ grep 'USB4\>' /tmp/tb/.config
>> # CONFIG_USB4 is not set
>>
>> I believe it's due to:
>>     obj-${CONFIG_USB4} := thunderbolt.o
>> in drivers/thunderbolt/Makefile. I.e. ${} used instead of more common $().
>>
>> But even if I change the parser:
>>
>> --- a/scripts/kconfig/streamline_config.pl
>> +++ b/scripts/kconfig/streamline_config.pl
>> @@ -317,7 +317,7 @@ foreach my $makefile (@makefiles) {
>>           $_ = convert_vars($_, %make_vars);
>>
>>           # collect objects after obj-$(CONFIG_FOO_BAR)
>> -       if (/obj-\$\((CONFIG_[^\)]*)\)\s*[+:]?=\s*(.*)/) {
>> +       if (/obj-\$[({](CONFIG_[^})]*)[)}]\s*[+:]?=\s*(.*)/) {
>>               $var = $1;
>>               $objs = $2;
>>
> 
> 
> Will you send this fix as a patch?

Hi,

ah, yes, sorry, I forgot. Today or tomorrow.

thanks for pinging me,
-- 
js
suse labs

