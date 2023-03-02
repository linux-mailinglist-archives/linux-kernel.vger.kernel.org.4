Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCCC6A7A23
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCBDoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBDoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:44:10 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73ED199CC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:44:08 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l13so16829648qtv.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 19:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mQQWQ0QpJBc3je7KutpjYJ3sQ0eek1XLz027wHmEQc=;
        b=DHwtadMw/OrS63w0GQ/Zv/CqMSLqLn+etKj7T9vwzgGrPidTsWUf+RWzeIcNvg0vd2
         X8l3RS8MKCnoCKymkXmmMvW5CJcgZTfNBOfgqmuWiwBwvjs3YCaDcOC71tay6KcXtiwS
         HlzmAbKdv3nGfrwRQx0JWWJ5ZFiS5R0N9hm00kcqKdKd8yREDRs0RWxL42GUUw+3Ngf8
         kAlgXJz8Nwm/WpNGEN3nLJgsnlJZLsKNl5hYHUTHgzvz/HtxA/huqt9maU5+vgbwtiib
         JCXF1ct3mUewcFSS5Y4ikWyCUQKnONefh/8TaonRPqifJ/e4tJRBdAgs7C/1/qwqAXPS
         vg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mQQWQ0QpJBc3je7KutpjYJ3sQ0eek1XLz027wHmEQc=;
        b=BUuJB5ub9yie9TE5ifKrFOSKB3DBEqH3nXMQlf0XxjlaU21KW0TtmoFwcq5YhoTs14
         7qid34sP6wy7LEaAft3Ebhye1Wx4TyM48ns+fcO0sn8bq1xM9C9JX67yYbDBjGktyZfZ
         PTE4Ynb/r9jEtu0dnQxUzYP0Mq+rlZBPNYPDmWh6yKwKvCPPpvxrU9h/IAPxR0A8mIjb
         7qSxHKq7Hypyml4lxCCV0WZQlHmNgf5fHxSvspFxK0aJx+8TKxzRDpGWLl8ncBpgou/g
         9xYzt7HhCnO+81YovWzsESWQDH6zFtezWvX/wQFCuYpVZKltLG7kOnTgF8Ds14VZspcC
         zgaw==
X-Gm-Message-State: AO0yUKVKA+mdo50YsFgwzsNjZs04eo8JhHt6ylrlPB8T6nP/lTeuyzWm
        E6tfSB+tZZgx4WrqeTy3R2Nag09wOBRVLv+qVvDHmnM3jhsm6AcSH/BsIxlv5P2MeTMH9dn4wpQ
        0cS7z6+vypXLhtashSls=
X-Google-Smtp-Source: AK7set8CpUzq8g90UOmFq8VsipXa/6ZvF13DGEytpa7CzIZBTnvyMe7Ejf9+dLJM91gAI1RS7IgYig==
X-Received: by 2002:ac8:5a56:0:b0:3bf:ce15:ff2c with SMTP id o22-20020ac85a56000000b003bfce15ff2cmr15375101qta.20.1677728647867;
        Wed, 01 Mar 2023 19:44:07 -0800 (PST)
Received: from ghost.leviathan.sladewatkins.net (pool-108-44-32-49.albyny.fios.verizon.net. [108.44.32.49])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a025b00b0073b575f3603sm9989340qkn.101.2023.03.01.19.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 19:44:07 -0800 (PST)
Message-ID: <6bae12cb-f15e-e50f-7c77-016f94aa8fdd@sladewatkins.net>
Date:   Wed, 1 Mar 2023 22:44:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/4] extcon: Added extcon_alloc_cables to simplify
 extcon register function
Content-Language: en-US, en-AU
To:     Bumwoo Lee <bw365.lee@samsung.com>
References: <20230220054513.27385-3-bw365.lee@samsung.com>
 <20230220054513.27385-1-bw365.lee@samsung.com>
 <CGME20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925@epcms1p3>
 <20230224100325epcms1p3e8886e278e23f610c8490cb69f1d452d@epcms1p3>
 <091101d94ca7$a4ad23c0$ee076b40$@samsung.com>
