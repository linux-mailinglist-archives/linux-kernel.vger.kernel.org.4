Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C160D5F2393
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJBOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJBOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:31:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CB542AC5;
        Sun,  2 Oct 2022 07:31:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c2so6960841lfb.10;
        Sun, 02 Oct 2022 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nPUjAsLi35VmxqzE3gTIZsLlhSf+oQzitgSJsWh0i5M=;
        b=l/bPfck3ZR1lc20PMEvd9Hz+H8OJyptL4UGOuK7411/MG3PYmvi+pDN98y2W5hf35I
         RZ64hMsN9vPZ3QY6y3unrahXDu+0vq9yqQuA2LfhYizuvxxFJphYnGXEaixC2UV2z103
         dACWOxpwETP6Pp2Wu74o/yYHlT0qFuIVzANXE68EEcVZrzjvYM2ejKkhISORxK/n10r6
         Tk1ursRQgqk4yCa0tdDzUYF4xOxjPX6kzW2yynOelWLjdPZ0wpHeCTqwbnXMLVz2sfTJ
         CMJMPZjzFFLOOcrHJjWurT1XCXuUPahzqBtWmsk+0oir+0nQN8mRtuZxw23oEx8P+tTB
         Qw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nPUjAsLi35VmxqzE3gTIZsLlhSf+oQzitgSJsWh0i5M=;
        b=OLpwxY3MAmyUarNKXPUVeOkJPEYz7iqMlVOKqt9PH+Ko2QsF+HQttd0phX1c8p9hAs
         27CSfMK50LLBq8ZxFt6fRMBnKvgyQPxtlBGswOzNgE8vqQnLx/LQmkz1AuYJUWWGzPmU
         bRCIs6mAeg3dZaDArZ7Vv2qTnDIiy8cH9mB2nD9GtVbY5akUsq8Pr7hdZ6oZ9cXHimiF
         xGlcFqYyIbw+Foee0klCtl9Aykoyh6BPvzvwlENnqXlck8iVGtux9lLIUY/OwseF7tgc
         Pt1Ct099hvQtHq1HuopyQS563AqkPKE0W+dI05r30dCWJH2CkJdra5oA43QH2rcK0LE8
         XxWg==
X-Gm-Message-State: ACrzQf3dqIVMlI5h0qBIZTYyr+lDenQR13FecGjPJNOv81HCoGNNUJvO
        d6ulo3gKOQ8HuZ/hxVK2LlM=
X-Google-Smtp-Source: AMsMyM5PpKV39RbAH0Gv8BGs2mVxHebxMgTxLdxjouR3ISxGO4kx/IFxeyFq+48P1Teo+Zhokl5pRQ==
X-Received: by 2002:ac2:5088:0:b0:4a2:2e18:c4c9 with SMTP id f8-20020ac25088000000b004a22e18c4c9mr1269443lfm.5.1664721084364;
        Sun, 02 Oct 2022 07:31:24 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id cf38-20020a056512282600b0049a6a9bc0dcsm1092397lfb.134.2022.10.02.07.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 07:31:23 -0700 (PDT)
Message-ID: <87f737af-c676-4e91-658f-55d9d78ae760@gmail.com>
Date:   Sun, 2 Oct 2022 17:31:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
 <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
 <20220922180339.30138141@jic23-huawei>
 <3eea7954-3faf-3fc9-7507-c318488c5524@gmail.com>
 <20221002121857.3f7d9423@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221002121857.3f7d9423@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/22 14:18, Jonathan Cameron wrote:
> On Wed, 28 Sep 2022 14:14:14 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 9/22/22 20:03, Jonathan Cameron wrote:
>>> On Wed, 21 Sep 2022 14:45:35 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>> +
>>>> +/*
>>>> + * The sensor HW can support ODR up to 1600 Hz - which is beyond what most of
>>>> + * Linux CPUs can handle w/o dropping samples. Also, the low power mode is not
>>>> + * available for higher sample rates. Thus the driver only supports 200 Hz and
>>>> + * slower ODRs. Slowest being 0.78 Hz
>>>> + */
>>>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.78 1.563 3.125 6.25 12.5 25 50 100 200");
>>>> +static IIO_CONST_ATTR(scale_available,
>>>> +		      "598.550415 1197.10083 2394.20166 4788.40332");
>>>> +
>>>> +static struct attribute *kx022a_attributes[] = {
>>>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>>>> +	&iio_const_attr_scale_available.dev_attr.attr,
>>>
>>> Use the read_avail() callback instead of doing these as attributes.
>>> That makes the values available to consumer drivers...
>>
>> Am I correct that populating the read_avail() does not add sysfs entries
>> for available scale/frequency? Eg, if I wish to expose the supported
>> values via sysfs I still need these attributes? Implementing the
>> read_avail() as well is not a problem though.
> 
> Need to also set the relevant bit in
> info_mask_shared_by_xxx_avail in the channels for the sysfs files to be created

Thanks for the help! I missed this. I'll try that :)

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

