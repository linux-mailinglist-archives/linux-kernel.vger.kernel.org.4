Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC103632011
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKULOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKULOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:14:25 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC584D5C6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:09:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so18313403lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuX6FZ1W0vpW7Y12XoeyLD7P4ETLxuBUk2BOI4aPQig=;
        b=vborJQM1GpjC4QKjI3V7OXfJpKvWDITN5Gd+Vy0NUgNw9sXq7GXnIGClzgWX+ZIpR/
         YZ5gNMrFOr3Z+59rcOxYHdnJ2bK2IBlcZCOcEzxdOfjnNYwhtJgoTgAwSGTVSDLrHKtt
         gfKyQIlxCL1wJQaJCe9xU+UHekV7ZqOtkajkVoJxkQeD5oY/piFwuIobrQZg1SbIwT07
         bX0QER8DoeIrSpuCw07qV+GsQRVNqIs35IWEHwFSS2wkPdAPPmYGtSsPYuV18u9tr3K/
         8T3d11YUgvMDTJXu0fvMMxTRrlPk0APOEGiLGr7Ruz4KqEKt1xKO38GZ97FmeIf2Dlsd
         WKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuX6FZ1W0vpW7Y12XoeyLD7P4ETLxuBUk2BOI4aPQig=;
        b=H4IPHuRiFNxctNL1KOAByHhCs+Rw7iZE6IJP9vrekfHa6fHiMywhLL/GTLWnzxFv7+
         MtHid9kgGl6N6iw7G/GgAvD6bypJzVURWTXddT9zE/R3G+trjwAndcxxF5+tMaqfBByF
         JyMfiKADjsge8ziYa/VWMBzPjPckEu2ZAsMU5zmd4TLZP7Z7M58BR8DfmTmo7ERJvDHx
         Z42ipcC4O0ynFStl55Ow3kR1R3VfGbETFEHcUOo3uo1GfyTwIGhP7fke+BVFMqOF3zwX
         nKks5eqdMg0GFO9LZt4eAjiBVPCtK6aIErYgfUug7TWDj+STMf6czxLLgUJemFheP6XY
         zPXg==
X-Gm-Message-State: ANoB5pmpEFEUAcXQC1zFEU3qMtzQmVD7Ex64KHzO9LUsynayr2KKy/1G
        P35DyBxDLAcGdzln1agx4cMJGA==
X-Google-Smtp-Source: AA0mqf5oVU7cnw9LyMVs1IjiNHk6ZppVCKCoyYIeLsFxdgYYamCpTK6nzynQSBw1F0bEzSkQfNDVog==
X-Received: by 2002:a05:6512:20c3:b0:4a2:776f:f3c6 with SMTP id u3-20020a05651220c300b004a2776ff3c6mr5442332lfr.302.1669028969401;
        Mon, 21 Nov 2022 03:09:29 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id be40-20020a056512252800b00497a61453a9sm1987491lfb.243.2022.11.21.03.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:09:28 -0800 (PST)
Message-ID: <fafbb9d3-5e4b-fee1-7227-044964bb2292@linaro.org>
Date:   Mon, 21 Nov 2022 12:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/2] pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118182039.29236-1-quic_molvera@quicinc.com>
 <20221118182039.29236-3-quic_molvera@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118182039.29236-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.11.2022 19:20, Melody Olvera wrote:
> Add pin control driver for the TLMM block found in the QDU1000
> and QRU1000 SoC.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/pinctrl/qcom/Kconfig           |   10 +
>  drivers/pinctrl/qcom/Makefile          |    1 +
>  drivers/pinctrl/qcom/pinctrl-qdu1000.c | 1273 ++++++++++++++++++++++++
>  3 files changed, 1284 insertions(+)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdu1000.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 1378ddca084f..9ff4145646a3 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -248,6 +248,16 @@ config PINCTRL_QCOM_SSBI_PMIC
>  	 which are using SSBI for communication with SoC. Example PMIC's
>  	 devices are pm8058 and pm8921.
>  
> +config PINCTRL_QDU1000
[...]

