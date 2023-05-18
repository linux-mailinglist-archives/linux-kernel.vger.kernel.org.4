Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF2707C76
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjERJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjERJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:05:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873D1BD4;
        Thu, 18 May 2023 02:05:57 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I7fDZI002865;
        Thu, 18 May 2023 09:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=uYeQEwyNSDyCJ75uoKD+30zbamaz1CT8c5M3QBOfLmg=;
 b=SxAZU6BRlV5z34vD5F+S4djsGQR477TRsXa0mbYNIdLvSlORXcMjWBzGwJ7GMeyuxiGP
 0xtU1SZuy0GBIuXroaxhMnBHGVglASkn3WAmhmYREuVJur4r2EMdkLbJn3SAgmzCiUY9
 SDhnCof5CD1+gn0qQBeAeO+JLnkAXaQ59WF87s6ticwvPVWN7hgDuznIu2E+Manj2R0Y
 2Ioe4qA+Lrow8AvuwAwftilrnRadeAa2zKqL3M6YnVHFZUaCcu6zAqNjBA9eddqZ5n20
 WtCOE7sn7je2kXswryCJsTd88AMz5DhHHuGgbzq4oC1HIvXaXQ+XQIY2ZmwHwoXlbYYV aQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnc30rhn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 09:05:15 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34I95E8Z007845
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 09:05:14 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 02:05:08 -0700
Date:   Thu, 18 May 2023 14:35:04 +0530
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
Message-ID: <20230518090503.GA9173@varda-linux.qualcomm.com>
References: <cover.1684140883.git.quic_varada@quicinc.com>
 <37adcf5d8d545a076e8ed971a4fb6c6c2833ef3c.1684140883.git.quic_varada@quicinc.com>
 <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
 <20230516120426.GA1679@varda-linux.qualcomm.com>
 <1999753b-ceee-d66c-9a48-cbcbb8e6236e@linaro.org>
 <20230517055726.GA3165@varda-linux.qualcomm.com>
 <cfba78d7-e563-4544-00f3-0991b91eb1f3@linaro.org>
 <20230518054054.GA998@varda-linux.qualcomm.com>
 <fe1d81d2-52e6-7d2d-8d6c-ffdcbb8ccc89@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <fe1d81d2-52e6-7d2d-8d6c-ffdcbb8ccc89@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nrTYQQDUDTmMbJS_he-e3ode_aWIedTP
X-Proofpoint-ORIG-GUID: nrTYQQDUDTmMbJS_he-e3ode_aWIedTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=803 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, May 18, 2023 at 09:09:12AM +0200, Krzysztof Kozlowski wrote:
> On 18/05/2023 07:40, Varadarajan Narayanan wrote:
> > On Wed, May 17, 2023 at 09:00:49AM +0200, Krzysztof Kozlowski wrote:
> >> On 17/05/2023 07:57, Varadarajan Narayanan wrote:
> >>> Part-1 is adding the 'const' entries at the beginning i.e.
> >>>
> >>> 	+      - const: qcom,tsens-v0_1
> >>> 	+      - const: qcom,tsens-v1
> >>> 	+      - const: qcom,tsens-v2
> >>> 	+      - const: qcom,ipq8074-tsens
> >>>
> >>> Part-2 is changing from one valid syntax to another i.e.
> >>>
> >>> 	+        items:
> >>> 	+          - enum:
> >>> 	+              - qcom,ipq9574-tsens
> >>> 	+          - const: qcom,ipq8074-tsens
> >>>
> >>> Without both of the above changes, either or both of dtbs_check
> >>> & dt_binding_check fails. So, it is not possible to just add the
> >>> "valid hunk" (part-2) alone.
> >>
> >> Of course it is. All schema files work like that...
> >>>
> >>> If having both part-1 and part-2 in the same patch is not
> >>> acceptable, shall I split them into two patches? Please let me know.
> >>
> >> No, hunk one is not justified.
> >
> > For the other compatibles, the enum entries and const/fallback
> > entries are different. For the 9574 & 8074 case, we want to have
> > qcom,ipq8074-tsens as both enum and const/fallback entry. Hence,
> > if we don't have the first hunk, dtbs_check fails for 8074
> > related dtbs
> >
> > 	ipq8074-hk01.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
> > 		['qcom,ipq8074-tsens'] is too short
>
> Why? It is already there. Open the file and you will see that this is
> already covered.

