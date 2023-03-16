Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005536BD58B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCPQ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCPQ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:27:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326CFD5896
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:27:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a32so2283593ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678984054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgoI8HDAw8DGqGULBmPS4IbGiPxejev4P/nypOOejrw=;
        b=l2gZDY2Z3j0UJx8PNYzO/gjPYttRRjWs+xVVJA5Gn7e6XuvANExiJC60railcxmyaI
         LyOjWbjjrCBemZmJpMi/oBFuy5JifneesVoTXxeeudi6COAfOP3qBavy4dhqi3QTDhlL
         R5DToKUh+SCN5k+FhtuB6JGRZuREZC5tpCs/82c9/ueYAAf0y2xYrHlHlpKlR9lvXPph
         /6KvihiWSJYkid880uvXVcXOILIO2zDe02KpulUTyCiVPjEHR367R+iHBnhA/L1dJk8N
         Q4b4OxpYUim0vRpAA09G4fgLnVk6qL/94lsPeTwyud4cDwcLd85GrUcWC2q9h16+bUhz
         ztdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678984054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgoI8HDAw8DGqGULBmPS4IbGiPxejev4P/nypOOejrw=;
        b=U4ckzm5eHlGTyB+TLAQYrS1Jv3niUbaSFd/cE1Nn/2cKgkOUWwvyHLCSwfAbcakpUs
         U19UpMgri/NZkxp0/rxSka0qlIBTF3Mj/WhlLvW+OHbzsRQsG7G9FlJ0LCTBY48gzEhv
         CCoYg1djl95aG7KyFZ2DsfqUqWyhIkuJgVrMbb53SgDVMxZy/CRyTGRufnLPaNq0x10l
         BH7YbgZDnkMCZSPj5HiTL2rBrfH+ioZHyQuJq+fGnYYp/aDikNKcQ2wv8jdcpCngglSm
         CW0NrdVchTcgQljC4t1l+gH10jUsr/13UTpg5jE7Od5RxDNlPh0PCmYiyQGWYxXFQYSj
         zq5A==
X-Gm-Message-State: AO0yUKV9pYpesDlF3F4UGKn9FZkHjpxvaHzKA5xm7XbBD1YGLAouBgsU
        8En1Ne7ZEpoEUwMHwM8ljzEVqw==
X-Google-Smtp-Source: AK7set+uiTFWRcANc6aH1W5Zx6iNStZaeFHhy4gIvHevv9TobMbS7+YWEYeKYUNq+RNSZVVs2JjeQw==
X-Received: by 2002:a2e:869a:0:b0:299:bb73:fcd4 with SMTP id l26-20020a2e869a000000b00299bb73fcd4mr395061lji.7.1678984054475;
        Thu, 16 Mar 2023 09:27:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b5-20020a056512218500b004d85f2acd8esm1276211lft.295.2023.03.16.09.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 09:27:34 -0700 (PDT)
Message-ID: <a0181586-817c-e093-990f-5f95c10aadbd@linaro.org>
Date:   Thu, 16 Mar 2023 18:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/4] firmware: qcom_scm: Refactor code to support
 multiple download mode
Content-Language: en-GB
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
 <1677664555-30191-4-git-send-email-quic_mojha@quicinc.com>
 <469b4a3a-ea40-ad6b-2848-210325b8914c@linaro.org>
 <fe07806e-e77b-1198-1ffb-be8e2df53dd6@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <fe07806e-e77b-1198-1ffb-be8e2df53dd6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 09:46, Mukesh Ojha wrote:
