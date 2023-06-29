Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A7F741DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjF2Bpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjF2Bpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:45:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4781FCB;
        Wed, 28 Jun 2023 18:45:37 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0CrFQ029409;
        Thu, 29 Jun 2023 01:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=ZYWynEvEKNe8VfOw/p/gTYwzAY7ckXkgyE3yqJuE0T0=;
 b=MJA9ev2Hkxjx5p10t12BffBjoMcDAiGG2uua9kd2bo1QIn9+IMwwap3Gs5CMnbWzZ2HK
 PCxYfg2M5Xs5vkGPJdyxpjK9trQ5yVfGDT3K+SOf1hhtRbMVdE1HyKQ8UewJ8IEEJdyf
 k4RKtyrVOo+PsTmDAoF+JQV23BcN/JcvYGAVXDjW5zGfDfJJGmJrDwD44XhrXf7Ycivt
 zEwNqjYeL7fWDg95JHWzsQAh7USekFhzTKtpLeXnfmLyDhWJaqgfxYZWFyBOVjKiYlUi
 3u/hy2R3J3J1HziDGZcAzXkGg9SZVSWVS3oP+QKsuPrC0fkbIlEP9qSsSMHyenUqhE8H dg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgetpj99c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 01:45:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T1jCmm022921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 01:45:13 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 28 Jun 2023 18:45:05 -0700
Date:   Thu, 29 Jun 2023 07:15:01 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <mathieu.poirier@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 08/21] dt-bindings: reserved-memory: Add qcom,ramoops
 binding
Message-ID: <07e3a4ce-d1fd-4af7-a288-a88e8fb1c954@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-9-git-send-email-quic_mojha@quicinc.com>
 <87ba1c2d-fa0b-4ac5-ba79-b3556101b612@quicinc.com>
 <CAL_Jsq+_G4wBR7tm+DvN-yYSaoAX6OgxHa0AToJYucDdhD=Dtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+_G4wBR7tm+DvN-yYSaoAX6OgxHa0AToJYucDdhD=Dtg@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9kp9rIKzyYn_Az1wGtxsEwfzcKAeNG4n
