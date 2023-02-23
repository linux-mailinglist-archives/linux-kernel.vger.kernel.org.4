Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2362F6A05E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjBWKTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjBWKTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:19:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D14498AB;
        Thu, 23 Feb 2023 02:19:47 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N5rI3b006103;
        Thu, 23 Feb 2023 10:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pfyZZO6xMEuJP6vhvmuwjFzktu+Iqk/2I7+Jba2oc0Q=;
 b=PD9VRS2bhbQhURCoEYg6FUd7hWiK+nlu+o/5QzxXFcLw5KVOCLWCaZDXWT/0HloGyXEq
 QElhiZqJXA5fHGpQpE8iC5IyGCkjMxl+GQGU54dQhzS/mTEJlqU9K+KdzbhGbr6KSwxK
 1ycSoPYTeOn1AGfGTo2EEMHDVxumBRtUo48/iLdYqifD5y39lG0+uQSK9GchQA43obe9
 ytteGyQRasIekblHJR9z802pptTe6c55wpylNFru44K7fI1kz18jcNgTH6/O8/1Opc3E
 ddQ9Ls0itgl/KQVSNNI7ILI0gPM2gnh4QOzRfWRrCV/gxcXuHsI9wrnGdA/TqJUAqzo9 /Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwybwgykd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:19:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NAJcgk019330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:19:38 GMT
Received: from [10.216.58.21] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 02:19:34 -0800
Message-ID: <ef82f126-af16-8eba-4da9-eb08106a03db@quicinc.com>
Date:   Thu, 23 Feb 2023 15:49:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND v8 4/5] clk: qcom: lpassaudiocc-sc7280: Merge AHB clocks
 into lpass_aon
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <quic_visr@quicinc.com>, <robh+dt@kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20230215151330.539885-1-quic_mohs@quicinc.com>
 <20230215151330.539885-5-quic_mohs@quicinc.com>
 <CAE-0n53mDzqua47jEqrJwQBhcQcyBjJAtNvH2J-tCPhkvV9JtA@mail.gmail.com>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <CAE-0n53mDzqua47jEqrJwQBhcQcyBjJAtNvH2J-tCPhkvV9JtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mggz6HI0JFJFTJw8yYfdZ-xCUKslvekK
X-Proofpoint-ORIG-GUID: mggz6HI0JFJFTJw8yYfdZ-xCUKslvekK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_06,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=987 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302230088
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/16/2023 11:01 AM, Stephen Boyd wrote:
> Quoting Mohammad Rafi Shaik (2023-02-15 07:13:29)
>> @@ -828,8 +830,9 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
>>          if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
>>                  lpass_audio_cc_sc7280_regmap_config.name = "cc";
>>                  desc = &lpass_cc_sc7280_desc;
>> -               ret = qcom_cc_probe(pdev, desc);
>> -               goto exit;
>> +               ret = qcom_cc_probe_by_index(pdev, 1, desc);
> Where is the patch to the binding yaml file?
Thanks for comment.

The dtbinding  yaml file for this is already present in existing yaml.

Below is the snippet for the same:

compatible = "qcom,sc7280-lpassaoncc";
reg = <0x3380000 0x30000>;

Actually what ever the  CC register region <required range is  0x3389000 
0x24> which we are accessing is already present in the above reg map 
range of dtsi, so we have not updated the 
/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml file.

