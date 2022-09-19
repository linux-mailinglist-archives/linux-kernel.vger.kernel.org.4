Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF85BCDC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiISN64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiISN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:58:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444912A733;
        Mon, 19 Sep 2022 06:58:51 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JD1hPO005695;
        Mon, 19 Sep 2022 13:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EXRFKA+jIFBhIkdXJ44/eTpvfW+ddnv7ZuRYuj2zRRw=;
 b=XERH5R+Tt2Yn7uOFdfxPQYkQ5V++vhDxvEMA4IweZlxmtaKZsj2aumxIzyhhEfvlJmYL
 vzS7xGXLCIFBLyZXTial4lk68i37182KA5aUvvE5yaBR40Re6XqftCwpMpob9q6IG/9r
 PEVCQTy++DYUCGVPoAryVPz4ZR0e8viSxk8CSodsjgcBd9Re1UFmsN1IWAYbz+Jk1pvO
 jLmlodFS9Zr6NgXbx26sHbfajPRHb4wn/ZOJ08YEW0dhFz1HrhJT8iZ/F7N9vI5eiyhY
 vKBEYW0Fg/ocARptSfWkGvAFJPvU1E9wo6LJNC+wTl3nAMESCt3isS0Udz+//3+0XmTH NQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6b1vutg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 13:58:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JDw0PV021606
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 13:58:00 GMT
Received: from [10.216.41.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 06:57:55 -0700
Message-ID: <85ee0b41-dfd0-8fc3-6d16-3d055ad18792@quicinc.com>
Date:   Mon, 19 Sep 2022 19:27:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 4/8] remoteproc: qcom: Update rproc parse firmware
 callback
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bgoswami@quicinc.com>, <bjorn.andersson@linaro.org>,
        <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <judyhsiao@chromium.org>, <lgirdwood@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
 <1662643422-14909-5-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50i7jqoA8rYhkvMEd_i13apA1ZWhHsXBj99Sn_8Hkywag@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n50i7jqoA8rYhkvMEd_i13apA1ZWhHsXBj99Sn_8Hkywag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _Lt2djVv0AlKeKrPgJ8IXs4lubkBcDET
X-Proofpoint-ORIG-GUID: _Lt2djVv0AlKeKrPgJ8IXs4lubkBcDET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190093
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/12/2022 4:25 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-09-08 06:23:38)
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index 02d17b4..207270d4 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -447,7 +447,7 @@ static unsigned long adsp_panic(struct rproc *rproc)
>>          return qcom_q6v5_panic(&adsp->q6v5);
>>   }
>>
>> -static const struct rproc_ops adsp_ops = {
>> +static struct rproc_ops adsp_ops = {
> This is sad.
>
>>          .start = adsp_start,
>>          .stop = adsp_stop,
>>          .da_to_va = adsp_da_to_va,
>> @@ -590,6 +590,9 @@ static int adsp_probe(struct platform_device *pdev)
>>                  return ret;
>>          }
>>
>> +       if (desc->has_iommu)
>> +               adsp_ops.parse_fw = rproc_elf_load_rsc_table;
>> +
> Why not have two different set of ops so that the function pointer table
> can't be hijacked? One for the parse_fw callback? Or simply return from
> rproc_elf_load_rsc_table() when has_iommu is false?
Okay. Will change accordingly.
>
>>          rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
