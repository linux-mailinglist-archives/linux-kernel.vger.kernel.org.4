Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2B6CA21E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjC0LHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjC0LHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:07:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC4C49D9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:07:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r29so8289142wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679915220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qitJTqC1V5NX4sqdWfyfOSl5R7cjvJjk8ZEy1hQzGYw=;
        b=uZKetoWJiYs++Fgjpf9n+9rMID4at3FHq8zR9UT1O/0uo5hUok59vw/gaUyKRIF9lh
         eZ+W/gt0HbWb5I+4PoOaU9DSMdUhmndm2Ou669CxfJ3AfCzZ/tUYxzZuwZgQdKjet0z5
         aMWIXxPMmPGhfnPrCx+kFJ/zcZZvn2MLkD+jfzbCw6J0SefC9ForEtNmAn4LfUsA/JUt
         FdZ6kDn3PvmE3GsEyBw4xW3MaG15fka/zB7iP+q4VN8KJbOoaS8JhYkUJBHIj4McJTQ+
         nft4zMNSISkqF6667a6kUzxfz3JKI7HBEWDiL46dHbaNKPTGPJa1GdL53w5ZX6WT+7Xb
         ofxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679915220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qitJTqC1V5NX4sqdWfyfOSl5R7cjvJjk8ZEy1hQzGYw=;
        b=S8osct/CdGSrq5proZ7wZtpPcCP2mfBaaNqZy8KFIjC74emSDKLBMSSCqumkCyQM6p
         +Ts5NMsoR5gT5IgP9qObiRwPmeV4j1Jm0swRT1knt5Eax3uWLji0MAd+SuQe1nTq9i0L
         DYBeSaIq8CCCceWSlVVmSzija/83z2tz1D4uRleUSb5Or7h7xRuna0rhhvt+hS8Svq1y
         PXa6VqWLmq91sEC2Nci5axfkjbEGwQaxUW8hSX217TsvLh45hGISdsgM9uwJ5UKKuBi9
         7LaduKYs1+64PKMfzDbFPncmLoGrUT+izkxcp6r86Tsytyp+b6gxZwUpYIUqv5Nv278k
         O7rA==
X-Gm-Message-State: AAQBX9cJJIEXQMfKA596Mfl2NslQEsvnhCLFPQMCcs0APpXbDiUB12Ut
        SrZ2eIfViD9rzSi2W+QD71Qigw==
X-Google-Smtp-Source: AKy350YWw4DxoHkP05YdbwUNjWA9N5HHoPz6vmYEJISihg2trk7/De13x7ewKuibreEd0BHOEXJ70A==
X-Received: by 2002:adf:fe08:0:b0:2d6:a357:f138 with SMTP id n8-20020adffe08000000b002d6a357f138mr9284325wrr.18.1679915220550;
        Mon, 27 Mar 2023 04:07:00 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm24774833wrr.69.2023.03.27.04.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 04:07:00 -0700 (PDT)
Message-ID: <70d0a8b6-62c2-fa3e-df5c-f86ba75484d0@linaro.org>
Date:   Mon, 27 Mar 2023 12:06:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/2] mtd: rawnand: stm32_fmc2: use timings.mode instead
 of checking tRC_min
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Christophe Kerello <christophe.kerello@foss.st.com>,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230327094742.38856-1-christophe.kerello@foss.st.com>
 <20230327094742.38856-3-christophe.kerello@foss.st.com>
 <75dcd205-5432-7103-370c-d65d792631ea@linaro.org>
 <20230327124313.1ccd3d66@xps-13>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230327124313.1ccd3d66@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/23 11:43, Miquel Raynal wrote:
> Hi Tudor,
> 
> tudor.ambarus@linaro.org wrote on Mon, 27 Mar 2023 11:30:51 +0100:
> 
>> On 3/27/23 10:47, Christophe Kerello wrote:
>>> This patch is using timings.mode value instead of checking tRC_min timing
>>> for EDO mode support.
>>>   
>>
>> Fixes and Cc to stable here too, as you'd like to have this backported
>> as well, don't you?
> 
> Actually the reason why Christophe split this into two patches is
> because timings.mode was introduced rather lately, he wanted the same
> patch to apply on all stable kernels, he actually asked for that split
> and I agreed (another solution would have been to send this current
> patch to Linus and have the other version sent to stable, but it
> requires a bit of scheduling on both ends).
> 
> Link: https://lore.kernel.org/linux-mtd/20230327101156.0ec2816a@xps-13/T/#t

Right, I understood that from the beginning. If it were to me, I would
Cc: stable@vger.kernel.org #v5.4+ for the first patch and
Cc: stable@vger.kernel.org #v5.10+ for the second.

So first would be alone just in v5.4, and starting with v5.10 we'll have
both and we'll mimic what we currently have in upstream mainline.

> 
>>
>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>  
>>
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>
>>> ---
>>>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>> index 3abb63d00a0b..9e74bcd90aaa 100644
>>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>> @@ -1531,7 +1531,7 @@ static int stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
>>>  	if (IS_ERR(sdrt))
>>>  		return PTR_ERR(sdrt);
>>>  
>>> -	if (sdrt->tRC_min < 30000)
>>> +	if (conf->timings.mode > 3)
>>>  		return -EOPNOTSUPP;
>>>  
>>>  	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)  
> 
> 
> Thanks,
> Miquèl
