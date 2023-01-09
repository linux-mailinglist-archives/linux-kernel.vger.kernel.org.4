Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE85662F30
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbjAISeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbjAISc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:32:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0801F765A;
        Mon,  9 Jan 2023 10:30:14 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309H8CTi032253;
        Mon, 9 Jan 2023 18:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=vtRFdTmuN+czXRloZuJahQBiEWPIOIfJue0GPu8iOwg=;
 b=HWgv9+dUIWPpZ+8jmscn+8g00AQNxJv2g/6fQX0+NYPcn2Kea1tensK2y4qhkQdac/Nv
 NutN9DlajE7RwLTC9XYYay+15RGNsqVPLwAdgw44qPjjh6zTW0q6dn4M/tB8zH1wcfpY
 7vJlKUwwIyZUW67GV+N5UaS973tLeTBJlrPzcTWpEqdF+lxN7H8MvP/mzUF/Aie1oxgN
 dTHKvsy3tVF5zqmcCiSLVOoWP/bVsJqi5sJWYQjGLAOrILRc1v83hvPlxYmRIvZxChi7
 +hPmkVjT00jrSzi80tJxDu6w/i+XUqdaaXS3cNMv9eFypIkKx0IQ0u31SMDF+Pp3bFg+ UQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0q2ar4rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 18:30:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309IUBem013949
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 18:30:11 GMT
Received: from [10.110.108.111] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 10:30:10 -0800
Message-ID: <58121e22-a992-e8c8-2add-e3279be25185@quicinc.com>
Date:   Mon, 9 Jan 2023 10:30:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msml@vger.kernel.org>,
        <quic_ccooper@quicinc.com>, <mkrom@qti.qualcomm.com>,
        <quic_tsoni@quicinc.com>
From:   John Moon <quic_johmoo@quicinc.com>
Subject: Out-of-tree devfreq governor header
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HznFUOqTV4_ihcvZ21kzOx8KcM8PK_gE
X-Proofpoint-ORIG-GUID: HznFUOqTV4_ihcvZ21kzOx8KcM8PK_gE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_12,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1031
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=916
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090132
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We have an out-of-tree devfreq governor which uses the "governor.h" 
header from "drivers/devfreq". The source code for the governor is 
public on CodeLinaro [1].

Currently, the driver directly includes the "governor.h" header even 
though it's not a public header. A comment at the top of "governor.h" 
says explicitly: "This header is for devfreq governors in drivers/devfreq/".

Could you please advise the best way to use this private devfreq header 
from an out-of-tree governor? Could we move the header into "include/linux"?

[1]: 
https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-kernel/-/blob/gfx-kernel.lnx.1.0.r3-rel/governor_msm_adreno_tz.c#L20

Thanks,
John
