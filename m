Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B339E5F4BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJDW0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJDW0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:26:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B156A24F16;
        Tue,  4 Oct 2022 15:26:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a26so31851742ejc.4;
        Tue, 04 Oct 2022 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gxxCPoTuJMOSZWV7ZoohoQIwVCcKKPT3+VrlbE6R128=;
        b=iLhO6i0YDFgtJ3lLa6aCTzogDHhcGnplnt/nJPPuTrLHeAgaMd3YUHC9L/PjE4By+h
         Y1VEZtSqa8rVMry2b0Mxd14zJNERCqyrUOXZ+8uuDom7JFNdZSRSnaHGngVGImCuEMZu
         wgCP6PJHwsqpmGD4LMSJkOOWOUGh397bYsnQLUTz7/d1QOgVLAxkux1ydtow83Q9lMVp
         +gxygruYjzzyA7s6pE+hoGfe7mMXS/zgOv3hlEHAcDKwS9m27yj0DxmVT0HynxXyFN7r
         knJII+JdxWkKdH1Spp3VFISVS0O9PWWJ6QPgFNTApyQtNoLZXnhXXCl5k5Co/wFGKK8y
         OtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gxxCPoTuJMOSZWV7ZoohoQIwVCcKKPT3+VrlbE6R128=;
        b=IsS5GAM4qYRR6zDyNESj4oRdvqCq9NpOgYGEXZpep6+KrzVk+yesCCtdFVFDIQ/GP8
         H72diBs3qTzI3ALlHX3XDRTmU8+o31dTYqSVyz47sX+W3REIlbpEjoAJSpcGHSHsJlHb
         MOmOFTW9wHikLyN/kwtuiE4o63rMidxgPqiCcf2z7rDc1VdozkIz5S7zUV50LpKK3txD
         l1xaVzh8l80Css6P7Xi6XFdtmIlmcJs6OqGfNmy5k2jLrsMXfZbU8P6Y8uzevv/ZRCva
         a588mmOfdNRsTPuFPm4ITZA8gr09vUPi+Vuij+JeLyp+7Cgc+nnW6RvBDsml0kGF8OAJ
         r15A==
X-Gm-Message-State: ACrzQf2oL/6IDyXYBxPwDZnSePPPvKkIw9jrUK9Q+O4X56t4GtxzaANX
        90pS6rrEoB5Wt6InLg0AHDY=
X-Google-Smtp-Source: AMsMyM6wV8D2Hq+wrMII6GokNk6Shwto13MWWaKZrUkboyIRUSt2gcKGXbr8vSfMF7rXAaWgWW37xA==
X-Received: by 2002:a17:907:3da0:b0:787:89cc:faab with SMTP id he32-20020a1709073da000b0078789ccfaabmr20888608ejc.92.1664922375108;
        Tue, 04 Oct 2022 15:26:15 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a06:125d:3a8d:82a2:428d? (p200300c78f3e6a06125d3a8d82a2428d.dip0.t-ipconnect.de. [2003:c7:8f3e:6a06:125d:3a8d:82a2:428d])
        by smtp.gmail.com with ESMTPSA id g25-20020a056402321900b004542e65337asm2471215eda.51.2022.10.04.15.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 15:26:14 -0700 (PDT)
Message-ID: <439cda66-dd61-abc8-3154-16404e6b1658@gmail.com>
Date:   Wed, 5 Oct 2022 00:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] media: atomisp: Fix spelling mistake "modee" -> "mode"
Content-Language: en-US
To:     "Colin King (gmail)" <colin.i.king@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004161336.155337-1-colin.i.king@gmail.com>
 <73a3969a-d821-f3ee-78ce-df2fedefecdb@gmail.com>
 <b9ef993d-dd37-05da-9095-e27c403ce1ab@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <b9ef993d-dd37-05da-9095-e27c403ce1ab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 23:52, Colin King (gmail) wrote:
