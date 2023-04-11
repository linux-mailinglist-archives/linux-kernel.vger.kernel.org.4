Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3176D6DE190
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjDKQxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjDKQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:53:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E5455AE;
        Tue, 11 Apr 2023 09:53:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j1so12256208wrb.0;
        Tue, 11 Apr 2023 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681232003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqH7wKCunfUiuqasfAeXmHcMyjFK4ZmMnPdmKKyPhSs=;
        b=Sto7PC17h7hjlHE8aTCm/iwT8VNstBiPTLFlB7wdFEc2PWJbQP2zooUmso0CFEljeM
         N8EG/K0bVQXF2CjR6M4prrQmEALL4v+CGgS0LICcUiZe3zq8UHET+5fh+BsaIltiJWMp
         Iq/K/a2EQSmYzKzpC1/zioK3aix++OrSGzRVBNBZhiyP6orXdZLVns18VYRI8+no0BD7
         dOPmiVJweiA6FrI1ZAr4tn1dWelVQ7eKGbgZrxGtjf33cZR40AEEfvcAGRjTmxmuF8PF
         T+Wah9HhOFZtnrH7fRGbdetLv/HzqfqUz2GVZnYEXwa0i1p6fnwts/IKpI7Kyw9ltmNs
         SnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqH7wKCunfUiuqasfAeXmHcMyjFK4ZmMnPdmKKyPhSs=;
        b=51/D7pQZ83WJPxzQzNNnwHFGXm2OC1MXJA3vLon81hB4CW5myk4KIq/CZsRwM2t2n4
         LsNI54HaAOXGlQ9VLohX74ZCNXTipEWcNuVIuUBdsqpJQ4JTBbmjMJpXJUs9msNsuh8p
         Ca8qlWSiRRPeO6JRGEl7QW/KT9ibLX86R8gBerkEVHpnXJUI5JYeXgA8ESxgdozNVpjW
         fTx9BcQuhExmaWorOflOxtA8vTPkKV8rr2GMf9W8c7UlSNDYLRz5MeMXuLKrOiaJhqGG
         PFB4clZa1CvtEgG21B47V2iHycOqKSESYXV+8EG3WI2HqhGiJvVqlSLxMyq2QCtP/vl/
         EIZA==
X-Gm-Message-State: AAQBX9c5Or5yzMgcdyxfDhxM/tDjp3ugYFHZE1L0eJy1ktdRTz6Lb6j0
        0hvyf5ukY/JN17g7SHm5AiM=
X-Google-Smtp-Source: AKy350bhBbxkafNLcd1dFNwPNeIL04wjQJtDV2hZGi6h7vo/pgPYxtzzT3Dv1AP7pLfqZBRp8rnNGA==
X-Received: by 2002:adf:f288:0:b0:2cf:2dcc:3421 with SMTP id k8-20020adff288000000b002cf2dcc3421mr9034790wro.5.1681232002613;
        Tue, 11 Apr 2023 09:53:22 -0700 (PDT)
Received: from [192.168.0.32] ([37.222.243.26])
        by smtp.gmail.com with ESMTPSA id c18-20020a056000105200b002db1b66ea8fsm14919281wrx.57.2023.04.11.09.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 09:53:21 -0700 (PDT)
Message-ID: <a31ae980-a61b-f058-2841-2f23ba90e8ab@gmail.com>
Date:   Tue, 11 Apr 2023 18:53:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: build failure after merge of the mediatek tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230403181552.607a8b64@canb.auug.org.au>
 <20230411092522.6380fa88@canb.auug.org.au>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230411092522.6380fa88@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2023 01:25, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 3 Apr 2023 18:15:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the mediatek tree, today's linux-next build (arm64
>> defconfig) failed like this:
>>
>> aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
>> aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
>> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mmsys.o: in function `mtk_mmsys_update_bits':
>> drivers/soc/mediatek/mtk-mmsys.c:147: undefined reference to `cmdq_pkt_write_mask'
>> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mmsys.o: in function `mtk_mmsys_probe':
>> drivers/soc/mediatek/mtk-mmsys.c:386: undefined reference to `cmdq_dev_get_client_reg'
>> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mutex.o: in function `mtk_mutex_enable_by_cmdq':
>> drivers/soc/mediatek/mtk-mutex.c:883: undefined reference to `cmdq_pkt_write'
>> aarch64-linux-gnu-ld: drivers/soc/mediatek/mtk-mutex.o: in function `mtk_mutex_probe':
>> drivers/soc/mediatek/mtk-mutex.c:1023: undefined reference to `cmdq_dev_get_client_reg'
>>
>> Caused by commit
>>
>>    b34884b4c878 ("soc: mediatek: Cleanup ifdefs for IS_REACHABLE(CONFIG_MTK_CMDQ)")
>>
>> I have used the mediatek tree from next-20230331 for today.
>>
>> There were also the following warnings:
>>
>> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:104.21-109.4: Warning (unit_address_format): /soc/i2c@11010000/accelerometer@0x10: unit name should not have leading "0x"
>> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:111.20-114.4: Warning (unit_address_format): /soc/i2c@11010000/magnetometer@0x12: unit name should not have leading "0x"
>> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:104.21-109.4: Warning (i2c_bus_reg): /soc/i2c@11010000/accelerometer@0x10: I2C bus unit address format error, expected "10"
>> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts:111.20-114.4: Warning (i2c_bus_reg): /soc/i2c@11010000/magnetometer@0x12: I2C bus unit address format error, expected "12"
> 
> Ping?
> 

Fix from Angelo applied. Sorry for the delay.

Matthias
