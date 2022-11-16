Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD1562B6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiKPJyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKPJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:54:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7367F1759D;
        Wed, 16 Nov 2022 01:54:20 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG641K2005817;
        Wed, 16 Nov 2022 09:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=SLKxYZqGxj167jz0sYj8WG4KNM9owQ7O91/mF4XQLl8=;
 b=YLQCh+QoW6vmIwOBdH63QykX5FQvZjjzYG9rm5AYSFU1iWWMUcUHF1qAbnEKI3DA9sSe
 ORjavcwQfbHtHLKaasSb1yhCER+uGq/9PNuB5niZGCVPcrTT2Lk144I2KcY9kP6dyL8o
 Ag65ZkVOwofRKEhjxvUE19H13xIGrt0qot7mtOIrydn9hg3OCfxWDh4J9wj1F5Qvji3p
 KjDZUEA/5SK27BIImuItmqOhEXO8Y9B2hP5VOhxowlWljKIL9kDDT/PrvUPadeQSu3cX
 w0NiZT3a3U/DEJJJnrnrTgUL+lxrwt58tweEyEjz0SxqIL8FQqu8ZaXI3B7Evz4KZ9Cv Zg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kvt928nf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 09:54:14 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AG9j99o012178;
        Wed, 16 Nov 2022 09:54:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3kutnequck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 09:54:13 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AG9peZN020815;
        Wed, 16 Nov 2022 09:54:13 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 2AG9sDiI023266
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 09:54:13 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 16 Nov 2022 01:54:09 -0800
Date:   Wed, 16 Nov 2022 15:24:05 +0530
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        "Brian Masney" <bmasney@redhat.com>
Subject: Re: [PATCH v8 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
Message-ID: <20221116095405.GA16833@hu-ppareek-blr.qualcomm.com>
References: <20221116075207.32363-1-quic_ppareek@quicinc.com>
 <20221116075207.32363-3-quic_ppareek@quicinc.com>
 <Y3ScYKVYIVyj/mG0@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3ScYKVYIVyj/mG0@hovoldconsulting.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hFIq7TZRebjQ1Gov3h16LvPmXZSu7zVn
X-Proofpoint-ORIG-GUID: hFIq7TZRebjQ1Gov3h16LvPmXZSu7zVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 09:16:32AM +0100, Johan Hovold wrote:
> On Wed, Nov 16, 2022 at 01:22:07PM +0530, Parikshit Pareek wrote:
> > Introduce the Qualcomm SA8540P ride automotive platform, also known as
> > Qdrive-3 development board.
> > 
> > This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> > regulators, debug UART, PMICs, remoteprocs and USB.
> > 
> > The SA8540P ride contains four PM8450 PMICs. A separate DTSI file has
> > been created for PMIC, so that it can be used for future SA8540P based
> > boards.
> > 
> > Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> 
> > +&ufs_mem_hc {
> > +	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
> > +
> > +	vcc-supply = <&vreg_l17c>;
> > +	vcc-max-microamp = <800000>;
> > +	vccq-supply = <&vreg_l6c>;
> > +	vccq-max-microamp = <900000>;
> > +
> > +	status = "disabled";
> > +};
> > +
> > +&ufs_mem_phy {
> > +	vdda-phy-supply = <&vreg_l8g>;
> > +	vdda-pll-supply = <&vreg_l3g>;
> > +
> > +	status = "disabled";
> > +};
> 
> Why are these disabled? This should be mentioned somewhere (e.g. commit
> message and/or comment) or you can drop the nodes until support is in
> place.
My bad. Happened by mistake.
> 
> Johan
Regards,
Parikshit Pareek
