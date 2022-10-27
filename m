Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CED60F4C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiJ0KTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiJ0KTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:19:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DFF115C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:19:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so3814108wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3v8EBCOL/pBarxV0ODSGCNmHcX5fEuS/fZKHlL3Tpw=;
        b=gKA2dW3fJ2rFkjzoulrUEa0ZDzOT0UEWyrFD/SIlWhEb6Whcmyl6CQAToGDwyRWYIJ
         L256X0v3MeZ37S0/8KOzsxMjhEGFBmJJDa3AxZR6Q2WocPGUKDteY2MxuuKoDQdgzV/M
         5HMuHkRSrZgeZFcaC9hGoL/xffJEUk944P8pq6u/+WeCzeApEbiuAX7XQWGNkpbo3PoL
         ymvNPOx4jvD+0ZlMbF1UJPli0/VxcBsd6pf4ScXWLGf8clXlSjovCcPOLlrO9+85LmpL
         ysiq4xEo4G50hftAGd4vfdz3bH9w49ipcSdKOwEX4oZbEiSZJF9QmdTGDZE9Gun1Lkur
         uEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3v8EBCOL/pBarxV0ODSGCNmHcX5fEuS/fZKHlL3Tpw=;
        b=d4AbSJHy8+07MvWL3YUioD+uItbuOugaZn0efJIHvpjEPY63pjqbF3HKAPWj5mH2/2
         7CTGc7lPJ1EvFCQy3JTAmASAKNn9AnY7Xu8dQuF4ZFM8Sw6w95fXLlfLeqxXMvQmhmpd
         6DCMrwqKA8WH8bkgrxtqcYznt4/BsSPgbCArUMMGQ1/MwizhkmswWPCTvqkzmflJulmI
         AMFbCJ192kBGwOZ1gIxtZcW6fNOisWAsbSLzcZ0GEAwAYHzAxc0Wu+UzYgo6sSqmmfIH
         c3CutFkImtBtQjqLM8AmIoiBAnhJdFZY+00/vZkzk5zDDm+x07qANI6Uz0G11MTegc+E
         AsWw==
X-Gm-Message-State: ACrzQf0zPuqmEL3CiFO2wBzyyE6th0g3IzPKi9QAyEwpWKQu8Y+qdOc8
        wZ/ejWxgeiBmduiVqlbvmIj2Tw==
X-Google-Smtp-Source: AMsMyM7Z0QwLULgwz0dq3qhv6BQb+6iwiHd/mM4Ad8Zaf10YeEBPSMLE6J0xqkKIeai1eHLPuCoM9g==
X-Received: by 2002:a05:600c:1c9d:b0:3c5:8081:1fc4 with SMTP id k29-20020a05600c1c9d00b003c580811fc4mr5425907wms.161.1666865974182;
        Thu, 27 Oct 2022 03:19:34 -0700 (PDT)
Received: from [192.168.1.194] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id l3-20020a05600c4f0300b003a5f3f5883dsm4703642wmq.17.2022.10.27.03.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 03:19:33 -0700 (PDT)
Message-ID: <619a829e-d902-eba9-537e-176a8acb149c@linaro.org>
Date:   Thu, 27 Oct 2022 11:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] soundwire: qcom: add support for v1.7 Soundwire
 Controller
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
 <20221026110210.6575-7-srinivas.kandagatla@linaro.org>
 <e3ebba30-65ec-183a-eb91-c5147c28441d@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <e3ebba30-65ec-183a-eb91-c5147c28441d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 26/10/2022 21:14, Pierre-Louis Bossart wrote:
> 
>> @@ -1582,6 +1597,7 @@ static const struct of_device_id qcom_swrm_of_match[] = {
>>   	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
>>   	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
>>   	{ .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_6_data },
>> +	{ .compatible = "qcom,soundwire-v1.7.0", .data = &swrm_v1_5_data },
> 
> is this line intentional, it looks odd that 1.7 is compatible with 1.5,
> but 1.6 isn't?
This is more around the data rather than compatible, 1.6 data is marked 
with sw_clk_gate_required = true which is not the case with 1.7.

from 1.5 we use same frame shape info for 1.6, 1.7, except that 1.6 had 
this sw_clk_gate_required flag set.

--srini

> 
