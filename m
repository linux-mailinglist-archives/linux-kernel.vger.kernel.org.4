Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94D6093DD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiJWOV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJWOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:21:24 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600BE50708;
        Sun, 23 Oct 2022 07:21:23 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so636672fac.1;
        Sun, 23 Oct 2022 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTAAkkj/PEqEYXCHWGmASpbHjy0heS6WaXHLTcNNRCQ=;
        b=c5LDdOqLDCIMz+hCtZ8Owc1PLjcqMDkHRloTKXi50u5M5blkov+LBRqMLilT02pSgI
         AhJyQizNqnNEtQvsUUay4+PkblK+Es0xSgH/TF6V3LjAkkOvOsfWT46CLc8epx5dGXry
         G5vAtRLLu6D/wR8M5jW1b4jbhb6yTPwFvdjhD/O+8qKyPyseVTQkirg/509O+wZ5YTP0
         eDjiaLW93Jzydpakl26NeGO9jqDyT+9fgDsDKcEsUCMq4rDvLNm5Z+90qk2E9N0mDlkk
         TRv+sEz2tTqodsZxRcqg8axZGlV15FTUUQJxKI2pPQmQGItPBL8zhgHjL/xp3Um3ivcF
         rQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTAAkkj/PEqEYXCHWGmASpbHjy0heS6WaXHLTcNNRCQ=;
        b=A9rUBZj9N7x2idb1aVFoTuMsjKvzWOhnEbfdK0pzca+5Y3stBx0VJIymrL6o8C44oI
         1JwyPqmL2QLUiRA1FF8ngEfOZMDbZstnO9XdmmChWJuxsle4O0cWH8ord12/bSoGRl7n
         fFngr+6ehAVeAsUFDSGLt0vbdxZFDcjO/9HV/OURJrBaYF9zUCikanZ7Myjm4yPUxS9H
         A9gImn6/IVHDL19nNn35lRb937FQ0RoJ1T7KFowajWRIik9KotM7JMrA+5cubzitsYiN
         8jX4gqUyhIvT4X8qdW90SyYiNV2JkgqSys57f5Fy7pDH3mgzRCKTWIZJ1d5+fexIJEQJ
         IhUA==
X-Gm-Message-State: ACrzQf2hDphTmDBnX/Cn4DLMNwMx/uE8E9V0HtvIzTG5z4OWOcvF0EQB
        EQhmVz98saeHBnmmbavq1Og=
X-Google-Smtp-Source: AMsMyM5YuD6L0l9a4P5ALqEGY/7htBU57fOqiFG3zRJqI/Q/kVmMIK+fuKVNidojQsn9n7VKGgREuA==
X-Received: by 2002:a05:6870:3126:b0:132:7416:cb31 with SMTP id v38-20020a056870312600b001327416cb31mr18368629oaa.140.1666534882683;
        Sun, 23 Oct 2022 07:21:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w21-20020acaad15000000b00354932bae03sm2565450oie.10.2022.10.23.07.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 07:21:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1d052998-9ac2-2d4b-927a-06e0318eaef4@roeck-us.net>
Date:   Sun, 23 Oct 2022 07:21:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for temperature
 sensor offsets
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, leonard.anderweit@gmail.com,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221021174834.736930-1-savicaleksa83@gmail.com>
 <20221022135720.GA739650@roeck-us.net>
 <6ef88c2c-3435-8847-0f4f-53e81cd3af5d@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <6ef88c2c-3435-8847-0f4f-53e81cd3af5d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/22 06:15, Aleksa Savic wrote:
> On 2022-10-22 15:57:20 GMT+02:00, Guenter Roeck wrote:
>> Please go up to 100 columns to avoid excessive line splits.
> 
> Will fix this and other comments in v2.
> 
>> Is it really necessary to re-read the control buffer repeatedly
>> to report this value ? I don't know how costly that is, but unlike
>> the pwm value I would not expect the number to change.
> 
> Yes, aside from the driver userspace can also change settings on the
> device using hidraw and we'd end up with stale data. Reading it is
> very fast, it takes about 4ms in my testing.
> 
>> Also, is this number indeed not included in the regular reports
>> sent from the controller ?
> 
> Unfortunately, it's not. The sensor report only includes final (calculated)
> sensor readings.
> 
>> The driver doesn't distinguish between offsets in the control buffer
>> (pwm, and now temperature sensor offset) and offsets in the report buffer,
>> making it a bit difficult to determine if those are the same or not.
>> Some explanation in the driver would be nice if someone finds the time
>> to provide one. If the control buffer offsets are in a different number
>> space, they should really be marked accordingly (for example with a
>> _CTRL in the define).
> 
> I can see how it can be confusing. After this, I can send a patch to
> reorder the macros & initializations and add more comments regarding
> what is what.
> 

Please do.

Thanks,
Guenter

