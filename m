Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE0F68CD2C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBGDOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBGDOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:14:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6627F15C91;
        Mon,  6 Feb 2023 19:14:48 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3172nebw027708;
        Tue, 7 Feb 2023 03:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kRsHSyBbyvbcSIKsV4n9sFpqfsDPUQpQY0M81T0f1+4=;
 b=pSKh0mHUycjJO2B0EURt0udy5GB2ABM8T/B1H8mb3yTSSoYa2Xv04E6k2+zdtxg6ce82
 c6me/Hpmboq29LXgty/Y0d46lx25CrYdCtRiqpkogJ0f788LXmDDi/VT8hxqGyoY1hfR
 gzuR3q/S71WcKqbnr0HQ00MQnFs64MUWQSTXS7oAWSmI9ukUzhXsBkxAjzHLwMr0Vxl3
 M8aus5xlmosHcnWQg4oj04EjPpSlrz+rcW3frDFI9QeogivRU/JOHJPLADuCJcxgaxAP
 AKBFUBwk2eOYCvHp2rl6nU/4Ejz7S6HP659s8u/FEUVXU7LsRGbeB2aSii+lBAAHaXso nQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhgng56ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 03:14:38 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3173Ebvs001228
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 03:14:37 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 19:14:36 -0800
Message-ID: <bd7eb8dd-647c-241a-ff1c-d5c59429c0d7@quicinc.com>
Date:   Mon, 6 Feb 2023 19:14:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 03/22] rtc: pm8xxx: use regmap_update_bits()
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-4-johan+linaro@kernel.org>
From:   David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20230202155448.6715-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9rH6Ozz-Lm5TpwmDOOLXDlHeJikwlfJF
X-Proofpoint-ORIG-GUID: 9rH6Ozz-Lm5TpwmDOOLXDlHeJikwlfJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070028
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 07:54, Johan Hovold wrote:
> Switch to using regmap_update_bits() instead of open coding
> read-modify-write accesses.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 87 ++++++++++------------------------------
>  1 file changed, 22 insertions(+), 65 deletions(-)

Reviewed-by: David Collins <quic_collinsd@quicinc.com>


> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index f49bda999e02..8c2847ac64f4 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -78,10 +78,10 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	int rc, i;
>  	unsigned long secs, irq_flags;
> -	u8 value[NUM_8_BIT_RTC_REGS], alarm_enabled = 0, rtc_disabled = 0;
> -	unsigned int ctrl_reg, rtc_ctrl_reg;
>  	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
>  	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
> +	u8 value[NUM_8_BIT_RTC_REGS];
> +	bool alarm_enabled;
>  
>  	if (!rtc_dd->allow_set_time)
>  		return -ENODEV;
> @@ -97,31 +97,16 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  
>  	spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_flags);
>  
> -	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
> +	rc = regmap_update_bits_check(rtc_dd->regmap, regs->alarm_ctrl,
> +				      regs->alarm_en, 0, &alarm_enabled);
>  	if (rc)
>  		goto rtc_rw_fail;
>  
> -	if (ctrl_reg & regs->alarm_en) {
> -		alarm_enabled = 1;
> -		ctrl_reg &= ~regs->alarm_en;
> -		rc = regmap_write(rtc_dd->regmap, regs->alarm_ctrl, ctrl_reg);
> -		if (rc)
> -			goto rtc_rw_fail;
> -	}
> -

I like this usage of regmap_update_bits_check().  It is a great helper
to use in this situation.  It really helps to simplify the logic.

Take care,
David

