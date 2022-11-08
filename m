Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB98620DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiKHKtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiKHKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:48:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2CA43871;
        Tue,  8 Nov 2022 02:48:41 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A897LnJ024277;
        Tue, 8 Nov 2022 10:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oqCPnuhcclVuBKkKCdVweXH9kYN9fMbcdEPaLydmOz8=;
 b=SKBFWKilnYWXak7J5N9kGRD9TMc7gE8Bu596/p5t5weTLAPVimhxe/n3SwviPUvhEsL0
 7DHJR/Fy4IdQCcBSFtQYTZjWWTRm1dDvoW4kiHKTVRBB/bvHZv6qIMP/5isIEhQLb3pm
 pJdOL+VG2OrKoIFtCItKXw48KDmJcfmcwqr5tCeNA3rAX9VlW0soZ/Ej3OBcfVbyTf4g
 p7yU5sFogwAR8sZbJ9yYjg17WMEeRJftojG+6kN+23jJMVmK4bfUclbymqedAcGvNNBk
 bnpLcq06mtylCAHc+jDdHx14nScVKOaLPGs0jFIPITAd0Dd/rbXl/hukUi6aYFKeA6Rg kQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhkp0k8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 10:48:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8AmLuZ007667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 10:48:21 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 02:48:18 -0800
Message-ID: <dd4821da-331f-4529-8162-90bfe95aa8f8@quicinc.com>
Date:   Tue, 8 Nov 2022 16:18:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC 1/2] dt-bindings: firmware: arm,scmi: Add support for memlat
 vendor protocol
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <quic_avajid@quicinc.com>
References: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
 <1667451512-9655-2-git-send-email-quic_sibis@quicinc.com>
 <20221104180339.GA2079655-robh@kernel.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221104180339.GA2079655-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c85QPdilenasOBfnSH_12kIYBDxRx3Ng
X-Proofpoint-ORIG-GUID: c85QPdilenasOBfnSH_12kIYBDxRx3Ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Rob,
Thanks for taking time to review the series.

On 11/4/22 23:33, Rob Herring wrote:
> On Thu, Nov 03, 2022 at 10:28:31AM +0530, Sibi Sankar wrote:
>> Add bindings support for the SCMI QTI memlat (memory latency) vendor
>> protocol. The memlat vendor protocol enables the frequency scaling of
>> various buses (L3/LLCC/DDR) based on the memory latency governor
>> running on the CPUSS Control Processor.
> 
> I thought the interconnect binding was what provided details for bus
> scaling.

The bus scaling in this particular case is done by SCP FW and not
from any kernel client. The SCMI vendor protocol would be used to
pass on the bandwidth requirements during initialization and SCP FW
would vote on it independently after it is

> 
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   .../devicetree/bindings/firmware/arm,scmi.yaml     | 164 +++++++++++++++++++++
>>   1 file changed, 164 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> index 1c0388da6721..efc8a5a8bffe 100644
>> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> @@ -189,6 +189,47 @@ properties:
>>         reg:
>>           const: 0x18
>>   
>> +  protocol@80:
>> +    type: object
>> +    properties:
>> +      reg:
>> +        const: 0x80
>> +
>> +      qcom,bus-type:
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        items:
>> +          minItems: 1
>> +        description:
>> +          Identifier of the bus type to be scaled by the memlat protocol.
>> +
>> +      cpu-map:
> 
> cpu-map only goes under /cpus node.

sure will use a qcom specific node instead

> 
>> +        type: object
>> +        description:
>> +          The list of all cpu cluster configurations to be tracked by the memlat protocol
>> +
>> +        patternProperties:
>> +          '^cluster[0-9]':
>> +            type: object
>> +            description:
>> +              Each cluster node describes the frequency domain associated with the
>> +              CPUFREQ HW engine and bandwidth requirements of the buses to be scaled.
>> +
>> +            properties:
> 
> cpu-map nodes don't have properties.

ack

> 
>> +              operating-points-v2: true
>> +
>> +              qcom,freq-domain:
> 
> Please don't add new users of this. Use the performance-domains binding
> instead.

The plan was to re-use the ^^ to determine frequency domain of
the cpus since they are already present in the dts. I guess using
performance-domains bindings would require a corresponding change in
qcom-cpufreq-hw driver as well. Ack.

