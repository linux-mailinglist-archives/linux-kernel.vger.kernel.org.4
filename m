Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A231B6120BD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 08:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ2Ggk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 02:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2Ggi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 02:36:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4458DCEAC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 23:36:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p8so11527564lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 23:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SX79OcFnzFmNh9O1kQChmt48pJKtZVdmieFsDvN9MK0=;
        b=cxmnlgp4tbwqnXT6MRK29rBaH/MuzoXkpIEBbloRif7Ec7p2u5lSdBORvBldsp/yzE
         e34eNxXb+cuBHYv3Y4WjqX1CmaWGbXcIKNVsQS6urciRCo3Wy05JUjG7/n0d99WUL9yk
         Q4aPsupcuzzfZcBClu6z9m/I+VgjJE81Y9A9jCB8zDE5tvovCPheXKOm436AWA3Zjrkt
         U3FTGOwTX5dwYGUqeppOMUbWlVkH9x0NbFu75+hvOfAXC63ZD1jwkl+r9VCwrPB/AffL
         XW+3EdIz7+6a8wQV8LVK41JTt25WHKipQY8tlAmEDq62zfZykENW8KmoTAmHtN4OjXo1
         MclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX79OcFnzFmNh9O1kQChmt48pJKtZVdmieFsDvN9MK0=;
        b=VqKpqgYaXlNUnUdjqveKDAV8Kw92loCrkeqvPi4OBkDCVAvJs052drcNvPkPLWXKE+
         0P27pFhTSXSMEli8rX/t7GCMCd9bo+cI5NbfUdZxvtuS3IWE59nX/pA89+3XSNV4D/Qb
         5Sb1a46PaWFrApYsynnZByDWiQ0KFH8raSpj5zoBvfBaT1Umqp75Wb6Jc22ofddRsD5K
         xr2Rxv3lqaYIhELAsmDYLJ38Q/o64ulo13M5xTRhOzdPYJBhbXkjA1Rm/cSaQiWEYr1l
         1UgzAXRFIBUnJOMPEHYwG1X3EhwHEj/MQc+Bf/24zNIE/u5krvwEwNUDOltHtEHOWdws
         sXPA==
X-Gm-Message-State: ACrzQf1qOcqhPKjrh8h/2Q08YmNTbAJSyUO82gwTZ3GmMnDeDQ5gFjOB
        TGg+/OrMcB3eV3qovOMFRHM=
X-Google-Smtp-Source: AMsMyM45mJhyP7YjjOqTLTNcQNJTxPeqKLlKj0a9ZJfdhMkXmMHvfuz9vbbOYrhM9FdlNa1yUqFPJA==
X-Received: by 2002:a05:6512:3501:b0:4a1:fa45:5008 with SMTP id h1-20020a056512350100b004a1fa455008mr1125634lfs.42.1667025395936;
        Fri, 28 Oct 2022 23:36:35 -0700 (PDT)
Received: from [10.0.0.42] (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id h5-20020a2ea485000000b0026b2094f6fcsm96534lji.73.2022.10.28.23.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 23:36:35 -0700 (PDT)
Message-ID: <6cc2948c-04eb-d62b-dfa0-5a94544ea6c9@gmail.com>
Date:   Sat, 29 Oct 2022 09:45:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] soc: ti: k3-ringacc: Allow the driver to be built as
 module
To:     Nishanth Menon <nm@ti.com>
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        nfrayer@baylibre.com
References: <20221021080231.1076-1-peter.ujfalusi@gmail.com>
 <20221028005521.gzdo46oz65cxlthd@recent>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20221028005521.gzdo46oz65cxlthd@recent>
Content-Type: text/plain; charset=UTF-8
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



On 10/28/22 03:55, Nishanth Menon wrote:
>> @@ -336,6 +336,11 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
>>  
>>  	mutex_lock(&ringacc->req_lock);
>>  
>> +	if (!try_module_get(ringacc->dev->driver->owner)) {
> 
> Does a cascaded error handling make sense instead?
> 
> goto error_mod_fail?

I think it does not make the code nicer, but I can do that way

> 
>> +		mutex_unlock(&ringacc->req_lock);
>> +		return NULL;
>> +	}
>> +
>>  	if (id == K3_RINGACC_RING_ID_ANY) {
>>  		/* Request for any general purpose ring */
>>  		struct ti_sci_resource_desc *gp_rings =
>> @@ -380,6 +385,7 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
>>  	return &ringacc->rings[id];
>>  
>>  error:
>> +	module_put(ringacc->dev->driver->owner);
> 
> error_mod_fail:
> 
>>  	mutex_unlock(&ringacc->req_lock);
>>  	return NULL;
>>  }
>> @@ -616,6 +622,8 @@ int k3_ringacc_ring_free(struct k3_ring *ring)
>>  no_init:
>>  	clear_bit(ring->ring_id, ringacc->rings_inuse);
>>  
>> +	module_put(ringacc->dev->driver->owner);
>> +
>>  out:
>>  	mutex_unlock(&ringacc->req_lock);
>>  	return 0;
>> @@ -1450,6 +1458,7 @@ static const struct of_device_id k3_ringacc_of_match[] = {
>>  	{ .compatible = "ti,am654-navss-ringacc", .data = &k3_ringacc_data, },
>>  	{},
>>  };
>> +MODULE_DEVICE_TABLE(of, k3_ringacc_of_match);
>>  
>>  struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
>>  					    struct k3_ringacc_init_data *data)
>> @@ -1544,12 +1553,26 @@ static int k3_ringacc_probe(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +static int k3_ringacc_remove(struct platform_device *pdev)
>> +{
>> +	struct k3_ringacc *ringacc = dev_get_drvdata(&pdev->dev);
>> +
>> +	mutex_lock(&k3_ringacc_list_lock);
>> +	list_del(&ringacc->list);
>> +	mutex_unlock(&k3_ringacc_list_lock);
>> +	return 0;
>> +}
>> +
>>  static struct platform_driver k3_ringacc_driver = {
>>  	.probe		= k3_ringacc_probe,
>> +	.remove		= k3_ringacc_remove,
>>  	.driver		= {
>>  		.name	= "k3-ringacc",
>>  		.of_match_table = k3_ringacc_of_match,
>> -		.suppress_bind_attrs = true,
> 
> Might be good to note sysfs behavior change in commit log?

Since the udma driver kept this I will keep it here as well.

> 
>>  	},
>>  };
>> -builtin_platform_driver(k3_ringacc_driver);
>> +module_platform_driver(k3_ringacc_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
> 
> GPL ? checkpatch should have complained?

Yes, it complains if I run it ;)

> 
>> +MODULE_DESCRIPTION("TI Ringacc driver for K3 SOCs");
>> +MODULE_AUTHOR("Grygorii Strashko <grygorii.strashko@ti.com>");
>> -- 
>> 2.38.1
>>
> 

-- 
Péter
