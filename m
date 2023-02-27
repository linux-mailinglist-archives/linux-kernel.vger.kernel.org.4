Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120AC6A476B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjB0Q7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjB0Q7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:59:48 -0500
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F5B1ACDB;
        Mon, 27 Feb 2023 08:59:47 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id c4so1044419pfl.0;
        Mon, 27 Feb 2023 08:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cetFDf1NFYgP8RIWSMrRAlJBHdWqEvMTTTCcK4WGr3A=;
        b=hr7sIC7LWKAbrpE60IE46R1WO3/5SjVykBoyPlyNMpaUr7CzkBfljiH47AnYTqEdlT
         OUt1dB+snxS6vqnvAAAaVOZIPulQFweOOqcoRwsOTuZtxfFiAte/qrf2tTlnFRV8fU8f
         OjsbWdZ1QReOWxgcjbPvMAeEuQAed5vSWOVytpb5oNlCumlayrmzziToP4JPNgcbQHg5
         t+iEx5tAzjmEgyrHp64MAAOpUQ84Cys3rF0gDskgYjYpAO6Gkm86Ai5iePK9b4E+5bX5
         +YXAzAYBGNICmZ/vvQRAMvt/ZzU+pFh5t70cvUmd8n8jSAb61O8CI+1hgOMLUmj1hUWJ
         tgbw==
X-Gm-Message-State: AO0yUKUvswiyQquwWPR/Dm4JZvh2wVCUmtrBUte/aF/+AaBIwJG/QCti
        08RjcgslhSeevY6kDh9+NstL2odveDA=
X-Google-Smtp-Source: AK7set9SulBRpkxpWtvUBsnGmBfaWh12g+qSKuKCB//RgoIFO1CLr2gSNDgam7mYI2fM4jN6HOEYGw==
X-Received: by 2002:aa7:982b:0:b0:5a8:2008:d1eb with SMTP id q11-20020aa7982b000000b005a82008d1ebmr21151842pfl.17.1677517186979;
        Mon, 27 Feb 2023 08:59:46 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id t11-20020aa7938b000000b005a8a4665d3bsm4458612pfe.116.2023.02.27.08.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 08:59:46 -0800 (PST)
Message-ID: <21f73bfd-1d91-106f-d3a8-eb4674c517e6@acm.org>
Date:   Mon, 27 Feb 2023 08:59:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1677078770-30994-2-git-send-email-Arthur.Simchaev@wdc.com>
 <b1f0ed44-d707-5593-7449-8a6bd23c9902@acm.org>
 <BY5PR04MB632717453EB0D403388B4F1EEDAF9@BY5PR04MB6327.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <BY5PR04MB632717453EB0D403388B4F1EEDAF9@BY5PR04MB6327.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/23 08:03, Arthur Simchaev wrote:
>>>
>>>    */
>>>   struct utp_upiu_query {
>>>   	__u8 opcode;
>>>   	__u8 idn;
>>>   	__u8 index;
>>>   	__u8 selector;
>>> -	__be16 reserved_osf;
>>> -	__be16 length;
>>> -	__be32 value;
>>> -	__be32 reserved[2];
>>> +	__u8 osf3;
>>> +	__u8 osf4;
>>> +	__be16 osf5;
>>> +	__be32 osf6;
>>> +	__be32 osf7;
>>>   };
>> All changes in UAPI headers must be backwards compatible. The above doesn't look like a backwards compatible change to me.
>
> This API was originally invented to support ufs-bsg.
> AFAIK, ufs-utils is the only app that makes use of this API,
> and it doesn't dig into struct utp_upiu_query inner fields.

That does not match what I see. I see that code in ufs-utils accesses 
the 'length' and 'value' members of the above data structure.

Please follow the rules for UAPI header files.

Thanks,

Bart.
