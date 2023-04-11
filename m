Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE06DE0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDKQYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDKQYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:24:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94ED1999;
        Tue, 11 Apr 2023 09:24:50 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BFGqli003050;
        Tue, 11 Apr 2023 16:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Nzq6IMaf+v4naZmcNk65CmHgfAB4uZmQQqrjKIoECSA=;
 b=S8Q7FmernMvI6zcc6P6UjCJb5aHih8+6mpdyPCgaEqDcMYI2BYfXIxzUIFCpjXCNDooC
 LYavpjJ3JP97w6VA5Tp5R9RWhcOPlUjNjNTc/ngz8CMIG4kuVtlMK9yxTx41+SIdp8YS
 XTGrPrcm0zh5h/hqW3DN14QUmGVkhmXpML5zgfXMbhQKjVMwfgfs4o+GIjgB03dj63Ty
 mgkuZ2DudCUZCx3p96u/dkWEtAByiYSux0K8t+bXn49bkFV2QiGTYqmzgUsOaUMXoQ4G
 U3e0mFg38ep6RiDJrA9IOZt+JKlENov4Xhg5KGalDPQeQj68QO9E8W3DRHDmmlB7pg8q 3w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pw9b9g952-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 16:24:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BGO3M3026631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 16:24:03 GMT
Received: from [10.216.22.209] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 09:23:56 -0700
Message-ID: <24804682-6ead-03b1-8b21-3ac413187c4a@quicinc.com>
Date:   Tue, 11 Apr 2023 21:53:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sa8775p: add the pcie smmu node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Eric Chanudet <echanude@redhat.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
References: <20230406200723.552644-1-brgl@bgdev.pl>
 <20230406200723.552644-6-brgl@bgdev.pl>
 <20230410201145.6e2qsl5gtwh7n3k7@echanude>
 <CAMRc=MdSTqO0bW1=_it43K_pn7EuBWRPvBF29N1gdqsh3TpAcg@mail.gmail.com>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <CAMRc=MdSTqO0bW1=_it43K_pn7EuBWRPvBF29N1gdqsh3TpAcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LuM71LE-Ip_VE-JInf-pi73Ip0TTRoI9
