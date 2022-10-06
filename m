Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620EA5F66F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiJFMzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiJFMzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:55:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F04DA6C34;
        Thu,  6 Oct 2022 05:54:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g1so2527334lfu.12;
        Thu, 06 Oct 2022 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jgwtLPJ++8LIBXvoR40Ojn/bqP9gjiaU+M/jYaXBo5k=;
        b=ckl50uFPWPylS0hGbvj8cr3bZ+XnkIx6hWD5aDIGMfrqr6xPMfSrWtn93ToxYD5lRp
         vJCeGeIDPsVKugYLYhsBh8TFIbuLHcqkkIbj8M8Ajk3mUuV6oTZwWXwMjmCmtx2OiiW4
         mLdHN5XD190L0bTRcAItO1XAENJiH4SW9HQUQVtSoT2grWihidF8KO0IL+UfR4VLJ0qA
         UpsLtsk77dYkcE33svn+oFYxnPVBCfTqYcru1a00fpr8ebb5I4foZr0lJxR3PYYwt5HT
         lSFrLex0im4NGIzfLGU3Vb/DsgaXXEzuo8GD6bvvT1ZgVVkinh6QtGKmtNWWVg62yEfH
         yTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jgwtLPJ++8LIBXvoR40Ojn/bqP9gjiaU+M/jYaXBo5k=;
        b=U++s7gZAhUvJevJzpZ6rHtYgzDXuxYDh4CwU1gd/nuI1r6IzjoW+sRC9nuyHTM+fFL
         /Qm5wfwyBhexnV++JOPyrO9uppMKXtmq7cipIpGe1vyQx+8w65YKgmBvfGgJOzJifUro
         VdKYgL82g/58fgbHrW5DCY6XaDO3JTzC7OWwlPH9pf24nxdF67RcsMi6afUuUBrRKesC
         u8cXI+S7TU9nLGd791Y3Z3hXBFbpseIhlqz9qge0GZOVgJ7YfRpkfUwQOJmgA/TCPqeJ
         aRRhaIDZrOiMnoOv20zZ387ZEO8YxpPurpXrR4k8r1UZm8xYUYqkG0YR+ymXv1SJUtqJ
         Yg/w==
X-Gm-Message-State: ACrzQf07O8reOeGiYU6U/zXG+2WmZdF/QiK8Hxe24bEAqLT9wWDA7zkS
        2YhcWOvtn1yT49kJH81wwGc=
X-Google-Smtp-Source: AMsMyM54GsEvYJD0wKautAAAWm5cvHk0bNLRw0sbM04efA9nFAioyhHR5MF+cE9jwNmgDE6x4MHjnw==
X-Received: by 2002:ac2:539c:0:b0:4a2:259c:c849 with SMTP id g28-20020ac2539c000000b004a2259cc849mr1847119lfh.323.1665060835453;
        Thu, 06 Oct 2022 05:53:55 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id by37-20020a05651c1a2500b0026dce5839fdsm1584342ljb.94.2022.10.06.05.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 05:53:54 -0700 (PDT)
Message-ID: <8ef99012-4959-a674-13c1-186b9c1c2cd4@gmail.com>
Date:   Thu, 6 Oct 2022 15:53:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com, matti.vaittinen@fi.rohmeurope.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        cosmin.tanislav@analog.com, jic23@kernel.org,
        Eugen.Hristev@microchip.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, bleung@chromium.org,
        groeck@chromium.org, alexandru.ardelean@analog.com,
        nathan@kernel.org, miquel.raynal@bootlin.com, linmq006@gmail.com,
        u.kleine-koenig@pengutronix.de, paul@crapouillou.net,
        mihail.chindris@analog.com, gwendal@chromium.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
References: <cover.1664782676.git.mazziesaccount@gmail.com>
 <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
 <c163203c-d87b-7e71-f582-964a99e37efb@microchip.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <c163203c-d87b-7e71-f582-964a99e37efb@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On 10/6/22 11:35, Claudiu.Beznea@microchip.com wrote:
> On 03.10.2022 11:13, Matti Vaittinen wrote:
>> The iio_triggered_buffer_setup_ext() and the
>> devm_iio_kfifo_buffer_setup_ext() were changed by
>> commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
>> to silently expect that all attributes given in buffer_attrs array are
>> device-attributes. This expectation was not forced by the API - and some
>> drivers did register attributes created by IIO_CONST_ATTR().
>>
>> When using IIO_CONST_ATTRs the added attribute "wrapping" does not copy
>> the pointer to stored string constant and when the sysfs file is read the
>> kernel will access to invalid location.
>>
>> Change the function signatures to expect an array of iio_dev_attrs to
>> avoid similar errors in the future.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> on SAMA5D2
> 

Thanks a ton for the testing! I do _really_ appreciate it :) I am now 
slightly more confident regarding the fix here - and a lot more 
confident that we do have an actual bug (as you explained in the reply 
to the first RFT) :)

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

