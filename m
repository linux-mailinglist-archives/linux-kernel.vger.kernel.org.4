Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2716704D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjEPMEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjEPMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:04:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4897C30FE;
        Tue, 16 May 2023 05:04:42 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GAcDsi015268;
        Tue, 16 May 2023 12:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=pY0yj58hPlHBY9cauW2Ttf8YI3LqWC5Y7iGKqTrGPuU=;
 b=BylNkX9FKHmH26cNJix/WlUwnlCWc5DAh+nqIc7L0WEXGW65JeEBHNUqCEZ2Z1P+dVEq
 ekmVVvF2QR5Yygq4ieKZBVRq3bcc5kP2q26ZHG040fXw/rG76eUIh3yHPydE4dmv3+md
 ay0qCNEIfMp+iHXdjmMr+vV23Mfbyqo/7eNq1wocN/46l+rn7yvGLbo3C03LFkJsN2iK
 ud3Afr+mTeAg3QckPLZGNgLeT8RFVL11qdkpmRoTPUhxuRPF+AavwnvYkUrIYeoRDJff
 /5fodlAGA4HvfDdoPm05NohySdsOQiRDwd5YZT5BJuviUpsfqeGe72DMMHlmQEObkidK Gg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkkde2xfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 12:04:37 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GC4a7o003529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 12:04:36 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 16 May 2023 05:04:31 -0700
Date:   Tue, 16 May 2023 17:34:27 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Message-ID: <20230516120426.GA1679@varda-linux.qualcomm.com>
References: <cover.1684140883.git.quic_varada@quicinc.com>
 <37adcf5d8d545a076e8ed971a4fb6c6c2833ef3c.1684140883.git.quic_varada@quicinc.com>
 <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QvkZWJduGUlbTGZSluXhlCVCd_QCTVML
X-Proofpoint-ORIG-GUID: QvkZWJduGUlbTGZSluXhlCVCd_QCTVML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_05,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160103
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 06:10:29PM +0200, Krzysztof Kozlowski wrote:
> On 15/05/2023 12:13, Varadarajan Narayanan wrote:
> > From: Praveenkumar I <quic_ipkumar@quicinc.com>
> >
> > Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
> >
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > [v3]:
> > 	Fix dt_binding_check & dtbs_check errors (Used
> > 	Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
> > 	as reference/example)
> >
> > 	Drop 'Acked-by: Rob Herring' as suggested in review
> >
> > [v2]:
> > 	Thanks to Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 	for the tip to make qcom,ipq8074-tsens as fallback.
> > ---
> >  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > index d9aa54c..57e3908 100644
> > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > @@ -19,6 +19,11 @@ description: |
> >  properties:
> >    compatible:
> >      oneOf:
> > +      - const: qcom,tsens-v0_1
> > +      - const: qcom,tsens-v1
> > +      - const: qcom,tsens-v2
>
> Nope, these are not correct.
>
> > +      - const: qcom,ipq8074-tsens
>
> Also nope, this is already there.
>
> > +
> >        - description: msm8960 TSENS based
> >          items:
> >            - enum:
> > @@ -66,8 +71,10 @@ properties:
> >            - const: qcom,tsens-v2
> >
> >        - description: v2 of TSENS with combined interrupt
> > -        enum:
> > -          - qcom,ipq8074-tsens
>
> Why?
>
> > +        items:
> > +          - enum:
> > +              - qcom,ipq9574-tsens
> > +          - const: qcom,ipq8074-tsens

Without changing it like this either dtbs_check or
dt_binding_check kept failing.

	- description: v2 of TSENS with combined interrupt
	  enum:
	    - qcom,ipq8074-tsens
	    - qcom,ipq9574-tsens

dtbs_check gave this kind of error
	['qcom,ipq9574-tsens', 'qcom,ipq8074-tsens'] is too long

After changing it like in https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L31

	- description: v2 of TSENS with combined interrupt
	  const: qcom,ipq8074-tsens
	  - enum:
	      - qcom,ipq9574-tsens
	  - const: qcom,ipq8074-tsens

dt_binding_check gives the following error

	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:70:9: did not find expected key

and dtbs_check gives

	./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:70:9: [error] syntax error: expected <block end>, but found '-' (syntax)
	  CHKDT   Documentation/devicetree/bindings/processed-schema.json
	./Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml
	./Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml
	./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:70:9: did not find expected key
	  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
	/local/mnt/workspace/varada/v3/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml: ignoring, error parsing file

If i change it like below,

	- description: v2 of TSENS with combined interrupt
	  enum:
	    - qcom,ipq9574-tsens
	  - const: qcom,ipq8074-tsens

dt_binding_check and dtbs_check gives same error as above.

Looked around and found Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
which seemed to do something similar to what is wanted in this
case. Hence changed qcom-tsens.yaml similar to the allwinner yaml
file. After which dt_binding_check and dtbs_check passed. Please
let me know if there is a better way to solve this. Will go with
that.

Thanks
Varada

> >
> >    reg:
> >      items:
> > @@ -279,6 +286,7 @@ allOf:
> >            contains:
> >              enum:
> >                - qcom,ipq8074-tsens
> > +              - qcom,ipq9574-tsens
>
> Not needed, drop.
>
> >      then:
> >        properties:
> >          interrupts:
> > @@ -294,6 +302,7 @@ allOf:
> >            contains:
> >              enum:
> >                - qcom,ipq8074-tsens
> > +              - qcom,ipq9574-tsens
>
> Ditto.
>
>
> Best regards,
> Krzysztof
>
