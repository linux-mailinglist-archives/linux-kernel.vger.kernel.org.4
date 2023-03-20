Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD26C0A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCTFqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCTFqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:46:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4A818B16;
        Sun, 19 Mar 2023 22:46:34 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K5K3x0015415;
        Mon, 20 Mar 2023 05:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FdiERBDNupNV8C9GnoQMOmECcBVBz64rI00JxNqc3kc=;
 b=ploVJHXTMBMU0aI1KvKd9h7Tes7aOJko/q2qqbeJguIQ4XjTzxMncT/QHahwbWMN+2nU
 IKtbB7tvU5Wt4c2d8/ADDKROFhCl9+8xxjDlQLsnGs04rEd+ht3rDwmV6eIMRCMg2Y2f
 NRxPuCm2cNdR9vzMxa85yCgSk7vQsljbaONSqLJPe2X0uszQV0lflNX5sUKJ4eqINnyj
 k1Xgg3cljsiveVFtEyUrEa0qghPqRoFtUQQuWDZ0cp6A3J4vLBTS/qcr8BxU4E1ELBTb
 5WNShpDSzoXB7Sxq/fqQRj1wTne0RyX1VF46yr9Btjzas2Wfx1b3lethgjiUdI8jlt2m 8A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pd6kgkv1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 05:46:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32K5kPRA008738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 05:46:25 GMT
Received: from [10.216.3.84] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 19 Mar
 2023 22:46:22 -0700
Message-ID: <f673e050-6093-bf01-ed24-325f8de584d5@quicinc.com>
Date:   Mon, 20 Mar 2023 11:16:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 3/4] clk: qcom: lpassaudiocc-sc7280: Add required gdsc
 power domain clks in lpass_cc_sc7280_desc strcuture
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_visr@quicinc.com>,
        <swboyd@chromium.org>
References: <20230317141622.1926573-1-quic_mohs@quicinc.com>
 <20230317141622.1926573-4-quic_mohs@quicinc.com>
 <06cc8339e30eb38175e04058b69b41ca.sboyd@kernel.org>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <06cc8339e30eb38175e04058b69b41ca.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nArNwX-OFIHeiD9u-ck6TP02jeR-Rgeu
X-Proofpoint-ORIG-GUID: nArNwX-OFIHeiD9u-ck6TP02jeR-Rgeu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_02,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=721 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200051
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/18/2023 12:13 AM, Stephen Boyd wrote:
> Just remove strcuture from the subject.
>
> Quoting Mohammad Rafi Shaik (2023-03-17 07:16:21)
>> Add the gdsc's in lpass_cc_sc7280_desc strcuture,
> s/strcuture/struct/
>
>> When qcom,adsp-pil-mode is enabled, gdsc's required to solve
> Just 'GDSCs', because gdsc isn't owning anything.
>
>> dependencies in lpass_audiocc probe.
> I think you're saying that we need to register the GDSCs when
> qcom,adsp-pil-mode is set in the qcom,sc7280-lpassaoncc node. Otherwise,
> we don't get any GDSCs provided by that node when we should always be
> providing them.

Yes, need to register GDSCs when qcom,adsp-pil-mode is set in the 
qcom,sc7280-lpassaoncc node.

The lpass_audiocc requires GDSCs to probe become success.

>> Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
> If the above is right, then this fixes tag is wrong. It should really be
>
> Fixes: 0cbcfbe50cbf ("clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon")
>
> right?
Okay, will change fixes tag.
