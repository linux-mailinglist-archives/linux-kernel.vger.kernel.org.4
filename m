Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BED6C434B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCVGhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVGhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:37:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6253D5B5C7;
        Tue, 21 Mar 2023 23:37:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f16so17801853ljq.10;
        Tue, 21 Mar 2023 23:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679467048;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyQWxUcj6eiH7pd+/4aargKQP3EMvN/nH0WVLFxLIMA=;
        b=Sd8/yBAwwAcPyEcFJSTuStS1KB37qFKiKIFbz1NrU94QdM538nFKll/EwzxQnJ5XvV
         nGmqr5C9ItBc43u4D0qFqoSvhR35A7jk5Lnwk4gL/pUx56zJQFgXqV6W15RrnEwvhxRe
         Enq5lWRaswWF/mw675F8xZ+FP1otL/a99TBOHsyAVH7jhCaRNg0ou6efBlfmJ73VGYgR
         bOruuZ9RPeWgS+knapaQZpwMoD3rE4F3/GcDTujaYGMHZL81duvblrtOFDRApKykaetZ
         A6D7t8wLwo2uKkCTpiqxr1va62NJGvQjBpoof2oTvKrVWkWQ5p1Ae4sfFJ0CfwcsiDn6
         sQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467048;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyQWxUcj6eiH7pd+/4aargKQP3EMvN/nH0WVLFxLIMA=;
        b=jzEh8t69Ebvs/n/MZgDBQn6gzTXJ3CgIO78GsMz75LIgjt8hrV190416hOuHoUADYH
         EL2bO/p1KiDYq+FgzjZApuSxzfa/DsIlXsaBQnLMybS/BmMSdYycZ5wvSpSkSqNPeFVA
         0eOp9FuIsU+CdGAZJQ3OrFXYHrJKNqgmkOwSxljMTKPlWVNaF7+wnBkQ2MZe+l8MLwo9
         jUeqhnHRjflUOwecqBqHqPZwTy15ucQo5rYLCRbC8dhesnPsjWmdOo3lotGVgdQwAn62
         PcUKIDDFqZd/+x4aG7qzLZej4NC8n4AEMFIWczPzrDNW22FkF6nLaCmz3x5BmIobrv3w
         wulA==
X-Gm-Message-State: AO0yUKXfInniX3EnQvhkAvmzTIOWSd/8du7+OL+sujuPj+i4uPK1jEpu
        j4lJXnXpcXZjZi1m5Dmd1VTskzbTdzE=
X-Google-Smtp-Source: AK7set/g2tYwuOjfjuGeQzU6s33MDSRQibUdK0ss+tfknJb9xTynEXYEfJpeI8DT7IxpdaCWYrPgMw==
X-Received: by 2002:a2e:9896:0:b0:299:aa61:1a72 with SMTP id b22-20020a2e9896000000b00299aa611a72mr1779599ljj.15.1679467048459;
        Tue, 21 Mar 2023 23:37:28 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e6e02000000b00295a8c68585sm2484209ljc.56.2023.03.21.23.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 23:37:27 -0700 (PDT)
Message-ID: <4e4d527b-c323-4b21-bee5-f0745d67c903@gmail.com>
Date:   Wed, 22 Mar 2023 08:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
 <4c28925d-c07c-61b7-8863-9c00e6846687@gmail.com> <ZBnTuykAqse5vBhO@carbian>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
In-Reply-To: <ZBnTuykAqse5vBhO@carbian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 17:56, Mehdi Djait wrote:
> Hello Matti,
> 
>>> +static int kx022a_get_fifo_bytes(struct kx022a_data *data)
>>> +{
>>> +	struct device *dev = regmap_get_device(data->regmap);
>>> +	__le16 buf_status;
>>> +	int ret, fifo_bytes;
>>> +
>>> +	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1, &buf_status, sizeof(buf_status));
>>> +	if (ret) {
>>> +		dev_err(dev, "Error reading buffer status\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	buf_status &= data->chip_info->buf_smp_lvl_mask;
>>> +	fifo_bytes = le16_to_cpu(buf_status);
>>> +
>>> +	/*
>>> +	 * The KX022A has FIFO which can store 43 samples of HiRes data from 2
>>> +	 * channels. This equals to 43 (samples) * 3 (channels) * 2 (bytes/sample) to
>>> +	 * 258 bytes of sample data. The quirk to know is that the amount of bytes in
>>> +	 * the FIFO is advertised via 8 bit register (max value 255). The thing to note
>>> +	 * is that full 258 bytes of data is indicated using the max value 255.
>>> +	 */
>>> +	if (data->chip_info->type == KX022A && fifo_bytes == KX022A_FIFO_FULL_VALUE)
>>> +		fifo_bytes = KX022A_FIFO_MAX_BYTES;
>>> +
>>> +	if (fifo_bytes % KX_FIFO_SAMPLES_SIZE_BYTES)
>>> +		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
>>> +
>>> +	return fifo_bytes;
>>> +}
>>
>> I like adding this function. Here I agree with Jonathan - having a device
>> specific functions would clarify this a bit. The KX022A "quirk" is a bit
>> confusing. You could then get rid of the buf_smp_lvl_mask.
> 
> my bad here, I should have made a separate patch and explained more ...
> buf_smp_lvl_mask is essential because kionix products use different
> number of bits to report "the number of data bytes that have been stored in the
> sample buffer" using the registers BUF_STATUS_1 and BUF_STATUS_2

Yes, they have different size of FIFO, and the KX022A does also have the 
nasty "FIFO FULL" quirk. Due to this quirk and other differences I was 
suggesting you created own functions for kx022a and kx132. Eg something 
along the lines:

static int kx022a_get_fifo_bytes(struct kx022a_data *data)
{
...
}
static int kx132_get_fifo_bytes(struct kx022a_data *data)
{
...
}

struct chip_info {
	...
	int (*fifo_bytes)(struct kx022a_data *);
};

and do the:
fifo_bytes = kx022a_get_fifo_bytes;
or
fifo_bytes = kx132_get_fifo_bytes;

in probe. That will also remove the need to check the IC variant for 
each FIFO read.

If you did that you could remove the buf_smp_lvl_mask and maybe also the 
buf_statusX members from the chip_info struct (at least for now). You 
could also do regular read for KX022A and drop the endianess conversion 
for it. Bulk read is only needed for ICs with more than 8bits of FIFO 
status. Furthermore, the IC-type check could then go away and the above 
mentioned KX022A-specific handling would not be obfuscating the kx132 code.

> 
> kx022a: 8bits
> kx132: 10bits
> kx12x: 11bits
> kx126: 12bits
> 
> I think this function is quite generic and can be used for different
> kionix devices:
> 
> - It reads BUF_STATUS_1 and BUF_STATUS_2 and then uses a chip specific
> mask
> - It takes care of the quirk of kx022a which is just a simple if statement

Yes. Your function definitely works. And I do like the fact that you did 
own function for the "amount of data in fifo"-check. Still, the code 
would be little simpler and perform a tiny bit better if you did two 
functions instead of one.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