I guess dtbs_check doesn't like the same value being a const and
a oneof entry. Have attached the file, please see if something is
not in order.

> If you remove it, then yes, you will see errors and the answer is: do
> not remove it.

I haven't removed it. For this patch, ipq8074-tsens changed from
being an oneof enum entry to a const entry. Probably, that is why
dtbs_check is giving these errors.

> > 	ipq8074-hk10-c2.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
> > 		['qcom,ipq8074-tsens'] is too short
> >
> > 	ipq8074-hk10-c1.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
> > 		['qcom,ipq8074-tsens'] is too short
> >
> > I'm not sure of the correct solution. Having the first hunk
> > solves the above dtbs_check errors, so went with it. I'm able to
> > avoid dtbs_check errors with just one entry in the first hunk.
>
> You made multiple changes in one patch which is not correct. Your goal
> is to add only one change - ipq9574 followed by ipq8074. Add this one.
> Don't touch others.

But that breaks dtbs_check.

> >  	+      - const: qcom,ipq8074-tsens
> >
> > Please let me know if there is a better way to resolve this or we
> > can have just the 8074 entry in the first hunk.
>
> You only need to add new item on the oneOf list:
>  - enum
>      - ipq9574
>  - const: ipq8074

The "['qcom,ipq8074-tsens'] is too short" errors were generated
with the above snippet only. Please see the attachment

Thanks
Varada

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="qcom-tsens.yaml"

# SPDX-License-Identifier: (GPL-2.0 OR MIT)
# Copyright 2019 Linaro Ltd.
%YAML 1.2
---
$id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml#
$schema: http://devicetree.org/meta-schemas/core.yaml#

title: QCOM SoC Temperature Sensor (TSENS)

maintainers:
  - Amit Kucheria <amitk@kernel.org>

description: |
  QCOM SoCs have TSENS IP to allow temperature measurement. There are currently
  three distinct major versions of the IP that is supported by a single driver.
  The IP versions are named v0.1, v1 and v2 in the driver, where v0.1 captures
  everything before v1 when there was no versioning information.