> +DECLARE_MSM_GPIO_PINS(145);
> +DECLARE_MSM_GPIO_PINS(146);
> +DECLARE_MSM_GPIO_PINS(147);
> +DECLARE_MSM_GPIO_PINS(148);
> +DECLARE_MSM_GPIO_PINS(149);
> +DECLARE_MSM_GPIO_PINS(150);
> +
> +static const unsigned int sdc1_rclk_pins[] = { 151 };
> +static const unsigned int sdc1_clk_pins[] = { 152 };
> +static const unsigned int sdc1_cmd_pins[] = { 153 };
> +static const unsigned int sdc1_data_pins[] = { 154 };
> +
> +enum qdu1000_functions {
> +	msm_mux_gpio,
> +	msm_mux_CMO_PRI,
> +	msm_mux_SI5518_INT,
Any reason these two are uppercase?

Konrad
> +	msm_mux_atest_char,
> +	msm_mux_atest_usb,
> +	msm_mux_char_exec,
> +	msm_mux_cmu_rng,
> +	msm_mux_dbg_out_clk,
> +	msm_mux_ddr_bist,
> +	msm_mux_ddr_pxi0,
> +	msm_mux_ddr_pxi1,
> +	msm_mux_ddr_pxi2,
> +	msm_mux_ddr_pxi3,

[...]

> +
> +/* Every pin is maintained as a single group, and missing or non-existing pin
/*
 * Every pin...


Konrad
> + * would be maintained as dummy group to synchronize pin group index with
> + * pin descriptor registered with pinctrl core.
> + * Clients would not be able to request these dummy pin groups.
> + */
> +static const struct msm_pingroup qdu1000_groups[] = {
> +	[0] = PINGROUP(0, qup20, qup21, ddr_bist, _, _, _, _, _, _),
> +	[1] = PINGROUP(1, qup20, qup21, ddr_bist, _, _, _, _, _, _),
> +	[2] = PINGROUP(2, qup21, qup20, ddr_bist, _,
> +		       tsense_pwm1, _, _, _, _),
> +	[3] = PINGROUP(3, qup21, qup20, ddr_bist, _,
> +		       tsense_pwm2, _, _, _, _),
> +	[4] = PINGROUP(4, qup22, _, _, _, _, _, _, _, _),
> +	[5] = PINGROUP(5, qup22, _, _, _, _, _, _, _, _),
> +	[6] = PINGROUP(6, qup00, tgu_ch0, phase_flag, _,
> +		       qdss_gpio, _, _, _, _),
> +	[7] = PINGROUP(7, qup00, tgu_ch1, phase_flag, _,
> +		       qdss_gpio, _, _, _, _),
> +	[8] = PINGROUP(8, qup00, tgu_ch2, phase_flag, _,
> +		       qdss_gpio, _, _, _, _),
> +	[9] = PINGROUP(9, qup00, tgu_ch3, phase_flag, _,
> +		       qdss_gpio, _, _, _, _),
> +	[10] = PINGROUP(10, qup01, qup02, _, _, _, _, _, _, _),
> +	[11] = PINGROUP(11, qup01, qup02, _, _, _, _, _, _, _),
> +	[12] = PINGROUP(12, qup02, qup01, qup17, _, _, _, _, _, _),
> +	[13] = PINGROUP(13, qup02, qup01, qup17, _, _, _, _, _, _),
> +	[14] = PINGROUP(14, qup03, qup04, qup17, _, _, _, _, _, _),
> +	[15] = PINGROUP(15, qup03, qup04, _, _, _, _, _, _, _),
> +	[16] = PINGROUP(16, qup04, qup03, phase_flag, _,
> +			qdss_gpio, _, _, _, _),
> +	[17] = PINGROUP(17, qup04, qup03, phase_flag, _,
> +			qdss_gpio, _, _, _, _),
> +	[18] = PINGROUP(18, qup10, prng_rosc, phase_flag,
> +			_, qdss_gpio, _, _, _, _),
> +	[19] = PINGROUP(19, qup10, prng_rosc, phase_flag,
> +			_, qdss_gpio, _, _, _, _),
> +	[20] = PINGROUP(20, qup10, prng_rosc, pll_bist,
> +			phase_flag, _, qdss_gpio, _, _, _),
> +	[21] = PINGROUP(21, qup10, prng_rosc, phase_flag,
> +			_, qdss_gpio, _, _, _, _),
> +	[22] = PINGROUP(22, qup11, qup12, phase_flag, _,
> +			qdss_gpio, _, _, _, _),
> +	[23] = PINGROUP(23, qup11, qup12, phase_flag, _,
> +			qdss_gpio, _, _, _, _),
> +	[24] = PINGROUP(24, qup12, qup11, phase_flag, _,
> +			qdss_gpio, _, _, _, _),
> +	[25] = PINGROUP(25, qup12, qup11, phase_flag, _,
> +			qdss_gpio, _, _, _, _),
> +	[26] = PINGROUP(26, qup13, qup14, intr_c,
> +			phase_flag, _, qdss_gpio, _, _, _),
> +	[27] = PINGROUP(27, qup13, qup14, intr_c,
> +			phase_flag, _, qdss_gpio, _, _, _),
> +	[28] = PINGROUP(28, qup14, qup13, intr_c,
> +			phase_flag, _, qdss_gpio, _, _, _),
> +	[29] = PINGROUP(29, qup14, qup13, qup16,
> +			phase_flag, _, qdss_gpio, _, _, _),
> +	[30] = PINGROUP(30, qup17, qup15, tmess_prng3,
> +			phase_flag, _, qdss_gpio, _, _, _),
> +	[31] = PINGROUP(31, qup17, qup15, tmess_prng2,
> +			phase_flag, _, qdss_gpio, _, _, _),
> +	[32] = PINGROUP(32, qup15, tmess_prng1, phase_flag,
> +			_, qdss_gpio, _, _, _, _),
> +	[33] = PINGROUP(33, qup15, tmess_prng0, phase_flag,
> +			_, qdss_gpio, _, _, _, _),
> +	[34] = PINGROUP(34, qup16, qdss_gpio, _, _, _, _, _, _, _),
> +	[35] = PINGROUP(35, qup16, qdss_gpio, _, _, _, _, _, _, _),
> +	[36] = PINGROUP(36, qup16, qdss_cti, _, _, _, _, _, _, _),
> +	[37] = PINGROUP(37, qup16, qdss_cti, _, _, _, _, _, _, _),
> +	[38] = PINGROUP(38, qup16, qdss_cti, _, _, _, _, _, _, _),
> +	[39] = PINGROUP(39, qup16, qdss_cti, _, _, _, _, _, _, _),
> +	[40] = PINGROUP(40, qup17, qdss_cti, _, _, _, _, _, _, _),
> +	[41] = PINGROUP(41, qup17, qdss_cti, _, _, _, _, _, _, _),
> +	[42] = PINGROUP(42, usb_con_det, phase_flag, _,
> +			qdss_gpio, _, _, _, _, _),
> +	[43] = PINGROUP(43, usb_dfp_en, phase_flag, _,
> +			qdss_gpio, _, _, _, _, _),
> +	[44] = PINGROUP(44, SI5518_INT, tgu_ch4, _, _, _, _, _, _, _),
> +	[45] = PINGROUP(45, tgu_ch5, _, _, _, _, _, _, _, _),
> +	[46] = PINGROUP(46, tgu_ch6, _, _, _, _, _, _, _, _),
> +	[47] = PINGROUP(47, hardsync_pps_in, tgu_ch7, _, _, _, _, _, _, _),
> +	[48] = PINGROUP(48, tod_pps_in, qdss_cti, _, _, _, _, _, _, _),
> +	[49] = PINGROUP(49, gps_pps_in, qdss_cti, _, _, _, _, _, _, _),
> +	[50] = PINGROUP(50, _, _, _, _, _, _, _, _, _),
> +	[51] = PINGROUP(51, _, _, _, _, _, _, _, _, _),
> +	[52] = PINGROUP(52, _, _, _, _, _, _, _, _, _),
> +	[53] = PINGROUP(53, _, _, _, _, _, _, _, _, _),
> +	[54] = PINGROUP(54, _, _, _, _, _, _, _, _, _),
> +	[55] = PINGROUP(55, _, _, _, _, _, _, _, _, _),
> +	[56] = PINGROUP(56, _, qlink6_wmss, _, _, _, _, _, _, _),
> +	[57] = PINGROUP(57, _, qlink7_wmss, _, _, _, _, _, _, _),
> +	[58] = PINGROUP(58, _, _, _, _, _, _, _, _, _),
> +	[59] = PINGROUP(59, _, _, _, _, _, _, _, _, _),
> +	[60] = PINGROUP(60, _, _, _, _, _, _, _, _, _),
> +	[61] = PINGROUP(61, _, _, _, _, _, _, _, _, _),
> +	[62] = PINGROUP(62, _, _, _, _, _, _, _, _, _),
> +	[63] = PINGROUP(63, _, _, _, _, _, _, _, _, _),
> +	[64] = PINGROUP(64, _, _, _, _, _, _, _, _, _),
> +	[65] = PINGROUP(65, _, _, _, _, _, _, _, _, _),
> +	[66] = PINGROUP(66, qlink0_request, _, _, _, _, _, _, _, _),
> +	[67] = PINGROUP(67, qlink0_enable, _, _, _, _, _, _, _, _),
> +	[68] = PINGROUP(68, qlink1_request, _, _, _, _, _, _, _, _),
> +	[69] = PINGROUP(69, qlink1_enable, _, _, _, _, _, _, _, _),
> +	[70] = PINGROUP(70, qlink2_request, _, _, _, _, _, _, _, _),
> +	[71] = PINGROUP(71, qlink2_enable, _, _, _, _, _, _, _, _),
> +	[72] = PINGROUP(72, qlink3_request, _, _, _, _, _, _, _, _),
> +	[73] = PINGROUP(73, qlink3_enable, _, _, _, _, _, _, _, _),
> +	[74] = PINGROUP(74, qlink4_request, _, _, _, _, _, _, _, _),
> +	[75] = PINGROUP(75, qlink4_enable, _, _, _, _, _, _, _, _),
> +	[76] = PINGROUP(76, qlink5_request, _, _, _, _, _, _, _, _),
> +	[77] = PINGROUP(77, qlink5_enable, _, _, _, _, _, _, _, _),
> +	[78] = PINGROUP(78, qlink6_request, _, _, _, _, _, _, _, _),
> +	[79] = PINGROUP(79, qlink6_enable, _, _, _, _, _, _, _, _),
> +	[80] = PINGROUP(80, qlink7_request, _, _, _, _, _, _, _, _),
> +	[81] = PINGROUP(81, qlink7_enable, _, _, _, _, _, _, _, _),
> +	[82] = PINGROUP(82, qlink0_wmss, _, _, _, _, _, _, _, _),
> +	[83] = PINGROUP(83, qlink1_wmss, _, _, _, _, _, _, _, _),
> +	[84] = PINGROUP(84, qlink4_wmss, _, _, _, _, _, _, _, _),
> +	[85] = PINGROUP(85, qlink5_wmss, _, _, _, _, _, _, _, _),
> +	[86] = PINGROUP(86, eth012_int_n, gcc_gp1, _, qdss_cti, _, _, _, _, _),
> +	[87] = PINGROUP(87, eth345_int_n, gcc_gp2, _, qdss_cti, _, _, _, _, _),
> +	[88] = PINGROUP(88, eth6_int_n, smb_alert, gcc_gp3, _,
> +			qdss_gpio, _, _, _, _),
> +	[89] = PINGROUP(89, phase_flag, cmu_rng, _,
> +			qdss_gpio, atest_char, _, _, _, _),
> +	[90] = PINGROUP(90, usb2phy_ac, phase_flag,
> +			cmu_rng, _, qdss_gpio,
> +			atest_char, _, _, _),
> +	[91] = PINGROUP(91, usb_phy, phase_flag, cmu_rng,
> +			_, qdss_gpio, atest_char, _, _, _),
> +	[92] = PINGROUP(92, phase_flag, cmu_rng, _,
> +			qdss_gpio, atest_char, _, _, _, _),
> +	[93] = PINGROUP(93, vfr_0, qdss_cti, _, _, _, _, _, _, _),
> +	[94] = PINGROUP(94, vfr_1, qdss_cti, _, _, _, _, _, _, _),
> +	[95] = PINGROUP(95, phase_flag, _, qdss_gpio,
> +			atest_char, _, _, _, _, _),
> +	[96] = PINGROUP(96, phase_flag, _, qdss_gpio, _, _, _, _, _, _),
> +	[97] = PINGROUP(97, phase_flag, _, qdss_gpio, _, _, _, _, _, _),
> +	[98] = PINGROUP(98, pll_clk, _, _, _, _, _, _, _, _),
> +	[99] = PINGROUP(99, pcie_clkreqn, char_exec, _, _, _, _, _, _, _),
> +	[100] = PINGROUP(100, char_exec, _, _, _, _, _, _, _, _),
> +	[101] = PINGROUP(101, smb_alert, _, _, _, _, _, _, _, _),
> +	[102] = PINGROUP(102, phase_flag, _, qdss_gpio, _, _, _, _, _, _),
> +	[103] = PINGROUP(103, CMO_PRI, qdss_gpio, _, _, _, _, _, _, _),
> +	[104] = PINGROUP(104, _, _, _, _, _, _, _, _, _),
> +	[105] = PINGROUP(105, _, _, _, _, _, _, _, _, _),
> +	[106] = PINGROUP(106, _, _, _, _, _, _, _, _, _),
> +	[107] = PINGROUP(107, _, _, _, _, _, _, _, _, _),
> +	[108] = PINGROUP(108, _, _, _, _, _, _, _, _, _),
> +	[109] = PINGROUP(109, _, _, _, _, _, _, _, _, _),
> +	[110] = PINGROUP(110, _, _, _, _, _, _, _, _, _),
> +	[111] = PINGROUP(111, _, _, _, _, _, _, _, _, _),
> +	[112] = PINGROUP(112, _, _, _, _, _, _, _, _, _),
> +	[113] = PINGROUP(113, _, _, _, _, _, _, _, _, _),
> +	[114] = PINGROUP(114, qspi0, tb_trig, _,
> +			 atest_usb, ddr_pxi0, _, _, _, _),
> +	[115] = PINGROUP(115, qspi1, _, atest_usb,
> +			 ddr_pxi0, _, _, _, _, _),
> +	[116] = PINGROUP(116, qspi2, _, atest_usb,
> +			 ddr_pxi1, _, _, _, _, _),
> +	[117] = PINGROUP(117, qspi3, _, atest_usb,
> +			 ddr_pxi1, _, _, _, _, _),
> +	[118] = PINGROUP(118, _, atest_usb, ddr_pxi2, _, _, _, _, _, _),
> +	[119] = PINGROUP(119, _, _, ddr_pxi2, _, _, _, _, _, _),
> +	[120] = PINGROUP(120, _, _, ddr_pxi3, _, _, _, _, _, _),
> +	[121] = PINGROUP(121, _, ddr_pxi3, _, _, _, _, _, _, _),
> +	[122] = PINGROUP(122, _, ddr_pxi4, _, _, _, _, _, _, _),
> +	[123] = PINGROUP(123, _, ddr_pxi4, _, _, _, _, _, _, _),
> +	[124] = PINGROUP(124, _, ddr_pxi5, _, _, _, _, _, _, _),
> +	[125] = PINGROUP(125, qspi_cs, _, ddr_pxi5, _, _, _, _, _, _),
> +	[126] = PINGROUP(126, qspi_clk, _, ddr_pxi6, _, _, _, _, _, _),
> +	[127] = PINGROUP(127, _, ddr_pxi6, _, _, _, _, _, _, _),
> +	[128] = PINGROUP(128, qup22, _, ddr_pxi7, _, _, _, _, _, _),
> +	[129] = PINGROUP(129, qup22, ddr_pxi7, _, _, _, _, _, _, _),
> +	[130] = PINGROUP(130, qup05, qup06, jitter_bist_ref,
> +			 qdss_cti, _, _, _, _, _),
> +	[131] = PINGROUP(131, qup05, qup06, qdss_cti, _, _, _, _, _, _),
> +	[132] = PINGROUP(132, qup06, qup05, smb_dat,
> +			 qdss_cti, _, _, _, _, _),
> +	[133] = PINGROUP(133, qup06, qup05, smb_clk,
> +			 qdss_cti, _, _, _, _, _),
> +	[134] = PINGROUP(134, qup08, qup07, gcc_gp1, _,
> +			 qdss_cti, _, _, _, _),
> +	[135] = PINGROUP(135, qup08, qup07, gcc_gp2, _,
> +			 qdss_cti, vsense_trigger, _, _, _),
> +	[136] = PINGROUP(136, gcc_gp3, dbg_out_clk, _, _, _, _, _, _, _),
> +	[137] = PINGROUP(137, _, _, _, _, _, _, _, _, _),
> +	[138] = PINGROUP(138, qlink2_wmss, _, _, _, _, _, _, _, _),
> +	[139] = PINGROUP(139, qlink3_wmss, _, _, _, _, _, _, _, _),
> +	[140] = PINGROUP(140, _, _, _, _, _, _, _, _, _),
> +	[141] = PINGROUP(141, intr_c, _, _, _, _, _, _, _, _),
> +	[142] = PINGROUP(142, intr_c, _, _, _, _, _, _, _, _),
> +	[143] = PINGROUP(143, intr_c, _, _, _, _, _, _, _, _),
> +	[144] = PINGROUP(144, qdss_cti, _, _, _, _, _, _, _, _),
> +	[145] = PINGROUP(145, qdss_cti, _, _, _, _, _, _, _, _),
> +	[146] = PINGROUP(146, _, _, _, _, _, _, _, _, _),
> +	[147] = PINGROUP(147, _, _, _, _, _, _, _, _, _),
> +	[148] = PINGROUP(148, _, _, _, _, _, _, _, _, _),
> +	[149] = PINGROUP(149, _, _, _, _, _, _, _, _, _),
> +	[150] = PINGROUP(150, _, _, _, _, _, _, _, _, _),
> +	[151] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x9e000, 0, 0),
> +	[152] = SDC_QDSD_PINGROUP(sdc1_clk, 0x9d000, 13, 6),
> +	[153] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x9d000, 11, 3),
> +	[154] = SDC_QDSD_PINGROUP(sdc1_data, 0x9d000, 9, 0),
> +};
> +static const struct msm_pinctrl_soc_data qdu1000_tlmm = {
> +	.pins = qdu1000_pins,
> +	.npins = ARRAY_SIZE(qdu1000_pins),
> +	.functions = qdu1000_functions,
> +	.nfunctions = ARRAY_SIZE(qdu1000_functions),
> +	.groups = qdu1000_groups,
> +	.ngroups = ARRAY_SIZE(qdu1000_groups),
> +	.ngpios = 151,
> +};
> +
> +static int qdu1000_tlmm_probe(struct platform_device *pdev)
> +{
> +	return msm_pinctrl_probe(pdev, &qdu1000_tlmm);
> +}
> +
> +static const struct of_device_id qdu1000_tlmm_of_match[] = {
> +	{ .compatible = "qcom,qdu1000-tlmm", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, qdu1000_tlmm_of_match);
> +
> +static struct platform_driver qdu1000_tlmm_driver = {
> +	.driver = {
> +		.name = "qdu1000-tlmm",
> +		.of_match_table = qdu1000_tlmm_of_match,
> +	},
> +	.probe = qdu1000_tlmm_probe,
> +	.remove = msm_pinctrl_remove,
> +};
> +
> +static int __init qdu1000_tlmm_init(void)
> +{
> +	return platform_driver_register(&qdu1000_tlmm_driver);
> +}
> +arch_initcall(qdu1000_tlmm_init);
> +
> +static void __exit qdu1000_tlmm_exit(void)
> +{
> +	platform_driver_unregister(&qdu1000_tlmm_driver);
> +}
> +module_exit(qdu1000_tlmm_exit);
> +
> +MODULE_DESCRIPTION("QTI QDU1000 TLMM driver");
> +MODULE_LICENSE("GPL");
