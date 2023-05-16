Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBF5704E70
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjEPM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjEPM7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:59:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989C25248;
        Tue, 16 May 2023 05:59:01 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GBJqJU003802;
        Tue, 16 May 2023 12:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ooIszafhZntFwAFrRjm+YK/b9Svr96m9RF4ZndvUYGQ=;
 b=i7GGjjh0fv+QPXFP6cwv0q9yKvXiuAjH2LuT/XlPi7DNou94D9/LKiucip0FwvOXEupe
 zus59nguv9Yn6JHXN2N4ZckCh/RsRcm/ySazFtA1e0p8U1kKJlpusSNfvjdhoDfgluLX
 KRieEmo5joSr58Kb7YFXjeiAKrCHAZ1Q7m4X040AW4KJGi2+0LuMFTdYFB3hwfwl8hfM
 ZjHqEZTkPpcaorjqsXjr1vY7pPYwOs1V9t9I8gNSOt4BoS9gjjbtvHuIyBkO0cu8dhOo
 joS1CO8oSx6SDSIrWaeEDbFemdYyRaQJn8vCz6Yb1ihBvxTufwzwXTHbcGW3Qd0mM3A6 bQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkkde321x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 12:57:42 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GCvf7Q013666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 12:57:42 GMT
Received: from [10.252.212.215] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 05:57:36 -0700
Message-ID: <049c7e3e-eaf2-0253-bf5b-83b9e8f949ab@quicinc.com>
Date:   Tue, 16 May 2023 18:27:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 00/18] Venus QoL / maintainability fixes
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        <stable@vger.kernel.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <f9904e82-4756-2add-3c7e-e019ce966515@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <f9904e82-4756-2add-3c7e-e019ce966515@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qUj_6eWhD4UKgMSzasX94rUMbBJsya9s
X-Proofpoint-ORIG-GUID: qUj_6eWhD4UKgMSzasX94rUMbBJsya9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_06,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=653 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160108
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/12/2023 8:31 AM, Bryan O'Donoghue wrote:
> On 04/05/2023 09:00, Konrad Dybcio wrote:
>> Tested on 8250, but pretty please test it on your boards too!
> 
> What's the definition of test here ?
> 
> I ran this
> 
> ffplay -codec:video h264_v4l2m2m FantasticFour-ROTSS.mp4
> 
> and this
> 
> ffplay -codec:video vp8_v4l2m2m /mnt/big-buck-bunny_trailer.webm
> 
> on db410c with no errors. Then again I applied and disapplied the 8x8 264 fix to
> that branch and saw no discernable difference so I'm not very confident we have
> good coverage.
> 
> @Stan @Vikash could you give some suggested tests for coverage here ?

I could think of below test aspects for this series
1. Suspend Resume
2. Concurrency test
3. Module load -> video usecase -> module unload -> module load -> video
usecase. This would ensure video firmware is reloaded and functional.
4. Video playback and encode for all supported resolution and codecs.
5. In general, video playback with more test content.

I would be testing the series with stability test suite on CrOS. That would be
either on sc7180 or sc7280 setup.

Konrad, you can post the new version as one patch needs to be dropped. Test can
be done on the new version. There are few patches in the series pending review,
which can be done in parallel.

-Vikash

> 
> @Konrad - get a db410c !
> 
> My superficial first-pass on this series looks good but, before giving a
> Tested-by here, I think we should define a set of coverage tests, run them - the
> upper end on sm8250 and lower end msm8916 "makes sense to me"
> 
> 20? different gstreamer tests at different formats and different sizes on our
> selected platforms db410c, rb5, rb3 I have - also an 820 I haven't booted and an
> enforce sdm660.
> 
> Which tests will we use to validate this series and subsequent series to ensure
> we don't have more regressions ?
> 
> ---
> bod
