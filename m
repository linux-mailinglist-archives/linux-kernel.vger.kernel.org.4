Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138FA615D3D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiKBH7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBH7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:59:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB75919F;
        Wed,  2 Nov 2022 00:59:02 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A26u5sG029837;
        Wed, 2 Nov 2022 07:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gtdIXYsLEzFgWed1Bm5ZeLWyrCiOwAMK11yjO8P9WS4=;
 b=n2wx/J/qKseCC4Oqv32aH1jI9Tct8yZSLqZTTKkZzvIl4Yr7L9WTb0ypRimiPYpgkxmh
 GriLEjv49vpPEeFFv/fpVqT5KVupKlosaIEwXc0AN6DQ9hsW+5gwh0YZJHi+71ExWXDp
 MjHirdrYGBBbrnVdObqm5kmNbsDrPJqo4fQU9hIW4KHztA1vDdU+FpJAARb2IiLogoFE
 k+aTT4NjAORgD70V9gDewmRw+0C8enqDbNer44QLRl4bpZLmghIYGv445OYu7Zz/oXxr
 0MLVrlvuGIESMSi+uqIS7sfQNEf8f2+y9PFDYPe3FToHPvL8YBYwIWM8c009bBXh8Oh9 Vg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkj8x8bbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 07:58:56 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A27wtGl013386;
        Wed, 2 Nov 2022 07:58:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3khdkxch93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 07:58:55 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A27wtxB013377;
        Wed, 2 Nov 2022 07:58:55 GMT
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 2A27wsla013374
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 07:58:55 +0000
Received: from [10.206.12.35] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 00:58:51 -0700
Message-ID: <c96304da-f57e-4926-2f3f-665c2054fb00@quicinc.com>
Date:   Wed, 2 Nov 2022 13:28:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1] clk: qcom: gcc-sc8280xp: add cxo as parent for
 gcc_ufs_ref_clkref_clk
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>, Stephen Boyd <sboyd@kernel.org>
CC:     <andersson@kernel.org>, <bmasney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
 <20221101182402.32CE5C433C1@smtp.kernel.org>
 <Y2IZaxukERXNcPGR@hovoldconsulting.com>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <Y2IZaxukERXNcPGR@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pZuhdHDq-2iwn_7s1LX3L5NVFJCK10cS
X-Proofpoint-ORIG-GUID: pZuhdHDq-2iwn_7s1LX3L5NVFJCK10cS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_04,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=922
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2022 12:46 PM, Johan Hovold wrote:
> On Tue, Nov 01, 2022 at 11:23:59AM -0700, Stephen Boyd wrote:
>> Quoting Shazad Hussain (2022-10-30 07:23:33)
>>> Since 'commit f3aa975e230e ("arm64: dts: qcom: sc8280xp: correct ref
>>
>> So we should have a Fixes tag for this commit? Or really back to the
>> beginning of the driver?
>>
>>> clock for ufs_mem_phy")' we need to explicitly make cxo as parent to
>>> gcc_ufs_ref_clkref_clk to have an independent vote from ufs_mem_phy.
> 
> The commit message is slightly misleading as this affects the other UFS
> PHY as well.
> 
> If CX is indeed a parent of this clock then the issue has been there
> since the clock driver was added. (And otherwise, the PHY binding may
> need to be amended instead.)
> 
> Johan

CX is not the actual parent of this clk. GCC_UFS_REF_CLKREF_CLK is an 
external clk to the device, which needs to be voted. If we use the 
GCC_UFS_REF_CLKREF_CLK as ref clk, we don't have explicit vote for CX 
from ufs_mem_phy.
If no client votes for CX,(very unlikely) then it's won't be ON for 
ufs_mem_phy as well right ! So to maintain the voting to CX, we make 
this as parent to ref clk.

Shazad
