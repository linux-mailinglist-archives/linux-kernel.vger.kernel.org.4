Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79D25FBDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJKWqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKWp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:45:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4C06C773;
        Tue, 11 Oct 2022 15:45:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BM0qn0021810;
        Tue, 11 Oct 2022 22:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=57BPCXUaF1qOQpkMOq8mYxbHJHy+Ow2FgOHfSPu9WPA=;
 b=LUMfglt1snlvkNQdXmeIPCOOCXipr9veVW+HoeO04ojycjNFyBar+zYLKhBIxoi/0hO0
 0SdEYFaxvJLxLulSJOVWgOUqBXsnS8VWPNU56SdlhKohPFsvvuKqzVBUuFMm7qF1CJP8
 WlBE5FxkqVokymt63kYPSFF0d/SkDlBdbNsS/4vgJ6tDmMv1LprXrg5yISrl8C/AyiEC
 bGyn79vT0lxArEFJ8dNgIPqvXS3wYV1WtZ8wr8ECkFC3FSaaqmit1mBPwtmdh01qO4Lt
 h1e0fcCnzs1lZGjVgkzA4DUuJdC3DxhgpJVx3p7bpZIjNosWUVrPzKZmhtvSGlMyjnWu Cg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx5ugjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 22:45:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BMjfn9008190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 22:45:41 GMT
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 15:45:41 -0700
Message-ID: <f0e7fdfb-6439-ac27-5119-38cf99010269@quicinc.com>
Date:   Tue, 11 Oct 2022 15:45:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 04/13] arm64: smccc: Include alternative-macros.h
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-5-quic_eberman@quicinc.com>
 <Y0UZrAavHNxkJVm9@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y0UZrAavHNxkJVm9@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i23mEmHpoR8MCPu3G1VMD8WNzRTHc_kg
X-Proofpoint-ORIG-GUID: i23mEmHpoR8MCPu3G1VMD8WNzRTHc_kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=730 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110131
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 12:22 AM, Greg Kroah-Hartman wrote:
> On Mon, Oct 10, 2022 at 05:08:31PM -0700, Elliot Berman wrote:
>> Fix build error when CONFIG_ARM64_SVE is selected and
>> asm/alternative-macros.h wasn't implicitly included by another header.
>>
>> Fixes: cfa7ff959a78 ("arm64: smccc: Support SMCCC v1.3 SVE register saving hint")
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Shouldn't this be independant of this whole series and get merged now
> and backported to stable kernels if it really is causing a build problem
> today?

I'll drop the "Fixes:" tag here since there is no build problem today. 
asm/alternative-macros.h was already implicitly included in all the 
cases where arm-smccc.h was being included. When I introduced the Gunyah 
hypercalls, I noticed the assumption.
