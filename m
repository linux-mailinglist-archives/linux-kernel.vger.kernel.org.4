Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF42710BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbjEYMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbjEYMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:05:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453B10B;
        Thu, 25 May 2023 05:05:10 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PAsSRl003840;
        Thu, 25 May 2023 11:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WtHLc5bn2wfymNfcUBeWUkg7r2uCrw/LdIA1iRY40Eo=;
 b=Cz5yuhCEuhH0o6dCx55WX3AFOR4Yv3kKg9ZBZN5hMK1nwlT7cFUDgLNy9nxaWWi16Qnx
 /UuuEAnlCWFVBIZnVMY+HcDKNxdSefdA/OTWmxvtvSb5pBByBZ21zv5R2grbxzYzjXtQ
 bx8ljZ7BB02DWd+vT7AEXZXralrg2hLx4EcMdIjzFevqJ882fbriPA6EcLfFkFIIrdeP
 yKjpY8itWMXr6h3jCgxlh4pnTzHV2nHbPkH52/y9gBzOkM855CFc7Y+x4xxPIXNgOcTJ
 oei95Xly+FPNYUT0E2DunWOQtpEmU6pesOdMTPYHFO1r41sSW9bykRdffWijPvBIpNq8 0Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsywfrvke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:36:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PBa7VP005854
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:36:08 GMT
Received: from [10.216.30.6] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 04:36:04 -0700
Message-ID: <6628ab14-0e50-fe1d-bb4d-560c4e4bf4d2@quicinc.com>
Date:   Thu, 25 May 2023 17:06:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] media: venus: hfi_cmds: Replace fake flex-array
 with flexible-array member
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <ZGQn63U4IeRUiJWb@work> <202305171049.9AB52166@keescook>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <202305171049.9AB52166@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gfj1UhZYxJxXEbwwHMnvDL0wpeipHpXC
X-Proofpoint-ORIG-GUID: Gfj1UhZYxJxXEbwwHMnvDL0wpeipHpXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250096
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/2023 11:20 PM, Kees Cook wrote:
> On Tue, May 16, 2023 at 07:03:39PM -0600, Gustavo A. R. Silva wrote:
>> One-element arrays are deprecated, and we are replacing them with flexible
>> array members instead. So, replace one-element arrays with flexible-array
>> members in struct hfi_sys_set_resource_pkt, and refactor the rest of
>> the code, accordingly.
>>
>> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
>> routines on memcpy() and help us make progress towards globally
>> enabling -fstrict-flex-arrays=3 [1].
>>
>> The only binary differences seen before/after changes are the
>> following:
>>
>>      17ba:      mov    %rbx,%rdi
>>      17bd:      call   17c2 <pkt_sys_set_resource+0x42>
>>                         17be: R_X86_64_PLT32    __tsan_write4-0x4
>> -    17c2:      movl   $0x14,(%rbx)
>> +    17c2:      movl   $0x10,(%rbx)
>>      17c8:      lea    0x4(%rbx),%rdi
>>      17cc:      call   17d1 <pkt_sys_set_resource+0x51>
>>                         17cd: R_X86_64_PLT32    __tsan_write4-0x4
>>
>> which is expected once this accounts for the following line of code
>> at  drivers/media/platform/qcom/venus/hfi_cmds.c:73
>>
>> 73         pkt->hdr.size = sizeof(*pkt);
>>
>> and as *pkt is of type struct hfi_sys_set_resource_pkt, sizeof(*pkt) is
>> reduced by 4 bytes, due to the flex-array transformation.
> 
> Based on the other place that was subtracting the 1 element, this looks
> like hfi_cmds.c:73 is an existing sizing bug that is now fixed with this
> patch, yes?

It is not a bug. The way it is structured is like [packet header + payload]. The
packet header size should be (size of header + payload). Line 73 calculates the
size of packet header, while line 86 calculates size of payload. Since payload
starts from the last u32, the total size needs to be reduced by size of u32.

> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Link: https://github.com/KSPP/linux/issues/293
>> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

The patch looks good. As stated in previous patch, lets combine this into a
single series.

>> ---
>>  drivers/media/platform/qcom/venus/hfi_cmds.c | 2 +-
>>  drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> index 3f74d518ad08..7c82e212434e 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> @@ -83,7 +83,7 @@ int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32 size,
>>  		res->size = size;
>>  		res->mem = addr;
>>  		pkt->resource_type = HFI_RESOURCE_OCMEM;
>> -		pkt->hdr.size += sizeof(*res) - sizeof(u32);
>> +		pkt->hdr.size += sizeof(*res);
>>  		break;
>>  	}
>>  	case VIDC_RESOURCE_NONE:
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
>> index ba74d03eb9cd..dd9c5066442d 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
>> @@ -56,7 +56,7 @@ struct hfi_sys_set_resource_pkt {
>>  	struct hfi_pkt_hdr hdr;
>>  	u32 resource_handle;
>>  	u32 resource_type;
>> -	u32 resource_data[1];
>> +	u32 resource_data[];
>>  };
>>  
>>  struct hfi_sys_release_resource_pkt {
>> -- 
>> 2.34.1
>>
> 
