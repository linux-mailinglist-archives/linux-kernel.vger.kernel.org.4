Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E75F60B47E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiJXRrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJXRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:47:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D1C14DF2B;
        Mon, 24 Oct 2022 09:23:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kt23so700696ejc.7;
        Mon, 24 Oct 2022 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hP8b5SS/NsW2nMLW/xSwPyyreIz/0UJMi8FgJ7xYbiY=;
        b=dNM2IXi+yYy6NnfdJ0TWhvuVgBAl+4pS8y/Xs7eHyDthyelxiOrwCJ2MEm484pEee7
         FsCzK0hK4j9dQJQdUC/VItm1G6DklEZV6krCcMu9ShYPfsnZ8IfGLVvUH57PgzTVG1Rk
         2h9QjlQwGsn4TEIRl7DUjsnnxEUa3zzEFPq072nA8G233sfQb8AaFSk/VSIFJjnMH0DV
         HKi4BtKavXvMJ0YqKZwwhMTETchk9k8FeINrfelCyow4ZD/KQJvhor1AeHMOvYuEiCSg
         6yr6i+0zGKEAc8z7igya8o7OuyAJjzoW/q0GkyJmU8nJ72KzKK0gl1N/5t+4wxbTNY2b
         WgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hP8b5SS/NsW2nMLW/xSwPyyreIz/0UJMi8FgJ7xYbiY=;
        b=RT8w61t2q03P51m/PigJPdBxZNfN/t6IMWUjy6ifyk06qqQs70zQ1vyekO5KNJLjaj
         Oy5XyxGDMisbx7PEZJF1OnvJNv3KkHNJjzYk/SS4L1NrKi/sCyu3AkAnh8JqhZV8q4Y7
         CLfb42QO04yJSfc37XLyybPnH46gguOz3S4y74SO/wTSw8UhktflVvAa5Dtlq4kXpbNQ
         SkkeledsAMbSWfWmQQoyzkLoz9zHan/wA4NsFrt7cHL19bYXeLY89CRXMYghb5UKhUaP
         aIunXrpLKoylXKCMrJ0SYd4u6Bnvzpmk4srW+U2+iDEMtzXxNImZV2A+PxWF9Ut5IBu5
         yEzg==
X-Gm-Message-State: ACrzQf0r8d0ZtDzde59nskMfLss/8wH5h1JVhruCXxmQBpl5I1g+WJsb
        9k7AZuXwr2+K3Ml9ASBvcvVsmUD8Y1o=
X-Google-Smtp-Source: AMsMyM7Cg1lEvF1ex7ag4vTHjVpCu9JynpVIzJ3mjmVZwbfOJxh18CRJCEfRbJb7+Z8sToY2Hx7afg==
X-Received: by 2002:a2e:a7c5:0:b0:26f:c304:a16f with SMTP id x5-20020a2ea7c5000000b0026fc304a16fmr12556208ljp.47.1666620974864;
        Mon, 24 Oct 2022 07:16:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::2? (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id 11-20020ac24d4b000000b00492dc29be7bsm4544141lfp.227.2022.10.24.07.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:16:14 -0700 (PDT)
Message-ID: <4e6d331b-0cc3-de9b-9fa2-96981f594c83@gmail.com>
Date:   Mon, 24 Oct 2022 17:16:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     DDRokosov@sberdevices.ru, andriy.shevchenko@linux.intel.com,
        demonsingur@gmail.com, devicetree@vger.kernel.org,
        jagathjog1996@gmail.com, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, nikita.yoush@cogentembedded.com,
        robh+dt@kernel.org
References: <cover.1666350457.git.mazziesaccount@gmail.com>
 <7baf3dd482ab1db0d8a3676d6d5d3e4ab7f3cf9d.1666350457.git.mazziesaccount@gmail.com>
 <3ad8b485-9007-f7e9-f52a-d5644a688bcf@wanadoo.fr>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <3ad8b485-9007-f7e9-f52a-d5644a688bcf@wanadoo.fr>
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

Thanks for the review Christophe,

On 10/24/22 16:34, Christophe JAILLET wrote:
> Le 21/10/2022 à 13:22, Matti Vaittinen a écrit :
>> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
>> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
>> tap/motion detection, wake-up & back-to-sleep events, four acceleration
>> ranges (2, 4, 8 and 16g), and probably some other cool features.
>>
>> Add support for the basic accelerometer features such as getting the
>> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
>> using the WMI IRQ).
>>
>> Important things to be added include the double-tap, motion
>> detection and wake-up as well as the runtime power management.
>>
>> Signed-off-by: Matti Vaittinen 
>> <mazziesaccount-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> ---
> 
> Hi, should there be a v5:

I did already send out the v5 shortly before your review. If I need to 
send v6 I'll apply your suggestions.


Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

