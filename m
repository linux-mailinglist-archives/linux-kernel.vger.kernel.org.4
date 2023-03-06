Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEFE6ABE1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCFL1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFL1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:27:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFB625E05;
        Mon,  6 Mar 2023 03:27:00 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326AsMia009533;
        Mon, 6 Mar 2023 11:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vccaepMqKUauOtZKuEm35sHqScVf3ibI9ugbL2S8QQU=;
 b=QVuCH8zU91KSuKi/GagImM1G4XFFfKSrEGfYcj35dhVtyfNelC20FT1cidVp58jazppC
 2HJFHeKNLcJfs8A89MhMi95KvOsWVJnCxJo3ZXQaRu28P6/VmLSRVB/5oTKO6Pf7YgGT
 T3vFEMMc6BoBsZsQUmIX2Dl1EjoEpNwan94cRFg4GtneegOFyRWwNdN+981ZKH2ahoIc
 DXfBt9WY6Jgkn3iVN3wZ6Y6TsZX9WZlabwkOJoWWzRWI9E2WEz4rRhKTgIZN4GLHgix1
 NvRzZjrsQ/NpJ75jjg7C9W8NcK0x4my/udhuYhCJU3erUxEMjCWNWG8WRQPOkfaW+S6b 1g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p415acgxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 11:26:55 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326BQsJe013801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 11:26:54 GMT
Received: from [10.201.3.167] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 03:26:51 -0800
Message-ID: <61e8c730-e46d-728d-d770-f1ead4405d12@quicinc.com>
Date:   Mon, 6 Mar 2023 16:56:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
 <CAA8EJprbMybV0o1-436yLhVnnEX6qywrj=JmWDCL5usaH0DXiQ@mail.gmail.com>
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <CAA8EJprbMybV0o1-436yLhVnnEX6qywrj=JmWDCL5usaH0DXiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b97YULQRoOF9o3faWvakX9gPOEaAKvvz
X-Proofpoint-ORIG-GUID: b97YULQRoOF9o3faWvakX9gPOEaAKvvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_04,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

On 3/2/2023 9:52 PM, Dmitry Baryshkov wrote:
> On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
>> Add USB phy and controller related nodes
>>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 92 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 2bb4053..319b5bd 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -215,6 +215,98 @@
>>                  #size-cells = <1>;
>>                  ranges = <0 0 0 0xffffffff>;
>>
>> +               ssphy_0: ssphy@7D000 {
>> +                       compatible = "qcom,ipq9574-qmp-usb3-phy";
>> +                       reg = <0x7D000 0x1C4>;
>> +                       #clock-cells = <1>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges;
>> +
>> +                       clocks = <&gcc GCC_USB0_AUX_CLK>,
>> +                                <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
>> +                       clock-names = "aux", "cfg_ahb";
>> +
>> +                       resets =  <&gcc GCC_USB0_PHY_BCR>,
>> +                                <&gcc GCC_USB3PHY_0_PHY_BCR>;
>> +                       reset-names = "phy","common";
>> +                       status = "disabled";
>> +
>> +                       usb0_ssphy: lane@7D200 {
> Please use newer style device bindings for new PHYs.
>
>> +                               reg = <0x0007D200 0x130>,       /* Tx */
>> +                                     <0x0007D400 0x200>,       /* Rx */
>> +                                     <0x0007D800 0x1F8>,       /* PCS  */
>> +                                     <0x0007D600 0x044>;       /* PCS misc */
>> +                               #phy-cells = <0>;
>> +                               clocks = <&gcc GCC_USB0_PIPE_CLK>;
>> +                               clock-names = "pipe0";
>> +                               clock-output-names = "gcc_usb0_pipe_clk_src";
> No, this clock doesn't originate from gcc, so the gcc prefix is incorrect.
>
>> +                       };
>> +               };
>> +
>> +               qusb_phy_0: qusb@7B000 {
>> +                       compatible = "qcom,ipq9574-qusb2-phy";
>> +                       reg = <0x07B000 0x180>;
>> +                       #phy-cells = <0>;
>> +
>> +                       clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
>> +                               <&xo_board_clk>;
>> +                       clock-names = "cfg_ahb", "ref";
>> +
>> +                       resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
>> +                       status = "disabled";
>> +               };
>> +
>> +               usb3: usb3@8A00000 {
> You know the drill. This node is in the wrong place.
>
>> +                       compatible = "qcom,dwc3";
>> +                       reg = <0x8AF8800 0x400>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges;
>> +
>> +                       clocks = <&gcc GCC_SNOC_USB_CLK>,
>> +                               <&gcc GCC_ANOC_USB_AXI_CLK>,
>> +                               <&gcc GCC_USB0_MASTER_CLK>,
>> +                               <&gcc GCC_USB0_SLEEP_CLK>,
>> +                               <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>> +
>> +                       clock-names = "sys_noc_axi",
>> +                               "anoc_axi",
>> +                               "master",
>> +                               "sleep",
>> +                               "mock_utmi";
> Please fix the indentation of the lists.
>
>> +
>> +                       assigned-clocks = <&gcc GCC_SNOC_USB_CLK>,
>> +                                         <&gcc GCC_ANOC_USB_AXI_CLK>,
> Why do you assign clock rates to the NOC clocks? Should they be set
> using the interconnect instead?

The SNOC and ANOC run at a fixed speed of 350MHz and 342MHz respectively 
and are not scaled. These clocks are for the interface between the USB 
block and the SNOC/ANOC. Do we still need to use interconnect?

>> +                                         <&gcc GCC_USB0_MASTER_CLK>,
>> +                                         <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>> +                       assigned-clock-rates = <200000000>,
>> +                                              <200000000>,
>> +                                              <200000000>,
>> +                                              <24000000>;
>> +
>> +                       resets = <&gcc GCC_USB_BCR>;
>> +                       status = "disabled";
>> +
>> +                       dwc_0: dwc3@8A00000 {
>> +                               compatible = "snps,dwc3";
>> +                               reg = <0x8A00000 0xcd00>;
>> +                               clock-names = "ref";
>> +                               clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> clocks before clock-names
>
>> +                               interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>> +                               phys = <&qusb_phy_0>, <&usb0_ssphy>;
>> +                               phy-names = "usb2-phy", "usb3-phy";
>> +                               tx-fifo-resize;
>> +                               snps,dis_ep_cache_eviction;
>> +                               snps,is-utmi-l1-suspend;
>> +                               snps,hird-threshold = /bits/ 8 <0x0>;
>> +                               snps,dis_u2_susphy_quirk;
>> +                               snps,dis_u3_susphy_quirk;
>> +                               snps,quirk-frame-length-adjustment = <0x0A87F0A0>;
>> +                               dr_mode = "host";
>> +                       };
>> +               };
>> +
>>                  pcie0_phy: phy@84000 {
>>                          compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>>                          reg = <0x00084000 0x1bc>; /* Serdes PLL */
>> --
>> 2.7.4

Will address these and post a new revision.

Thanks

Varada

