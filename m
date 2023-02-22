Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468369EF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjBVHQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBVHQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:16:40 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A3B36696;
        Tue, 21 Feb 2023 23:16:08 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id da10so27747838edb.3;
        Tue, 21 Feb 2023 23:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NaeMlSFMix0AWDF/IlR9/1jY7K34ruOaDXpt2ygRF7c=;
        b=g3ds6/ellHqJxaoJ3J8BrUfIXmslNqLETg+r085MC++mQLplLYDKd1npNQd9/14e8c
         B06zmrGM/q81jggvjJlzbULIGObc5xwWcUFoCbSut1uth3gzqC2FcBj5l2ccljx0ccZo
         eThscTgazKEE89A5AVyse0a/9gWQC4UZRTsRiivDxkBAqZqXLMPmAQf7q1gUYEt9QznY
         DH5wMMbLXis6xiWfBCeuuwYjD+WT8cI06lhz89Q2aC6JF24yTd0MyBwlsyO3IrV1METV
         ebeGug6sZHzVfthgJNHfpekWBEdLEEEV5r7oIykUe91jDRlbg9ZadnnjJIUU7ipkhMAp
         kVWg==
X-Gm-Message-State: AO0yUKWSCwsDoYAv+dbfxa6ZbZn34xQTHmmVpTRUs6M5uf29tugV+aif
        ZxAFOlk7XJyhxDXhLJekC68AeEW2Bxw=
X-Google-Smtp-Source: AK7set8CCcp8OM6Fa4mVzoPzE0/8ibzcixEaOI1tgCPflIhUXazWIE2qtj7lHQj0Fz54iEBvL7FKKA==
X-Received: by 2002:a17:907:764c:b0:88e:e498:109b with SMTP id kj12-20020a170907764c00b0088ee498109bmr15831335ejc.5.1677050166492;
        Tue, 21 Feb 2023 23:16:06 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709060dd400b008be5b97ca49sm5436500eji.150.2023.02.21.23.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 23:16:06 -0800 (PST)
Message-ID: <4e5aeac3-2a99-8fd5-cf1d-a35870ecd807@kernel.org>
Date:   Wed, 22 Feb 2023 08:16:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 2/2] trigger: ledtrig-tty: add additional modes
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>, kernel test robot <lkp@intel.com>
Cc:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        pavel@ucw.cz, lee@kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
References: <20230221081901.15557-3-fe@dev.tdt.de>
 <202302220740.2RKDHnof-lkp@intel.com>
 <deee30ef43e397233dd15d11b86ae91a@dev.tdt.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <deee30ef43e397233dd15d11b86ae91a@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 23, 7:07, Florian Eckert wrote:
> 
> 
> On 2023-02-22 01:02, kernel test robot wrote:
>> Hi Florian,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on tty/tty-testing]
>> [also build test WARNING on tty/tty-next tty/tty-linus
>> staging/staging-testing staging/staging-next staging/staging-linus
>> pavel-leds/for-next linus/master v6.2 next-20230221]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:
>> https://github.com/intel-lab-lkp/linux/commits/Florian-Eckert/tty-new-helper-function-tty_get_mget/20230221-162126
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
>> tty-testing
>> patch link: 
>> https://lore.kernel.org/r/20230221081901.15557-3-fe%40dev.tdt.de
>> patch subject: [PATCH v5 2/2] trigger: ledtrig-tty: add additional modes
>> reproduce:
>>         #
>> https://github.com/intel-lab-lkp/linux/commit/445b7555bccd279bf106995ee42f5dbef2e97c8b
>>         git remote add linux-review 
>> https://github.com/intel-lab-lkp/linux
>>         git fetch --no-tags linux-review
>> Florian-Eckert/tty-new-helper-function-tty_get_mget/20230221-162126
>>         git checkout 445b7555bccd279bf106995ee42f5dbef2e97c8b
>>         make menuconfig
>>         # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS,
>> CONFIG_WARN_ABI_ERRORS
>>         make htmldocs
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Link:
>> https://lore.kernel.org/oe-kbuild-all/202302220740.2RKDHnof-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> Documentation/ABI/testing/sysfs-class-led-trigger-tty:9: WARNING: 
>>>> Unexpected indentation.
>>>> Documentation/ABI/testing/sysfs-class-led-trigger-tty:9: WARNING: 
>>>> Block quote ends without a blank line; unexpected unindent.
>>
>> vim +9 Documentation/ABI/testing/sysfs-class-led-trigger-tty
>>
>>    > 9    Date:        January 2023
> 
> I apologies for the question! But I don't know what the test buildbot 
> here wants from me.
> I've looked at the other files and I can't find anything that stands out.

sphinx is always misleading.

It's the indentation of all "LED on if ...".

-- 
js
suse labs

