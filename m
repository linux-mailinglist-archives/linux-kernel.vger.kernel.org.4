Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9AF61439A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 04:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiKADUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 23:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiKADUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 23:20:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E164C1;
        Mon, 31 Oct 2022 20:20:10 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A13B3We003254;
        Tue, 1 Nov 2022 03:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vsmyPGqjrN3pNUGJKucOlOuMfiAWJI3kVBM4CmpcAkg=;
 b=UUJ0PGKXDKWr5c3E2BU6bNCBnUPNMa0Equr0An1IGwSLjMDeld0Q1S79X1JxIq5dXGb+
 kG6ulC1mMuXLMDmCu0i2QX+vTzs08Klenr/y1VWSNNWzZINaI/SPoWNsLFSQImZbOe3b
 DCLLTVawa4nQVXP5mVWm3D4tMPBm7aXB+yj4ToXzr9hC/pVUUOnSjyuybNtaItgVqFoG
 Ki5altTbn2ScPNROPmrGTWwi9st/hHGJA15ZLkT30j/QXcBA4GUFf65EzIS+sL/lauc0
 Pl1GgCpc+75hf1A4NQm71V/UvO4WgE1a+F9ToBezO9RpHxhGO/tgFFedTWcYxwY4iM+V dQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kjsqh05ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 03:19:56 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A13JtsO000716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Nov 2022 03:19:55 GMT
Received: from [10.110.109.83] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 31 Oct
 2022 20:19:53 -0700
Message-ID: <fb7e101f-8de0-d77e-30e1-74b882b19583@quicinc.com>
Date:   Mon, 31 Oct 2022 20:19:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 02/21] dt-bindings: Add binding for gunyah hypervisor
Content-Language: en-US
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-3-quic_eberman@quicinc.com>
 <CABb+yY3JVNPG3dcyHNFxEeGEu3MN_pAOh3+cwexPPe2YG6SNUg@mail.gmail.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <CABb+yY3JVNPG3dcyHNFxEeGEu3MN_pAOh3+cwexPPe2YG6SNUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4w0f77iR79SVZoQsJSIViVLTnRUaGtL4
X-Proofpoint-ORIG-GUID: 4w0f77iR79SVZoQsJSIViVLTnRUaGtL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_22,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=749 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

On 10/27/2022 7:33 PM, Jassi Brar wrote:
 > On Wed, Oct 26, 2022 at 1:59 PM Elliot Berman 
<quic_eberman@quicinc.com> wrote:
 > .....
 >> +
 >> +        gunyah-resource-mgr@0 {
 >> +            compatible = "gunyah-resource-manager-1-0", 
"gunyah-resource-manager";
 >> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX 
full IRQ */
 >> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX 
empty IRQ */
 >> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
 >> +                  /* TX, RX cap ids */
 >> +        };
 >>
 > All these resources are used only by the mailbox controller driver.
 > So, this should be the mailbox controller node, rather than the
 > mailbox user.> One option is to load gunyah-resource-manager as a 
module that relies
 > on the gunyah-mailbox provider. That would also avoid the "Allow
 > direct registration to a channel" hack patch.

A message queue to another guest VM wouldn't be known at boot time and 
thus couldn't be described on the devicetree. We will need "Allow direct 
registration to a channel" patch anyway to support those message queues. 
I would like to have one consistent mechanism to set up message queues.

- Elliot
