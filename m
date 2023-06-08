Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD89727918
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjFHHqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjFHHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:46:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0091FD6;
        Thu,  8 Jun 2023 00:46:01 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3586GONT012048;
        Thu, 8 Jun 2023 07:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vYfvQsABtN9adGyqutB1LWz7wMFIv+gN0Snd+SMHouc=;
 b=YKlRZZq/eBnEutX5qJoqATUxA+d4qutzuk1F+hB6k4iAzNo23L3se3xCP7mvDMIPudJJ
 el0TWitcSnbrfwAEHZQffSkvvSPdEFgYQMPyhJLBR4F2/62/u9uc7IY8p1Y2phduKi7/
 9NrsTss1CEBqwuaLLtQMLUWgA9nSrJMiJ0NHV40UMaljuXDxh3GxVb2rOkFmNMLfwyJg
 krjZ43r9HDnwW3ydGD5NwRMhWm+1AN32dgsjxL8m9BPYaLEZWQLoYNdbNlPvw+Mt7CEa
 zr6KmezqaEbZkenWtVX4gC7MDhvUDf1n/ObLxMlI/y7uWnwltpnGe6HEFXnItNgUbZOW 1Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2rbtj7g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 07:45:46 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3587jjmv021145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 07:45:45 GMT
Received: from [10.233.17.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 00:45:39 -0700
Message-ID: <a7ccc45f-5fe5-37b0-c9d6-736efd9b6feb@quicinc.com>
Date:   Thu, 8 Jun 2023 15:45:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 2/3] dt-bindings: arm: Add support for Coresight dummy
 trace
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        "Yuanfang Zhang" <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20230602084149.40031-1-quic_hazha@quicinc.com>
 <20230602084149.40031-3-quic_hazha@quicinc.com>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <20230602084149.40031-3-quic_hazha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bylCzzUn5NfTilE7UHdqiiDkPrg8OiKo
X-Proofpoint-ORIG-GUID: bylCzzUn5NfTilE7UHdqiiDkPrg8OiKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080065
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reviewers,

Could you please help to review this patch?

Thanks
Hao

On 6/2/2023 4:41 PM, Hao Zhang wrote:
> This patch add support for Coresight dummy source and dummy sink trace.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>   .../arm/arm,coresight-dummy-sink.yaml         | 73 +++++++++++++++++++
>   .../arm/arm,coresight-dummy-source.yaml       | 71 ++++++++++++++++++
>   2 files changed, 144 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
> new file mode 100644
> index 000000000000..cb78cfa56702
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/arm,coresight-dummy-sink.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Coresight Dummy sink component
> +
> +description: |
> +  CoreSight components are compliant with the ARM CoreSight architecture
> +  specification and can be connected in various topologies to suit a particular
> +  SoCs tracing needs. These trace components can generally be classified as
> +  sinks, links and sources. Trace data produced by one or more sources flows
> +  through the intermediate links connecting the source to the currently selected
> +  sink.
> +
> +  The Coresight dummy sink component is for the specific coresight sink devices
> +  kernel don't have permission to access or configure, e.g., CoreSight EUD on
> +  Qualcomm platforms. It is a mini-USB hub implemented to support the USB-based
> +  debug and trace capabilities. For this device, a dummy driver is needed to
> +  register it as Coresight sink device in kernel side, so that path can be
> +  created in the driver. Then the trace flow would be transferred to EUD via
> +  coresight link of AP processor. It provides Coresight API for operations on
> +  dummy source devices, such as enabling and disabling them. It also provides
> +  the Coresight dummy source paths for debugging.
> +
> +  The primary use case of the coresight dummy sink is to build path in kernel
> +  side for dummy sink component.
> +
> +maintainers:
> +  - Mike Leach <mike.leach@linaro.org>
> +  - Suzuki K Poulose <suzuki.poulose@arm.com>
> +  - James Clark <james.clark@arm.com>
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Hao Zhang <quic_hazha@quicinc.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - arm,coresight-dummy-sink
> +
> +  in-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Input connection from the Coresight Trace bus to
> +          dummy sink, such as Embedded USB debugger(EUD).
> +
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - in-ports
> +
> +additionalProperties: false
> +
> +examples:
> +  # Minimum dummy sink definition. Dummy sink connect to coresight replicator.
> +  - |
> +    sink {
> +      compatible = "arm,coresight-dummy-sink";
> +
> +      in-ports {
> +        port {
> +          eud_in_replicator_swao: endpoint {
> +            remote-endpoint = <&replicator_swao_out_eud>;
> +          };
> +        };
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
> new file mode 100644
> index 000000000000..5fedaed49a1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/arm,coresight-dummy-source.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Coresight Dummy source component
> +
> +description: |
> +  CoreSight components are compliant with the ARM CoreSight architecture
> +  specification and can be connected in various topologies to suit a particular
> +  SoCs tracing needs. These trace components can generally be classified as
> +  sinks, links and sources. Trace data produced by one or more sources flows
> +  through the intermediate links connecting the source to the currently selected
> +  sink.
> +
> +  The Coresight dummy source component is for the specific coresight source
> +  devices kernel don't have permission to access or configure. For some SOCs,
> +  there would be Coresight source trace components on sub-processor which
> +  are conneted to AP processor via debug bus. For these devices, a dummy driver
> +  is needed to register them as Coresight source devices, so that paths can be
> +  created in the driver. It provides Coresight API for operations on dummy
> +  source devices, such as enabling and disabling them. It also provides the
> +  Coresight dummy source paths for debugging.
> +
> +  The primary use case of the coresight dummy source is to build path in kernel
> +  side for dummy source component.
> +
> +maintainers:
> +  - Mike Leach <mike.leach@linaro.org>
> +  - Suzuki K Poulose <suzuki.poulose@arm.com>
> +  - James Clark <james.clark@arm.com>
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Hao Zhang <quic_hazha@quicinc.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - arm,coresight-dummy-source
> +
> +  out-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Output connection from the source to Coresight
> +          Trace bus.
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - out-ports
> +
> +additionalProperties: false
> +
> +examples:
> +  # Minimum dummy source definition. Dummy source connect to coresight funnel.
> +  - |
> +    source {
> +      compatible = "arm,coresight-dummy-source";
> +
> +      out-ports {
> +        port {
> +          dummy_riscv_out_funnel_swao: endpoint {
> +            remote-endpoint = <&funnel_swao_in_dummy_riscv>;
> +          };
> +        };
> +      };
> +    };
> +
> +...