properties:
  compatible:
    oneOf:
      - description: msm8960 TSENS based
        items:
          - enum:
              - qcom,ipq8064-tsens
              - qcom,msm8960-tsens

      - description: v0.1 of TSENS
        items:
          - enum:
              - qcom,mdm9607-tsens
              - qcom,msm8916-tsens
              - qcom,msm8939-tsens
              - qcom,msm8974-tsens
          - const: qcom,tsens-v0_1

      - description: v1 of TSENS
        items:
          - enum:
              - qcom,msm8956-tsens
              - qcom,msm8976-tsens
              - qcom,qcs404-tsens
          - const: qcom,tsens-v1

      - description: v2 of TSENS
        items:
          - enum:
              - qcom,msm8953-tsens
              - qcom,msm8996-tsens
              - qcom,msm8998-tsens
              - qcom,sc7180-tsens
              - qcom,sc7280-tsens
              - qcom,sc8180x-tsens
              - qcom,sc8280xp-tsens
              - qcom,sdm630-tsens
              - qcom,sdm845-tsens
              - qcom,sm6115-tsens
              - qcom,sm6350-tsens
              - qcom,sm8150-tsens
              - qcom,sm8250-tsens
              - qcom,sm8350-tsens
              - qcom,sm8450-tsens
              - qcom,sm8550-tsens
          - const: qcom,tsens-v2

      - description: v2 of TSENS with combined interrupt
        items:
          - enum:
              - qcom,ipq9574-tsens
          - const: qcom,ipq8074-tsens

  reg:
    items:
      - description: TM registers
      - description: SROT registers

  interrupts:
    minItems: 1
    maxItems: 2

  interrupt-names:
    minItems: 1
    maxItems: 2

  nvmem-cells:
    oneOf:
      - minItems: 1
        maxItems: 2
        description:
          Reference to an nvmem node for the calibration data
      - minItems: 5
        maxItems: 35
        description: |
          Reference to nvmem cells for the calibration mode, two calibration
          bases and two cells per each sensor
        # special case for msm8974 / apq8084
      - maxItems: 51
        description: |
          Reference to nvmem cells for the calibration mode, two calibration
          bases and two cells per each sensor, main and backup copies, plus use_backup cell

  nvmem-cell-names:
    oneOf:
      - minItems: 1
        items:
          - const: calib
          - enum:
              - calib_backup
              - calib_sel
      - minItems: 5
        items:
          - const: mode
          - const: base1
          - const: base2
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
          - pattern: '^s[0-9]+_p1$'
          - pattern: '^s[0-9]+_p2$'
        # special case for msm8974 / apq8084
      - items:
          - const: mode
          - const: base1
          - const: base2
          - const: use_backup
          - const: mode_backup
          - const: base1_backup
          - const: base2_backup
          - const: s0_p1
          - const: s0_p2
          - const: s1_p1
          - const: s1_p2
          - const: s2_p1
          - const: s2_p2
          - const: s3_p1
          - const: s3_p2
          - const: s4_p1
          - const: s4_p2
          - const: s5_p1
          - const: s5_p2
          - const: s6_p1
          - const: s6_p2
          - const: s7_p1
          - const: s7_p2
          - const: s8_p1
          - const: s8_p2
          - const: s9_p1
          - const: s9_p2
          - const: s10_p1
          - const: s10_p2
          - const: s0_p1_backup
          - const: s0_p2_backup
          - const: s1_p1_backup
          - const: s1_p2_backup
          - const: s2_p1_backup
          - const: s2_p2_backup
          - const: s3_p1_backup
          - const: s3_p2_backup
          - const: s4_p1_backup
          - const: s4_p2_backup
          - const: s5_p1_backup
          - const: s5_p2_backup
          - const: s6_p1_backup
          - const: s6_p2_backup
          - const: s7_p1_backup
          - const: s7_p2_backup
          - const: s8_p1_backup
          - const: s8_p2_backup
          - const: s9_p1_backup
          - const: s9_p2_backup
          - const: s10_p1_backup
          - const: s10_p2_backup

  "#qcom,sensors":
    description:
      Number of sensors enabled on this platform
    $ref: /schemas/types.yaml#/definitions/uint32
    minimum: 1
    maximum: 16

  "#thermal-sensor-cells":
    const: 1
    description:
      Number of cells required to uniquely identify the thermal sensors. Since
      we have multiple sensors this is set to 1

required:
  - compatible
  - interrupts
  - interrupt-names
  - "#thermal-sensor-cells"
  - "#qcom,sensors"

allOf:
  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,ipq8064-tsens
              - qcom,mdm9607-tsens
              - qcom,msm8916-tsens
              - qcom,msm8960-tsens
              - qcom,msm8974-tsens
              - qcom,msm8976-tsens
              - qcom,qcs404-tsens
              - qcom,tsens-v0_1
              - qcom,tsens-v1
    then:
      properties:
        interrupts:
          items:
            - description: Combined interrupt if upper or lower threshold crossed
        interrupt-names:
          items:
            - const: uplow

  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,msm8953-tsens
              - qcom,msm8996-tsens
              - qcom,msm8998-tsens
              - qcom,sc7180-tsens
              - qcom,sc7280-tsens
              - qcom,sc8180x-tsens
              - qcom,sc8280xp-tsens
              - qcom,sdm630-tsens
              - qcom,sdm845-tsens
              - qcom,sm6350-tsens
              - qcom,sm8150-tsens
              - qcom,sm8250-tsens
              - qcom,sm8350-tsens
              - qcom,sm8450-tsens
              - qcom,tsens-v2
    then:
      properties:
        interrupts:
          items:
            - description: Combined interrupt if upper or lower threshold crossed
            - description: Interrupt if critical threshold crossed
        interrupt-names:
          items:
            - const: uplow
            - const: critical

  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,ipq8074-tsens
    then:
      properties:
        interrupts:
          items:
            - description: Combined interrupt if upper, lower or critical thresholds crossed
        interrupt-names:
          items:
            - const: combined

  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,ipq8074-tsens
              - qcom,tsens-v0_1
              - qcom,tsens-v1
              - qcom,tsens-v2

    then:
      required:
        - reg

