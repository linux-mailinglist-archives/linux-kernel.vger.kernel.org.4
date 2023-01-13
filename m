Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F22866989A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbjAMNdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbjAMNco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:32:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0999C6252;
        Fri, 13 Jan 2023 05:24:43 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBVFf5019311;
        Fri, 13 Jan 2023 13:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=s3lPgerO6Zm01G+91xyFLAHC60wLD4aqEIvBZkGUB6c=;
 b=QxZzU5zovo5MzXmync7d90efp1g+jFA7zJkwPsL7QIkwssDgzEJAQpd91Gj8MDU17niQ
 w2WdTX+EWxa+kLtqxvzRs2Pk9PKWlvj1H9GGtET9SQ3igPn/1sRzhkLE49/QXnKYWFWb
 g04+vpJStPQ3mCrNeAQ176Gk35Vjz5Q5XrFw2xzlTxvsJyUzOCuzGuvI60aKweY63hem
 CV+s7c0eidi+Lm8tG29II9f/xCD4Ow9uGSrPr6SvAV4fYT1J010O8sS6az7+iVrE4MIq
 ETS1syPe/bK56pszj3oQSAG+n/hLEc+8CYQch4rKEPP1VCqc4gJb5utLHKy46i+fqc5a 4Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n351f8r3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:24:31 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DDOQTT021079
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:24:26 GMT
Received: from [10.216.54.29] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:24:22 -0800
Message-ID: <6b016170-0d01-ebb3-a47e-4107cabc4403@quicinc.com>
Date:   Fri, 13 Jan 2023 18:54:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/3] Documentation: admin-guide: ramoops.rst: Update
 the ramoops document
Content-Language: en-US
To:     <keescook@chromium.org>, <gpiccoli@igalia.com>, <corbet@lwn.net>,
        <tony.luck@intel.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
 <1673611126-13803-2-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1673611126-13803-2-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: je4DLjiZ5rsvOfLf7ljzJh2YyOFGFa7Q
X-Proofpoint-ORIG-GUID: je4DLjiZ5rsvOfLf7ljzJh2YyOFGFa7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/13/2023 5:28 PM, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This is not desirable
> in environments where it is preferred the region to be dynamically
> allocated at runtime. So, update the document while adding the
> support in the driver.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Change in v2:
>    - Added this patch as per changes going to be done in patch 3/3
> 
>   Documentation/admin-guide/ramoops.rst | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> index e9f8514..88884b2 100644
> --- a/Documentation/admin-guide/ramoops.rst
> +++ b/Documentation/admin-guide/ramoops.rst
> @@ -16,8 +16,9 @@ survive after a restart.
>   Ramoops concepts
>   ----------------
>   
> -Ramoops uses a predefined memory area to store the dump. The start and size
> -and type of the memory area are set using three variables:
> +Ramoops uses both predefined and dynamically memory area to store the dump.
> +The start and size and type of the memory area are set using three
> +variables:
>   
>     * ``mem_address`` for the start
>     * ``mem_size`` for the size. The memory size will be rounded down to a
> @@ -70,7 +71,8 @@ Setting the ramoops parameters can be done in several different manners:
>   
>    B. Use Device Tree bindings, as described in
>    ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
> - For example::
> +
> + Example of statically reserved ramoops region::
>   
>   	reserved-memory {
>   		#address-cells = <2>;
> @@ -85,6 +87,23 @@ Setting the ramoops parameters can be done in several different manners:
>   		};
>   	};
>   
> + Example of dynamically reserved ramoops region::
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ramoops@8f000000 {

Will fix it as ramoops_region : ramoops ?

> +			compatible = "ramoops";
> +			alloc-ranges = <0x0 0x00000000 0xffffffff 0xffffffff>;
> +			size = <0 0x100000>;
> +			record-size = <0x4000>;
> +			console-size = <0x4000>;
> +		};
> +	};
> +
> +
>    C. Use a platform device and set the platform data. The parameters can then
>    be set through that platform data. An example of doing that is:
>   

-Mukesh
