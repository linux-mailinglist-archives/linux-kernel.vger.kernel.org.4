Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C05675051E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjGLKrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjGLKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:47:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E7B19B4;
        Wed, 12 Jul 2023 03:47:43 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CAUKpt018634;
        Wed, 12 Jul 2023 10:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NhtwwmrFLrsgWtVNGMMYdBX94i+RseVMe+iRvC4WikU=;
 b=YtGiLugPMEe8ENFDZaHZLqzMG1fCV1K8JRjgpxpgmfZs6nqpa973fPLSJhaYpo5g7VPt
 LvtC472eo6mhPHMdiA3tFdHrjLhr9OBu0kMCt0BPUpqJ1N2vbECMKAwDesyM2llhuyo+
 9NIEBauw4U7kCDX2tdoQtq9sCuoZ4oRa1llzPX2TGZRX0fDc4qhbzCeXpXTe44cNk4KD
 IWTUvQewunt+I1NgXaDkZIs1nGZ+KuhoeWXGyngdD7jyLrFqgODEy5KpCXLpPKher2UD
 UzKhkKadUIS1IJ8H6VCxshm02PU/cw+u/JGIBotyoCHCobOer/iokMkngNuLzsr7qyBa sA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsfeq16na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 10:47:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CAlTGW029892
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 10:47:29 GMT
Received: from [10.204.79.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 03:47:24 -0700
Message-ID: <9c766061-5508-c60c-55a1-2cf893f655e2@quicinc.com>
Date:   Wed, 12 Jul 2023 16:17:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] ASoC: dt-bindings: Update maintainer email id
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <cychiang@chromium.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230707074337.3120530-1-quic_rohkumar@quicinc.com>
 <CAMuHMdXRt_9BzfnaqVJUAS4QdvGBDZk3B+R_cERUykZhyNWtzQ@mail.gmail.com>
From:   Rohit Kumar <quic_rohkumar@quicinc.com>
In-Reply-To: <CAMuHMdXRt_9BzfnaqVJUAS4QdvGBDZk3B+R_cERUykZhyNWtzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ibN9tAFNWnfiJZqiQ04kuYBXdPCS-kxz
X-Proofpoint-GUID: ibN9tAFNWnfiJZqiQ04kuYBXdPCS-kxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=951 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120095
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/2023 2:48 PM, Geert Uytterhoeven wrote:
> Hi Rohit,
>
> Thanks for your patch!
>
> On Fri, Jul 7, 2023 at 9:49 AM Rohit kumar <quic_rohkumar@quicinc.com> wrote:
>> [PATCH v2] ASoC: dt-bindings: Update maintainer email id
> Thank you for stepping forward to become a maintainer for all ASoC
> DT bindings ;-)
>
>> Updated my mail id to latest quicinc id.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Rohit kumar <quic_rohkumar@quicinc.com>
>> ---
>> v2: Updated commit header
>>
>>   .../devicetree/bindings/sound/google,sc7180-trogdor.yaml        | 2 +-
>>   Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml     | 2 +-
> Oh wait, this is not for all of ASoC...
>
> Please use one-line summaries that reflect the actual changes.
> Thanks!

Sorry, Looks like change is already applied. I will take care of it from 
next time.

Thanks,

Rohit

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
