Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93586B3594
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCJEXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCJEWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:22:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A5DF8287;
        Thu,  9 Mar 2023 20:20:22 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32A3AjQB029841;
        Fri, 10 Mar 2023 04:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AJ5dBzBaSKqSf1Ba/YZpvWjGeMq5RaKskpH+CDXL1pA=;
 b=dfX0wJHdRZcaxXc+W8nxZ1a2XLAf4fyGBenqSltmiMnAIxthkEC/M4jxTR+5+tZrEugu
 BrC4vrr4LT33V6LbKL2ZzW/JqB1IGd3rDrcHTiuuKflOwwJE12d+fXqM6twYHGnvXwRF
 OrskvvFnqwaq9Z5+WnK3GmNepniTaqJa6OjisdlV/J/fHQSOD4pdx7AULBfnGobh8vTC
 FB87eVpsSw2Wd+HWfWlkZPQ8x13J73z3jFPewvUT6sgMz4GO5sHIVxUGT+pKhMkg908y
 9EecnEWCONy95FshLJGFIQ1QR2a0VDXy4/gq+O/k+TcrpTlv5kYUx9hAtxWdyTwlBD7Q ew== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7q0y0x3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 04:20:06 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32A4K5uo025099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 04:20:05 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Mar 2023
 20:20:01 -0800
Message-ID: <9d54e732-75e6-6912-750b-2c4238d618bb@quicinc.com>
Date:   Fri, 10 Mar 2023 12:19:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4] scsi: ufs: core: Add trace event for MCQ
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <1677836154-29192-1-git-send-email-quic_ziqichen@quicinc.com>
 <67db2c6b-c3b0-c525-e6a9-2b2fe6c6adbb@acm.org>
 <f80fd91b-3a03-5c38-72c0-cd5c3edb33b8@quicinc.com>
 <8a83ec79-be04-ec5c-f3ef-67f64dc55f12@acm.org>
 <f96b1867-142f-7fdc-8123-58fe3bdce844@quicinc.com>
 <99f2ea8e-e543-fc14-91d7-0e7e29d2f381@acm.org>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <99f2ea8e-e543-fc14-91d7-0e7e29d2f381@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kzG8T3kxifzbSNm8Di_lm03_QUcfGaeD
X-Proofpoint-ORIG-GUID: kzG8T3kxifzbSNm8Di_lm03_QUcfGaeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_01,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/9/2023 11:45 PM, Bart Van Assche wrote:
> On 3/8/23 18:44, Ziqi Chen wrote:
>> Thanks for you suggestion. But the member hwq->id is an Unsigned 
>> integer. if you want to identify SDB mode and MCQ mode,  using "0" is 
>> enough, Or how about add string such as below?
>>
>> ufshcd_command: MCQ: complete_rsp: 1d84000.ufshc: tag: 14, DB: 0x0, 
>> size: 32768, IS: 0, LBA: 5979448,opcode: 0x2a (WRITE_10),group_id: 
>> 0x0, hqid: 2
> 
> Hi Ziqi,
> 
> Since 0 is a valid queue ID using 0 to identify the legacy command 
> submission mechanism is ambiguous.
> 
> Thanks,
> 
> Bart.

OK, let me convert hwq id to int from ftrace side.


Best Regards,
Ziqi
