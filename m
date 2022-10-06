Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BD85F5F3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJFC4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJFC4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:56:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBEA7FFAB;
        Wed,  5 Oct 2022 19:54:56 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2962f2pB017580;
        Thu, 6 Oct 2022 02:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=22YcYq+W1feRc4HBuCzwqSEcjToWsa3pJjCRJMDKwOE=;
 b=G/650jOgfd3+wyx4fOLpTBsBSC/14eGB1u//NUP2Jhjh7j4lmluJDJ03GATl124QxUj/
 hqYPcgOJ14rw3cTouERXRiPl++V6qCj9FWzdGjrnwY4hGqhueQGsDHCOV+FgwhoTC04+
 AjgcgogSR0q0kxjAn0hIS4rsW2weBO+5Z18tr2QCx59sNuusCoTeVQCG8IWt723A4BBq
 cDybgfsBOCnZSV4lg0mqdFiRNvBc1dzmXOkHwWZ+XsmDIPbuH8URe7j0m5NSMLSJ+Ck3
 rLdMWNXNwR5cabewv7yr+hHYXRMKSFvYny6HCK+85qxWXw/zeAME74bJS4WOE9tC9Kn6 pw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0escvw01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 02:54:50 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2962sn4O020936;
        Thu, 6 Oct 2022 02:54:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jxemkrcn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 02:54:49 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2962snrJ020929;
        Thu, 6 Oct 2022 02:54:49 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 2962snga020928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 02:54:49 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 19:54:45 -0700
Date:   Thu, 6 Oct 2022 08:24:41 +0530
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Shazad Hussain" <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        "Johan Hovold" <johan@kernel.org>
Subject: Re: [PATCH v5 0/3] arm64: dts: qcom: add dts for sa8540p-ride board
Message-ID: <20221006025441.GA31711@hu-ppareek-blr.qualcomm.com>
References: <20221003125444.12975-1-quic_ppareek@quicinc.com>
 <02365772-de32-56ab-65a2-0a2fbccb5e2e@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <02365772-de32-56ab-65a2-0a2fbccb5e2e@somainline.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YzRmov9snVSBKpE-BcNYVsx8tBVMPKhJ
X-Proofpoint-GUID: YzRmov9snVSBKpE-BcNYVsx8tBVMPKhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 mlxlogscore=726 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 11:05:11PM +0200, Konrad Dybcio wrote:
> 
> On 03/10/2022 14:54, Parikshit Pareek wrote:
> > Change in v5:
> > - Moved the usb and ufs nodes from sa8540p-adp.dtsi file to respective
> >    board specific dts files: sa8295p-adp.dts and sa8540p-adp-ride.dts.
> 
> Is there any benefit in this? USB0/2 and UFS (not UFS card) nodes are
> identical
> 
> in the 2 files.
Similar boards might come in future, anticipated to be differing mainly
with respect to usb/ufs. Hence thought it better to put ufs/usb nodes in
board specific dts.

Regards,
Parikshit Pareek
> 
> 
> Konrad
> 
> >    Took inputs from Shazad Hussain in this regard(John)
> > - Added more description of the board differences(John)
> > - Not including Reviewed-by for Krzysztof, because of the new changes to
> >    be reviewed.
> > - Removed Reported-by tag(John).
> > 
> > Changes in v4:
> >   - Removed the ufs_card_hc node, as it is not mounted on Qdrive-3 board.
> >   - Removed usb_1 relared nodes, as usb1 doesn't have any port connected on
> >     Qdrive3 board.
> >   - Added Reported-by tag for Shazad(for ufs and usb_1 node removals)
> > 
> > Changes in v3:
> >   - Added Acked-by tag (Krzysztof)
> >   - Renamed dtsi to sa8540p-adp.dtsi (John)
> >   - Removed copyright from sa8295-adp.dts and sa8295-adp.dtsi(John)
> >   - Added cover letter
> > 
> > change in v2:
> > - Make dt-binding patch as the first one in the patch set
> > - Add , after year 2022, in the license header
> > 
> > Initial version:
> > - Move the common nodes to sa8540p-adp.dtsi, and create qrive-3 board
> >    specific file sa8540p-adp-ride.dts.
> > 
> > 
> > Parikshit Pareek (3):
> >    dt-bindings: arm: qcom: Document additional sa8540p device
> >    arm64: dts: qcom: sa8295p: move common nodes to dtsi
> >    arm64: dts: qcom: introduce sa8540p-ride dts
> > 
> >   .../devicetree/bindings/arm/qcom.yaml         |   1 +
> >   arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >   arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 528 +++++-------------
> >   arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts |  71 +++
> >   .../{sa8295p-adp.dts => sa8540p-adp.dtsi}     | 133 -----
> >   5 files changed, 219 insertions(+), 515 deletions(-)
> >   rewrite arch/arm64/boot/dts/qcom/sa8295p-adp.dts (70%)
> >   create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> >   copy arch/arm64/boot/dts/qcom/{sa8295p-adp.dts => sa8540p-adp.dtsi} (72%)
> > 
