Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12D571227A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbjEZInQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjEZInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:43:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D4EE53
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:43:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f1411e8111so502662e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685090580; x=1687682580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5Kfhw+9CaJ0j/V6VRJ6bWfGNa0fy6gbb/Nv+Rehbro=;
        b=lufWUASwRJoazthcTBLZC58sQdGPlHgAgHDTZyFwkiCwme590hANNyz8Alj9AaFKc/
         +ABWkshV5xjFIP/C1OgDN6Q7DK6C2IbTehKPs7RatOW86oE41rms68c03eHPnPdQbuMp
         b5zDP5j2VTrOPR+n+1l+wWAF3tLoOvFUqa0jUq1vedAsawwr7K++gubmcIfFo5hi1Vu9
         2+ngUvCPQQscshVJS5rIWJXY5XCSQjEuSwj6zgo7sEQshInWOSS9Ja7dfaaPNhuR7m+k
         ePs5J/OuB7A8jCz9JXA/AL+UpWop2v2FHExkIuAXFTOGM2ag/Pph1smxCz9rlXCd6MC4
         uP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685090580; x=1687682580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5Kfhw+9CaJ0j/V6VRJ6bWfGNa0fy6gbb/Nv+Rehbro=;
        b=HcMiKPm6pIvjpOiY2v7B342wIs447UyEzeDAc37XlKbW+bSrF+MRH9kthvASttME/o
         VhMQgOmuMa6ciYn5ohFVVq10Pv3MV9H2RB+xwQFw7pz0EhS52p765hlNZAN3Xsw6s82c
         9pSahJTJSp8cc+kF9LWnVCbSb8JmwQp7iKDZfQwHWrs5Dh2Hfr1WUNCUbhdRd+IQD50l
         HABZFyj73rIpFaxSQTrimgS1++LQmSKW5fJSN8QBSSGYXEmg6ECwAjhmJFkj2xP67czp
         swlWZTO70UT5P8nEZ+ibAqodZixAoYYWBZuFHl3IRFMuufb+1+MJ2XMVGX1/j2SN2+hO
         4Q7A==
X-Gm-Message-State: AC+VfDz7sxEclLCJghNh+LeLQgDUmbtADGrw62A4h5cnw8eJFIbNOPu7
        B27cXLQgeIpAhkUgWR3awjFRf4LbojbLyIUrtMQ=
X-Google-Smtp-Source: ACHHUZ5QjAdqKQi45/6vwRz5lVDs1bwVz+ievEd0FHtpAv1KWZ8vWv4hA6/3H4ST0UD1AC8IfMEv1Q==
X-Received: by 2002:a2e:84c1:0:b0:2ac:8a05:b2c7 with SMTP id q1-20020a2e84c1000000b002ac8a05b2c7mr469389ljh.7.1685090580528;
        Fri, 26 May 2023 01:43:00 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id t4-20020a2e9c44000000b002ad99aa3fa8sm617332ljj.13.2023.05.26.01.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 01:43:00 -0700 (PDT)
Message-ID: <ed1f3496-184c-c9e1-8c46-1602d35effde@linaro.org>
Date:   Fri, 26 May 2023 10:42:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/5] soc: qcom: smem: introduce qcom_smem_get_soc_id()
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, ansuelsmth@gmail.com
References: <20230525210214.78235-1-robimarko@gmail.com>
 <20230525210214.78235-3-robimarko@gmail.com>
 <a196330e-9d70-1bbd-6fae-7d60eb06e478@linaro.org>
 <20230526023325.y7iqygmbtjmbf4zo@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526023325.y7iqygmbtjmbf4zo@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.2023 04:33, Bjorn Andersson wrote:
> On Fri, May 26, 2023 at 01:18:17AM +0200, Konrad Dybcio wrote:
>>
>>
>> On 25.05.2023 23:02, Robert Marko wrote:
>>> Introduce a helper to return the SoC SMEM ID, which is used to identify the
>>> exact SoC model as there may be differences in the same SoC family.
>>>
>>> Currently, cpufreq-nvmem does this completely in the driver and there has
>>> been more interest expresed for other drivers to use this information so
>>> lets expose a common helper to prevent redoing it in individual drivers
>>> since this field is present on every SMEM table version.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>> Changes in v4:
>>> * Change helper name to qcom_smem_get_soc_id()
>>> * Remove len and just pass NULL, that is sufficient here
>>>
>>> Changes in v3:
>>> * Change export to EXPORT_SYMBOL_GPL
>>> * Use an argument for returning SoC ID
>>> * Update kerneldoc
>>> ---
>>>  drivers/soc/qcom/smem.c       | 23 +++++++++++++++++++++++
>>>  include/linux/soc/qcom/smem.h |  2 ++
>>>  2 files changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>>> index bc98520c4969..78cf79ea4924 100644
>>> --- a/drivers/soc/qcom/smem.c
>>> +++ b/drivers/soc/qcom/smem.c
>>> @@ -14,6 +14,7 @@
>>>  #include <linux/sizes.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/soc/qcom/smem.h>
>>> +#include <linux/soc/qcom/socinfo.h>
>>>  
>>>  /*
>>>   * The Qualcomm shared memory system is a allocate only heap structure that
>>> @@ -772,6 +773,28 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>>>  }
>>>  EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
>>>  
>>> +/**
>>> + * qcom_smem_get_soc_id() - return the SoC ID
>>> + * @id:	On success, we return the SoC ID here.
>>> + *
>>> + * Look up SoC ID from HW/SW build ID and return it.
>>> + *
>>> + * Return: 0 on success, negative errno on failure.
>>> + */
>>> +int qcom_smem_get_soc_id(u32 *id)
>> __le32 *id
>>
> 
> Why do you want this passed back to the user in little endian? When is
> it not going to be compared to a cpu-endian constant?
Ugh. You're right. This makes no sense.

Konrad
> 
>> LGTM otherwise!
>>
>> Konrad
>>> +{
>>> +	struct socinfo *info;
>>> +
>>> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
>>> +	if (IS_ERR(info))
>>> +		return PTR_ERR(info);
>>> +
>>> +	*id = info->id;
> 
> This should be __le32_to_cpu() though...
> 
> Regards,
> Bjorn
> 
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
>>> +
>>>  static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>>>  {
>>>  	struct smem_header *header;
>>> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
>>> index 86e1b358688a..223db6a9c733 100644
>>> --- a/include/linux/soc/qcom/smem.h
>>> +++ b/include/linux/soc/qcom/smem.h
>>> @@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
>>>  
>>>  phys_addr_t qcom_smem_virt_to_phys(void *p);
>>>  
>>> +int qcom_smem_get_soc_id(u32 *id);
>>> +
>>>  #endif
