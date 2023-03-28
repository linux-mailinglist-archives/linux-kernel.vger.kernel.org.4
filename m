Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9C6CB902
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjC1ICi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjC1ICd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:02:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3969B3C24;
        Tue, 28 Mar 2023 01:02:32 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S6XBr2019175;
        Tue, 28 Mar 2023 08:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TI6CfWwlXuhNOW1naYuuJZOwDDyz9eYdva5tnP4XpDg=;
 b=GMYNMRWb5+u1OjZ2Bot0vZKEFDcsp22fv1iQIBeRujMR6cOmC/qxpRvpgDePNL5SrcNu
 Fw/rBJsUYA9Z7EyHJOicT0XQOyE82MQ0oInNMfm9Q3D+ModvIpT5bndEZHHpnjSAAxJc
 QhxfNuAH2n73S0OWld1pYJOgJaSUowhtd1sRo6/y5aVFVNikiPUiQK3MHwfVJ2fpnooI
 eCqqjcVxLoZhMPqEyOn2tawC42CguP9XDJrZyKaRFqNzKVpcDhyeXbTpJZTtADUASXms
 6TbDhw9EaO1TcKrwfpbk9CrU4/vnvBrYAYgJ6hgF/Q8VfjtZk+uXQkvhdkrQdemT975n Dg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk79bb0an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 08:02:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S82K5b000524
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 08:02:20 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 01:02:17 -0700
Message-ID: <ed4a2dc4-4382-0c17-a227-cfa8fec569d8@quicinc.com>
Date:   Tue, 28 Mar 2023 16:02:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <linux-leds@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, Luca Weiss <luca.weiss@fairphone.com>
References: <20230303095023.538917-1-quic_fenglinw@quicinc.com>
 <20230303095023.538917-2-quic_fenglinw@quicinc.com>
 <ZB8wbv93+Vmx3trt@duo.ucw.cz>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <ZB8wbv93+Vmx3trt@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3QEOupkb2NeUKfi_tMvDgNnJe2ipTJJv
X-Proofpoint-GUID: 3QEOupkb2NeUKfi_tMvDgNnJe2ipTJJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 mlxlogscore=559 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280066
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/2023 1:33 AM, Pavel Machek wrote:
> Hi!
> 
>> Add initial driver to support flash LED module found in Qualcomm
>> Technologies, Inc. PMICs. The flash module can have 3 or 4 channels
>> and each channel can be controlled indepedently and support full scale
>> current up to 1.5 A. It also supports connecting two channels together
>> to supply one LED component with full scale current up to 2 A. In that
>> case, the current will be split on each channel symmetrically and the
>> channels will be enabled and disabled at the same time.
> 
> 
>> +static int qcom_flash_strobe_set(struct led_classdev_flash *fled_cdev, bool state)
>> +{
>> +	struct qcom_flash_led *led = flcdev_to_qcom_fled(fled_cdev);
>> +	int rc;
>> +
>> +	rc = set_flash_current(led, led->flash_current_ma, FLASH_MODE);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = set_flash_timeout(led, led->flash_timeout_ms);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = set_flash_module_en(led, state);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return set_flash_strobe(led, SW_STROBE, state);
>> +}
> 
> Should we disable the module before setting the current? It might be
> already active due to torch mode...
> 
The module enabling status should be kept as it is because it may be 
still controlling other LED channels, I can strobe off the LED before 
setting the current to cover such case. I will update it as a following 
patch.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	flash_data->v4l2_flash = devm_kcalloc(dev, count,
>> +			sizeof(*flash_data->v4l2_flash), GFP_KERNEL);
>> +	if (!flash_data->v4l2_flash)
>> +		return -ENOMEM;
>> +
>> +	device_for_each_child_node(dev, child) {
>> +		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
>> +		if (!led) {
>> +			rc = -ENOMEM;
>> +			goto release;
>> +		}
>> +
>> +		led->flash_data = flash_data;
>> +		rc = qcom_flash_register_led_device(dev, child, led);
>> +		if (rc < 0)
>> +			goto release;
>> +
>> +		flash_data->leds_count++;
>> +	}
> 
> Do you need to do of_node_put in error path
I will update this as well.

> 
> BR,
> 							Pavel
