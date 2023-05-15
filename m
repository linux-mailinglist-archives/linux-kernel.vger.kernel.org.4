Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDD270319C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjEOPch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242417AbjEOPcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:32:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175DA1BC9;
        Mon, 15 May 2023 08:32:34 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FEeUK2031390;
        Mon, 15 May 2023 15:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TAlD90dXc/rktBgVfR0wgp7XrmKmHudrO7IIMnPdVCY=;
 b=jfVn5FLRS/gJf/o4lOwCdG5kRegH6joXBAwmYNvPivsZPI6OlefdvNfj814FOTXoLOKz
 oohk30kyzILjjuWXixNbmOTvmVeSY1cGDJWrwmXgWF70yYl/4UK6kt8DvU6PEjTGu/EZ
 ux0sUWiL1bW6ksdv6PW0q3sxsuyzl69G7ik7GlYNyFhmq6i3o13xvbipbGSdaGWkOAZr
 dlpDT9m+w/ZM5JjMkGPKCrm5562BxKwQTsjWomueNro+Nt2vbl3+lSgamH5s7YYPQ6nE
 wBvVSQnT2mcz/2SeE2pqz1zvdU4745j3mMH9U9rd445nqqL9Avj/0KE80TEZ6oUK4lag dw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkgq6s9vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 15:32:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34FFWMJM014623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 15:32:22 GMT
Received: from [10.216.35.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 08:32:15 -0700
Message-ID: <d14567fd-0576-55bb-40c0-442e060c28ba@quicinc.com>
Date:   Mon, 15 May 2023 21:02:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 7/9] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-8-quic_kriskura@quicinc.com>
 <ZGJBLUsPcbsxj989@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZGJBLUsPcbsxj989@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nmyNzzX9rv7MTM0Z_ompwG15xsGzBiTW
X-Proofpoint-GUID: nmyNzzX9rv7MTM0Z_ompwG15xsGzBiTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150128
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/15/2023 7:56 PM, Johan Hovold wrote:
> On Sun, May 14, 2023 at 11:19:15AM +0530, Krishna Kurapati wrote:
>> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
>> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
>> platforms.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 66 ++++++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index 8fa9fbfe5d00..50f6a8424537 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -3133,6 +3133,72 @@ usb_1_role_switch: endpoint {
>>   			};
>>   		};
>>   
>> +		usb_2: usb@a4f8800 {
> 
> As I believe someone already pointed out, this node is not in sort order
> (i.e. it should go before usb@a6f8800).
> 
Hi Johan,

   I missed that message, but since I named it usb_2, so I placed it in 
order after usb_1. Hope that is fine !!

>> +			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
>> +			reg = <0 0x0a4f8800 0 0x400>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +
>> +			clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
>> +				 <&gcc GCC_USB30_MP_MASTER_CLK>,
>> +				 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
>> +				 <&gcc GCC_USB30_MP_SLEEP_CLK>,
>> +				 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
>> +				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
>> +				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
>> +			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi",
>> +				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";
>> +
>> +			assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
>> +					  <&gcc GCC_USB30_MP_MASTER_CLK>;
>> +			assigned-clock-rates = <19200000>, <200000000>;
>> +
>> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
>> +					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
>> +					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			interrupt-names = "dp_hs_phy_irq",
>> +					  "dm_hs_phy_irq",
>> +					  "ss_phy_irq",
>> +					  "pwr_event_1",
>> +					  "pwr_event_2",
>> +					  "pwr_event_3",
>> +					  "pwr_event_4";
>> +
>> +			power-domains = <&gcc USB30_MP_GDSC>;
>> +			required-opps = <&rpmhpd_opp_nom>;
>> +
>> +			resets = <&gcc GCC_USB30_MP_BCR>;
>> +
>> +			interconnects = <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI1 0>,
>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
> 
> This is not the correct interconnect master and slave; it should be
> MASTER_USB3_MP and SLAVE_USB3_MP.
> 
Thanks for pointing it out. I need to check how it was working all these 
days. (Probably since both of them vote for the same NOC, it didn't show 
any affect)
>> +			interconnect-names = "usb-ddr", "apps-usb";
> 
> Looks like 'wakeup-source' is missing here too.
> 

I believe this property was added to enable wakeup from system suspend 
in host mode. I didn't add this property as currently I don't need to 
support wakeup. If any requirement comes in future, then I might need to 
add dp/dm interrupts (if any) for other ports as well and then need to 
change driver code to enable/disable them on suspend/resume.

>> +
>> +			status = "disabled";
>> +
>> +			usb_2_dwc3: usb@a400000 {
>> +				compatible = "snps,dwc3";
>> +				reg = <0 0x0a400000 0 0xcd00>;
>> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +				iommus = <&apps_smmu 0x800 0x0>;
>> +				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
>> +					<&usb_2_hsphy1>, <&usb_2_qmpphy1>,
>> +					<&usb_2_hsphy2>,
>> +					<&usb_2_hsphy3>;
>> +				phy-names = "usb2-port0", "usb3-port0",
>> +						"usb2-port1", "usb3-port1",
>> +						"usb2-port2",
>> +						"usb2-port3";
> 
> The phys and phy-names continuation lines above are still not aligned.
> 
Missed it. Will fix it in next version.

Thanks,
Krishna,
>> +			};
>> +		};
>> +
>>   		mdss0: display-subsystem@ae00000 {
>>   			compatible = "qcom,sc8280xp-mdss";
>>   			reg = <0 0x0ae00000 0 0x1000>;
> 
> Johan