> 
>> +                $ref: /schemas/types.yaml#/definitions/phandle-array
>> +                description:
>> +                  Reference to the frequency domain of the CPUFREQ HW engine
>> +                items:
>> +                  - items:
>> +                      - description: phandle to CPUFREQ HW engine
>> +                      - description: frequency domain associated with the cluster
>> +
>> +            required:
>> +              - qcom,freq-domain
>> +              - operating-points-v2
>> +
>>   additionalProperties: false
>>   
>>   patternProperties:
>> @@ -429,4 +470,127 @@ examples:
>>           };
>>       };
>>   
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    firmware {
>> +        scmi {
>> +            compatible = "arm,scmi";
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            mboxes = <&cpucp_mbox>;
>> +            mbox-names = "tx";
>> +            shmem = <&cpu_scp_lpri>;
>> +
>> +            scmi_memlat: protocol@80 {
>> +                reg = <0x80>;
>> +                qcom,bus-type = <0x2>;
>> +
>> +                cpu-map {
>> +                    cluster0 {
>> +                        qcom,freq-domain = <&cpufreq_hw 0>;
>> +                        operating-points-v2 = <&cpu0_opp_table>;
>> +                    };
>> +
>> +                    cluster1 {
>> +                        qcom,freq-domain = <&cpufreq_hw 1>;
>> +                        operating-points-v2 = <&cpu4_opp_table>;
>> +                    };
>> +
>> +                    cluster2 {
>> +                        qcom,freq-domain = <&cpufreq_hw 2>;
>> +                        operating-points-v2 = <&cpu7_opp_table>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +
>> +        cpu0_opp_table: opp-table-cpu0 {
>> +            compatible = "operating-points-v2";
>> +
>> +            cpu0_opp_300mhz: opp-300000000 {
>> +                opp-hz = /bits/ 64 <300000000>;
>> +                opp-peak-kBps = <9600000>;
>> +            };
>> +
>> +            cpu0_opp_1325mhz: opp-1324800000 {
>> +                opp-hz = /bits/ 64 <1324800000>;
>> +                opp-peak-kBps = <33792000>;
>> +            };
>> +
>> +            cpu0_opp_2016mhz: opp-2016000000 {
>> +                opp-hz = /bits/ 64 <2016000000>;
>> +                opp-peak-kBps = <48537600>;
>> +            };
>> +        };
>> +
>> +        cpu4_opp_table: opp-table-cpu4 {
>> +            compatible = "operating-points-v2";
>> +
>> +            cpu4_opp_691mhz: opp-691200000 {
>> +                opp-hz = /bits/ 64 <691200000>;
>> +                opp-peak-kBps = <9600000>;
>> +            };
>> +
>> +            cpu4_opp_941mhz: opp-940800000 {
>> +                opp-hz = /bits/ 64 <940800000>;
>> +                opp-peak-kBps = <17817600>;
>> +            };
>> +
>> +            cpu4_opp_2611mhz: opp-2611200000 {
>> +                opp-hz = /bits/ 64 <2611200000>;
>> +                opp-peak-kBps = <48537600>;
>> +            };
>> +        };
>> +
>> +        cpu7_opp_table: opp-table-cpu7 {
>> +            compatible = "operating-points-v2";
>> +
>> +            cpu7_opp_806mhz: opp-806400000 {
>> +                opp-hz = /bits/ 64 <806400000>;
>> +                opp-peak-kBps = <9600000>;
>> +            };
>> +
>> +            cpu7_opp_2381mhz: opp-2380800000 {
>> +                opp-hz = /bits/ 64 <2380800000>;
>> +                opp-peak-kBps = <44851200>;
>> +            };
>> +
>> +            cpu7_opp_2515mhz: opp-2515200000 {
>> +                opp-hz = /bits/ 64 <2515200000>;
>> +                opp-peak-kBps = <48537600>;
>> +            };
>> +        };
>> +    };
>> +
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        cpucp_mbox: mailbox@17400000 {
>> +            compatible = "qcom,cpucp-mbox";
>> +            reg =   <0x0 0x17c00000 0x0 0x10>, <0x0 0x18590300 0x0 0x700>;
>> +            interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>> +            #mbox-cells = <0>;
>> +        };
>> +
>> +        sram@18509400 {
>> +            compatible = "mmio-sram";
>> +            reg = <0x0 0x18509400 0x0 0x400>;
>> +            no-memory-wc;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges = <0x0 0x0 0x18509400 0x400>;
>> +
>> +            cpu_scp_lpri: scp-sram-section@0 {
>> +                compatible = "arm,scmi-shmem";
>> +                reg = <0x0 0x80>;
>> +            };
>> +        };
>> +    };
>> +
>>   ...
>> -- 
>> 2.7.4
>>
>>
