Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810FF5FD3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJMEfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJMEfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:35:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B0D38FF;
        Wed, 12 Oct 2022 21:35:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h13so908138pfr.7;
        Wed, 12 Oct 2022 21:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+t/wRO7cDS+JStmRGsK3eGMJ7JaSW3Y+vh0orEs5wo=;
        b=NbUixCsympOyyxmgxJtLOMjMaEDxuMw/tv4quYnj4+R8R5fFBDfdh49sKZX5a0E6yn
         ThsjXhf2MxE7YQyhKqGr6s1wAQiR/GnN3SYIiRd7/HX3rPAiIW3/GXVhso97PnDTWbN7
         FD9lUwelyDWMaRq2ky4g2YyI+YRrNfqPgn3ZpiQ3sZLp0zcqhSYPpYzvSqfiqFQC7Zht
         ZbHMRipeAhd/8zPU6ltEioRT5Yy31nGxnD6kMbWNhz1wpdtqbkzdrsGNr/I8mqbY5wEE
         Mpu60rqensiGRsbLvH5xuwXQOdoW18+jHucaK11VZ/hTKYBFwsMuEBuSNswRKmTqsljx
         rKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+t/wRO7cDS+JStmRGsK3eGMJ7JaSW3Y+vh0orEs5wo=;
        b=Sm357DEonMHzvehiBkt8fKwS54d58ok2d6jnjUv8IjfskpUn1dqnyv0bNtBNYQtfQO
         s3V2szNJVdsDjK0Nf+kiPBjdYVOzEvFucsXGIz92RvhG1+LsPBS9cfzBGdtGHwU/k4o5
         0GriSUaefCS2s2O5GCv3HdON7QA23P9HfvVCuyE8uQ7eSWly4K+kEWFV4RfJtGKnEcwO
         mojI1iT3MjxyHplrGSZRQwrAPagj4iBtANmLcxnXCwaHFwQ+h8wbOzjmL+bHjWivGpyz
         M6su8raz7L4xvqVHV1P1Ac6QwLZxlyY3KhUu6eU23MzjLTMnd5MmXVIlEu8B0S5OagyW
         ge5w==
X-Gm-Message-State: ACrzQf3xgQa60sPOkH+fYo3F1BiMjqNC03ybtTwNqLQ20M14GCf+4YKP
        YMRJ2j2iZn+lft+qJm7RTvk=
X-Google-Smtp-Source: AMsMyM7e9Uu3ZmV2fHhuIulvRHyJNR2d25sYlKpkRXZWFMBbM8IFY6zxNvhyHSo+OtgHXagNhwW6wg==
X-Received: by 2002:a62:164d:0:b0:562:bc4e:253 with SMTP id 74-20020a62164d000000b00562bc4e0253mr31393932pfw.26.1665635727277;
        Wed, 12 Oct 2022 21:35:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a19-20020aa795b3000000b0056246403534sm751299pfk.88.2022.10.12.21.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 21:35:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <22ea65b3-5832-c340-195d-058cf3c34f8d@roeck-us.net>
Date:   Wed, 12 Oct 2022 21:35:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     karthik gengan <gengankarthik@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAAboHLVgQKzNVU6XDWGZmnxGK0DGvtgyzMsY9V+UiOJVq1JyTg@mail.gmail.com>
 <085e90e5-d21e-9068-a2e1-6f7e07fa64df@roeck-us.net>
 <CAAboHLU8a9vztdM2b8+Y2ZUAs0+fD4HgwV2X_ASRa=SnWJXTwQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] [v1 1/1]hwmon:(pmbus) Validate the data for chip
 supporting vout_mode (PMBUS_HAVE_VOUT) in the linear config.
In-Reply-To: <CAAboHLU8a9vztdM2b8+Y2ZUAs0+fD4HgwV2X_ASRa=SnWJXTwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 20:42, karthik gengan wrote:
> Hi Guenter,
> 
> Thanks for your response but I need some more valuable suggestions...
> 
>          In the pmbus_data structure, we are updating the vout_out mode
> value based on the config ( linear, vid .direct) and this structure is declared
> in pmbus_core.c .so the low-level driver could not able to access this
> structure.
> 
> Guidance required,
>       1. Move the pumbus_data structure declaration to pmbus.h, so that low-level
>            the driver can check and update the vout_mode if the value
> is not proper.   (or)
>       2.  if the vout_mode attribute value is exposed in the sysfs, the
> user-level application
>            can modify the value. ( if the value is not proper).
>                                 (or)
>        3. if an ioctl call is exposed for the vout_mode then the
> user-level application can
>             able to update the value. ( if the value is not proper).
> 
> (or)  guide me to a better approach to handle this issue.
> 

Have a look at drivers/hwmon/pmbus/stpddc60.c. That chip reports a wrong
value for PMBUS_VOUT_MODE, and the driver provides the expected value
to the PMBus core. Taking that as example, the simple solution is to have
the chip driver report the expected value. There is no need to get
userspace involved. Actually, involving userspace would be completely wrong.

> For reference,
>            UCD90xx vendor claims that vout_mode value should be present
> if the chip
> supports PMBUS_VOUT_MODE command. Hence the patch validated the vout_mode
> value for PMBUS_VOUT_MODE supported chip.
> 

Not sure if I understand, but if any of the chips supported by the ucd9009
driver does not support the VOUT_MODE command or reports a wrong value,
just extend ucd9000_read_byte_data() to report whatever value the command
should return.

That would need some confirmation, though - I don't recall any such problem,
and  UCD90xxx Sequencer and System Health Controller PMBUS Command Reference
(SLVU352) clearly states that the command is supported.

Guenter