X-Proofpoint-GUID: 9kp9rIKzyYn_Az1wGtxsEwfzcKAeNG4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:17:13PM -0600, Rob Herring wrote:
> On Wed, Jun 28, 2023 at 8:11 AM Pavan Kondeti <quic_pkondeti@quicinc.com> wrote:
> >
> > On Wed, Jun 28, 2023 at 06:04:35PM +0530, Mukesh Ojha wrote:
> > > Qualcomm ramoops minidump logger provide a means of storing
> > > the ramoops data to some dynamically reserved memory instead
> > > of traditionally implemented ramoops where the region should
> > > be statically fixed ram region. Its device tree binding
> > > would be exactly same as ramoops device tree binding and is
> > > going to contain traditional ramoops frontend data and this
> > > content will be collected via Qualcomm minidump infrastructure
> > > provided from the boot firmware.
> > >
> > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > ---
> > >  .../devicetree/bindings/soc/qcom/qcom,ramoops.yaml | 126 +++++++++++++++++++++
> > >  1 file changed, 126 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
> > > new file mode 100644
> > > index 000000000000..b1fdcf3f8ad4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
> > > @@ -0,0 +1,126 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/soc/qcom/qcom,ramoops.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Qualcomm Ramoops minidump logger
> > > +
> > > +description: |
> > > +  Qualcomm ramoops minidump logger provide a means of storing the ramoops
> > > +  data to some dynamically reserved memory instead of traditionally
> > > +  implemented ramoops where the region should be statically fixed ram
> > > +  region. Because of its similarity with ramoops it will also have same
> > > +  set of property what ramoops have it in its schema and is going to
> > > +  contain traditional ramoops frontend data and this region will be
> > > +  collected via Qualcomm minidump infrastructure provided from the
> > > +  boot firmware.
> > > +
> > > +maintainers:
> > > +  - Mukesh Ojha <quic_mojha@quicinc.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - qcom,sm8450-ramoops
> > > +      - const: qcom,ramoops
> > > +
> > > +  memory-region:
> > > +    maxItems: 1
> > > +    description: handle to memory reservation for qcom,ramoops region.
> > > +
> > > +  ecc-size:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: enables ECC support and specifies ECC buffer size in bytes
> > > +    default: 0 # no ECC
> > > +
> > > +  record-size:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: maximum size in bytes of each kmsg dump
> > > +    default: 0
> > > +
> > > +  console-size:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: size in bytes of log buffer reserved for kernel messages
> > > +    default: 0
> > > +
> > > +  ftrace-size:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: size in bytes of log buffer reserved for function tracing and profiling
> > > +    default: 0
> > > +
> > > +  pmsg-size:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: size in bytes of log buffer reserved for userspace messages
> > > +    default: 0
> > > +
> > > +  mem-type:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: if present, sets the type of mapping is to be used to map the reserved region.
> > > +    default: 0
> > > +    oneOf:
> > > +      - const: 0
> > > +        description: write-combined
> > > +      - const: 1
> > > +        description: unbuffered
> > > +      - const: 2
> > > +        description: cached
> > > +
> > > +  max-reason:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    default: 2 # log oopses and panics
> > > +    maximum: 0x7fffffff
> > > +    description: |
> > > +      If present, sets maximum type of kmsg dump reasons to store.
> > > +      This can be set to INT_MAX to store all kmsg dumps.
> > > +      See include/linux/kmsg_dump.h KMSG_DUMP_* for other kmsg dump reason values.
> > > +      Setting this to 0 (KMSG_DUMP_UNDEF), means the reason filtering will be
> > > +      controlled by the printk.always_kmsg_dump boot param.
> > > +      If unset, it will be 2 (KMSG_DUMP_OOPS), otherwise 5 (KMSG_DUMP_MAX).
> > > +
> > > +  flags:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    default: 0
> > > +    description: |
> > > +      If present, pass ramoops behavioral flags
> > > +      (see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
> > > +
> > > +  no-dump-oops:
> > > +    deprecated: true
> > > +    type: boolean
> > > +    description: |
> > > +      Use max_reason instead. If present, and max_reason is not specified,
> > > +      it is equivalent to max_reason = 1 (KMSG_DUMP_PANIC).
> > > +
> > > +  unbuffered:
> > > +    deprecated: true
> > > +    type: boolean
> > > +    description: |
> > > +      Use mem_type instead. If present, and mem_type is not specified,
> > > +      it is equivalent to mem_type = 1 and uses unbuffered mappings to map
> > > +      the reserved region (defaults to buffered mappings mem_type = 0).
> > > +      If both are specified -- "mem_type" overrides "unbuffered".
> > > +
> >
> > Most of the properties you added here are already documented at
> > Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> 
> That is certainly a problem. Don't define the same property more than
> once. Not yet checked and enforced by the tools, but it will be.
> 
> > Can't we just reference them here? would something like work?
> >
> > max-reason:
> >   $ref: "../../reserved-memory/ramoops.yaml#/properties/max-reason
> 
> Can work, but no. Common properties need to go into a schema of common
> properties which the device specific schemas reference.
> 

Thanks for the clarification. We need to define the common properties
and make it available under /schemas/<>.yaml and add a reference to it
in these bindings. Is my understanding correct?

> >
> > > +unevaluatedProperties: false
> > > +
> >
> > will there be any additional properties be added dynamically? if not,
> > should not we use "additionalProperties: false" here?
> 
> I don't know what you mean by dynamically, but that's not the criteria
> for which to use.
> 
ok, I was wrong in saying dynamically. I should say "are there any other
properties that will be included that are not documented here".

is below my understanding correct?

additionalProperties needs to be set to false if at all this binding
defines all the possible properties (including child nodes) and not
referring to any other schemas.

If that is not the case and this binding references to other schemas,
then unevaluatedProperties could be used since additionalProperties
can't support combining schemas.

Thanks,
Pavan
