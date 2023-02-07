Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7217468DA65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjBGOT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjBGOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:19:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A54D29434;
        Tue,  7 Feb 2023 06:19:54 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317DcmHH020942;
        Tue, 7 Feb 2023 14:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=k1M9nmRiFDLPQ8oXfcmTfW98qcSBYVvYTWTZ/0q5I4w=;
 b=DZIpm5grI/gZVmCeGCJ0pYqkGEJb4FeOpZqTHjrwW0GHuWOBxqXch9AqKV/hTLPLcuDr
 Mu+JP4Xa3P5aBpn/fDO0b/mbmESlK/IL8HfnXiYVphewn7MSGLQ4L8Qf4qLJuVVlIRpS
 cIaTG5G2u2T+bU7ZGDjOKcjtKQy2qBX/cXQLUs0DMb5JxRdgqGx60RTRTwp3A+0LAV8R
 aPIzNnLmxQU/UqGdO7/I1jXa5e+NLcXYKEM15dHobHh9UHxzUXsB+WmzPb4fX9Wo7ljg
 Jxj6/El5RusyOQ/fWb6lgyOFHRlbb95lMcaUyxqL4xNDn9oW094qQUiWyS/z8UbOD9mx 9Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkfes98dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 14:19:48 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 317EJlPJ026357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 14:19:47 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 06:19:47 -0800
Date:   Tue, 7 Feb 2023 06:19:45 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 4/4] power: supply: Introduce Qualcomm PMIC GLINK
 power supply
Message-ID: <20230207141945.GA1639831@hu-bjorande-lv.qualcomm.com>
References: <20230201041853.1934355-1-quic_bjorande@quicinc.com>
 <20230201041853.1934355-5-quic_bjorande@quicinc.com>
 <20230203112720.oa7e2psevbazicqo@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230203112720.oa7e2psevbazicqo@mercury.elektranox.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uC5Zdx35CjGFUL6WPEEJmo0TCVbfweKQ
X-Proofpoint-ORIG-GUID: uC5Zdx35CjGFUL6WPEEJmo0TCVbfweKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_05,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 12:27:20PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jan 31, 2023 at 08:18:53PM -0800, Bjorn Andersson wrote:
> ...
> > +static const enum power_supply_property sm8350_bat_props[] = {
> > +	POWER_SUPPLY_PROP_STATUS,
> > +	POWER_SUPPLY_PROP_HEALTH,
> > +	POWER_SUPPLY_PROP_PRESENT,
> > +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> > +	POWER_SUPPLY_PROP_CAPACITY,
> > +	POWER_SUPPLY_PROP_VOLTAGE_OCV,
> > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > +	POWER_SUPPLY_PROP_TEMP,
> > +	POWER_SUPPLY_PROP_TECHNOLOGY,
> > +	POWER_SUPPLY_PROP_CHARGE_COUNTER,
> > +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> > +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> > +	POWER_SUPPLY_PROP_CHARGE_FULL,
> 
> no CHARGE_NOW?
> 

This doesn't seem to be exposed by the firmware...

> > +	POWER_SUPPLY_PROP_MODEL_NAME,
> > +	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
> > +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> > +	POWER_SUPPLY_PROP_POWER_NOW,
> > +};
> 
> ...
> 
> > +static struct auxiliary_driver qcom_battmgr_driver = {
> > +	.name = "pmic_glink_power_supply",
> > +	.probe = qcom_battmgr_probe,
> > +	.id_table = qcom_battmgr_id_table,
> > +};
> > +
> > +static int __init qcom_battmgr_init(void)
> > +{
> > +	return auxiliary_driver_register(&qcom_battmgr_driver);
> > +}
> > +module_init(qcom_battmgr_init);
> > +
> > +static void __exit qcom_battmgr_exit(void)
> > +{
> > +	auxiliary_driver_unregister(&qcom_battmgr_driver);
> > +}
> > +module_exit(qcom_battmgr_exit);
> 
> module_auxiliary_driver()

Missed that we have one of those, will update and resend.

> 
> Otherwise LGTM.
> 
> -- Sebastian 


Thanks,
Bjorn
