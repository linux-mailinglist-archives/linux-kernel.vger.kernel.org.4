Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF7D7188B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjEaRon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjEaRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:44:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342C3BE;
        Wed, 31 May 2023 10:44:40 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VDisVh018055;
        Wed, 31 May 2023 17:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=FP0IfVlmRQOpePEoLgxi5SYwXoJIQ5bpDSXFU7D5nxg=;
 b=h7+L/2Rmu8/ia8/DVsDom38AfaZqf/tYd2mPor8WLkyZxbGo78zpOGj9F7E5jU9UaO9r
 9fCxTtTK2cv2DVWpI9SET2xCC2cAQ1wimdikkvaj5uvUl6Ns0XJA3dptesrO/nYaG4hs
 ZruOnVt+5GmKewPN5eQJDF5H7JiaDCL5A85+hnNrx/6LgNZPwGQcnW8q2vemtfmbZI2Z
 q20X2gKTTLTlT6Qf+SZLjdGudBHsll2KU9MBLJZfnX2gHj0X6AF7XJ+UmF7rDzMR7gOA
 jRiW81U5iuDClrKp1dYPTDE7dpIBe49wzLJPAoPsNgb0MUSymQvVI9qtHA+Z4m48PqSL Rw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwwbtj04p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 17:44:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VHiVXx020027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 17:44:31 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 10:44:30 -0700
Date:   Wed, 31 May 2023 10:44:29 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: reserved-memory: rmtfs: Allow dynamic
 allocation
Message-ID: <20230531174429.GB112802@hu-bjorande-lv.qualcomm.com>
References: <20230530193436.3833889-1-quic_bjorande@quicinc.com>
 <20230530193436.3833889-2-quic_bjorande@quicinc.com>
 <4337f333-0c78-8749-658d-3f7f69538571@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4337f333-0c78-8749-658d-3f7f69538571@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8YXM3on_Kr2b7RiU6ga1Q3wOSnY6Kq9D
X-Proofpoint-ORIG-GUID: 8YXM3on_Kr2b7RiU6ga1Q3wOSnY6Kq9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_12,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=941 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:05:50AM +0200, Krzysztof Kozlowski wrote:
> On 30/05/2023 21:34, Bjorn Andersson wrote:
> > Allow instances of the qcom,rmtfs-mem either be defined as a
> > reserved-memory regoin, or just standalone given just a size.
> 
> typo: region
> 
> I am pretty sure I saw some patches from Qualcomm also making one of
> reserved-memory users a bit more dynamic (some boot-thingy?). Would be
> nice to unify...
> 
> > 
> > This relieve the DeviceTree source author the need to come up with a
> > static memory region for the region.
> 
> If you region does not have to be static, why bothering with the size in
> DT? I assume this can be really dynamic and nothing is needed in DT. Not
> even size.
> 

The size, client-id and vmid need to match the firmware and access
policy configuration, and are as such device-specific properties for the
region.

The desired size is available during the rmtfs handshake, so it's
plausible that one could come up with a mechanism of dynamic allocation.
But this would be complicated (as I'd prefer not to have the rmtfs
service in the kernel...), and we'd still end up with something in DT to
affect placement etc - often a reserved-memory region to specifically
define the placement.

We'd still need the client-id and vmid properties, and we still need
some mechanism to instantiate the rmtfs service and something that will
configure the access permissions for the region...

Regards,
Bjorn
