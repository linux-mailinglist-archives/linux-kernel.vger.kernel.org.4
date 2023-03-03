Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CFB6A9844
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCCNWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCCNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:22:05 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB2D5F511;
        Fri,  3 Mar 2023 05:22:04 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3237R87M004261;
        Fri, 3 Mar 2023 13:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ezmnzgleGoKIsUL8Pz0q/kFaBQ9AnYUqQ0G/Vtd+RuY=;
 b=J0j2bz4drb7odBmZpgWtveEuyf9mdoOF8h30RjxpqUSrs20gUb6Trmh9ucqbcELuAW/i
 7a0fSIuhiMnCy6gRU/dRr5AUbHOsKuFjRbm2XyGGijIB6mTUG5OUs/Zmx33rdTyFO/2J
 /haMD0ymcRCy+NzHMOf1geCkcc9ssplJ1q0TMnscZxZjHvIbXcGBykKFNJQ/rA4E2bJE
 zEuXaVavljCuAWAGHzfr+cSPCCAiCNVEhWSABcsu82HyqMXe8c7ip0du40T0PsA6n8WN
 Tb04Ai8qU3PMUHXvi5XiklogSSVe477zQHoTUsrnjwAawVU7axo3CHAz3pDOJn8WLUKz aA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2veeugbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 13:22:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 323DLwM2024604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 13:21:59 GMT
Received: from [10.216.12.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 05:21:53 -0800
Message-ID: <39f73580-f263-de0e-6819-89c3f4c75c3a@quicinc.com>
Date:   Fri, 3 Mar 2023 18:51:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the
 bootup voltage
To:     Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
 <20230217142030.16012-5-quic_devipriy@quicinc.com>
 <907628d1-b88d-5ac6-ed9d-7f63e2875738@linaro.org>
 <Y/aeu5ua7cY5cGON@sirena.org.uk>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <Y/aeu5ua7cY5cGON@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8bh5hIIS522p9i9Jqvw0VHcf-WtwcpkN
X-Proofpoint-GUID: 8bh5hIIS522p9i9Jqvw0VHcf-WtwcpkN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030115
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 4:31 AM, Mark Brown wrote:
> On Wed, Feb 22, 2023 at 11:11:42PM +0100, Konrad Dybcio wrote:
> 
>> Thinking about it again, this seems like something that could be
>> generalized and introduced into regulator core.. Hardcoding this
>> will not end well.. Not to mention it'll affect all mp5496-using
>> boards that are already upstream.
> 
>> WDYT about regulator-init-microvolts Mark?
> 
> The overwhelming majority of devices that have variable voltages
> support readback, these Qualcomm firmware devices are pretty much
> unique in this regard.  We don't want a general property to set a
> specific voltage since normally we should be using the
> constraints and don't normally need to adjust things immediately
> since we can tell what the current voltage is.
> 
> This is pretty much just going to be a device specific bodge,
> ideally something that does know what the voltage is would be
> able to tell us at runtime but if that's not possible then
> there's no good options.  If the initial voltage might vary based
> on board then a device specific DT property might be less
> terrible, if it's determined by the regulator the current code
> seems fine.  Or just leave the current behavour, if the
> constraints are accurate then hopefully a temporary dip in
> voltage is just inelegant rather than an issue.  Indeed the
> current behaviour might well save power if you've got a voltage
> range configured and nothing actually ever gets round to setting
> the voltage (which is depressingly common, people seem keen on
> setting voltage ranges even when the voltage is never varied in
> practice).

Hi Mark, The initial bootup voltage is actually blown into the OTP 
register of the PMIC and it remains the same across boards for IPQ9574 
SoC. Initially the SoC runs at 800MHz with a voltage of 875mV set by the 
bootloaders. As kernel does not know the initial voltage, during 
regulator registration the framework considers the current voltage to be 
zero and tries to bring up the regulator to minimum supported voltage of 
600mV. This causes the dip which might be of concern in SS parts where 
the voltage might be insufficient leading to silent reboots.

Best Regards,
Devi Priya
