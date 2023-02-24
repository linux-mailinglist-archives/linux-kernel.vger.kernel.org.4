Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89226A2060
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjBXRRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBXRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:17:18 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C0716896;
        Fri, 24 Feb 2023 09:17:14 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OCYJbh027126;
        Fri, 24 Feb 2023 17:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/s0mPwvSSDW+VQauRoSbgFNDF3tO1lzqgOdoz387oPo=;
 b=Io5nYkDPhQSndUbG9/z2HdXwNkSrHRyQ9bx08fXmHxmDmKVIpMx4zzrS1zi09opW3UtJ
 rnot6S/LhjryKVIPj0+kMUdgXNOZmxegEzq79m6VXcx9pckEold/NGYtCD09m8XytXHc
 GJoFRGLxe1aD1WolUrSnLo/0J8Uyf2/m3q70zLe9KGqo25iqAVgdwRT7mEcGHLGvy+dq
 ch14i8qKY8eXwWlU4ZaobQK0W9k//i7ssPGejo+7riGEnh3kS5pX7EILL38Keji6FNSE
 TiMdxRWXyZSAwV6e42iOR5sYeNrbeQkC++pAwphOensVIf73ptRFmvClB7ZVsY1tFmVq JQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxuu110qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 17:17:08 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OHH7hF023679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 17:17:07 GMT
Received: from [10.110.82.3] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 09:17:07 -0800
Message-ID: <31766494-4952-ab02-d9b1-861e81d9b080@quicinc.com>
Date:   Fri, 24 Feb 2023 09:17:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/1] remoteproc: qcom: Add remoteproc tracing
Content-Language: en-US
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230224165142.17745-1-quic_gokukris@quicinc.com>
 <20230224165142.17745-2-quic_gokukris@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230224165142.17745-2-quic_gokukris@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZUF84FnOekLcPjwSR-2iTz6t9nmHm3zw
X-Proofpoint-ORIG-GUID: ZUF84FnOekLcPjwSR-2iTz6t9nmHm3zw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_12,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=503 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240136
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/2023 8:51 AM, Gokul krishna Krishnakumar wrote:
> This change adds traces to the following rproc events:
> 1. subdevices events - (STRAT/STOP/CRASH)
> 2. subsystem events - (START/STOP/CRASH)
> 3. RPROC framework events - (Firmware Load/Authentication)


Whenever I see 1/2/3 bullets it probably means different patches? I am 
not sure if that applies here, but I don't know why you use numbered 
bullets here. Also please describe what is the benefit of these trace 
events and how you plan to use it? What kind of debugging scenartio it 
will help you.

---Trilok Soni
