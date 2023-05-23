Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E270DA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbjEWKTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbjEWKTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:19:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB9F94;
        Tue, 23 May 2023 03:19:45 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NA82RB009845;
        Tue, 23 May 2023 10:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=dk8HLLZPWZ+CSPzJuc18BjNfkPZ4Kmk0/japlqgqybc=;
 b=OTGY0hWe7O5lQh9jFtO5z60jHjBzvG1yhXPCqpRwCoyYLmNk1+asXcVFVqDoyNkJU7C3
 5yWsm4N3WPLa46AMcBzP+XZFuM8gRby4QX+XdPTGekTr4aK5Y4l+FHouSuAfTQhfm3j1
 2QmFQWcEf2akei53loEJJMFqdNvh6EPheoICpjOodiNaKpCvEJwu+CVU9+VrDwiD0bBd
 t0ygLorshP4B8y36wIKT97u0YR9Xlqm5sUR1imYBsxBTcODsSgGyXLxeycHEWcCdmw7i
 Sv9j9IVoPwCRJgVkI7A0DqKsP+dibJ0HbKzngl3NKBLYH5yxh+TC6RBo1xlAkW1K0yLn cA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrpmm0uvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 10:19:13 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34NAJDuc000506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 10:19:13 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 23 May 2023 03:19:08 -0700
Date:   Tue, 23 May 2023 15:49:04 +0530
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
Message-ID: <20230523101903.GA31656@varda-linux.qualcomm.com>
References: <37adcf5d8d545a076e8ed971a4fb6c6c2833ef3c.1684140883.git.quic_varada@quicinc.com>
 <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
 <20230516120426.GA1679@varda-linux.qualcomm.com>
 <1999753b-ceee-d66c-9a48-cbcbb8e6236e@linaro.org>
 <20230517055726.GA3165@varda-linux.qualcomm.com>
 <cfba78d7-e563-4544-00f3-0991b91eb1f3@linaro.org>
 <20230518054054.GA998@varda-linux.qualcomm.com>
 <fe1d81d2-52e6-7d2d-8d6c-ffdcbb8ccc89@linaro.org>
 <20230518090503.GA9173@varda-linux.qualcomm.com>
 <24b60ca3-b6b9-662f-03c8-df1536b52bc9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <24b60ca3-b6b9-662f-03c8-df1536b52bc9@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8xDTVSq8aSk1mu5vyVJO804DDkQ_zO5A
X-Proofpoint-GUID: 8xDTVSq8aSk1mu5vyVJO804DDkQ_zO5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 01:06:49PM +0200, Krzysztof Kozlowski wrote:
> On 18/05/2023 11:05, Varadarajan Narayanan wrote:
> > On Thu, May 18, 2023 at 09:09:12AM +0200, Krzysztof Kozlowski wrote:
> >> On 18/05/2023 07:40, Varadarajan Narayanan wrote:
> >>> On Wed, May 17, 2023 at 09:00:49AM +0200, Krzysztof Kozlowski wrote:
> >>>> On 17/05/2023 07:57, Varadarajan Narayanan wrote:
> >>>>> Part-1 is adding the 'const' entries at the beginning i.e.
> >>>>>
> >>>>> 	+      - const: qcom,tsens-v0_1
> >>>>> 	+      - const: qcom,tsens-v1
> >>>>> 	+      - const: qcom,tsens-v2
> >>>>> 	+      - const: qcom,ipq8074-tsens
> >>>>>
> >>>>> Part-2 is changing from one valid syntax to another i.e.
> >>>>>
> >>>>> 	+        items:
> >>>>> 	+          - enum:
> >>>>> 	+              - qcom,ipq9574-tsens
> >>>>> 	+          - const: qcom,ipq8074-tsens
> >>>>>
> >>>>> Without both of the above changes, either or both of dtbs_check
> >>>>> & dt_binding_check fails. So, it is not possible to just add the
> >>>>> "valid hunk" (part-2) alone.
> >>>>
> >>>> Of course it is. All schema files work like that...
> >>>>>
> >>>>> If having both part-1 and part-2 in the same patch is not
> >>>>> acceptable, shall I split them into two patches? Please let me know.
> >>>>
> >>>> No, hunk one is not justified.
> >>>
> >>> For the other compatibles, the enum entries and const/fallback
> >>> entries are different. For the 9574 & 8074 case, we want to have
> >>> qcom,ipq8074-tsens as both enum and const/fallback entry. Hence,
> >>> if we don't have the first hunk, dtbs_check fails for 8074
> >>> related dtbs
> >>>
> >>> 	ipq8074-hk01.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
> >>> 		['qcom,ipq8074-tsens'] is too short
> >>
> >> Why? It is already there. Open the file and you will see that this is
> >> already covered.
> >
> > I guess dtbs_check doesn't like the same value being a const and
> > a oneof entry.
>
> I don't understand.

      - description: v2 of TSENS with combined interrupt
        items:
          - enum:
              - qcom,ipq9574-tsens	<--- one of the compatible entries
          - const: qcom,ipq8074-tsens	<--- fallback entry

In this patch, we want 8074 to act as a compatible entry for
ipq8074*.dts and fallback entry for ipq9574.dtsi. That is why I
believe we are not able to just add 9574 and get it to pass
dtbs_check and dt_binding_check.