additionalProperties: false

examples:
  - |
    #include <dt-bindings/interrupt-controller/arm-gic.h>
    // Example msm9860 based SoC (ipq8064):
    gcc: clock-controller {

           /* ... */

           tsens: thermal-sensor {
                compatible = "qcom,ipq8064-tsens";

                 nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
                 nvmem-cell-names = "calib", "calib_backup";
                 interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
                 interrupt-names = "uplow";

                 #qcom,sensors = <11>;
                 #thermal-sensor-cells = <1>;
          };
    };

  - |
    #include <dt-bindings/interrupt-controller/arm-gic.h>
    // Example 1 (new calbiration data: for pre v1 IP):
    thermal-sensor@900000 {
        compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
        reg = <0x4a9000 0x1000>, /* TM */
              <0x4a8000 0x1000>; /* SROT */

        nvmem-cells = <&tsens_mode>,
                      <&tsens_base1>, <&tsens_base2>,
                      <&tsens_s0_p1>, <&tsens_s0_p2>,
                      <&tsens_s1_p1>, <&tsens_s1_p2>,
                      <&tsens_s2_p1>, <&tsens_s2_p2>,
                      <&tsens_s4_p1>, <&tsens_s4_p2>,
                      <&tsens_s5_p1>, <&tsens_s5_p2>;
        nvmem-cell-names = "mode",
                           "base1", "base2",
                           "s0_p1", "s0_p2",
                           "s1_p1", "s1_p2",
                           "s2_p1", "s2_p2",
                           "s4_p1", "s4_p2",
                           "s5_p1", "s5_p2";

        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-names = "uplow";

        #qcom,sensors = <5>;
        #thermal-sensor-cells = <1>;
    };

  - |
    #include <dt-bindings/interrupt-controller/arm-gic.h>
    // Example 1 (legacy: for pre v1 IP):
    tsens1: thermal-sensor@900000 {
           compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
           reg = <0x4a9000 0x1000>, /* TM */
                 <0x4a8000 0x1000>; /* SROT */

           nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
           nvmem-cell-names = "calib", "calib_sel";

           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
           interrupt-names = "uplow";

           #qcom,sensors = <5>;
           #thermal-sensor-cells = <1>;
    };

  - |
    #include <dt-bindings/interrupt-controller/arm-gic.h>
    // Example 2 (for any platform containing v1 of the TSENS IP):
    tsens2: thermal-sensor@4a9000 {
          compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
          reg = <0x004a9000 0x1000>, /* TM */
                <0x004a8000 0x1000>; /* SROT */

          nvmem-cells = <&tsens_caldata>;
          nvmem-cell-names = "calib";

          interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
          interrupt-names = "uplow";

          #qcom,sensors = <10>;
          #thermal-sensor-cells = <1>;
    };

  - |
    #include <dt-bindings/interrupt-controller/arm-gic.h>
    // Example 3 (for any platform containing v2 of the TSENS IP):
    tsens3: thermal-sensor@c263000 {
           compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
           reg = <0xc263000 0x1ff>,
                 <0xc222000 0x1ff>;

           interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
                        <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
           interrupt-names = "uplow", "critical";

           #qcom,sensors = <13>;
           #thermal-sensor-cells = <1>;
    };

  - |
    #include <dt-bindings/interrupt-controller/arm-gic.h>
    // Example 4 (for any IPQ8074 based SoC-s):
    tsens4: thermal-sensor@4a9000 {
           compatible = "qcom,ipq8074-tsens";
           reg = <0x4a9000 0x1000>,
                 <0x4a8000 0x1000>;

           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
           interrupt-names = "combined";

           #qcom,sensors = <16>;
           #thermal-sensor-cells = <1>;
    };
...

--YiEDa0DAkWCtVeE4--