> On 04/10/2022 22:25, Philipp Hortmann wrote:
>> On 10/4/22 18:13, Colin Ian King wrote:
>>> There is a spelling mistake in a literal string. Fix it.
>>>
>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>> ---
>>>   .../media/atomisp/pci/css_2401_system/host/pixelgen_private.h   | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git 
>>> a/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h 
>>> b/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h 
>>>
>>> index 1c7938d8ccb5..8f79424bedb2 100644
>>> --- 
>>> a/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h 
>>>
>>> +++ 
>>> b/drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h 
>>>
>>> @@ -161,7 +161,7 @@ STORAGE_CLASS_PIXELGEN_C void 
>>> pixelgen_ctrl_dump_state(
>>>                state->syng_stat_fcnt);
>>>       ia_css_print("Pixel Generator ID %d syng stat done  0x%x\n", ID,
>>>                state->syng_stat_done);
>>> -    ia_css_print("Pixel Generator ID %d tpg modee  0x%x\n", ID, 
>>> state->tpg_mode);
>>> +    ia_css_print("Pixel Generator ID %d tpg mode  0x%x\n", ID, 
>>> state->tpg_mode);
>>>       ia_css_print("Pixel Generator ID %d tpg hcnt mask  0x%x\n", ID,
>>>                state->tpg_hcnt_mask);
>>>       ia_css_print("Pixel Generator ID %d tpg hcnt mask  0x%x\n", ID,
>>
>>
>> This is typically to pedantic for a patch.
>>
>> You can fix same type of issues at one time. Do not make your patch to 
>> long.
>>
>> Use checkpatch.
>>
>> Bye Philipp
>>
>>
>> ./scripts/checkpatch.pl --file 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h
>> CHECK: Lines should not end with a '('
>> #32: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:32: 
>>
>> +STORAGE_CLASS_PIXELGEN_C hrt_data pixelgen_ctrl_reg_load(
>>
>> WARNING: please, no spaces at the start of a line
>> #33: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:33: 
>>
>> +    const pixelgen_ID_t ID,$
>>
>> WARNING: please, no spaces at the start of a line
>> #34: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:34: 
>>
>> +    const hrt_address reg)$
>>
>> CHECK: Lines should not end with a '('
>> #38: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:38: 
>>
>> +    return ia_css_device_load_uint32(PIXELGEN_CTRL_BASE[ID] + reg * 
>> sizeof(
>>
>> CHECK: Lines should not end with a '('
>> #46: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:46: 
>>
>> +STORAGE_CLASS_PIXELGEN_C void pixelgen_ctrl_reg_store(
>>
>> WARNING: please, no spaces at the start of a line
>> #47: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:47: 
>>
>> +    const pixelgen_ID_t ID,$
>>
>> WARNING: please, no spaces at the start of a line
>> #48: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:48: 
>>
>> +    const hrt_address reg,$
>>
>> WARNING: please, no spaces at the start of a line
>> #49: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:49: 
>>
>> +    const hrt_data value)$
>>
>> CHECK: Lines should not end with a '('
>> #69: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:69: 
>>
>> +STORAGE_CLASS_PIXELGEN_C void pixelgen_ctrl_get_state(
>>
>> WARNING: please, no spaces at the start of a line
>> #70: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:70: 
>>
>> +    const pixelgen_ID_t ID,$
>>
>> WARNING: please, no spaces at the start of a line
>> #71: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:71: 
>>
>> +    pixelgen_ctrl_state_t *state)$
>>
>> CHECK: Lines should not end with a '('
>> #133: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:133: 
>>
>> +STORAGE_CLASS_PIXELGEN_C void pixelgen_ctrl_dump_state(
>>
>> WARNING: please, no spaces at the start of a line
>> #134: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:134: 
>>
>> +    const pixelgen_ID_t ID,$
>>
>> WARNING: please, no spaces at the start of a line
>> #135: FILE: 
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h:135: 
>>
>> +    pixelgen_ctrl_state_t *state)$
>>
>> total: 0 errors, 9 warnings, 5 checks, 184 lines checked
>>
>> NOTE: For some of the reported defects, checkpatch may be able to
>>        mechanically convert to the typical style using --fix or 
>> --fix-inplace.
>>
>> drivers/staging/media/atomisp/pci/css_2401_system/host/pixelgen_private.h 
>> has style problems, please review.
>>
>> NOTE: If any of the errors are false positives, please report
>>        them to the maintainer, see CHECKPATCH in MAINTAINERS.
>> kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$
> 
> 
> So for a simple 1 char change I need to clean up everything else that is 
> legacy cruft that checkpatch warns about.
> 
> I'll decline. I just wanted to correct a simple typo, I've never faced 
> this kind of extra work to do in the past 3900+ patches I've submitted.  
> :-(
> 
> Colin

I am very sorry. I am wrong. I thought people like you do not send such 
patches.

I should have looked you up. My fault.

Bye Philipp