> >  Have attached the file, please see if something is
> > not in order.
>
> I don't know what changed there. Please work on patches.
>
> >
> >> If you remove it, then yes, you will see errors and the answer is: do
> >> not remove it.
> >
> > I haven't removed it.
>
> You did. Look:
>
>        - description: v2 of TSENS with combined interrupt
> -        enum:
> -          - qcom,ipq8074-tsens
>
> The first character in the diff (-) means removal.

It changed from 'enum' to 'const', that is why I said it is not
removed.

> > For this patch, ipq8074-tsens changed from
> > being an oneof enum entry to a const entry. Probably, that is why
> > dtbs_check is giving these errors.
>
> You removed the entry which you should not have touched.
>
> >
> >>> 	ipq8074-hk10-c2.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
> >>> 		['qcom,ipq8074-tsens'] is too short
> >>>
> >>> 	ipq8074-hk10-c1.dtb: thermal-sensor@4a9000: compatible: 'oneOf' condition
> >>> 		['qcom,ipq8074-tsens'] is too short
> >>>
> >>> I'm not sure of the correct solution. Having the first hunk
> >>> solves the above dtbs_check errors, so went with it. I'm able to
> >>> avoid dtbs_check errors with just one entry in the first hunk.
> >>
> >> You made multiple changes in one patch which is not correct. Your goal
> >> is to add only one change - ipq9574 followed by ipq8074. Add this one.
> >> Don't touch others.
> >
> > But that breaks dtbs_check.
>
> All other cases, hundreds of other binding files, do not have problem.
> Only this one "breaks dtbs_check". No, it does not.
>
> Whatever is broken is result of your removal of unrelated pieces.

Not sure about other binding files. Probably they don't have the
same value for fallback and normal compatible. If there is such
an example binding file, will replicate that syntax/structure for
ipq9574 too.

In the 'nvidia,tegra210-ope' example (https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L25)
too 'nvidia,tegra210-ope' is listed twice

      - const: nvidia,tegra210-ope	<===
      - items:
          - enum:
              - nvidia,tegra234-ope
              - nvidia,tegra194-ope
              - nvidia,tegra186-ope
          - const: nvidia,tegra210-ope	<===

> >>>  	+      - const: qcom,ipq8074-tsens
> >>>
> >>> Please let me know if there is a better way to resolve this or we
> >>> can have just the 8074 entry in the first hunk.
> >>
> >> You only need to add new item on the oneOf list:
> >>  - enum
> >>      - ipq9574
> >>  - const: ipq8074
> >
> > The "['qcom,ipq8074-tsens'] is too short" errors were generated
> > with the above snippet only. Please see the attachment
>
> It's not true. The error you see is result because you removed something
> you should not. I did not ask you to remove anything. So repeating -
> "add new item". Adding is not "removal and adding". Adding is just "adding".

See below for the changes that were tried and the corresponding errors.

(1) No lines removed

	@@ -66,6 +66,7 @@
	       - description: v2 of TSENS with combined interrupt
		 enum:
		   - qcom,ipq8074-tsens
	+          - qcom,ipq9574-tsens

	   reg:
	     items:

	dt_binding_check: No errors

	dtbs_check	:
		arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: thermal-sensor@4a9000: compatible: 'oneOf' conditional failed, one must be fixed:
	        ['qcom,ipq9574-tsens', 'qcom,ipq8074-tsens'] is too long

(2) No lines removed

	@@ -66,6 +66,8 @@
	       - description: v2 of TSENS with combined interrupt
		 enum:
		   - qcom,ipq8074-tsens
	+          - qcom,ipq9574-tsens
	+        - const: qcom,ipq8074-tsens

	   reg:
	     items:

	dt_binding_check: No errors

	dtbs_check	: Gives errors for all the DTS files that have tsens-v0_1, tsens-v2, tsens-v1. Copy pasted a sample for each one of them
		arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb: /soc@0/thermal-sensor@4a9000: failed to match any schema with compatible: ['qcom,msm8916-tsens', 'qcom,tsens-v0_1']
		arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb: /soc@0/thermal-sensor@4a9000: failed to match any schema with compatible: ['qcom,msm8953-tsens', 'qcom,tsens-v2']
		arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dtb: /soc@0/thermal-sensor@4a9000: failed to match any schema with compatible: ['qcom,msm8956-tsens', 'qcom,tsens-v1']


(3) No lines removed
	@@ -19,6 +19,7 @@
	 properties:
	   compatible:
	     oneOf:
	+      - const: qcom,ipq8074-tsens
	       - description: msm8960 TSENS based
		 items:
		   - enum:
	@@ -66,6 +67,8 @@
	       - description: v2 of TSENS with combined interrupt
		 enum:
		   - qcom,ipq8074-tsens
	+          - qcom,ipq9574-tsens
	+        - const: qcom,ipq8074-tsens

	   reg:
	     items:

	dt_binding_check: Same as above

	dtbs_check	: Same as above

(4) Change 8074 from enum to const
	@@ -19,6 +19,7 @@
	 properties:
	   compatible:
	     oneOf:
	+      - const: qcom,ipq8074-tsens
	       - description: msm8960 TSENS based
		 items:
		   - enum:
	@@ -64,8 +65,10 @@
		   - const: qcom,tsens-v2

	       - description: v2 of TSENS with combined interrupt
	-        enum:
	-          - qcom,ipq8074-tsens
	+        items:
	+          - enum:
	+              - qcom,ipq9574-tsens
	+          - const: qcom,ipq8074-tsens

	   reg:
	     items:

	dt_binding_check: No errors

	dtbs_check	: No errors

But (4) doesn't seem acceptable. Any other alternative to resolve this?

Thanks
Varada
