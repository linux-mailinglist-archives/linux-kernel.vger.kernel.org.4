Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D82632B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiKURza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKURz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:55:27 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC32D32AC;
        Mon, 21 Nov 2022 09:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669053324; x=1700589324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qfsa8AbMabrYEp+ISD3eb3o1sx27qrYMkB2inZEHjBw=;
  b=ShAPLAOcKWM+5VyOVw+JzL5kp0IrmDdXZCcvRBYhqKIJx2vEJq5o66r4
   gUq01KfJWM4XhskXz/Sw60K/Od3k5QZTEkYOv6XCfmoFbvMZKQkqD91bs
   ITjx070s5qwZDP5k6b+XTqtgrWYzXbrvWz71zqVhBwEPBkZrWdmQbhWzW
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Nov 2022 09:55:23 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 09:55:09 -0800
Received: from [10.110.33.239] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 09:55:08 -0800
Message-ID: <76219489-99cc-7f2e-7df6-b11f6a2c1933@quicinc.com>
Date:   Mon, 21 Nov 2022 11:55:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 3/3] interconnect: qcom: Add QDU1000/QRU1000
 interconnect driver
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-4-quic_molvera@quicinc.com>
 <6b68b7c2-e070-0a88-35ee-2060dcbdee91@wanadoo.fr>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <6b68b7c2-e070-0a88-35ee-2060dcbdee91@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2022 6:19 AM, Christophe JAILLET wrote:
> Le 18/11/2022 à 19:22, Melody Olvera a écrit :
>> Add interconnect provider driver for Qualcomm QDU1000 and QRU1000
>> platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>   drivers/interconnect/qcom/Kconfig   |    9 +
>>   drivers/interconnect/qcom/Makefile  |    2 +
>>   drivers/interconnect/qcom/qdu1000.c | 1079 +++++++++++++++++++++++++++
>>   drivers/interconnect/qcom/qdu1000.h |   95 +++
>>   4 files changed, 1185 insertions(+)
>>   create mode 100644 drivers/interconnect/qcom/qdu1000.c
>>   create mode 100644 drivers/interconnect/qcom/qdu1000.h
>>
>
> [...]
>
>> +static int qnoc_probe(struct platform_device *pdev)
>> +{
>> +    int ret;
>> +
>> +    ret = qcom_icc_rpmh_probe(pdev);
>> +    if (ret)
>> +        dev_err(&pdev->dev, "failed to register ICC provider\n");
>> +
>> +    return ret;
>> +}
>> +
>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +    struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>> +
>> +    icc_nodes_remove(&qp->provider);
>> +    icc_provider_del(&qp->provider);
>
> qcom_icc_rpmh_remove()?
>
> (more future proof, less verbose and more consistent with qcom_icc_rpmh_probe() in the probe)
>
> CJ

Good call. Does it make sense to just set the .probe and .remove functions as
qcom_icc_rpmh_probe() and qcom_icc_rpmh_remove(), respectively? Probe function
is just reporting if qcom_icc_rpmh_probe fails.

Thanks,
Melody
>
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id qnoc_of_match[] = {
>> +    { .compatible = "qcom,qdu1000-clk-virt",
>> +      .data = &qdu1000_clk_virt
>> +    },
>> +    { .compatible = "qcom,qdu1000-gem-noc",
>> +      .data = &qdu1000_gem_noc
>> +    },
>> +    { .compatible = "qcom,qdu1000-mc-virt",
>> +      .data = &qdu1000_mc_virt
>> +    },
>> +    { .compatible = "qcom,qdu1000-system-noc",
>> +      .data = &qdu1000_system_noc
>> +    },
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
>> +
>> +static struct platform_driver qnoc_driver = {
>> +    .probe = qnoc_probe,
>> +    .remove = qnoc_remove,
>> +    .driver = {
>> +        .name = "qnoc-qdu1000",
>> +        .of_match_table = qnoc_of_match,
>> +    },
>> +};
>
> [...]
>

