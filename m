Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA6D6BB526
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjCONua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjCONu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:50:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095252A171
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:50:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h8so32029612ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678888221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OM8iJRNFplJfGDi4un2hc/7xXTYet+KS5NXp7xD/8I=;
        b=TCMpPIMy+V8GC+lP8WKb689w22DJ48ExAeHDzMwBkioka5Cuhafa6iwjp3LzsOQEy9
         zfAMUnTyP2PXeYd5U91LFaYJ/KXLXmFpL9RK6bNSFBxpAzC/c34QsrazZDdtowfbfEYT
         kzey//Q7ilzDRvf7G+hzh0q09bDiFlJaeqQRaOT+8uUiYPUQCiQ+MK7xP1Svr4cXQzdS
         AGplAWbWkn4PQMNtYt/o0XA4V9xC9BlPxAZlZbS9LoZJlAUTdc7pgSpTfiIYu8I8GBj/
         6HlLXOB6c6y0wlXtpRCYwP3whzJOynMBVPAvw8Xzjl0IVBChMoDS4fAbmNBrLp8IWByr
         52cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OM8iJRNFplJfGDi4un2hc/7xXTYet+KS5NXp7xD/8I=;
        b=4MBTxgW06QnX83NYlqRadm0n6v19dZKGiRIyLawf4jYGEvAx0IRIioGOfxHe7UYfj+
         MURzGOI/Fxhldjyz3ZjkD0n83P3vfiAQ6TJEZG9P9sad0+swE5Exou0Qwb0jpAfCoxZ9
         aEQnlEFTBQMwPt8j/Ue3DoS6utZgbW5nsY3ayIcraX95jr5J9qqcGddclRTac0s+LFIC
         LL/h4aKI84IjJUvfaCeIppr2vk9Pl9mAAtedz1lN1X3KCTFdXXjcec1Xnvo+wo8yLI6l
         irLvdlM6UrOPtPRmO5iXpUppx5gndMvmgU77MzFrLcv60ZZHuPGh+FxayEujKrRaYnXG
         WK5Q==
X-Gm-Message-State: AO0yUKWjmSqUejF265/jF7ocuI4mvlExTMp0OCvpSFdRY5piOmNwKB5d
        cyGxLiM55GbmvncNYby7xPE=
X-Google-Smtp-Source: AK7set8runYUr6M/EemckAjqEAVmBSBrJd8vikbkDem5o9wVKRmOLFb2AGjgmhcI4wzdr2D70GNNKQ==
X-Received: by 2002:aa7:cd8d:0:b0:4fb:5fe1:bc3b with SMTP id x13-20020aa7cd8d000000b004fb5fe1bc3bmr2996679edv.0.1678888221468;
        Wed, 15 Mar 2023 06:50:21 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id i23-20020a17090639d700b009262198d096sm2554193eje.38.2023.03.15.06.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 06:50:21 -0700 (PDT)
Message-ID: <b37352ef-959e-d950-c0c6-32e1c7268b79@gmail.com>
Date:   Wed, 15 Mar 2023 15:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] staging: vme_user: remove unnecessary blank lines
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        martyn@welchs.me.uk, manohar.vanga@gmail.com, zoo868e@gmail.com,
        jerrykang026@gmail.com, cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <4bdfd864b573c164df30ec738afc93b06ce0d573.1678887330.git.eng.mennamahmoud.mm@gmail.com>
 <15b80b699315993d7f0da638f805446f6dc0b480.1678887330.git.eng.mennamahmoud.mm@gmail.com>
 <dcd9b79-bbd5-f160-317b-7fdd6ca6fc64@inria.fr>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <dcd9b79-bbd5-f160-317b-7fdd6ca6fc64@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١٥‏/٣‏/٢٠٢٣ ١٥:٤٥, Julia Lawall wrote:
>
> On Wed, 15 Mar 2023, Menna Mahmoud wrote:
>
>> remove unnecessary blank lines before a close brace
>> as reported by checkpatch script
>>
>> "CHECK: Blank lines aren't necessary before a close brace '}'"
>>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ----
> This should be three -s, not four.
>
>> changes in v2:
>> 	edit commit message
>> ---
> -s aren't needed here.
>
> julia


I see, Thanks Julia

Menna


>
>>   drivers/staging/vme_user/vme_tsi148.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
>> index bfa604043355..2f5eafd50934 100644
>> --- a/drivers/staging/vme_user/vme_tsi148.c
>> +++ b/drivers/staging/vme_user/vme_tsi148.c
>> @@ -1023,7 +1023,6 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
>>   err_res:
>>   err_window:
>>   	return retval;
>> -
>>   }
>>
>>   /*
>> @@ -1741,7 +1740,6 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
>>   				  list);
>>   		prev->descriptor.dnlau = cpu_to_be32(address_high);
>>   		prev->descriptor.dnlal = cpu_to_be32(address_low);
>> -
>>   	}
>>
>>   	return 0;
>> @@ -1773,7 +1771,6 @@ static int tsi148_dma_busy(struct vme_bridge *tsi148_bridge, int channel)
>>   		return 0;
>>   	else
>>   		return 1;
>> -
>>   }
>>
>>   /*
>> @@ -2220,7 +2217,6 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
>>   	}
>>
>>   	return 0;
>> -
>>   }
>>
>>   static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
>> @@ -2530,7 +2526,6 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	kfree(tsi148_bridge);
>>   err_struct:
>>   	return retval;
>> -
>>   }
>>
>>   static void tsi148_remove(struct pci_dev *pdev)
>> --
>> 2.34.1
>>
>>
>>
