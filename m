Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D9632E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKUUlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKUUlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:41:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DAEDAD0D;
        Mon, 21 Nov 2022 12:41:20 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALJttO4005251;
        Mon, 21 Nov 2022 20:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pmn/hum5pKKRWpLUM2SBQZekYoT6dkpEbrAeuH90AUE=;
 b=GffUMTavQfx9eELb8hltNFI3PtALLeAM/snphats9JqZ1qnte1/pn1RMWqh85yibnmus
 cAa2Ij/ri7BNSSc/qmRUC7n1lT8nUcz/WDDkkzW918FwPxdNbsMkPLdiT3G3XwFp4EY6
 77coPaoeHjm6F90jJo+2tjusBzRpNr3WaX9lkOVFdAcFe2LSZBvN5umxSh5nhhxzKcCk
 Onm4b87kamKvMFYFyxQr6OdertTTndUeRC2bxJQuYP5MTsCUL8xHWj4T/4WSgQzl/5r1
 DW/0831u7sd+apOQHgNvXkoJZdQ7MhsSME9jZ8XVyE+FOcrRrfYyDaI/CVtglxE8TvZM Yg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxreanp6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:41:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALKfFcZ002089
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:41:15 GMT
Received: from [10.110.33.239] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 12:41:14 -0800
Message-ID: <05404a70-2e42-6760-b3fd-78d23b02a531@quicinc.com>
Date:   Mon, 21 Nov 2022 14:41:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/2] pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118182039.29236-1-quic_molvera@quicinc.com>
 <20221118182039.29236-3-quic_molvera@quicinc.com>
 <fafbb9d3-5e4b-fee1-7227-044964bb2292@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <fafbb9d3-5e4b-fee1-7227-044964bb2292@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RmpRZlKO1gS9U7sETv2I2Dzt-yKpDSpd
