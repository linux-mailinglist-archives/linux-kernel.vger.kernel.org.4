Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF96565E52A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjAEFgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjAEFf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:35:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB6B5131A;
        Wed,  4 Jan 2023 21:35:50 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3054sjnr013420;
        Thu, 5 Jan 2023 05:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gWnhZ1G48hLuLE7lUYmRytEXz6CP0hOeaqLWQIgEeIQ=;
 b=fG1Kv3Vz7YjeR2E2ZHeHBMGciC7xKDb1PIwgAzu/x+8msBDeGmCBiarNAzcHHKPjgto/
 It2zLhCovo/TRoY3sl17lpRCtnFXKu/DWienszyUzXG06wJx4XmbJy9ACLertuS3BaTd
 0zzXqmXH/n/PC+i4ZmBJv1us51JxQlUD3AL+WQv/efbUcXgHgjBVhTAJMgGuf26ejKXH
 kQuOoHWyHZjStnJaovpuTMArXfn03bTFNDAU4jI3Ul69YEKyqlc5W+Da21RJxzvSgCjr
 WGEvQMG9WPTykVmmkQiDcbcSUc5iWi6BZpBHYbSqRGCZCSt4pxkaFuw7GshFt1B1MeoB wQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwj1rrmh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 05:06:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 305561Bo027164
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 05:06:01 GMT
Received: from [10.50.40.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 4 Jan 2023
 21:05:55 -0800
Message-ID: <311fe310-d43c-cf5f-623d-6f747bc2f2a5@quicinc.com>
Date:   Thu, 5 Jan 2023 10:34:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] soc: qcom: dcc: Fix examples list on
 /sys/kernel/debug/dcc/.../[list-number]/config documentation
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Devicetree <devicetree@vger.kernel.org>
CC:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        "Sibi Sankar" <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20221230135030.17002-1-bagasdotme@gmail.com>
 <20221230135030.17002-2-bagasdotme@gmail.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20221230135030.17002-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6Hq9MFPcxPOu8LHBchXP5ZxzE4UT20xQ
X-Proofpoint-GUID: 6Hq9MFPcxPOu8LHBchXP5ZxzE4UT20xQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_01,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301050041
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/2022 7:20 PM, Bagas Sanjaya wrote:
> kernel test robot reported htmldocs warnings:
> 
> Documentation/ABI/testing/debugfs-driver-dcc:34: WARNING: Unexpected indentation.
> Documentation/ABI/testing/debugfs-driver-dcc:34: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Fix these by fixing numbered list syntax on description of
> /sys/kernel/debug/dcc/.../[list-number]/config, including adding blank line
> separators as appropriate.
> 
> Link: https://lore.kernel.org/linux-doc/202212300426.eMLsZsvA-lkp@intel.com/
> Fixes: 4cbe60cf5ad622 ("soc: qcom: dcc: Add driver support for Data Capture and Compare unit(DCC)")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   Documentation/ABI/testing/debugfs-driver-dcc | 63 +++++++++++++-------
>   1 file changed, 41 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
> index a4680950205931..a00f4502885b58 100644
> --- a/Documentation/ABI/testing/debugfs-driver-dcc
> +++ b/Documentation/ABI/testing/debugfs-driver-dcc
> @@ -44,35 +44,54 @@ Description:
>   		example user can jump to list x only after list y is
>   		configured and enabled. The format for entering all
>   		types of instructions are explained in examples as
> -		follows.
> -		Example:
> -	         i)Read Type Instruction
> +		follows:
> +
> +	        i) Read Type Instruction
> +
>   		   echo R <1> <2> <3> >/sys/kernel/debug/dcc/../[list-number]/config
> +
>   		   1->Address to be considered for reading the value.
> +
>   		   2->The word count of the addresses, read n words
>   		      starting from address <1>. Each word is of 32 bits.
>   		      If not entered 1 is considered.
> +
>   		   3->Can be 'apb' or 'ahb' which indicates if it is apb or ahb
>   		      bus respectively. If not entered ahb is considered.
> -		ii)Write Type Instruction
> -		   echo W <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> -		   1->Address to be considered for writing the value.
> -		   2->The value that needs to be written at the location.
> -		   3->Can be a 'apb' or 'ahb' which indicates if it is apb or ahb
> -		      but respectively.
> -	       iii)Read Modify Write type instruction
> -		   echo RW <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> -		   1->The address which needs to be considered for read then write.
> -		   2->The value that needs to be written on the address.
> -		   3->The mask of the value to be written.
> -		iv)Loop Type Instruction
> -		   echo L <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> -		   1->The loop count, the number of times the value of the addresses will be
> -		      captured.
> -		   2->The address count, total number of addresses to be entered in this
> -		      instruction.
> -		   3->The series of addresses to be entered separated by a space like <addr1>
> -		      <addr2>... and so on.
> +
> +		ii) Write Type Instruction
> +
> +		    echo W <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> +
> +		    1->Address to be considered for writing the value.
> +
> +		    2->The value that needs to be written at the location.
> +
> +		    3->Can be a 'apb' or 'ahb' which indicates if it is apb or ahb
> +		       but respectively.
> +
> +	        iii) Read Modify Write type instruction
> +
> +		     echo RW <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> +
> +		     1->The address which needs to be considered for read then write.
> +
> +		     2->The value that needs to be written on the address.
> +
> +		     3->The mask of the value to be written.
> +
> +		iv) Loop Type Instruction
> +
> +		    echo L <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> +
> +		    1->The loop count, the number of times the value of the addresses will be
> +		       captured.
> +
> +		    2->The address count, total number of addresses to be entered in this
> +		       instruction.
> +
> +		    3->The series of addresses to be entered separated by a space like <addr1>
> +		       <addr2>... and so on.
>   
>   What:           /sys/kernel/debug/dcc/.../[list-number]/enable
>   Date:           December 2022

Acked-by:Souradeep Chowdhury <quic_schowdhu@quicinc.com>
