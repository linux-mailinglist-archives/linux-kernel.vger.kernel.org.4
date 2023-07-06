Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A7174A070
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjGFPII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGFPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:08:04 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D958F;
        Thu,  6 Jul 2023 08:08:03 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5704fce0f23so10303337b3.3;
        Thu, 06 Jul 2023 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688656083; x=1691248083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fhKDXfNLksqjPbDJ1dryLnVoY0PienNmWQ0YtHQqD1I=;
        b=cdpMYjK8EOXOKUGX8wEDIslNunNJVXrnK/gnMwT3qmLxLZdOXwyHUrP/zyHbTUu4yq
         qHijdNhXHwivyGMJzeShXCK4Dbeuucu4+ro82RDUq607vtg/QM76jWu+j+Tznf5wQwVg
         viZVaQykW+raKwQFZifZYBfKw3Ynii1v1klbFy3kze44My/16/NZhEtip8fPYGs3NTbM
         ddM37ItfIEl0JFio0WdYsshFydC81SABjCT9iwJEJccyr0BcnQko0yFpkT0SAyG3JZIH
         v1xKiqvJCUrB8LGuRJEDK9427xFM/TNW4qTbcIaXhILup6adPuNGG89EYT18otXbXmP8
         I/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688656083; x=1691248083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhKDXfNLksqjPbDJ1dryLnVoY0PienNmWQ0YtHQqD1I=;
        b=kaOquPmdBwj4j0zFd/i3pTDaMUnbQtRAjzH+mdWHiEDx1Tlotg1Pw8fyUKkGNvih1U
         XCI0l7CDbseVeFLHToMFUNJ9sIUYISpfmM1xsYNreHrGUx1q3sbTzfCozN2pNKQXq/PQ
         W0QInkTmtIJu3c3+8MqNi4mNcqP+N9EC1vEi8C7/iGdrtCkpNRbXjrWfmln3FpoOv7YD
         Cb7Teicy38O7a+IfCw5uRRgQ/OUBWrmYQ9AJPBpVb+NhbUjsyVqCHSSrlQHTRHCI3QvG
         3djkVVy5rLDZOdk31WceP7jLqk9JlYLbxCN+ZTcTmvAMhnnkhUV4qthmKCDIAKj/BP6x
         fCkA==
X-Gm-Message-State: ABy/qLaWlP5Ah/YTgLDKrX93Ry0Z9zSBoeXRc2iHE7zv7txuzoIXgTd4
        obfDx42tfUNQzTJV6pVaZuU=
X-Google-Smtp-Source: APBJJlH3E+K3Y578inZxgbxd9/+HY82YZzYskjgsODqMpD6kh5DlGQOppMs+gucEq/9oN2gxrbaN2g==
X-Received: by 2002:a81:62d5:0:b0:577:1e1e:c950 with SMTP id w204-20020a8162d5000000b005771e1ec950mr2602482ywb.9.1688656082994;
        Thu, 06 Jul 2023 08:08:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a124-20020a0df182000000b00568b941e5e3sm399514ywf.72.2023.07.06.08.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:08:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3da1af1f-58e1-cb54-a959-1dfd6b8a1222@roeck-us.net>
Date:   Thu, 6 Jul 2023 08:08:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [GIT PULL] sh updates for v6.5
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
 <9bc72d0c-fe33-5759-799c-f54e325ba38d@roeck-us.net>
 <ab09d99c78bd378f23580427323c6418cd0888af.camel@physik.fu-berlin.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ab09d99c78bd378f23580427323c6418cd0888af.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/6/23 07:04, John Paul Adrian Glaubitz wrote:
> On Thu, 2023-07-06 at 07:01 -0700, Guenter Roeck wrote:
>> Perfect example why it is a bad idea to let build failures linger around.
>> The build failure fixed by this patch ...
> 
> How was that lingered around? Your patch was merged within less than a week.
> 

The _build failure_ was lingering around, not my fix for it.

>>> John Paul Adrian Glaubitz (1):
>>>         sh: j2: Use ioremap() to translate device tree address into kernel memory
>>>
>>> Masahiro Yamada (4):
>>>         sh: Fix -Wmissing-include-dirs warnings for various platforms
>>>         sh: Move build rule for cchips/hd6446x/ to arch/sh/Kbuild
>>>         sh: Refactor header include path addition
>>>         sh: Remove compiler flag duplication
>>>
>>> Sergey Shtylyov (1):
>>>         sh: Avoid using IRQ0 on SH3 and SH4
>>>
>> ... was hiding boot failures with all my qemu emulations caused by
>> this patch.
> 
> But Sergey's patch had been in my for-next tree since June 11 [1].
> 

The build failure was introduced into linux-next with commit 99b619b37ae1.
According to the commit log, that happened around June 9. Ever since then
all sh builds in linux-next failed.

Guenter

