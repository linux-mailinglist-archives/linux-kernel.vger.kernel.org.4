Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8358E6FD441
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjEJD0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjEJDZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:25:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE66593;
        Tue,  9 May 2023 20:22:49 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A2wf8w019001;
        Wed, 10 May 2023 03:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jYfWkb3nvw2s1Yb4lS3IVzdPiVJQmcdbojNMM9X1xmM=;
 b=C6DIND7D4p80tv7NPY9tRDm3hYbrIMjUbAKfSsDSPrmlUrs9qjHzmKXhpF0TSIBnH1K2
 lFSYneCz9/C+PTBx3at6sCS+6OwGKTXEOEbqxdOgrMkZZN3bV8IwkxFzJpQnOAprxzCh
 7MJ+1+E/pFjORRCP4NW7IeU3IiA5ck6IXle5pnUBQ3zieb2J4OhZgi2r+QK/Ri0imWa0
 M2UdVm3SLnVA4JKKeEmuGlhy1tbc8JzW8XIq0AKSlfaZ3YCPiHJctL/IRei6qsmFA2B9
 lP4KvaXIMR9Vt8mEDSLlQuYXGWm1+UB1TnixlKFK9ywdPUX/8MpgcgEj3mJ9InpzB9UY KQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfw3d0k1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 03:22:09 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34A3M8HK032683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 03:22:08 GMT
Received: from [10.233.17.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 20:22:02 -0700
Message-ID: <4535f993-156c-5401-53a8-bcf938bf24b7@quicinc.com>
Date:   Wed, 10 May 2023 11:21:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: Add Coresight Dummy Trace
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>
CC:     Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20230505092422.32217-1-quic_hazha@quicinc.com>
 <20230505092422.32217-3-quic_hazha@quicinc.com>
 <958ae925-dee2-3273-0cd6-b5edc891ba70@arm.com>
 <20230505120529.GB898031@leoy-yangtze.lan>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <20230505120529.GB898031@leoy-yangtze.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ppfiNE2VQvAMtKiS4ZW5wAhZLyVorj4L
X-Proofpoint-GUID: ppfiNE2VQvAMtKiS4ZW5wAhZLyVorj4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305100024
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki, Leo,

On 5/5/2023 8:05 PM, Leo Yan wrote:
> On Fri, May 05, 2023 at 11:54:03AM +0100, Suzuki Kuruppassery Poulose wrote:
> 
> [...]
> 
>>> +title: ARM Coresight Dummy component
>>> +
>>> +description: |
>>> +  Coresight Dummy Trace Module is for the specific devices that kernel
>>> +  don't have permission to access or configure, e.g., CoreSight TPDMs
>>> +  on Qualcomm platforms. So there need driver to register dummy devices
>>> +  as Coresight devices. It may also be used to define components that
>>> +  may not have any programming interfaces (e.g, static links), so that
>>> +  paths can be established in the driver. Provide Coresight API for
>>> +  dummy device operations, such as enabling and disabling dummy devices.
>>> +  Build the Coresight path for dummy sink or dummy source for debugging. > +
>>> +  The primary use case of the coresight dummy is to build path in kernel
>>> +  side for dummy sink and dummy source.
>>> +
>>> +maintainers:
>>> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
>>> +  - Tao Zhang <quic_taozha@quicinc.com>
>>> +  - Hao Zhang <quic_hazha@quicinc.com>
>>> +  - Yuanfang Zhang <quic_yuanfang@quicinc.com>
>>
>> Given this is a generic "CoreSight" component, I would prefer to have the
>> CoreSight subsystem maintainers listed here (too). I don't mind
>> the entries above, but would like to make sure that the subsystem
>> people are aware of the changes happening here. Please use:
>>
>> Mike Leach <mike.leach@linaro.org>
>> Suzuki K Poulose <suzuki.poulose@arm.com>
>> Leo Yan <leo.yan@linaro.org>
>  > Given I am spending little time on CoreSight reviewing, I'd like to
> use James Clark's email address to replace my own; I believe this
> would benefit long term maintenance.
> 
>    James Clark <james.clark@arm.com>
> 
> Thanks!
>
Thanks for your review. I will update the maintainers in the next patch 
series.

Thanks,
Hao

>> With the above:
>>
>> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - arm,coresight-dummy-sink
>>> +          - arm,coresight-dummy-source
>>> +
>>> +  out-ports:
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +
>>> +    properties:
>>> +      port:
>>> +        description: Output connection from the source to Coresight
>>> +          Trace bus.
>>> +        $ref: /schemas/graph.yaml#/properties/port
>>> +
>>> +  in-ports:
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +
>>> +    properties:
>>> +      port:
>>> +        description: Input connection from the Coresight Trace bus to
>>> +          dummy sink, such as Embedded USB debugger(EUD).
>>> +        $ref: /schemas/graph.yaml#/properties/port
>>> +
>>> +required:
>>> +  - compatible
>>> +
>>> +if:
>>> +  # If the compatible contains the below value
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: arm,coresight-dummy-sink
>>> +
>>> +then:
>>> +  required:
>>> +    - in-ports
>>> +
>>> +else:
>>> +  required:
>>> +    - out-ports
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  # Minimum dummy sink definition. Dummy sink connect to coresight replicator.
>>> +  - |
>>> +    sink {
>>> +      compatible = "arm,coresight-dummy-sink";
>>> +
>>> +      in-ports {
>>> +        port {
>>> +          eud_in_replicator_swao: endpoint {
>>> +            remote-endpoint = <&replicator_swao_out_eud>;
>>> +          };
>>> +        };
>>> +      };
>>> +    };
>>> +
>>> +  # Minimum dummy source definition. Dummy source connect to coresight funnel.
>>> +  - |
>>> +    source {
>>> +      compatible = "arm,coresight-dummy-source";
>>> +
>>> +      out-ports {
>>> +        port {
>>> +          dummy_riscv_out_funnel_swao: endpoint {
>>> +            remote-endpoint = <&funnel_swao_in_dummy_riscv>;
>>> +          };
>>> +        };
>>> +      };
>>> +    };
>>> +
>>> +...
>>
