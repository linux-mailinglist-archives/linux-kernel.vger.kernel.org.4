Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A0264E28B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLOUtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiLOUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:49:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8023026AA3;
        Thu, 15 Dec 2022 12:49:27 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFKQwGT009458;
        Thu, 15 Dec 2022 20:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=VK6BeCywnJYOa+0P4ryIqF9jCO11IlECxLhsDeBfXyM=;
 b=YEkJ/3lvY2W/6Qqqo5M9NZXMP+FKDvx8ytoD1xiltCtpJqgfKujYqEkCQNolUiRZNAs0
 w+KQtfOqcDw5JCmc0QhkyxMlQBjkJuXwftlpKfvXptS8Pt08KLMrUMv9Vk75bk4hpzTZ
 yy0XnlvQOF0pafOfMzYf9Dvn6n4BGe3BFwZ3MNAphRzV+XxC/cCOt/8ktpPoZLq+Qw43
 fKl5R/WKX0C8NJmcbkN1RyXFFt8usaviClIYYu25kgg1TtkpTdqHX7iz1XErdVOcj5Nk
 kmIhbv36cpXQ5MfSRP01ZuaSbpr4Tu7zCdQTaAwwIZ9rOZ2w2yFbLTkqToXuKglwFwaP iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mfxseaj43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 20:49:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BFKnKnF007071
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 20:49:20 GMT
Received: from core-thresher1.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 15 Dec 2022 12:49:20 -0800
Date:   Thu, 15 Dec 2022 12:49:18 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: qcom,tlmm-common: document
 i2c pull property
Message-ID: <20221215204615.GA19388@core-thresher1.qualcomm.com>
References: <20221123152001.694546-1-abel.vesa@linaro.org>
 <20221123152001.694546-3-abel.vesa@linaro.org>
 <CACRpkdZtkHCkfUAcezSJvmei=HOezK6oyx+4C5kBrEtU+vAB-g@mail.gmail.com>
 <fecb2dd6-9be2-78dc-4598-cc338fbdc2a2@linaro.org>
 <CACRpkdZJaz9BEorQa7dTNkgTkwZjJNB-MWrpKFxHRgdsf3xJww@mail.gmail.com>
 <8602cacd-f552-e843-5c17-681b099069a3@linaro.org>
 <CACRpkdbqjNJH_QvWyEPceUUxRQ2tOpErNOWA0rg5GNwq7PfUFQ@mail.gmail.com>
 <f6ffd433-1652-fb4f-8657-928e7407ba5f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6ffd433-1652-fb4f-8657-928e7407ba5f@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nwRNLs4KNGuiwhYtkj-TaKeQrt4ea046
X-Proofpoint-GUID: nwRNLs4KNGuiwhYtkj-TaKeQrt4ea046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 09:15:02AM +0100, Neil Armstrong wrote:
> Hi Linus,
> 
> On 26/11/2022 22:53, Linus Walleij wrote:
> > On Fri, Nov 25, 2022 at 1:40 PM <neil.armstrong@linaro.org> wrote:
> > 
> > > As I understood, it enables an "I2C resistor" on the pin, removing the need
> > > of an external pull-up resistor on the line.
> > > 
> > > I assume the classical pull-up bias is not strong enough to replace an actual
> > > resistor on the PCB.

That is correct.

> > 
> > In that case I think this should be an argument to bias-pull-up like:
> > 
> > bias-pull-up = <360000>;
> > 
> > Nominally the pull up is in ohms:
> > 
> >    bias-pull-up:
> >      oneOf:
> >        - type: boolean
> >        - $ref: /schemas/types.yaml#/definitions/uint32
> >      description: pull up the pin. Takes as optional argument on hardware
> >        supporting it the pull strength in Ohm.
> > 
> > Then the driver can choose to shunt in this extra I2C resistance
> > from the resistance passed as argument. So no special property
> > is needed, provided you can get an idea about the resistance
> > provided here.
> 
> I like this alternative, I'll try to figure out if we can find a value
> to match against.
> 

The typical value for this resistor is 2.2kOhm.

Regards,
Bjorn