> Thanks for your time in checking this..
> 
> On 3/1/2023 4:29 PM, Dmitry Baryshkov wrote:
>> On 01/03/2023 11:55, Mukesh Ojha wrote:
>>> Currently on Qualcomm SoC, download_mode is enabled if
>>> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected.
>>>
>>> Refactor the code such that it supports multiple download
>>> modes and drop CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT config
>>> instead, give interface to set the download mode from
>>> module parameter.
>>>
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> ---
>>> Changes in v2:
>>>   - Passed download mode as parameter
>>>   - Accept human accepatable download mode string.
>>>   - enable = !!dload_mode
>>>   - Shifted module param callback to somewhere down in
>>>     the file so that it no longer need to know the
>>>     prototype of qcom_scm_set_download_mode()
>>>   - updated commit text.
>>>
>>>   drivers/firmware/Kconfig    | 11 --------
>>>   drivers/firmware/qcom_scm.c | 65 
>>> ++++++++++++++++++++++++++++++++++++++-------
>>>   2 files changed, 56 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>>> index b59e304..ff7e9f3 100644
>>> --- a/drivers/firmware/Kconfig
>>> +++ b/drivers/firmware/Kconfig
>>> @@ -215,17 +215,6 @@ config MTK_ADSP_IPC
>>>   config QCOM_SCM
>>>       tristate
>>> -config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>>> -    bool "Qualcomm download mode enabled by default"
>>> -    depends on QCOM_SCM
>>> -    help
>>> -      A device with "download mode" enabled will upon an unexpected
>>> -      warm-restart enter a special debug mode that allows the user to
>>> -      "download" memory content over USB for offline postmortem 
>>> analysis.
>>> -      The feature can be enabled/disabled on the kernel command line.
>>> -
>>> -      Say Y here to enable "download mode" by default.
>>> -
>>>   config SYSFB
>>>       bool
>>>       select BOOT_VESA_SUPPORT
>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>> index c9f1fad..ca07208 100644
>>> --- a/drivers/firmware/qcom_scm.c
>>> +++ b/drivers/firmware/qcom_scm.c
>>> @@ -17,17 +17,22 @@
>>>   #include <linux/clk.h>
>>>   #include <linux/reset-controller.h>
>>>   #include <linux/arm-smccc.h>
>>> +#include <linux/kstrtox.h>
>>>   #include "qcom_scm.h"
>>> -static bool download_mode = 
>>> IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
>>> -module_param(download_mode, bool, 0);
>>> -
>>>   #define SCM_HAS_CORE_CLK    BIT(0)
>>>   #define SCM_HAS_IFACE_CLK    BIT(1)
>>>   #define SCM_HAS_BUS_CLK        BIT(2)
>>>   #define QCOM_DOWNLOAD_MODE_MASK 0x30
>>> +#define QCOM_DOWNLOAD_FULLDUMP    0x10
>>> +#define QCOM_DOWNLOAD_NODUMP    0x0
>>> +
>>> +#define MAX_DLOAD_LEN    8
>>> +
>>> +static char download_mode[] = "off";
>>> +static u32 dload_mode;
>>>   struct qcom_scm {
>>>       struct device *dev;
>>> @@ -417,8 +422,9 @@ static int __qcom_scm_set_dload_mode(struct 
>>> device *dev, bool enable)
>>>       return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>>   }
>>> -static void qcom_scm_set_download_mode(bool enable)
>>> +static void qcom_scm_set_download_mode(u32 dload_mode)
>>>   {
>>> +    bool enable = !!dload_mode;
>>>       bool avail;
>>>       int ret = 0;
>>>       u32 val;
>>> @@ -438,7 +444,7 @@ static void qcom_scm_set_download_mode(bool enable)
>>>           val &= ~QCOM_DOWNLOAD_MODE_MASK;
>>>           if (enable)
>>> -            val |= QCOM_SCM_BOOT_SET_DLOAD_MODE;
>>> +            val |= dload_mode;
>>>           ret = qcom_scm_io_writel(__scm->dload_mode_addr, val);
>>>       } else {
>>> @@ -1338,6 +1344,47 @@ bool qcom_scm_is_available(void)
>>>   }
>>>   EXPORT_SYMBOL(qcom_scm_is_available);
>>> +static int set_dload_mode(const char *val, const struct kernel_param 
>>> *kp)
>>> +{
>>> +    int ret;
>>> +
>>> +    if (!strncmp(val, "full", strlen("full"))) {
>>> +        dload_mode = QCOM_DOWNLOAD_FULLDUMP;
>>> +    } else if (!strncmp(val, "off", strlen("off"))) {
>>> +        dload_mode = QCOM_DOWNLOAD_NODUMP;
>>> +    } else {
>>> +        if (kstrtouint(val, 0, &dload_mode) ||
>>> +             !(dload_mode == 0 || dload_mode == 1)) {
>>> +            pr_err("unknown download mode\n");
>>> +            return -EINVAL;
>>> +        }
>>> +
>>> +    }
>>> +
>>> +    ret = param_set_copystring(val, kp);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (__scm)
>>> +        qcom_scm_set_download_mode(dload_mode);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct kernel_param_ops dload_mode_param_ops = {
>>> +    .set = set_dload_mode,
>>> +    .get = param_get_string,
>>
>> Please follow the param_get_bool approach and return sanitized data 
>> here. In other words, "full" / "none" depending on the dload_mode 
>> instead of storing the passed string and returning it later.
>>
> 
> This could be done.
> 
>>> +};
>>> +
>>> +static struct kparam_string dload_mode_param = {
>>> +    .string = download_mode,
>>> +    .maxlen = MAX_DLOAD_LEN,
>>
>> I think writing "full" to this param might overwrite some kernel data. 
>> "00000000" should be even worse.
> 
> There is check in param_set_copystring() which would avoid that.


No. The check will validate the value's length against MAX_DLOAD_LEN. 
But it will not safeguard your code. download_mode's size is less than 
MAX_DLOAD_LEN.

-- 
With best wishes
Dmitry

