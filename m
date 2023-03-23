Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8D6C610D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCWHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCWHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:46:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80942D16A;
        Thu, 23 Mar 2023 00:45:43 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4JbCp010562;
        Thu, 23 Mar 2023 07:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HKGDOX4fhTeTuM1q7nuV+ZwY9cuMN6n495Q8WbaS6G4=;
 b=NlYLM6QFGIlBbvX/fRvE9v5XXrfZ0tMH114O2rC1OnGMS/R+St4Zww0urc2+k7yI3r9w
 LzlmIDVbLWemc3tecLUPs8i3ZBjHweuKBaiAS3jnlueCiVSy3WBuwOHI+Lpc+4DHemlI
 m8H2ucSXH4LkZm84+PQDQYQAcz/ghg5RY0vAHd8AtwkjPh+JhxUYN8dVLlk1TjDJ7olb
 lILhriAFkESD/OzPvVqJVpcpIC1dsqehy0ymru3B/P1yPMxtN6cHt9BGUKCDDCPYxtlg
 pG9vIfglEkao0n1yCTL++Skjxs/UfEwT2ZNAUM4mREuJnUEQTR9utkWM5eQgDkPnnNzu tA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgbf70vsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 07:45:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N7jVLi031567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 07:45:31 GMT
Received: from [10.216.20.183] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Mar
 2023 00:45:29 -0700
Message-ID: <5b3fcceb-1a0d-d0c7-910d-eb4e65892676@quicinc.com>
Date:   Thu, 23 Mar 2023 13:15:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 4/4] clk: qcom: lpassaudiocc-sc7280: Modify
 qcom_cc_probe to qcom_cc_probe_by_index
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_visr@quicinc.com>
References: <20230317141622.1926573-1-quic_mohs@quicinc.com>
 <20230317141622.1926573-5-quic_mohs@quicinc.com>
 <406d02f72767afafa8e563ec2ee7f310.sboyd@kernel.org>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <406d02f72767afafa8e563ec2ee7f310.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xMQy-vV_nI8Ki5_OM13f1xo6mXJZbbsn
X-Proofpoint-GUID: xMQy-vV_nI8Ki5_OM13f1xo6mXJZbbsn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=794 mlxscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303230058
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/2023 11:57 PM, Stephen Boyd wrote:
> Quoting Mohammad Rafi Shaik (2023-03-17 07:16:22)
>> Modify AHB clocks explicit registration from qcom_cc_probe to
>> qcom_cc_probe_by_index.
> Why? Isn't it the same?
yes, it is same.

As per the previous version review comment, modified qcom_cc_probe to 
qcom_cc_probe_by_index.
