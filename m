Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF2267B16F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjAYLew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjAYLej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:34:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B515C82
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:34:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r2so16716132wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0whpO4cbXzR1tiN4DzvNKJ/HfGU7YFSCpWie8Zua84=;
        b=CK2Et2ENldqVneTdeYBGCfDSADiC+JkZV9SYegfHCo46+6tX4hXP6e7gc1hZJRMIam
         gMQ4eIYhcW9MlUUTmUTBIvJmrjs54uEA5crk72FlVonOxx9atVFPAQtE6td1NFkaWXJu
         QdT+6NiMTS4gQ9P13schTIVsWV/MN8psRO2rF3GR/JDnoelCN1H9KcEoRD1Uq+qhe3M/
         BnjkO00eOzi1MuzWd3UiX70Dcbxly2rdzRA2SjfmrL2LlmnPdWKNF5UprlbmZZg26JcP
         +bXfoRrOmgsIhioAOqpiOpUmYW5wnMDKJDo/iWQjPhNxvVBYO3eNF+O4bsW0JojDVQ/e
         q3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0whpO4cbXzR1tiN4DzvNKJ/HfGU7YFSCpWie8Zua84=;
        b=V8n7iGCi7q6CLgU9FiQVmFHwWig4E7p6NFPK3pfYT8M3ZfVY0wp5xf5HiJge9JQ5DT
         2fcJmJkoyzv2/HrdcQCPoP4BsRq8TGyQd0FfkZZUE6AEDtzawaYKEGsLBC10EbDu1cn8
         hxWxxcoo8H01ZfObvBwRe7B+tjiRGxrBzMzr5ie6J/Tt7lrVtmHSqh8qqfe3VPCQc1rC
         oN+L1jAdAEDwYx2wd8o7c+DIkD6Yodb8flANh7mSblYL2a5QOhlaXK/nNOePTSF7Qw+y
         mRw/4IEOF5t6ZmkXtLj15hmjpwAGzbZl2Nm2vjSZ4Cu8KnbYKOyWXucLRaCIp5NAPKQL
         wdIA==
X-Gm-Message-State: AO0yUKWGOsmBJG3YKO3g0xC1udE6X2UAKqy9WJIeojzm0ZVj7O877nBC
        qdbeFdhc58ASsBhJ2vqHnppedw==
X-Google-Smtp-Source: AK7set/8+c33YavXOYtKD1LSh3zE+1ZWgScYR5anmuPGJvgD9aiQ4pFIQMGKXfwcJplkA009zs+OxQ==
X-Received: by 2002:adf:ec0f:0:b0:2bf:b661:87d9 with SMTP id x15-20020adfec0f000000b002bfb66187d9mr3089897wrn.50.1674646475202;
        Wed, 25 Jan 2023 03:34:35 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q14-20020adff78e000000b002be07cbefb2sm5011854wrp.18.2023.01.25.03.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:34:34 -0800 (PST)
Message-ID: <ae3d5dd0-8d68-9d4e-c98c-7284d1ebeccc@nexus-software.ie>
Date:   Wed, 25 Jan 2023 11:34:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: camss: Missing cleanup on probe error
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, Todor Tomov <todor.too@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <5898403.lOV4Wx5bFT@g550jk>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <5898403.lOV4Wx5bFT@g550jk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 20:02, Luca Weiss wrote:
> Hi all,
> 
> I hit an issue that was already fixed with upstream commit 3d658980e6da
> ("media: camss: Do not attach an already attached power domain on MSM8916
> platform") but this showed that some error handling is missing in camss_probe.
> 
> After these errors the resources aren't cleaned up and e.g. sensor drivers
> still try to probe but fail quite badly because some things are NULL or
> whatever.
> 
> [    1.979098] qcom-camss fda0ac00.camss: Failed to configure power domains:
> -17
> [    1.989327] qcom-camss: probe of fda0ac00.camss failed with error -17
> 
> The commit causing this (or at least part of this) is 2f6f8af67203 ("media:
> camss: Refactor VFE power domain toggling")
> 
> I tried a bit to add some error handling but in this case it now fails at
> v4l2_device_unregister_subdev -> media_device_unregister_entity ->
> __media_device_unregister_entity -> ida_free.
> And I'm not really sure how to fix (and honestly not super motivated).
> 
> See following patch (formatting probably messed up, sorry). Maybe someone who
> knows a bit more about the driver or the media subsystem can fix this, thanks!
> 
> Regards
> Luca
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/
> platform/qcom/camss/camss.c
> index 16545cecc4f4..0ba3c378d241 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1836,21 +1836,26 @@ static int camss_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	ret = camss_configure_pd(camss);
> +	//ret = camss_configure_pd(camss);
> +	ret = -17;
>   	if (ret < 0) {
>   		dev_err(dev, "Failed to configure power domains: %d\n",
> ret);
> -		return ret;
> +		goto err_configure_pd;
>   	}
>   
>   	pm_runtime_enable(dev);
>   
>   	return 0;
>   
> +err_configure_pd:
> +	media_device_unregister(&camss->media_dev);
> +	media_device_cleanup(&camss->media_dev);
>   err_register_subdevs:
>   	camss_unregister_entities(camss);
>   err_register_entities:
>   	v4l2_device_unregister(&camss->v4l2_dev);
>   err_cleanup:
> +	v4l2_async_nf_unregister(&camss->notifier);
>   	v4l2_async_nf_cleanup(&camss->notifier);
>   
>   	return ret;
> 
> 
> 

I'll take a look
