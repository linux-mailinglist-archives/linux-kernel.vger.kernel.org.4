Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1A65E533
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjAEFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjAEFle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:41:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B746598;
        Wed,  4 Jan 2023 21:41:32 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3054c39X017916;
        Thu, 5 Jan 2023 05:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W1mzfTLUU8HkEIhLUmcdPlhgNvkygLNZ+TnKmQClBI8=;
 b=MpxEzKETwpv1aHGIKgb3TMwDiqYsyqzkePbs+Aief8lniGXTDlzcddIlNTnd2r/qYabY
 HLf88zLM8plbXHN2p5/JxzV/UDQOW9WHCCvWNiD/ukDXHr4Qp7xj0Rwt2Y5vzbNn44du
 AoI6ajDaL6BBAj8tL7cZsPfSiXYM2qRgWIQVb49SbWKMpVfxO/PWnBEeHOghbiXW8G1J
 rPdJkRMAD6baaY3GsxHO6q2XZ1kpXtsZyl09/Dh9/uQdzds1RQC7iBSUbYKI0nOitdEo
 sAicSc2rl1YrLsb1bhiZ9gqPtTDY5VKQd/Y7gZiw+YyCQI1zQn0KW3CP41Uju6GbovDB BA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvvbkcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 05:17:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3055HtU1022813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 05:17:55 GMT
Received: from [10.50.40.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 4 Jan 2023
 21:17:49 -0800
Message-ID: <59c01308-075c-5108-9019-47ee1ba1210c@quicinc.com>
Date:   Thu, 5 Jan 2023 10:47:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] soc: qcom: dcc: rewrite description of dcc sysfs
 files
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
        Vinod Koul <vkoul@kernel.org>
References: <20221230135030.17002-1-bagasdotme@gmail.com>
 <20221230135030.17002-3-bagasdotme@gmail.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20221230135030.17002-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fghL7fGXkmy7bYDSvQWQsu8v2o5Khh8i
