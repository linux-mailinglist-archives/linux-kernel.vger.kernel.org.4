Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDA165CAFB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjADAjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjADAjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:39:40 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A7BC43
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 16:39:39 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bq39so40432795lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 16:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WVBnuKlPE/oUTRqhFq4kUqzVA1XN6vIiFknTafswgoQ=;
        b=LDmdQjzOsglTDJU1x/UviTH05DPRnDwLZeI4jv3+hfRYH9DCbcrkdDi3eH9Bj/iyKt
         60Ej2buIMkhP/Q2nLxlaHt/7odf6abDi81TO5fZ37hcuVKNAFyBn4efgA6usvVYKG73D
         tiaBtjbGpFvlTg/JF+8JbBuSl+zm7Mq24HZFM+phBQVFqyyjRLDHPJgzcCya6paeHe28
         R04FRlvHifbFkGbPiVF17EajIdPdri3u2IXcdoPAsPALkzuCTKXu5IbCXzXEtyx556/l
         GohsuuSjcAW67UZI/r7Kr1HLgPywNRGtdq5LSdmLyiyssg+AdIdtZ7GA3p8JL0AQ2jeR
         19QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVBnuKlPE/oUTRqhFq4kUqzVA1XN6vIiFknTafswgoQ=;
        b=jDI3G7mRJ+d7OkxhpLHz+k4jP/76YqKHfSM+KKIQ5VbULjndsyGZnZV0PzDkbgCAT+
         YQPoWqRSDod/17Amgf4X3RC8jugtQCt0Bfzbn9KIJ9jQuM8Y7NqVEM1EZ8sIhvtcjUzv
         FQ0sWV5gc5pP7TER7cG2wdDlyoqteS0JZx3vTo7xWcL3LQvyXQcgXclomdcljI6+9mAB
         Hu0ZvJInDg60BfklMepavPD3ltNA86iDxqVuisP7xKZhK46vf4I30o/DqdYviScnNomZ
         7tUrNdLrkR+P436GkH47ELXvz0xhgiuSeBuXXllZRgPUS00QycrtjAC/5lDKlHaba5BK
         BzDw==
X-Gm-Message-State: AFqh2kpsGc26jq4Pq4+7jV+WDDiVwVRWzbgI9mJ/Co29N/4Xnf8O+dtn
        00WspZP4UfUunBz4MfkMe66V+g==
X-Google-Smtp-Source: AMrXdXtLoi8JfPAeyx/akMXTY99ljU6r9amWVkiMz5z+fAPp28qXKnsS1TqW/vrHX5b/zqcEafDqEg==
X-Received: by 2002:a05:6512:3e0c:b0:4b5:a5c7:3286 with SMTP id i12-20020a0565123e0c00b004b5a5c73286mr15789966lfv.9.1672792777825;
        Tue, 03 Jan 2023 16:39:37 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id p21-20020a05651212d500b00494a603953dsm4942374lfg.89.2023.01.03.16.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 16:39:37 -0800 (PST)
Message-ID: <108e52fa-e53b-220c-b0a8-b5b746aafde6@linaro.org>
Date:   Wed, 4 Jan 2023 01:39:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] interconnect: qcom: rpm: Set QoS parameters
 regardless of RPM bw setting
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>
References: <20230103173059.265856-1-konrad.dybcio@linaro.org>
 <20230103173059.265856-2-konrad.dybcio@linaro.org>
 <0e2bdaec-b7ba-0474-8b80-8901fcc87a0f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0e2bdaec-b7ba-0474-8b80-8901fcc87a0f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.01.2023 00:43, Bryan O'Donoghue wrote:
> On 03/01/2023 17:30, Konrad Dybcio wrote:
>> QoS parameters and RPM bandwidth requests are wholly separate. Setting one
>> should only depend on the description of the interconnect node and not
>> whether the other is present. If we vote through RPM, QoS parameters
>> should be set so that the bus controller can make better decisions.
> 
> Is that true ?
> 
>> If we don't vote through RPM, QoS parameters should be set regardless,
>> as we're requesting additional bandwidth by setting the interconnect
>> clock rates.
>>
>> The Fixes tag references the commit in which this logic was added, it
>> has since been shuffled around to a different file, but it's the one
>> where it originates from.
>>
>> Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 06e0fee547ab..a190a0a839c8 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -252,8 +252,10 @@ static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
>>           ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
>>           if (ret)
>>               return ret;
>> -    } else if (qn->qos.qos_mode != -1) {
>> -        /* set bandwidth directly from the AP */
>> +    }
>> +
>> +    if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
>> +        /* Set QoS params from the AP */
>>           ret = qcom_icc_qos_set(n, sum_bw);
>>           if (ret)
>>               return ret;
> 
> Taking the example of
> 
> static struct qcom_icc_node bimc_snoc_slv = {
>         .name = "bimc_snoc_slv",
>         .id = MSM8939_BIMC_SNOC_SLV,
>         .buswidth = 16,
>         .mas_rpm_id = -1,
>         .slv_rpm_id = 2,
>         .num_links = ARRAY_SIZE(bimc_snoc_slv_links),
>         .links = bimc_snoc_slv_links,
> };
> 
> #define NOC_QOS_MODE_INVALID -1
> ap_owned == false
> qos_mode == NOC_QOS_MODE_FIXED
> 
> 
> if (!qn->qos.ap_owned) {
>     /* bod: this will run */
>     /* send bandwidth request message to the RPM processor */
>     ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
>     if (ret)
>         return ret;
> } else if (qn->qos.qos_mode != -1) {
>     /* bod: this will not run */
>     /* set bandwidth directly from the AP */
>     ret = qcom_icc_qos_set(n, sum_bw);
>     if (ret)
>         return ret;
> }
> 
> and your proposed change
> 
> if (!qn->qos.ap_owned) {
>     /* bod: this will run */
>     /* send bandwidth request message to the RPM processor */
>     ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
>     if (ret)
>         return ret;
> }
> 
> if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
>     /* bod: this will run */
>     /* set bandwidth directly from the AP */
>     ret = qcom_icc_qos_set(n, sum_bw);
>     if (ret)
>         return ret;
> }
> 
> however if we look downstream we have the concept of ap_owned
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_fabric_adhoc.c#L194
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_fabric_adhoc.c#L208
> 
> In simple terms
> if (node_info->ap_owned) {
>     ret = fabdev->noc_ops.set_bw(node_info,
>                                     } else {
>     ret = send_rpm_msg(node_device);
> }
> 
> I agree your code does what it says on the tin but, whats the overall justification to depart from the downstream logic ?
Okay, so maybe it would be worth checking with Qualcomm what it's
supposed to do. On msm-5.4 setting QoS is done unconditionally,
no matter if the node has valid (!= -1) rpm mas/slv IDs.

https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.9.14.r1/drivers/interconnect/qcom/icc-rpm.c#L97

It may be something that began with newer SoCs, or maybe the
carried-with-us-ever-since-3.4 chonky msm_bus driver had a bug..
or maybe the msm-5.4 interconnect impl has a bug.. We really
won't know unless somebody can confirm it for us..

My understanding would be such that the QoS parameters are always
set from the AP and RPM just scales the bandwidth on certain nodes,
like it scales power and frequency for some lines/devices. That
may or may not be true or might also depend on the SoC / RPM fw..

And even if RPM sets these values internally, it shouldn't hurt to
adjust them from AP again, but that would both deserve a different
comment and would be a rather bad design, as tuning the values
would require a rpm firmware update (and we know how vendors treat
firmware updates), so that might have been something qc engineers
took into account..

tldr: new soc good (*), old soc bad-or-no-effect (*), should ask QC

Konrad
> 
> ---
> bod