X-Proofpoint-ORIG-GUID: RmpRZlKO1gS9U7sETv2I2Dzt-yKpDSpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_16,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2022 5:09 AM, Konrad Dybcio wrote:
>
> On 18.11.2022 19:20, Melody Olvera wrote:
>> Add pin control driver for the TLMM block found in the QDU1000
>> and QRU1000 SoC.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  drivers/pinctrl/qcom/Kconfig           |   10 +
>>  drivers/pinctrl/qcom/Makefile          |    1 +
>>  drivers/pinctrl/qcom/pinctrl-qdu1000.c | 1273 ++++++++++++++++++++++++
>>  3 files changed, 1284 insertions(+)
>>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdu1000.c
>>
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index 1378ddca084f..9ff4145646a3 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -248,6 +248,16 @@ config PINCTRL_QCOM_SSBI_PMIC
>>  	 which are using SSBI for communication with SoC. Example PMIC's
>>  	 devices are pm8058 and pm8921.
>>  
>> +config PINCTRL_QDU1000
> [...]
>
>> +DECLARE_MSM_GPIO_PINS(145);
>> +DECLARE_MSM_GPIO_PINS(146);
>> +DECLARE_MSM_GPIO_PINS(147);
>> +DECLARE_MSM_GPIO_PINS(148);
>> +DECLARE_MSM_GPIO_PINS(149);
>> +DECLARE_MSM_GPIO_PINS(150);
>> +
>> +static const unsigned int sdc1_rclk_pins[] = { 151 };
>> +static const unsigned int sdc1_clk_pins[] = { 152 };
>> +static const unsigned int sdc1_cmd_pins[] = { 153 };
>> +static const unsigned int sdc1_data_pins[] = { 154 };
>> +
>> +enum qdu1000_functions {
>> +	msm_mux_gpio,
>> +	msm_mux_CMO_PRI,
>> +	msm_mux_SI5518_INT,
> Any reason these two are uppercase?

They're new functions. There's not really any other reason; I can make them lower case.

Thanks,
Melody

>
> Konrad
>> +	msm_mux_atest_char,
>> +	msm_mux_atest_usb,
>> +	msm_mux_char_exec,
>> +	msm_mux_cmu_rng,
>> +	msm_mux_dbg_out_clk,
>> +	msm_mux_ddr_bist,
>> +	msm_mux_ddr_pxi0,
>> +	msm_mux_ddr_pxi1,
>> +	msm_mux_ddr_pxi2,
>> +	msm_mux_ddr_pxi3,
> [...]
>
>> +
>> +/* Every pin is maintained as a single group, and missing or non-existing pin
> /*
>  * Every pin...
>
> Konrad
>> + * would be maintained as dummy group to synchronize pin group index with
>> + * pin descriptor registered with pinctrl core.
>> + * Clients would not be able to request these dummy pin groups.
>> + */
>> +static const struct msm_pingroup qdu1000_groups[] = {
>> +	[0] = PINGROUP(0, qup20, qup21, ddr_bist, _, _, _, _, _, _),
>> +	[1] = PINGROUP(1, qup20, qup21, ddr_bist, _, _, _, _, _, _),
>> +	[2] = PINGROUP(2, qup21, qup20, ddr_bist, _,
>> +		       tsense_pwm1, _, _, _, _),
>> +	[3] = PINGROUP(3, qup21, qup20, ddr_bist, _,
>> +		       tsense_pwm2, _, _, _, _),
>> +	[4] = PINGROUP(4, qup22, _, _, _, _, _, _, _, _),
>> +	[5] = PINGROUP(5, qup22, _, _, _, _, _, _, _, _),
>> +	[6] = PINGROUP(6, qup00, tgu_ch0, phase_flag, _,
>> +		       qdss_gpio, _, _, _, _),
>> +	[7] = PINGROUP(7, qup00, tgu_ch1, phase_flag, _,
>> +		       qdss_gpio, _, _, _, _),
>> +	[8] = PINGROUP(8, qup00, tgu_ch2, phase_flag, _,
>> +		       qdss_gpio, _, _, _, _),
>> +	[9] = PINGROUP(9, qup00, tgu_ch3, phase_flag, _,
>> +		       qdss_gpio, _, _, _, _),
>> +	[10] = PINGROUP(10, qup01, qup02, _, _, _, _, _, _, _),
>> +	[11] = PINGROUP(11, qup01, qup02, _, _, _, _, _, _, _),
>> +	[12] = PINGROUP(12, qup02, qup01, qup17, _, _, _, _, _, _),
>> +	[13] = PINGROUP(13, qup02, qup01, qup17, _, _, _, _, _, _),
>> +	[14] = PINGROUP(14, qup03, qup04, qup17, _, _, _, _, _, _),
>> +	[15] = PINGROUP(15, qup03, qup04, _, _, _, _, _, _, _),
>> +	[16] = PINGROUP(16, qup04, qup03, phase_flag, _,
>> +			qdss_gpio, _, _, _, _),
>> +	[17] = PINGROUP(17, qup04, qup03, phase_flag, _,
>> +			qdss_gpio, _, _, _, _),
>> +	[18] = PINGROUP(18, qup10, prng_rosc, phase_flag,
>> +			_, qdss_gpio, _, _, _, _),
>> +	[19] = PINGROUP(19, qup10, prng_rosc, phase_flag,
>> +			_, qdss_gpio, _, _, _, _),
>> +	[20] = PINGROUP(20, qup10, prng_rosc, pll_bist,
>> +			phase_flag, _, qdss_gpio, _, _, _),
>> +	[21] = PINGROUP(21, qup10, prng_rosc, phase_flag,
>> +			_, qdss_gpio, _, _, _, _),
>> +	[22] = PINGROUP(22, qup11, qup12, phase_flag, _,
>> +			qdss_gpio, _, _, _, _),
>> +	[23] = PINGROUP(23, qup11, qup12, phase_flag, _,
>> +			qdss_gpio, _, _, _, _),
>> +	[24] = PINGROUP(24, qup12, qup11, phase_flag, _,
>> +			qdss_gpio, _, _, _, _),
>> +	[25] = PINGROUP(25, qup12, qup11, phase_flag, _,
>> +			qdss_gpio, _, _, _, _),
>> +	[26] = PINGROUP(26, qup13, qup14, intr_c,
>> +			phase_flag, _, qdss_gpio, _, _, _),
>> +	[27] = PINGROUP(27, qup13, qup14, intr_c,
>> +			phase_flag, _, qdss_gpio, _, _, _),
>> +	[28] = PINGROUP(28, qup14, qup13, intr_c,
>> +			phase_flag, _, qdss_gpio, _, _, _),
>> +	[29] = PINGROUP(29, qup14, qup13, qup16,
>> +			phase_flag, _, qdss_gpio, _, _, _),
>> +	[30] = PINGROUP(30, qup17, qup15, tmess_prng3,
>> +			phase_flag, _, qdss_gpio, _, _, _),
>> +	[31] = PINGROUP(31, qup17, qup15, tmess_prng2,
>> +			phase_flag, _, qdss_gpio, _, _, _),
>> +	[32] = PINGROUP(32, qup15, tmess_prng1, phase_flag,
>> +			_, qdss_gpio, _, _, _, _),
>> +	[33] = PINGROUP(33, qup15, tmess_prng0, phase_flag,
>> +			_, qdss_gpio, _, _, _, _),
>> +	[34] = PINGROUP(34, qup16, qdss_gpio, _, _, _, _, _, _, _),
>> +	[35] = PINGROUP(35, qup16, qdss_gpio, _, _, _, _, _, _, _),
>> +	[36] = PINGROUP(36, qup16, qdss_cti, _, _, _, _, _, _, _),
>> +	[37] = PINGROUP(37, qup16, qdss_cti, _, _, _, _, _, _, _),
>> +	[38] = PINGROUP(38, qup16, qdss_cti, _, _, _, _, _, _, _),
>> +	[39] = PINGROUP(39, qup16, qdss_cti, _, _, _, _, _, _, _),
>> +	[40] = PINGROUP(40, qup17, qdss_cti, _, _, _, _, _, _, _),
>> +	[41] = PINGROUP(41, qup17, qdss_cti, _, _, _, _, _, _, _),
>> +	[42] = PINGROUP(42, usb_con_det, phase_flag, _,
>> +			qdss_gpio, _, _, _, _, _),
>> +	[43] = PINGROUP(43, usb_dfp_en, phase_flag, _,
>> +			qdss_gpio, _, _, _, _, _),
>> +	[44] = PINGROUP(44, SI5518_INT, tgu_ch4, _, _, _, _, _, _, _),
>> +	[45] = PINGROUP(45, tgu_ch5, _, _, _, _, _, _, _, _),
>> +	[46] = PINGROUP(46, tgu_ch6, _, _, _, _, _, _, _, _),
>> +	[47] = PINGROUP(47, hardsync_pps_in, tgu_ch7, _, _, _, _, _, _, _),
>> +	[48] = PINGROUP(48, tod_pps_in, qdss_cti, _, _, _, _, _, _, _),
>> +	[49] = PINGROUP(49, gps_pps_in, qdss_cti, _, _, _, _, _, _, _),
>> +	[50] = PINGROUP(50, _, _, _, _, _, _, _, _, _),
>> +	[51] = PINGROUP(51, _, _, _, _, _, _, _, _, _),
>> +	[52] = PINGROUP(52, _, _, _, _, _, _, _, _, _),
>> +	[53] = PINGROUP(53, _, _, _, _, _, _, _, _, _),
>> +	[54] = PINGROUP(54, _, _, _, _, _, _, _, _, _),
>> +	[55] = PINGROUP(55, _, _, _, _, _, _, _, _, _),
>> +	[56] = PINGROUP(56, _, qlink6_wmss, _, _, _, _, _, _, _),
>> +	[57] = PINGROUP(57, _, qlink7_wmss, _, _, _, _, _, _, _),
>> +	[58] = PINGROUP(58, _, _, _, _, _, _, _, _, _),
>> +	[59] = PINGROUP(59, _, _, _, _, _, _, _, _, _),
>> +	[60] = PINGROUP(60, _, _, _, _, _, _, _, _, _),
>> +	[61] = PINGROUP(61, _, _, _, _, _, _, _, _, _),
>> +	[62] = PINGROUP(62, _, _, _, _, _, _, _, _, _),
>> +	[63] = PINGROUP(63, _, _, _, _, _, _, _, _, _),
>> +	[64] = PINGROUP(64, _, _, _, _, _, _, _, _, _),
>> +	[65] = PINGROUP(65, _, _, _, _, _, _, _, _, _),
>> +	[66] = PINGROUP(66, qlink0_request, _, _, _, _, _, _, _, _),
>> +	[67] = PINGROUP(67, qlink0_enable, _, _, _, _, _, _, _, _),
>> +	[68] = PINGROUP(68, qlink1_request, _, _, _, _, _, _, _, _),
>> +	[69] = PINGROUP(69, qlink1_enable, _, _, _, _, _, _, _, _),
>> +	[70] = PINGROUP(70, qlink2_request, _, _, _, _, _, _, _, _),
>> +	[71] = PINGROUP(71, qlink2_enable, _, _, _, _, _, _, _, _),
>> +	[72] = PINGROUP(72, qlink3_request, _, _, _, _, _, _, _, _),
>> +	[73] = PINGROUP(73, qlink3_enable, _, _, _, _, _, _, _, _),
>> +	[74] = PINGROUP(74, qlink4_request, _, _, _, _, _, _, _, _),
>> +	[75] = PINGROUP(75, qlink4_enable, _, _, _, _, _, _, _, _),
>> +	[76] = PINGROUP(76, qlink5_request, _, _, _, _, _, _, _, _),
>> +	[77] = PINGROUP(77, qlink5_enable, _, _, _, _, _, _, _, _),
>> +	[78] = PINGROUP(78, qlink6_request, _, _, _, _, _, _, _, _),
>> +	[79] = PINGROUP(79, qlink6_enable, _, _, _, _, _, _, _, _),
>> +	[80] = PINGROUP(80, qlink7_request, _, _, _, _, _, _, _, _),
>> +	[81] = PINGROUP(81, qlink7_enable, _, _, _, _, _, _, _, _),
>> +	[82] = PINGROUP(82, qlink0_wmss, _, _, _, _, _, _, _, _),
>> +	[83] = PINGROUP(83, qlink1_wmss, _, _, _, _, _, _, _, _),
>> +	[84] = PINGROUP(84, qlink4_wmss, _, _, _, _, _, _, _, _),
>> +	[85] = PINGROUP(85, qlink5_wmss, _, _, _, _, _, _, _, _),
>> +	[86] = PINGROUP(86, eth012_int_n, gcc_gp1, _, qdss_cti, _, _, _, _, _),
>> +	[87] = PINGROUP(87, eth345_int_n, gcc_gp2, _, qdss_cti, _, _, _, _, _),
>> +	[88] = PINGROUP(88, eth6_int_n, smb_alert, gcc_gp3, _,
>> +			qdss_gpio, _, _, _, _),
>> +	[89] = PINGROUP(89, phase_flag, cmu_rng, _,
>> +			qdss_gpio, atest_char, _, _, _, _),
>> +	[90] = PINGROUP(90, usb2phy_ac, phase_flag,
>> +			cmu_rng, _, qdss_gpio,
>> +			atest_char, _, _, _),
>> +	[91] = PINGROUP(91, usb_phy, phase_flag, cmu_rng,
>> +			_, qdss_gpio, atest_char, _, _, _),
>> +	[92] = PINGROUP(92, phase_flag, cmu_rng, _,
>> +			qdss_gpio, atest_char, _, _, _, _),
>> +	[93] = PINGROUP(93, vfr_0, qdss_cti, _, _, _, _, _, _, _),
>> +	[94] = PINGROUP(94, vfr_1, qdss_cti, _, _, _, _, _, _, _),
>> +	[95] = PINGROUP(95, phase_flag, _, qdss_gpio,
>> +			atest_char, _, _, _, _, _),
>> +	[96] = PINGROUP(96, phase_flag, _, qdss_gpio, _, _, _, _, _, _),
>> +	[97] = PINGROUP(97, phase_flag, _, qdss_gpio, _, _, _, _, _, _),
>> +	[98] = PINGROUP(98, pll_clk, _, _, _, _, _, _, _, _),
>> +	[99] = PINGROUP(99, pcie_clkreqn, char_exec, _, _, _, _, _, _, _),
>> +	[100] = PINGROUP(100, char_exec, _, _, _, _, _, _, _, _),
>> +	[101] = PINGROUP(101, smb_alert, _, _, _, _, _, _, _, _),
>> +	[102] = PINGROUP(102, phase_flag, _, qdss_gpio, _, _, _, _, _, _),
>> +	[103] = PINGROUP(103, CMO_PRI, qdss_gpio, _, _, _, _, _, _, _),
>> +	[104] = PINGROUP(104, _, _, _, _, _, _, _, _, _),
>> +	[105] = PINGROUP(105, _, _, _, _, _, _, _, _, _),
>> +	[106] = PINGROUP(106, _, _, _, _, _, _, _, _, _),
>> +	[107] = PINGROUP(107, _, _, _, _, _, _, _, _, _),
>> +	[108] = PINGROUP(108, _, _, _, _, _, _, _, _, _),
>> +	[109] = PINGROUP(109, _, _, _, _, _, _, _, _, _),
>> +	[110] = PINGROUP(110, _, _, _, _, _, _, _, _, _),
>> +	[111] = PINGROUP(111, _, _, _, _, _, _, _, _, _),
>> +	[112] = PINGROUP(112, _, _, _, _, _, _, _, _, _),
>> +	[113] = PINGROUP(113, _, _, _, _, _, _, _, _, _),
>> +	[114] = PINGROUP(114, qspi0, tb_trig, _,
>> +			 atest_usb, ddr_pxi0, _, _, _, _),
>> +	[115] = PINGROUP(115, qspi1, _, atest_usb,
>> +			 ddr_pxi0, _, _, _, _, _),
>> +	[116] = PINGROUP(116, qspi2, _, atest_usb,
>> +			 ddr_pxi1, _, _, _, _, _),
>> +	[117] = PINGROUP(117, qspi3, _, atest_usb,
>> +			 ddr_pxi1, _, _, _, _, _),
>> +	[118] = PINGROUP(118, _, atest_usb, ddr_pxi2, _, _, _, _, _, _),
>> +	[119] = PINGROUP(119, _, _, ddr_pxi2, _, _, _, _, _, _),
>> +	[120] = PINGROUP(120, _, _, ddr_pxi3, _, _, _, _, _, _),
>> +	[121] = PINGROUP(121, _, ddr_pxi3, _, _, _, _, _, _, _),
>> +	[122] = PINGROUP(122, _, ddr_pxi4, _, _, _, _, _, _, _),
>> +	[123] = PINGROUP(123, _, ddr_pxi4, _, _, _, _, _, _, _),
>> +	[124] = PINGROUP(124, _, ddr_pxi5, _, _, _, _, _, _, _),
>> +	[125] = PINGROUP(125, qspi_cs, _, ddr_pxi5, _, _, _, _, _, _),
>> +	[126] = PINGROUP(126, qspi_clk, _, ddr_pxi6, _, _, _, _, _, _),
>> +	[127] = PINGROUP(127, _, ddr_pxi6, _, _, _, _, _, _, _),
>> +	[128] = PINGROUP(128, qup22, _, ddr_pxi7, _, _, _, _, _, _),
>> +	[129] = PINGROUP(129, qup22, ddr_pxi7, _, _, _, _, _, _, _),
>> +	[130] = PINGROUP(130, qup05, qup06, jitter_bist_ref,
>> +			 qdss_cti, _, _, _, _, _),
>> +	[131] = PINGROUP(131, qup05, qup06, qdss_cti, _, _, _, _, _, _),
>> +	[132] = PINGROUP(132, qup06, qup05, smb_dat,
>> +			 qdss_cti, _, _, _, _, _),
>> +	[133] = PINGROUP(133, qup06, qup05, smb_clk,
>> +			 qdss_cti, _, _, _, _, _),
>> +	[134] = PINGROUP(134, qup08, qup07, gcc_gp1, _,
>> +			 qdss_cti, _, _, _, _),
>> +	[135] = PINGROUP(135, qup08, qup07, gcc_gp2, _,
>> +			 qdss_cti, vsense_trigger, _, _, _),
>> +	[136] = PINGROUP(136, gcc_gp3, dbg_out_clk, _, _, _, _, _, _, _),
>> +	[137] = PINGROUP(137, _, _, _, _, _, _, _, _, _),
>> +	[138] = PINGROUP(138, qlink2_wmss, _, _, _, _, _, _, _, _),
>> +	[139] = PINGROUP(139, qlink3_wmss, _, _, _, _, _, _, _, _),
>> +	[140] = PINGROUP(140, _, _, _, _, _, _, _, _, _),
>> +	[141] = PINGROUP(141, intr_c, _, _, _, _, _, _, _, _),
>> +	[142] = PINGROUP(142, intr_c, _, _, _, _, _, _, _, _),
>> +	[143] = PINGROUP(143, intr_c, _, _, _, _, _, _, _, _),
>> +	[144] = PINGROUP(144, qdss_cti, _, _, _, _, _, _, _, _),
>> +	[145] = PINGROUP(145, qdss_cti, _, _, _, _, _, _, _, _),
>> +	[146] = PINGROUP(146, _, _, _, _, _, _, _, _, _),
>> +	[147] = PINGROUP(147, _, _, _, _, _, _, _, _, _),
>> +	[148] = PINGROUP(148, _, _, _, _, _, _, _, _, _),
>> +	[149] = PINGROUP(149, _, _, _, _, _, _, _, _, _),
>> +	[150] = PINGROUP(150, _, _, _, _, _, _, _, _, _),
>> +	[151] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x9e000, 0, 0),
>> +	[152] = SDC_QDSD_PINGROUP(sdc1_clk, 0x9d000, 13, 6),
>> +	[153] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x9d000, 11, 3),
>> +	[154] = SDC_QDSD_PINGROUP(sdc1_data, 0x9d000, 9, 0),
>> +};
>> +static const struct msm_pinctrl_soc_data qdu1000_tlmm = {
>> +	.pins = qdu1000_pins,
>> +	.npins = ARRAY_SIZE(qdu1000_pins),
>> +	.functions = qdu1000_functions,
>> +	.nfunctions = ARRAY_SIZE(qdu1000_functions),
>> +	.groups = qdu1000_groups,
>> +	.ngroups = ARRAY_SIZE(qdu1000_groups),
>> +	.ngpios = 151,
>> +};
>> +
>> +static int qdu1000_tlmm_probe(struct platform_device *pdev)
>> +{
>> +	return msm_pinctrl_probe(pdev, &qdu1000_tlmm);
>> +}
>> +
>> +static const struct of_device_id qdu1000_tlmm_of_match[] = {
>> +	{ .compatible = "qcom,qdu1000-tlmm", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, qdu1000_tlmm_of_match);
>> +
>> +static struct platform_driver qdu1000_tlmm_driver = {
>> +	.driver = {
>> +		.name = "qdu1000-tlmm",
>> +		.of_match_table = qdu1000_tlmm_of_match,
>> +	},
>> +	.probe = qdu1000_tlmm_probe,
>> +	.remove = msm_pinctrl_remove,
>> +};
>> +
>> +static int __init qdu1000_tlmm_init(void)
>> +{
>> +	return platform_driver_register(&qdu1000_tlmm_driver);
>> +}
>> +arch_initcall(qdu1000_tlmm_init);
>> +
>> +static void __exit qdu1000_tlmm_exit(void)
>> +{
>> +	platform_driver_unregister(&qdu1000_tlmm_driver);
>> +}
>> +module_exit(qdu1000_tlmm_exit);
>> +
>> +MODULE_DESCRIPTION("QTI QDU1000 TLMM driver");
>> +MODULE_LICENSE("GPL");

