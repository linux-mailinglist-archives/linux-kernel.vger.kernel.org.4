Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C66CCCE0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjC1WOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjC1WO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:14:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD32721
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:14:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k37so17770313lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680041664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/xFtn/jeHDXI1X7hT+Ejmk330S4TFBf9/uncxseBCY=;
        b=B6JdSXduaU0fyG+ZXz+NR1WfNQ9igw/nPHDCr2pD4WvibPnM6yZ7MWjRGl9/tfYC64
         T4RYN4Y0PaSfqyLtAx0hoPoHrnDFNkmqwAGwtN2wH5XaAdEHvj2g7BttPMKisolRcP5Q
         ODz51i2GK2WgvupulWXm5fglEFBxNwnW9i0nUgy3MJm6KTypi5DGro13xbfihh9wUL9f
         OStFd5mGNsga0QWtpAiFRNmZwksinb1sXppCbfhTR5PUQKXY73X0jDbB3uO4qh8dHSo1
         zVUCvFrMoiwZJ3dynEuiBZoJ0LV9ki9dR48v47NW3rJcusGF8LucgLeC8Owko3tGIEy1
         GW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/xFtn/jeHDXI1X7hT+Ejmk330S4TFBf9/uncxseBCY=;
        b=lqgRIg3wHqxc8SIWWWeZZNJt9OjMEWsoN6j54DNl2R4eI7wc7qH21Z3ioo0RmqowAI
         /rXcl8zNNDapwtBRHoV5V90yxoWKCI8qSKOeV0VLRRQkeyMtm5786ALjUipGBIyFZKUB
         SjDIWNgFaocHCHZzKEtlQgFzUiEvwC8euPcXsfbDzQ31h5CgO1CXprf9I3K9FN4ffjSh
         RdX5cru7I/4HfW+XFsT9tsZRRzmjAIgnnkZklldBaiHd6AGxT2kMLeYgZl/QolEam+pM
         6NVy/rqu5QRoggoFxhgYlpFrau0KIoEt1mNj5l8zf21GByxhYPuUZQKHThKvuWNYlF/z
         JEWA==
X-Gm-Message-State: AAQBX9dFf39HlWQGV5FmyI1xJWXpfoizqOoNxzMtTPCFZ4CHtAiprTjq
        cL2mxE6I76tBPU+KjeqTdLOgWgs1lqMlxvy+Rz0=
X-Google-Smtp-Source: AKy350YudBv3eBOlox2AXR7O/t0Mx7ohGhKQB/gCYHL/MtJPfnQW0s8cAGm6W6ROkwq9D7l7XYjs+Q==
X-Received: by 2002:ac2:569e:0:b0:4e8:49ff:8df8 with SMTP id 30-20020ac2569e000000b004e849ff8df8mr4945654lfr.61.1680041664385;
        Tue, 28 Mar 2023 15:14:24 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 6-20020ac24846000000b004d8540b947asm5226316lfy.56.2023.03.28.15.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 15:14:23 -0700 (PDT)
Message-ID: <2bff9246-dd42-1c21-930f-2da2fed588f2@linaro.org>
Date:   Wed, 29 Mar 2023 01:14:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 4/5] firmware: qcom_scm: Refactor code to support
 multiple download mode
Content-Language: en-GB
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1679935281-18445-1-git-send-email-quic_mojha@quicinc.com>
 <1679935281-18445-5-git-send-email-quic_mojha@quicinc.com>
 <20230327182324.elrxciz5vqvryp7y@ripper>
 <e342044c-dcf9-e443-5244-0990dfc59443@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <e342044c-dcf9-e443-5244-0990dfc59443@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 11:18, Mukesh Ojha wrote:
> 
> 
> On 3/27/2023 11:53 PM, Bjorn Andersson wrote:
>> On Mon, Mar 27, 2023 at 10:11:20PM +0530, Mukesh Ojha wrote:
>> [..]
>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>> index 3c6c5e7..0c94429 100644
>>> --- a/drivers/firmware/qcom_scm.c
>>> +++ b/drivers/firmware/qcom_scm.c
>>> @@ -20,11 +20,11 @@
>>>   #include <linux/clk.h>
>>>   #include <linux/reset-controller.h>
>>>   #include <linux/arm-smccc.h>
>>> +#include <linux/kstrtox.h>
>>>   #include "qcom_scm.h"
>>> -static bool download_mode = 
>>> IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
>>> -module_param(download_mode, bool, 0);
>>> +static u32 download_mode;
>>>   #define SCM_HAS_CORE_CLK    BIT(0)
>>>   #define SCM_HAS_IFACE_CLK    BIT(1)
>>> @@ -32,6 +32,7 @@ module_param(download_mode, bool, 0);
>>>   #define QCOM_DOWNLOAD_MODE_MASK 0x30
>>>   #define QCOM_DOWNLOAD_FULLDUMP    0x1
>>> +#define QCOM_DOWNLOAD_NODUMP    0x0
>>>   struct qcom_scm {
>>>       struct device *dev;
>>> @@ -440,8 +441,9 @@ static int __qcom_scm_set_dload_mode(struct 
>>> device *dev, bool enable)
>>>       return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>>   }
>>> -static void qcom_scm_set_download_mode(bool enable)
>>> +static void qcom_scm_set_download_mode(u32 download_mode)
>>>   {
>>> +    bool enable = !!download_mode;
>>>       bool avail;
>>>       int ret = 0;
>>> @@ -453,7 +455,7 @@ static void qcom_scm_set_download_mode(bool enable)
>>>       } else if (__scm->dload_mode_addr) {
>>>           ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
>>>                   QCOM_DOWNLOAD_MODE_MASK,
>>> -                enable ? QCOM_DOWNLOAD_FULLDUMP : 0);
>>> +                enable ? download_mode : 0);
>>
>> Afaict, with QCOM_DOWNLOAD_NODUMP as 0, this says:
>>
>>    when download_mode is non-zero, write that value, otherwise write 0
>>
>> That should be the same as "write download_mode", so you should be able
>> to drop the enable part.
>>
>>>       } else {
>>>           dev_err(__scm->dev,
>>>               "No available mechanism for setting download mode\n");
>>> @@ -1419,6 +1421,49 @@ static irqreturn_t qcom_scm_irq_handler(int 
>>> irq, void *data)
>>>       return IRQ_HANDLED;
>>>   }
>>> +
>>> +static int get_download_mode(char *buffer, const struct kernel_param 
>>> *kp)
>>> +{
>>> +    int len = 0;
>>> +
>>> +    if (download_mode == QCOM_DOWNLOAD_FULLDUMP)
>>> +        len = sysfs_emit(buffer, "full\n");
>>> +    else if (download_mode == QCOM_DOWNLOAD_NODUMP)
>>> +        len = sysfs_emit(buffer, "off\n");
>>> +
>>> +    return len;
>>> +}
>>> +
>>> +static int set_download_mode(const char *val, const struct 
>>> kernel_param *kp)
>>> +{
>>> +    u32 old = download_mode;
>>> +
>>> +    if (!strncmp(val, "full", strlen("full"))) {
>>
>> strcmp loops over the two string until they differ and/or both are
>> '\0'.
>>
>> As such, the only thing you achieve by using strncmp(.., T, strlen(T))
>> is that the code has to iterate over T twice - and you make the code
>> harder to read.
> 
> 
> If we use strcmp, i need to use "full\n" which we would not want to do.
> I think, we need to take this hit.

There is a special helper for the sysfs files. See sysfs_streq().

> 
> -- Mukesh
>>
>>> +        download_mode = QCOM_DOWNLOAD_FULLDUMP;
>>> +    } else if (!strncmp(val, "off", strlen("off"))) {
>>> +        download_mode = QCOM_DOWNLOAD_NODUMP;
>>> +    } else if (kstrtouint(val, 0, &download_mode) ||
>>> +           !(download_mode == 0 || download_mode == 1)) {
>>> +        download_mode = old;
>>> +        pr_err("unknown download mode\n");
>>
>> This will result in a lone "unknown download mode" line somewhere in the
>> kernel log, without association to any driver or any indication what the
>> unknown value was.
>>
>>    pr_err("qcom_scm: unknown download mode: %s\n", val);
>>
>> Would give both context and let the reader know right there what value
>> the code wasn't able to match.
>>
>> Regards,
>> Bjorn

-- 
With best wishes
Dmitry

