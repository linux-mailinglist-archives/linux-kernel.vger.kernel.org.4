Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B6B728EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbjFID57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbjFID5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:57:55 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFB4030F2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:57:50 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8Cx8Og9o4JkUOEAAA--.930S3;
        Fri, 09 Jun 2023 11:57:49 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxK8o9o4Jk_bMJAA--.21398S3;
        Fri, 09 Jun 2023 11:57:49 +0800 (CST)
Message-ID: <9854871e-2345-d82e-4e4e-d5bf492c2296@loongson.cn>
Date:   Fri, 9 Jun 2023 11:57:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] ASoC: loongson: Add Loongson Generic ASoC Sound Card
 Support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
References: <20230605120934.2306548-1-mengyingkun@loongson.cn>
 <20230605120934.2306548-2-mengyingkun@loongson.cn>
 <aa8381b5-0a3b-4a64-8c92-333ad751956b@sirena.org.uk>
From:   YingKun Meng <mengyingkun@loongson.cn>
In-Reply-To: <aa8381b5-0a3b-4a64-8c92-333ad751956b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxK8o9o4Jk_bMJAA--.21398S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQARDGSBxQEP2gABsp
X-Coremail-Antispam: 1Uk129KBj93XoWrKw4rXr1kWrWxKF1UAr1kWFX_yoW8Jr1xpF
        WjyFyjyF9xWF1qyrn5Ww4UZa4vyrWavw15Jw18GF1ag3s5ZFyfKr4fKFyYqayrCr92yFW2
        vF4jgrZ5AryDWFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
        N3UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brown,

Thanks for your kindly work.

On 2023/6/5 20:47, Mark Brown wrote:
> On Mon, Jun 05, 2023 at 08:09:33PM +0800, YingKun Meng wrote:
>
>> The driver supports the use of ACPI table to describe device resources.
>> On loongson 7axxx platforms, the audio device is an ACPI device.
> I'm not seeing any ACPI IDs added here, this is all DT other than this:

I use the special ACPI ID "PRP0001", it provides a means to use the existing

DT-compatible device identification in ACPI.

As described in the document "ACPI Based Device Enumeration".

>> +	if (has_acpi_companion(&pdev->dev)) {
>> +		device_property_read_string(&pdev->dev, "codec-name",
>> +						&codec_name);
>> +		for (i = 0; i < card->num_links; i++)
>> +			loongson_dai_links[i].codecs->name = codec_name;
>> +
>> +		device_property_read_string(&pdev->dev, "codec-dai-name",
>> +						&codec_dai_name);
>> +		for (i = 0; i < card->num_links; i++)
>> +			loongson_dai_links[i].codecs->dai_name = codec_dai_name;
>> +	} else {
> which doesn't look *great* from an ACPI point of view TBH.  I thought
> there were now some (semi?) standard ACPI bindings these days to support
> referencing other devices better?
Got it! I will rewrite this part.

