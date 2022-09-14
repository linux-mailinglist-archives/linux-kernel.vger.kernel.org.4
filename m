Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDE45B8E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiINRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:39:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75A7D783;
        Wed, 14 Sep 2022 10:39:06 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EHMBUJ028956;
        Wed, 14 Sep 2022 17:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rvVmLVjGZvLYsnQC4NpMDlUGCLF47EMYil578unxKAE=;
 b=DshsbVTUZA7O6bQDT+7+ojYtjWIPMBer0N2mWIX9+m9qwLdTlFYnfBkIv2sHOK3QeNe/
 fXkdcf3lUK+khhNXvQqf69p6fjsabmrOG2pplHQyDozFawrUSAM2TzCfBXuWRLQN9g9w
 rXI5JjLuS29pl2OUybWld2+sUiaN/DomiJfKV0wtRhmebneu9HDclg2Sx1nvGzke+/7d
 V/Je27IOwKbZFPJ4mEalKqS523OFqKepixrhVusfFqO4bnEqxEJEQErGvZ+gDSMBomZN
 9PnaOttvYzcmlQ7HisxIHkx3ZJsrpXThlpPst9jyDLBMlYz3uTaSpx9uJKPQ384GGb14 ig== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0htrm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 17:38:28 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28EHcRLg023297
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 17:38:27 GMT
Received: from [10.110.68.235] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 10:38:26 -0700
Message-ID: <b8e0cbb4-8d4e-1208-0fa0-8f9178b6d85f@quicinc.com>
Date:   Wed, 14 Sep 2022 10:38:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] mailbox: Add support for QTI CPUCP mailbox controller
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>,
        Gaurav Kohli <gkohli@codeaurora.org>
References: <1663135386-26270-1-git-send-email-quic_sibis@quicinc.com>
 <1663135386-26270-3-git-send-email-quic_sibis@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <1663135386-26270-3-git-send-email-quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zsvqOhOkRg0rVPDsdfbuvfxrDPfjUjY2
X-Proofpoint-GUID: zsvqOhOkRg0rVPDsdfbuvfxrDPfjUjY2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=766 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140085
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

> +
> +MODULE_AUTHOR("Gaurav Kohli <gkohli@codeaurora.org>");
> +MODULE_AUTHOR("Sibi Sankar <quic_sibis@qti.qualcomm.com>");

Email address should be quic_sibi@quicinc.com.

codeaurora.org is any way deprecated, so we should we keep it ? I know 
giving the credit is important, but above address will not be reachable 
anyways.

---Trilok Soni
