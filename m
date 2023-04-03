Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA36D466C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjDCOE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjDCOEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:04:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0CB170F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:04:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ml21so5347695pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680530690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWC5OUsnMEG/wy8PZ88/2WhJNwsVNvzCvOBVfTb924s=;
        b=bWo2P03yK1CmVrLbp8JEaZB3yJFdpgAcIhTCQXu9QQuajj9izkKMEi2zO3BGfFcR7S
         L7DusyqE6r6a5i69+a2PsB6w7Ia5Y2PDBIZ3DeI/jJk7fByby85chnfpJt69k2Z2w+16
         37cKNkVU2X9XlK7zocVCsMqgs1Y9B38+liwqGHh2ZonDo7qxM969K7q1PUbAdX2yga9x
         Sxj4/HV0QqTFe3KDm5WXRoNzOx+oy9UndDhtBY99IXn8yTdS9nEWxf68K5HHhsnSdGE0
         z6oSlC8RznyqFjAM99LUvE1QI1NYMDVjO7mBAsWhVu3pATIQpBOlU2rzj6OGTp2tJlqG
         0C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680530690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWC5OUsnMEG/wy8PZ88/2WhJNwsVNvzCvOBVfTb924s=;
        b=tmx7ZcPRq3f+/UtWvTBxLFkA4ZxTUfhZse2WkftPBH6CPLfLXjZDrJXS1MtH1KZmBQ
         /0hKG1Fz6cLflVPpeSYaUPQ0H3CcRj2QzYPqVsf3DEybBtYyfC0yDKJSiXeW6WNyOVbH
         +Ub2eF6aSVwbIS9o0LUAHmpHHr/cCVQTV6QIeBxk53b8KTHv9xhRT/mHiUUnCzSYWBEW
         NhqsVGT4PIgJSWTZAXfVrfwsEju2Pv+06NigwlbjU1cQljOt3hFSvUsMG02Q/7M6gxoP
         qsOLrcueFJksB4nmAgIjloJtbs0o/V5fmmhqRpKA2m5W6Q2oJyVWz6SbTfmkkQoYh3kp
         zA5A==
X-Gm-Message-State: AAQBX9cZhtOsHWzLTYZib/wA3QVwZT3wwepaVT4tn261NKvq1uFJc5wz
        VKBftfvjoSZFVkjsy6D3hJJkDzUgiNDURA==
X-Google-Smtp-Source: AKy350bw6B4SK+vSlyns7Q5Lg/gtKayV2nDj71g1joO/jL8L+La8JsFP9f/YPqEoBTscDaP3fYsGOw==
X-Received: by 2002:a17:903:2948:b0:19c:f232:21ca with SMTP id li8-20020a170903294800b0019cf23221camr34638773plb.3.1680530690442;
        Mon, 03 Apr 2023 07:04:50 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b001a1faed8707sm6644812plh.63.2023.04.03.07.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:04:50 -0700 (PDT)
Message-ID: <219812f6-0e36-dfb5-01f3-0733f911f198@gmail.com>
Date:   Mon, 3 Apr 2023 23:04:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 03/14] extcon: Use DECLARE_BITMAP() to declare bit
 arrays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-4-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 22. 23:39, Andy Shevchenko wrote:
> Bit arrays has a specific type helper for the declaration.
> Use it instead of homegronw equivalent.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 79006ab5334b..70e9755ba2bc 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -230,10 +230,10 @@ struct extcon_cable {
>  	union extcon_property_value jack_propval[EXTCON_PROP_JACK_CNT];
>  	union extcon_property_value disp_propval[EXTCON_PROP_DISP_CNT];
>  
> -	unsigned long usb_bits[BITS_TO_LONGS(EXTCON_PROP_USB_CNT)];
> -	unsigned long chg_bits[BITS_TO_LONGS(EXTCON_PROP_CHG_CNT)];
> -	unsigned long jack_bits[BITS_TO_LONGS(EXTCON_PROP_JACK_CNT)];
> -	unsigned long disp_bits[BITS_TO_LONGS(EXTCON_PROP_DISP_CNT)];
> +	DECLARE_BITMAP(usb_bits, EXTCON_PROP_USB_CNT);
> +	DECLARE_BITMAP(chg_bits, EXTCON_PROP_CHG_CNT);
> +	DECLARE_BITMAP(jack_bits, EXTCON_PROP_JACK_CNT);
> +	DECLARE_BITMAP(disp_bits, EXTCON_PROP_DISP_CNT);
>  };
>  
>  static struct class *extcon_class;

Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

