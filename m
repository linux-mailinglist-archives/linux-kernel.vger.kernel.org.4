Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F851646F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLHMW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLHMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:22:21 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4592E9F1;
        Thu,  8 Dec 2022 04:22:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so3439734ejc.4;
        Thu, 08 Dec 2022 04:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i5lRBdAoPLMSOy6lJ9M0RNuDyhnO6PTxXoPAh60xUpM=;
        b=cIlcWPq2u+2Ko4OG4WF2lQV351M/f/MveQeVD3o9/zHtEM3Lb7UqF9GH4WdeceAIA6
         ZVLURjQ51BGxRYnmsJyy7Zc9ITXgAgPKc+Z0RwydCGhIXQHVFSQ+tgSDyOlTOzTsOnHn
         mP5CzrA1gN8IHxFTJOAIBEqh9qVw0VhgJM7mQAo+/fKciDYDdQEo4w9E13FQj2k3K0Ry
         JLetA+OseBk/xTgWvDvL6gJEfFLuUFpxSltQ0zxuelfvp8c4Re835oZBrtbB2mOeBuIf
         VOCiZhlVbV4J7qXCJv4fofZE3vWITkjbnJ1Ij6ek7srf+snsyDNXBoeEX5UEGtueTUyr
         mR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5lRBdAoPLMSOy6lJ9M0RNuDyhnO6PTxXoPAh60xUpM=;
        b=KxLqagrpZmmQAE2fO8Fg7PSBAhGSBrmb06gsNyOeSzZXOfMu61tz9bekrSHl9D/M7s
         VICL1TKo5LgSFKO/W7+G2JTX616s1LLpU5O11pvZwZa9SHZlUDCWxDjjhO/y/t62FIlJ
         QvlxAPmHIJdmRe1v9xVSsRksznAbD5mwk/GPpWlEezlr3QIWZKflRNryCYkgvClPLpkK
         cjSKrviCow0aQd3CjAyQgKohRnXqdLzy0er6MCkoKeg3dDFCYOjCLAv16DFzB+mZous7
         MoUoH4Nf+vkcw8FEiFhY5d1YGNI3yn4jin2U3irl1gK2UZKvN9rkWGLKJzWpGwy1EAEk
         rilw==
X-Gm-Message-State: ANoB5pmIRUuhYC+Lu2JFGJPujoZ4lARSZ3igCZChfFORg81EW68CnMo+
        X31eDzWrW2lWo2sUUxby0WE=
X-Google-Smtp-Source: AA0mqf7E587LPcaZVztO0zqjmBfBeI2c13fzuYseYaeQhczxGwPqhvQdxgim8BjmQIwS+Hn/vOKzXg==
X-Received: by 2002:a17:906:6b97:b0:7c0:fe68:35e9 with SMTP id l23-20020a1709066b9700b007c0fe6835e9mr11384665ejr.49.1670502138053;
        Thu, 08 Dec 2022 04:22:18 -0800 (PST)
Received: from [10.176.235.173] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id f17-20020a05640214d100b0045b4b67156fsm3295382edx.45.2022.12.08.04.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 04:22:17 -0800 (PST)
Message-ID: <0a44763d-8c40-b9e7-6268-01567c401884@gmail.com>
Date:   Thu, 8 Dec 2022 13:22:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/4] ufs: core: Remove redundant wb check
To:     Bart Van Assche <bvanassche@acm.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1669550910-9672-2-git-send-email-Arthur.Simchaev@wdc.com>
 <b89f3337-0869-35a8-114d-85e1fd81eb2c@acm.org>
Content-Language: en-US
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <b89f3337-0869-35a8-114d-85e1fd81eb2c@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.12.22 12:31 AM, Bart Van Assche wrote:
> On 11/27/22 04:08, Arthur Simchaev wrote:
>> We used to use the extended-feature field in the device descriptor,
>> as an indication that the device supports ufs2.2 or later.
>> Remove that as this check is specifically done few lines above.
>>
>> Reviewed-by: Bean Huo <beanhuo@micron.com>
>> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
>> ---
>>   drivers/ufs/core/ufshcd.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 2dbe249..2e47c69 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -7608,10 +7608,6 @@ static void ufshcd_wb_probe(struct ufs_hba 
>> *hba, const u8 *desc_buf)
>>            (hba->dev_quirks & 
>> UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES)))
>>           goto wb_disabled;
>>   -    if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
>> -        DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
>> -        goto wb_disabled;
>> -
>>       ext_ufs_feature = get_unaligned_be32(desc_buf +
>>                       DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
>
> Does this code really have to be removed? I see a check of the
> UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES flag above the removed
> code but no check of the descriptor size?
>
it is not necessary to check this, but if you have concern, we could 
change to like this:


         if (desc_buf[DEVICE_DESC_PARAM_LEN] <
             DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
                 goto wb_disabled;

then   hba->desc_size could be removed.

Kind regards,

Bean



