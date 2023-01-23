Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810A06774C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 06:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjAWFOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 00:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjAWFOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 00:14:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B9617CFA;
        Sun, 22 Jan 2023 21:14:02 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N4pqvY023348;
        Mon, 23 Jan 2023 05:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PokQlAY0XObxV/4OP9P41L2+sykW6BgoKTlEHhw9H78=;
 b=e0L+JwugzK8ulEMeNHjecihmZbyDA1+tUrOLye1IRIQ9LOstIIoMrsWMYB1a22xcINF0
 IXkWzb3d7WpHUZ3fIUOVLUZGOnigGZTREKM4s8fSy9TfwJr3o7eLHXYGEINlgpFmE3G5
 PDAiU2AIcO2jbjgxutDnjoNvM4smSo/q/1PScRAmZl/VYmhaptmHB4vzEICONmhviNa/
 6Xho+Jg8Vck71Q7+x9TDnCpfC/RSfzePwLVoIbFl/JX5TETIJ+/pTsLO3b/UBW/GzU0H
 Or1bGC4vyLKnjgBSh8b7osfOa+F2ap70+9amlPau9+Ga8VUBUNNPF2SQnoLtgcQqS2YS zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89hk27xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 05:13:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30N5Dq7L031873
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 05:13:52 GMT
Received: from [10.216.3.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 22 Jan
 2023 21:13:47 -0800
Message-ID: <43bea488-7a71-aec3-508c-6a541d5db508@quicinc.com>
Date:   Mon, 23 Jan 2023 10:43:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND v5 0/6] Add resets for ADSP based audio clock controller
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
References: <1674322340-25882-1-git-send-email-quic_srivasam@quicinc.com>
 <030115dd-f489-5d4e-c993-e9fa8b550f04@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <030115dd-f489-5d4e-c993-e9fa8b550f04@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nCaUGGdgDJmR7PAPPCdrHV4Xy6GD6DRP
X-Proofpoint-ORIG-GUID: nCaUGGdgDJmR7PAPPCdrHV4Xy6GD6DRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_02,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=872 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230049
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/2023 7:21 PM, Krzysztof Kozlowski wrote:
Thanks for Your time Krzysztof!!!
> On 21/01/2023 18:32, Srinivasa Rao Mandadapu wrote:
>> Add resets and remove qdsp6ss clcok controller for audioreach based platforms.
>>
>> Changes since v4:
>>      -- Update Fixes tag in Merge lpasscc into lpass_aon patch.
>>      -- Revert removal of clk_regmap structure in Merge lpasscc into lpass_aon patch.
>>
> Your v5 before resend have build issues. Please fix.

In v5, one commit missed to amend local changes.Hence resent it.

on Resent patch series no build issues.

>
> Best regards,
> Krzysztof
>