X-Proofpoint-ORIG-GUID: LuM71LE-Ip_VE-JInf-pi73Ip0TTRoI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_11,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110150
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2023 5:20 PM, Bartosz Golaszewski wrote:
> On Mon, Apr 10, 2023 at 10:11 PM Eric Chanudet <echanude@redhat.com> wrote:
>>
>> On Thu, Apr 06, 2023 at 10:07:21PM +0200, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Add the PCIe SMMU node for sa8775p platforms.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi | 74 +++++++++++++++++++++++++++
>>>   1 file changed, 74 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> index 2343df7e0ea4..9ab630c7d81b 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> @@ -809,6 +809,80 @@ apps_smmu: iommu@15000000 {
>>>                                     <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
>>>                };
>>>
>>> +             pcie_smmu: iommu@15200000 {
>>> +                     compatible = "qcom,sa8775p-smmu-500", "qcom,smmu-500", "arm,mmu-500";
>>> +                     reg = <0x0 0x15200000 0x0 0x800000>;
>>
>> Testing on the board, applying on next-20230406:
>> [    1.041869] arm-smmu 15200000.iommu: SMMU address space size (0x80000) differs from mapped region size (0x800000)!
>>
>> In the downstream sources, the size is 0x80000[1].
>>
>> On reboot, I also get a synchronous abort, but the second line, from the
>> following output on the serial, could indicate the hypervisor is behind
>> it:
>>
>> [   26.906206] arm-smmu 15200000.iommu: disabling translation
>> 3      33.244434 Injecting instruction/data abort to VM 3, original ESR_EL2 = 0x93800047, fault VA = 0xffff80000a380000, fault IPA = 0x15200000, ELR_EL2 = 0xffffd064f70c9de8
>> [   26.942083] Internal error: synchronous external abort: 0000000096000010 [#1] PREEMPT SMP
>> [   26.948506] Modules linked in: nvmem_qcom_spmi_sdam qcom_pon spi_geni_qcom nvmem_reboot_mode crct10dif_ce i2c_qcom_geni phy_qcom_qmp_ufs gpucc_sa8775p ufs_qcom socinfo fuse ipv6
>> [   26.966702] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted 6.3.0-rc5-next-20230406-00019-g9d08a3c17f54-dirty #134
>> [   26.977315] Hardware name: Qualcomm SA8775P Ride (DT)
>> [   26.982505] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   26.989651] pc : arm_smmu_device_shutdown+0x88/0x1d8
>> [   26.994773] lr : arm_smmu_device_shutdown+0x70/0x1d8
>> [   26.999875] sp : ffff80000805bbf0
>> [   27.003283] x29: ffff80000805bbf0 x28: ffff0e69400a0000 x27: 0000000000000000
>> [   27.010608] x26: ffffd064f8130f38 x25: 0000000000000001 x24: ffffd064f8eac028
>> [   27.017932] x23: ffff0e6940eeb490 x22: ffffd064f8f24f80 x21: ffff0e6940eeb410
>> [   27.025254] x20: ffff0e6940808c80 x19: ffff0e6940eeb410 x18: 0000000000000006
>> [   27.032579] x17: 0000000000000001 x16: 0000000000000014 x15: ffff80000805b5c0
>> [   27.039903] x14: 0000000000000000 x13: ffffd064f8ac19a8 x12: 0000000000000606
>> [   27.047226] x11: 0000000000000202 x10: ffffd064f8b199a8 x9 : ffffd064f8ac19a8
>> [   27.054549] x8 : 00000000ffffefff x7 : ffffd064f8b199a8 x6 : 80000000fffff000
>> [   27.061872] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
>> [   27.069195] x2 : 0000000000000000 x1 : ffff80000a380000 x0 : 0000000000000001
>> [   27.076520] Call trace:
>> [   27.079041]  arm_smmu_device_shutdown+0x88/0x1d8
>> [   27.083787]  platform_shutdown+0x24/0x34
>> [   27.087825]  device_shutdown+0x150/0x258
>> [   27.091859]  kernel_restart+0x40/0xc0
>> [   27.095632]  __do_sys_reboot+0x1f0/0x274
>> [   27.099664]  __arm64_sys_reboot+0x24/0x30
>> [   27.103786]  invoke_syscall+0x48/0x114
>> [   27.107644]  el0_svc_common+0x40/0xf4
>> [   27.111410]  do_el0_svc+0x3c/0x9c
>> [   27.114822]  el0_svc+0x2c/0x84
>> [   27.117969]  el0t_64_sync_handler+0xf4/0x120
>> [   27.122357]  el0t_64_sync+0x190/0x194
>> [   27.126126] Code: f9400404 b50008e4 f9400681 52800020 (b9000020)
>> [   27.132385] ---[ end trace 0000000000000000 ]---
>>
> 
> Adding Shazad
> 
> Eric: This is supposedly gone in the latest meta but I thought you're
> already on the most recent release?
> 
> Shazad, what version exactly should Eric test this on?
> 
> Bart
> 

Hi Bart, We should use r00004.1 to verify this. Adding Parikshit to
confirm on the same.

-Shazad

>> [1] https://git.codelinaro.org/clo/la/kernel/ark-5.14/-/blob/ES2/arch/arm64/boot/dts/qcom/lemans.dtsi#L3498
>>
>>> +                     #iommu-cells = <2>;
>>> +                     #global-interrupts = <2>;
>>> +
>>> +                     interrupts = <GIC_SPI 920 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 921 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 925 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 926 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 927 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 928 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 950 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 951 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 952 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 953 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 954 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 955 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 956 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 957 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 958 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 885 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 886 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 887 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 888 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 842 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 843 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 844 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 845 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 847 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 802 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 805 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 806 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 807 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 808 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 809 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 812 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 813 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 814 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 837 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 838 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 839 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 854 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 855 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 790 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 794 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 796 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH>;
>>> +             };
>>> +
>>>                intc: interrupt-controller@17a00000 {
>>>                        compatible = "arm,gic-v3";
>>>                        reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
>>> --
>>> 2.37.2
>>>
>>
>> --
>> Eric Chanudet
>>
