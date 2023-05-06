Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012336F9250
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjEFNwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 09:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 09:52:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FD923A0C;
        Sat,  6 May 2023 06:52:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517bfdf55c3so1376038a12.2;
        Sat, 06 May 2023 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683381132; x=1685973132;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nH3aciUcYWZij0Kp0FJnKmzfOIAjxDn8kv06DNsAoc4=;
        b=nFGY9DUNTbIBD4xuCbyXHOZsu/e7ssdk1yHYQNn1nqG2smiH9Hr5OskB9rYX+sVv4P
         VrMPvmGIhKGj+K7F2fTIzQ47cwpxBUcOF54ea0s9zuFyGbhKA+2q3/C0NCY3tB8WJBsC
         el97UOOOGE3CVv0iWYT9QrAOl8QMurB6/rk7mmozjN9wJ8IbQHOWu/gZcEIxOPtGN9F2
         KZbbMqJGkaSYhzjt+BtcQ09x52TGhnrsA5C1PIT/OVdEx9L7NWa4DD8PvkbAUdcNOc1R
         t4JQZKzdEwiEQ6kpY+jeBNG7UBVR1keBDgbfoY+SXS3kHTqX4VDAOen+uI4Ql3/LhODi
         n9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683381132; x=1685973132;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nH3aciUcYWZij0Kp0FJnKmzfOIAjxDn8kv06DNsAoc4=;
        b=Am9PP2i5hOMeYuxTBJgFaYZU1fFTcTOfE9nxVv+XchPflsa6tEFKhe18+hYel7KgJe
         jxjJV67aVl0z9jRovUh0Z03RvxvbDCsRbUGsAHx3Wu2b1MwDSXfSR3BgP+SnSm3eZPDX
         wci81xnQ5J2X6unxii15O/Y1pdllGblQLaDTaN27iJ1YrfWXhrf0MfHYLqmohJGOGrrX
         yN9AmWEHYv0EcfiRX8c+xc0outvdT8dzUTCzsSo1BTV2Fy/LEwZ+CflHyPuVOxmaHVJr
         K5DstzFWrwyfYjUd02PoeIKzC8LTkOLXHubpLsfwkleSmnVf4Qm9trZAdA6+zcUBeqwb
         Jx+Q==
X-Gm-Message-State: AC+VfDz99Asl8ThelAm5eDUdj9XwKgVQIoxdMYM1SU92d1IE2U4m6QtM
        e8YRTrY8wkY+3Yx+rQH+bao=
X-Google-Smtp-Source: ACHHUZ5ZjsuG/vBhxtPHtJ+TD1wVNZ7JcjiMlPbOoWxS4CvZTYdmRhVZ2rnTP8zM8NydKL4Y6ksTGw==
X-Received: by 2002:a17:90a:eb15:b0:23d:286:47d3 with SMTP id j21-20020a17090aeb1500b0023d028647d3mr4699619pjz.40.1683381132058;
        Sat, 06 May 2023 06:52:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090ad14f00b0024b6a90741esm6619646pjw.49.2023.05.06.06.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 06:52:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <512351f8-e571-620a-1b2b-54989c079803@roeck-us.net>
Date:   Sat, 6 May 2023 06:52:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-5-james@equiv.tech>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC 04/11] Documentation/hwmon: Revise hwmon kernel API
 reference
In-Reply-To: <20230504075752.1320967-5-james@equiv.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 00:57, James Seo wrote:
> Reorganize content into coherent sections.
> Use kerneldocs to document functions and data structures when
> possible and add more details on using various API facilities.
> Fix minor issues (typos, grammar, etc.) and add markup.
> 
> Signed-off-by: James Seo <james@equiv.tech>
> ---
>   Documentation/hwmon/hwmon-kernel-api.rst | 740 ++++++++++++-----------
>   1 file changed, 384 insertions(+), 356 deletions(-)
> 
> diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
> index c2d1e0299d8d..cf084e040522 100644
> --- a/Documentation/hwmon/hwmon-kernel-api.rst
> +++ b/Documentation/hwmon/hwmon-kernel-api.rst
> @@ -1,374 +1,402 @@
> +========================================
>   The Linux Hardware Monitoring kernel API
>   ========================================
>   
>   Guenter Roeck
>   
> +.. contents::
> +
>   Introduction
> -------------
> +============
>   
>   This document describes the API that can be used by hardware monitoring
>   drivers that want to use the hardware monitoring framework.
>   
> -This document does not describe what a hardware monitoring (hwmon) Driver or
> -Device is. It also does not describe the API which can be used by user space
> -to communicate with a hardware monitoring device. If you want to know this
> -then please read the following file: Documentation/hwmon/sysfs-interface.rst.
> +This document does not describe what a hardware monitoring (``hwmon``) driver
> +or device is, nor does it describe the API for communicating with a hardware
> +monitoring device from userspace. For more information on these topics,
> +please read Documentation/hwmon/sysfs-interface.rst.
>   

There is a lot of nnecessary churn in your patches, where you reformat entire
paragrahps just to add a few "``". This makes it almost impossible to identify
the actual changes. For me it means that the review burden is so much that I'll
probably never get to actually review those changes.

Please split the changes into subjects, following the "one logical change per
patch" rule, and please refrain from changing entire paragraphs when adding
markups. Also, a reference to the markup rules explaining if and when markups
are warranted would be nice. For example, I have no idea why "hwmon" would
warrant a markup.

Guenter

