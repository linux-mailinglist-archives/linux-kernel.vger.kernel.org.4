Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06456615E28
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiKBIp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKBIpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:45:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E6527922;
        Wed,  2 Nov 2022 01:45:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A28VUvc010387;
        Wed, 2 Nov 2022 08:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zb/9i99wRAEI78F9AvVaZ1VodJp1Q1VCuyoRXyw483Q=;
 b=UIldyo3cOZ7ffZu6ydOR9kTR0cPNIBYnm8pXYE6UsgE8/16ma7GEhO4FCrQMWtrwLEdM
 VOfFHrenjBz2cxISPyNOUwAmlA5RN5utuIaGHJKghJ9GtCAgecsutYYqZAJW7I2aG6Yh
 he1li7GdRauvdq76pdV+4jUvSrfCK61mvW7v94SGfDnKxe2n+7KqoxdriATqQ8jrROtf
 cWBnAGchrQd/HWownrBb0DPd4qdbclP4DuJFFNh/2DPG3+3Urr87RYPLQ40LLdhryIPU
 CHL4jLVhJpSOWwr61AG5Iv47jDRu0KYZXHE5xscCL4EUOCbJlvyWwh/GOZcXU7YPoVxP Yg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkj88rea4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 08:45:39 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A28jXpt012214;
        Wed, 2 Nov 2022 08:45:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3khdr04p72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 08:45:33 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A28jWdY012192;
        Wed, 2 Nov 2022 08:45:32 GMT
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 2A28jWVu012185
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 08:45:32 +0000
Received: from [10.206.12.35] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 01:45:29 -0700
Message-ID: <bb590bfb-07a4-97c1-e5c0-d00d840e2e11@quicinc.com>
Date:   Wed, 2 Nov 2022 14:15:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1] clk: qcom: gcc-sc8280xp: add cxo as parent for
 gcc_ufs_ref_clkref_clk
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>, <andersson@kernel.org>,
        <bmasney@redhat.com>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
 <20221101182402.32CE5C433C1@smtp.kernel.org>
 <Y2IZaxukERXNcPGR@hovoldconsulting.com>
 <c96304da-f57e-4926-2f3f-665c2054fb00@quicinc.com>
 <Y2Imnf1+v5j5CH9r@hovoldconsulting.com>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <Y2Imnf1+v5j5CH9r@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x4EzHIYmN3Jn2c10Mi1hbUFizg8GJrOP
X-Proofpoint-ORIG-GUID: x4EzHIYmN3Jn2c10Mi1hbUFizg8GJrOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_05,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=898 adultscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2022 1:43 PM, Johan Hovold wrote:
> On Wed, Nov 02, 2022 at 01:28:48PM +0530, Shazad Hussain wrote:
>> On 11/2/2022 12:46 PM, Johan Hovold wrote:
>>> On Tue, Nov 01, 2022 at 11:23:59AM -0700, Stephen Boyd wrote:
>>>> Quoting Shazad Hussain (2022-10-30 07:23:33)
>>>>> Since 'commit f3aa975e230e ("arm64: dts: qcom: sc8280xp: correct ref
>>>>
>>>> So we should have a Fixes tag for this commit? Or really back to the
>>>> beginning of the driver?
>>>>
>>>>> clock for ufs_mem_phy")' we need to explicitly make cxo as parent to
>>>>> gcc_ufs_ref_clkref_clk to have an independent vote from ufs_mem_phy.
>>>
>>> The commit message is slightly misleading as this affects the other UFS
>>> PHY as well.
>>>
>>> If CX is indeed a parent of this clock then the issue has been there
>>> since the clock driver was added. (And otherwise, the PHY binding may
>>> need to be amended instead.)
> 
>> CX is not the actual parent of this clk. GCC_UFS_REF_CLKREF_CLK is an
>> external clk to the device, which needs to be voted. If we use the
>> GCC_UFS_REF_CLKREF_CLK as ref clk, we don't have explicit vote for CX
>> from ufs_mem_phy.
>>
>> If no client votes for CX,(very unlikely) then it's won't be ON for
>> ufs_mem_phy as well right ! So to maintain the voting to CX, we make
>> this as parent to ref clk.
> 
> Right, but if the PHYs really requires CX and it is not an ancestor of
> the refclk then this should be described by the binding (and not be
> hidden away in the clock driver).
> 
> Johan

This makes sense, will be posting v2 post for the same.
I assume this should use the Fixes tag then !

Shazad