Cc:     'Chanwoo Choi' <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        linux-kernel@vger.kernel.org, Slade Watkins <srw@sladewatkins.net>
From:   Slade's Kernel Patch Bot <KernelPatchBot@sladewatkins.net>
In-Reply-To: <091101d94ca7$a4ad23c0$ee076b40$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SWM-Antispam: Scanned by proxmox-gateway.frozen.leviathan.sladewatkins.net
X-SWM-Root-Server: frozen.leviathan.sladewatkins.net
X-SWM-TLS-Policy-Status: enforced
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 20:38, Bumwoo Lee wrote:
> Hello.
> 
> As you can see, edev->cables are freed if extcon_alloc_cables() function return error handling in extcon_dev_register()
> Other added functions are also same.
> 
> Because it's functionalized, apart from this, do you want to mention that it should be freed within the function? 
> Please let me know your opinion.
> 
> extcon_dev_register(struct extcon_dev *edev){
> ...
> 
> 	ret = extcon_alloc_cables(edev);
> 	if (ret)
> 		goto err_alloc_cables;
> 
> ...
> 
> err_alloc_cables:
>  	if (edev->max_supported)
>  		kfree(edev->cables);
> 
> 
> Regards,
> Bumwoo

This is Slade's kernel patch bot. When scanning his mailbox, I came across
this message, which appears to be a top-post. Please do not top-post on Linux
mailing lists.

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

Please bottom-post to Linux mailing lists in the future. See also:
https://daringfireball.net/2007/07/on_top

If you believe this is an error, please address a message to Slade Watkins
<srw@sladewatkins.net>.

Thank you,
-- Slade's kernel patch bot

> 
> -----Original Message-----
> From: MyungJoo Ham <myungjoo.ham@samsung.com> 
> Sent: Friday, February 24, 2023 7:03 PM
> To: Bumwoo Lee <bw365.lee@samsung.com>; Chanwoo Choi <cw00.choi@samsung.com>; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v2 2/4] extcon: Added extcon_alloc_cables to simplify extcon register function
> 
>> --------- Original Message ---------
>> Sender : 이범우 <bw365.lee@samsung.com>Product S/W Lab(VD)/삼성전자 Date : 
>> 2023-02-20 14:45 (GMT+9) Title : [PATCH v2 2/4] extcon: Added 
>> extcon_alloc_cables to simplify extcon register function
>>
>> The cable allocation part is functionalized from extcon_dev_register.
>>
>> Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
>> ---
>> drivers/extcon/extcon.c | 104 +++++++++++++++++++++++-----------------
>> 1 file changed, 59 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c index 
>> adcf01132f70..3c2f540785e8 100644
>> --- a/drivers/extcon/extcon.c
>> +++ b/drivers/extcon/extcon.c
>> @@ -1070,6 +1070,61 @@ void extcon_dev_free(struct extcon_dev *edev)  }  
>> EXPORT_SYMBOL_GPL(extcon_dev_free);
>>
>> +/**
>> + * extcon_alloc_cables() - alloc the cables for extcon device
>> + * @edev:        extcon device which has cables
>> + *
>> + * Returns 0 if success or error number if fail.
>> + */
>> +static int extcon_alloc_cables(struct extcon_dev *edev) {
>> +        int index;
>> +        char *str;
>> +        struct extcon_cable *cable;
>> +
>> +        if (!edev->max_supported)
>> +                return 0;
>> +
>> +        edev->cables = kcalloc(edev->max_supported,
>> +                               sizeof(struct extcon_cable),
>> +                               GFP_KERNEL);
>> +        if (!edev->cables)
>> +                return -ENOMEM;
>> +
>> +        for (index = 0; index < edev->max_supported; index++) {
>> +                cable = &edev->cables[index];
>> +
>> +                str = kasprintf(GFP_KERNEL, "cable.%d", index);
>> +                if (!str) {
>> +                        for (index--; index >= 0; index--) {
>> +                                cable = &edev->cables[index];
>> +                                kfree(cable->attr_g.name);
>> +                        }
>> +                        return -ENOMEM;
> 
> You have a memory leak.
> edev->cables is allocated and
> you are not freeing it.
> 
> In the previous code, it was freed by
> having different err-goto labels.
> 
> Please check if you have similar errors
> in other patches of this series.
> 
> ...
> 
>> @@ -1282,7 +1296,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>> err_alloc_cables:
>>         if (edev->max_supported)
>>                 kfree(edev->cables);
>> -err_sysfs_alloc:
>> +
>>         return ret;
>> }
>> EXPORT_SYMBOL_GPL(extcon_dev_register);
>> --
>> 2.35.1
>>
>>
> 
> Cheers,
> MyungJoo.
> 
> 
> 