X-Proofpoint-GUID: fghL7fGXkmy7bYDSvQWQsu8v2o5Khh8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_01,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301050041
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/2022 7:20 PM, Bagas Sanjaya wrote:
> The description of dcc sysfs files is somewhat confusing and not effective.
> Rewrite it to be clear.
> 
> While at it, also use literal code block for config sysfs examples and
> remove redundant examples that are obvious.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   Documentation/ABI/testing/debugfs-driver-dcc | 142 ++++++++++---------
>   1 file changed, 76 insertions(+), 66 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
> index a00f4502885b58..27ed5919d21b9c 100644
> --- a/Documentation/ABI/testing/debugfs-driver-dcc
> +++ b/Documentation/ABI/testing/debugfs-driver-dcc
> @@ -3,115 +3,125 @@ Date:           December 2022
>   Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>   Description:
>   		This file is used to check the status of the dcc
> -		hardware if it's ready to take the inputs. A 'Y'
> -		here indicates dcc is in a ready condition.
> -		Example:
> -		cat /sys/kernel/debug/dcc/.../ready
> +		hardware if it's ready to receive user configurations.
> +		A 'Y' here indicates dcc is ready.
>   
>   What:           /sys/kernel/debug/dcc/.../trigger
>   Date:           December 2022
>   Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>   Description:
>   		This is the debugfs interface for manual software
> -		triggers. The user can simply enter a 1 against
> -		the debugfs file and enable a manual trigger.
> -		Example:
> -		echo  1 > /sys/kernel/debug/dcc/.../trigger
> +		triggers. The trigger can be invoked by writing '1'
> +		to the file.
>   
>   What:           /sys/kernel/debug/dcc/.../config_reset
>   Date:           December 2022
>   Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>   Description:
>   		This file is used to reset the configuration of
> -		a dcc driver to the default configuration. This
> -		means that all the previous addresses stored in
> -		the driver gets removed and user needs to enter
> -		the address values from the start.
> -		Example:
> -		echo  1 > /sys/kernel/debug/dcc/../config_reset
> +		a dcc driver to the default configuration. When '1'
> +		is written to the file, all the previous addresses
> +		stored in the driver gets removed and users need to
> +		reconfigure addresses again.
>   
>   What:           /sys/kernel/debug/dcc/.../[list-number]/config
>   Date:		 December 2022
>   Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>   Description:
>   		This stores the addresses of the registers which
> -		should be read in case of a hardware crash or
> -		manual software triggers. The addresses entered here
> -		are considered under all the 4 types of dcc
> -		instructions Read type, Write type, Read Modify Write
> -		type and Loop type. The lists need to be configured
> -		sequentially and not in a overlapping manner. As an
> -		example user can jump to list x only after list y is
> -		configured and enabled. The format for entering all
> -		types of instructions are explained in examples as
> -		follows:
> +		can be read in case of a hardware crash or manual
> +		software triggers. The input addresses type
> +		can be one of following dcc instructions: read,
> +		write, read-write, and loop type. The lists need to
> +		be configured sequentially and not in a overlapping
> +		manner; e.g. users can jump to list x only after
> +		list y is configured and enabled. The input format for
> +		each type is as follows:
>   
> -	        i) Read Type Instruction
> +	        i) Read instruction
>   
> -		   echo R <1> <2> <3> >/sys/kernel/debug/dcc/../[list-number]/config
> +		   ::
>   
> -		   1->Address to be considered for reading the value.
> +		     echo R <addr> <n> <bus> >/sys/kernel/debug/dcc/../[list-number]/config
>   
> -		   2->The word count of the addresses, read n words
> -		      starting from address <1>. Each word is of 32 bits.
> -		      If not entered 1 is considered.
> +		   where:
>   
> -		   3->Can be 'apb' or 'ahb' which indicates if it is apb or ahb
> -		      bus respectively. If not entered ahb is considered.
> +		   <addr>
> +			The address to be read.
>   
> -		ii) Write Type Instruction
> +		   <n>
> +			The addresses word count, starting from address <1>.
> +			Each word is 32 bits (4 bytes). If omitted, defaulted
> +			to 1.
>   
> -		    echo W <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> +		   <bus type>
> +			The bus type, which can be either 'apb' or 'ahb'.
> +			The default is 'ahb' if leaved out.
>   
> -		    1->Address to be considered for writing the value.
> +		ii) Write instruction
>   
> -		    2->The value that needs to be written at the location.
> +		    ::
>   
> -		    3->Can be a 'apb' or 'ahb' which indicates if it is apb or ahb
> -		       but respectively.
> +		      echo W <addr> <n> <bus type> > /sys/kernel/debug/dcc/../[list-number]/config
>   
> -	        iii) Read Modify Write type instruction
> +		    where:
>   
> -		     echo RW <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> +		    <addr>
> +			The address to be written.
>   
> -		     1->The address which needs to be considered for read then write.
> +		    <n>
> +			The value to be written at <addr>.
>   
> -		     2->The value that needs to be written on the address.
> +		    <bus type>
> +			The bus type, which can be either 'apb' or 'ahb'.
>   
> -		     3->The mask of the value to be written.
> +	        iii) Read-write instruction
>   
> -		iv) Loop Type Instruction
> +		     ::
>   
> -		    echo L <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> +		       echo RW <addr> <n> <mask> > /sys/kernel/debug/dcc/../[list-number]/config
>   
> -		    1->The loop count, the number of times the value of the addresses will be
> -		       captured.
> +		     where:
>   
> -		    2->The address count, total number of addresses to be entered in this
> -		       instruction.
> +		     <addr>
> +			The address to be read and written.
>   
> -		    3->The series of addresses to be entered separated by a space like <addr1>
> -		       <addr2>... and so on.
> +		     <n>
> +		        The value to be written at <addr>.
> +
> +		     <mask>
> +			The value mask.
> +
> +		iv) Loop instruction
> +
> +		    ::
> +
> +		      echo L <loop count> <address count> <address>... > /sys/kernel/debug/dcc/../[list-number]/config
> +
> +		    where:
> +
> +		    <loop count>
> +			Number of iterations
> +
> +		    <address count>
> +			total number of addresses to be written
> +
> +		    <address>
> +			Space-separated list of addresses.
>   
>   What:           /sys/kernel/debug/dcc/.../[list-number]/enable
>   Date:           December 2022
>   Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>   Description:
>   		This debugfs interface is used for enabling the
> -		the dcc hardware. Enable file is kept under the
> -		directory list number for which the user wants
> -		to enable it. For example if the user wants to
> -		enable list 1, then he should go for
> -		echo 1 > /sys/kernel/debug/dcc/.../1/enable.
> -		On enabling the dcc, all the addresses entered
> +		the dcc hardware. A file named "enable" is in the
> +		directory list number where users can enable/disable
> +		the specific list by writing boolean (1 or 0) to the
> +		file.
> +
> +		On enabling the dcc, all the addresses specified
>   		by the user for the corresponding list is written
>   		into dcc sram which is read by the dcc hardware
> -		on manual or crash induced triggers. Lists should
> -		be enabled sequentially.For example after configuring
> -		addresses for list 1 and enabling it, a user can
> -		proceed to enable list 2 or vice versa.
> -		Example:
> -		echo  0 > /sys/kernel/debug/dcc/.../[list-number]/enable
> -		(disable dcc for the corresponding list number)
> -		echo  1 > /sys/kernel/debug/dcc/.../[list-number]/enable
> -		(enable dcc for the corresponding list number)
> +		on manual or crash induced triggers. Lists must
> +		be configured and enabled sequentially, e.g. list
> +		2 can only be enabled when list 1 have so.

Acked-by:Souradeep Chowdhury <quic_schowdhu@quicinc.com>
