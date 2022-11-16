Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C5662BC71
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKPLsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiKPLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:47:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C561D316
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:34:35 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k2so43382359ejr.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSN25FMtaCLxuWwxupnuFqSNClF21BZGQv9H2rkd4F4=;
        b=N+3LCdU8+WBNj6Va+j8XDwCcnTGZdWQlvxnmLolWzwoWReM5w04ftJmKeLi5sHFtdi
         qd1xdR05uszk1zrplvFVulx5m45dNBC1r6rLzB9Jvvt1evu+o8Cu/KUwKpLoFqDBEzaQ
         kkWgEqIEiqMHjtMUX7nARVzUCTzaskKntq+EKvyefjVdVhDBwqbUDNfQWu6BakLQoYQf
         ccdids+KS1uexyeSQFGfSXCTPKLF+11HVrrTK7+/L3Fqit4cgVPZ/dEW/USBlYjiSHgz
         a6YUe7FMVYP35WSdiBLkrkuNnz3/+0/MO67hGWFpVxLF8uOPXG2S1d/8d0dhHwpTTfrb
         p9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XSN25FMtaCLxuWwxupnuFqSNClF21BZGQv9H2rkd4F4=;
        b=gtNpLZMOazlXgRgPi5cBes/MiFPyXU5RNT6HmayiEujpM28DFV8zBU05fNB7+Oi+/h
         AB8R5OByN3Ffen1/mlAfGhe8vhi25piMmbfQ86OVtTTwAMie8OFa9kQn2/GI2YUWIN7z
         SYGL4CerFNN6w39hs9YqzcA1HLQC11VJJsjH7/mHILroIqVDqk0YH3HDvXUpf35CXhNS
         1W0+6NFg+LVPLWzhBOxyZCM5JjE962UQ+9MSgAU2vu8QmPiGeJI5p/ljyqLTuiBz3qfv
         WHpVJT6YE7jPOMn5s1WiaAg5cHrl3+5hye6cBO9b8OQF5VPJF4Dd7YXfwpkCOwrxwT5M
         ZFww==
X-Gm-Message-State: ANoB5pkH9psaS6r2XFwnt1l4QlQdwNAZoFKA0k4/9GSHBFJE/UaPZCJj
        G7dEgYeUXEja/My0Cvhsuk07sw==
X-Google-Smtp-Source: AA0mqf6Y72qdvQQfXe7FzaZw1Cq3220EjrYGb1VycKqc0vq2pP79SB4lXWkg9oEFJi33ylti81gB4g==
X-Received: by 2002:a17:906:76c5:b0:78d:cede:91f4 with SMTP id q5-20020a17090676c500b0078dcede91f4mr16968154ejn.764.1668598474204;
        Wed, 16 Nov 2022 03:34:34 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906118b00b0078cb06c2ef9sm6728716eja.8.2022.11.16.03.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:34:33 -0800 (PST)
Message-ID: <28233031-2f2f-845b-0e6e-627adad73ab0@linaro.org>
Date:   Wed, 16 Nov 2022 12:34:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] pinctrl: qcom: Add SM8550 pinctrl driver
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20221116105724.2600349-1-abel.vesa@linaro.org>
 <20221116105724.2600349-5-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116105724.2600349-5-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 16/11/2022 11:57, Abel Vesa wrote:
> Add pinctrl driver for TLMM block found in SM8550 SoC.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
[...]

> +
> +enum sm8550_functions {
> +	msm_mux_gpio,
> +	msm_mux_RESOUT_GPIO_N,
Any particular reason this one is uppercase and unsorted?

> +	msm_mux_aon_cci,
> +	msm_mux_aoss_cti,
> +	msm_mux_atest_char,
> +	msm_mux_atest_usb,
> +	msm_mux_audio_ext_mclk0,
> +	msm_mux_audio_ext_mclk1,
> +	msm_mux_audio_ref_clk,

[...]


> +
> +/* Every pin is maintained as a single group, and missing or non-existing pin
/*
  * Every..


With these fixed:
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> + * would be maintained as dummy group to synchronize pin group index with
> + * pin descriptor registered with pinctrl core.
> + * Clients would not be able to request these dummy pin groups.
> + */
> +static const struct msm_pingroup sm8550_groups[] = {
> +	[0] = PINGROUP(0, cci_i2c_sda, qup2_se0_l0_mirb, ibi_i3c, phase_flag, _, _, _, _, _),
> +	[1] = PINGROUP(1, cci_i2c_scl, qup2_se0_l1_mirb, ibi_i3c, _, _, _, _, _, _),
> +	[2] = PINGROUP(2, qup2_se4, phase_flag, _, _, _, _, _, _, _),
> +	[3] = PINGROUP(3, qup2_se4, phase_flag, _, _, _, _, _, _, _),
> +	[4] = PINGROUP(4, i2chub0_se4, _, _, _, _, _, _, _, _),
> +	[5] = PINGROUP(5, i2chub0_se4, _, _, _, _, _, _, _, _),
> +	[6] = PINGROUP(6, i2chub0_se5, _, _, _, _, _, _, _, _),
> +	[7] = PINGROUP(7, i2chub0_se5, _, _, _, _, _, _, _, _),
> +	[8] = PINGROUP(8, i2chub0_se6, _, _, _, _, _, _, _, _),
> +	[9] = PINGROUP(9, i2chub0_se6, _, _, _, _, _, _, _, _),
> +	[10] = PINGROUP(10, i2chub0_se7, qdss_cti, phase_flag, _, _, _, _, _, _),
> +	[11] = PINGROUP(11, i2chub0_se7, usb_phy, qdss_cti, phase_flag, _, _, _, _, _),
> +	[12] = PINGROUP(12, phase_flag, _, _, _, _, _, _, _, _),
> +	[13] = PINGROUP(13, phase_flag, _, _, _, _, _, _, _, _),
> +	[14] = PINGROUP(14, _, _, _, _, _, _, _, _, _),
> +	[15] = PINGROUP(15, _, _, _, _, _, _, _, _, _),
> +	[16] = PINGROUP(16, i2chub0_se0, _, _, _, _, _, _, _, _),
> +	[17] = PINGROUP(17, i2chub0_se0, _, _, _, _, _, _, _, _),
> +	[18] = PINGROUP(18, i2chub0_se1, _, _, _, _, _, _, _, _),
> +	[19] = PINGROUP(19, i2chub0_se1, _, _, _, _, _, _, _, _),
> +	[20] = PINGROUP(20, i2chub0_se2, pll_bist_sync, _, _, _, _, _, _, _),
> +	[21] = PINGROUP(21, i2chub0_se2, _, _, _, _, _, _, _, _),
> +	[22] = PINGROUP(22, i2chub0_se3, _, _, _, _, _, _, _, _),
> +	[23] = PINGROUP(23, i2chub0_se3, _, _, _, _, _, _, _, _),
> +	[24] = PINGROUP(24, qup1_se7, vsense_trigger_mirnat, _, _, _, _, _, _, _),
> +	[25] = PINGROUP(25, qup1_se7, _, _, _, _, _, _, _, _),
> +	[26] = PINGROUP(26, qup1_se7, uim1_present, _, _, _, _, _, _, _),
> +	[27] = PINGROUP(27, qup1_se7, uim0_present, _, _, _, _, _, _, _),
> +	[28] = PINGROUP(28, qup1_se0, ibi_i3c, _, _, _, _, _, _, _),
> +	[29] = PINGROUP(29, qup1_se0, ibi_i3c, _, _, _, _, _, _, _),
> +	[30] = PINGROUP(30, qup1_se0, _, _, _, _, _, _, _, _),
> +	[31] = PINGROUP(31, qup1_se0, _, _, _, _, _, _, _, _),
> +	[32] = PINGROUP(32, qup1_se1, ibi_i3c, _, _, _, _, _, _, _),
> +	[33] = PINGROUP(33, qup1_se1, ibi_i3c, _, _, _, _, _, _, _),
> +	[34] = PINGROUP(34, qup1_se1, _, _, _, _, _, _, _, _),
> +	[35] = PINGROUP(35, qup1_se1, _, _, _, _, _, _, _, _),
> +	[36] = PINGROUP(36, qup1_se2, ddr_bist_fail, _, _, _, _, _, _, _),
> +	[37] = PINGROUP(37, qup1_se2, ddr_bist_start, _, atest_usb, _, _, _, _, _),
> +	[38] = PINGROUP(38, qup1_se2, _, _, _, _, _, _, _, _),
> +	[39] = PINGROUP(39, qup1_se2, _, atest_usb, _, _, _, _, _, _),
> +	[40] = PINGROUP(40, qup1_se3, qup1_se2, ddr_bist_complete, _, ddr_pxi1, _, _, _, _),
> +	[41] = PINGROUP(41, qup1_se3, qup1_se2, ddr_bist_stop, _, ddr_pxi1, _, _, _, _),
> +	[42] = PINGROUP(42, qup1_se3, qup1_se2, _, _, _, _, _, _, _),
> +	[43] = PINGROUP(43, qup1_se3, jitter_bist, ddr_pxi3, _, _, _, _, _, _),
> +	[44] = PINGROUP(44, qup1_se4, aoss_cti, ddr_pxi3, _, _, _, _, _, _),
> +	[45] = PINGROUP(45, qup1_se4, aoss_cti, ddr_pxi2, _, _, _, _, _, _),
> +	[46] = PINGROUP(46, qup1_se4, aoss_cti, _, _, _, _, _, _, _),
> +	[47] = PINGROUP(47, qup1_se4, aoss_cti, dp_hot, ddr_pxi2, _, _, _, _, _),
> +	[48] = PINGROUP(48, usb_phy, qup1_se6, qspi2, sdc42, _, _, _, _, _),
> +	[49] = PINGROUP(49, qup1_se6, qspi3, sdc43, _, _, _, _, _, _),
> +	[50] = PINGROUP(50, qup1_se6, qspi_clk, sdc4_clk, tsense_pwm1, tsense_pwm2, tsense_pwm3, _, _, _),
> +	[51] = PINGROUP(51, qup1_se6, qspi_cs, sdc4_cmd, ddr_pxi0, _, _, _, _, _),
> +	[52] = PINGROUP(52, _, qup1_se5, ddr_pxi0, _, _, _, _, _, _),
> +	[53] = PINGROUP(53, _, qup1_se5, _, _, _, _, _, _, _),
> +	[54] = PINGROUP(54, _, qup1_se5, _, _, _, _, _, _, _),
> +	[55] = PINGROUP(55, qup1_se5, atest_usb, _, _, _, _, _, _, _),
> +	[56] = PINGROUP(56, qup2_se0_l0_mira, ibi_i3c, _, _, _, _, _, _, _),
> +	[57] = PINGROUP(57, qup2_se0_l1_mira, ibi_i3c, _, _, _, _, _, _, _),
> +	[58] = PINGROUP(58, qup2_se0_l2_mira, _, _, _, _, _, _, _, _),
> +	[59] = PINGROUP(59, qup2_se0_l3_mira, phase_flag, _, qdss_gpio, _, _, _, _, _),
> +	[60] = PINGROUP(60, qup2_se1, ibi_i3c, _, _, _, _, _, _, _),
> +	[61] = PINGROUP(61, qup2_se1, ibi_i3c, _, _, _, _, _, _, _),
> +	[62] = PINGROUP(62, qup2_se1, _, _, _, _, _, _, _, _),
> +	[63] = PINGROUP(63, qup2_se1, qup2_se0, phase_flag, _, _, _, _, _, _),
> +	[64] = PINGROUP(64, qup2_se2, tb_trig_sdc2, phase_flag, tgu_ch0_trigout, _, qdss_gpio, _, _, _),
> +	[65] = PINGROUP(65, qup2_se2, phase_flag, tgu_ch1_trigout, _, _, _, _, _, _),
> +	[66] = PINGROUP(66, qup2_se2, qup2_se0, tgu_ch2_trigout, _, _, _, _, _, _),
> +	[67] = PINGROUP(67, qup2_se2, qup2_se0, phase_flag, tgu_ch3_trigout, _, _, _, _, _),
> +	[68] = PINGROUP(68, qup2_se3, phase_flag, _, _, _, _, _, _, _),
> +	[69] = PINGROUP(69, qup2_se3, phase_flag, _, _, _, _, _, _, _),
> +	[70] = PINGROUP(70, qup2_se3, _, _, _, _, _, _, _, _),
> +	[71] = PINGROUP(71, cci_async_in, qup2_se3, _, _, _, _, _, _, _),
> +	[72] = PINGROUP(72, cci_async_in, qup2_se7, _, _, _, _, _, _, _),
> +	[73] = PINGROUP(73, qdss_gpio, _, _, _, _, _, _, _, _),
> +	[74] = PINGROUP(74, cci_i2c_sda, qup2_se7, _, _, _, _, _, _, _),
> +	[75] = PINGROUP(75, cci_i2c_scl, qup2_se7, qdss_cti, phase_flag, _, _, _, _, _),
> +	[76] = PINGROUP(76, qup2_se6, phase_flag, _, _, _, _, _, _, _),
> +	[77] = PINGROUP(77, qup2_se6, phase_flag, _, _, _, _, _, _, _),
> +	[78] = PINGROUP(78, qup2_se6, _, _, _, _, _, _, _, _),
> +	[79] = PINGROUP(79, qup2_se6, qdss_cti, phase_flag, _, _, _, _, _, _),
> +	[80] = PINGROUP(80, qup2_se5, phase_flag, _, _, _, _, _, _, _),
> +	[81] = PINGROUP(81, qup2_se5, phase_flag, _, _, _, _, _, _, _),
> +	[82] = PINGROUP(82, qup2_se5, _, _, _, _, _, _, _, _),
> +	[83] = PINGROUP(83, qup2_se5, phase_flag, _, _, _, _, _, _, _),
> +	[84] = PINGROUP(84, i2chub0_se9, _, _, _, _, _, _, _, _),
> +	[85] = PINGROUP(85, i2chub0_se9, _, _, _, _, _, _, _, _),
> +	[86] = PINGROUP(86, mdp_vsync, mdp_vsync0_out, mdp_vsync1_out, gcc_gp1, _, _, _, _, _),
> +	[87] = PINGROUP(87, mdp_vsync, mdp_vsync2_out, mdp_vsync3_out, gcc_gp2, _, _, _, _, _),
> +	[88] = PINGROUP(88, mdp_vsync_e, gcc_gp3, _, _, _, _, _, _, _),
> +	[89] = PINGROUP(89, qspi0, sdc40, dbg_out_clk, _, _, _, _, _, _),
> +	[90] = PINGROUP(90, usb1_hs, qspi1, sdc41, _, _, _, _, _, _),
> +	[91] = PINGROUP(91, qspi_cs, tb_trig_sdc4, _, _, _, _, _, _, _),
> +	[92] = PINGROUP(92, RESOUT_GPIO_N, phase_flag, tmess_prng0, _, _, _, _, _, _),
> +	[93] = PINGROUP(93, sd_write_protect, _, _, _, _, _, _, _, _),
> +	[94] = PINGROUP(94, phase_flag, tmess_prng1, _, _, _, _, _, _, _),
> +	[95] = PINGROUP(95, pcie0_clk_req_n, phase_flag, tmess_prng2, _, _, _, _, _, _),
> +	[96] = PINGROUP(96, phase_flag, tmess_prng3, _, _, _, _, _, _, _),
> +	[97] = PINGROUP(97, phase_flag, _, _, _, _, _, _, _, _),
> +	[98] = PINGROUP(98, pcie1_clk_req_n, phase_flag, _, _, _, _, _, _, _),
> +	[99] = PINGROUP(99, phase_flag, _, _, _, _, _, _, _, _),
> +	[100] = PINGROUP(100, cam_mclk, qdss_gpio, _, _, _, _, _, _, _),
> +	[101] = PINGROUP(101, cam_mclk, qdss_gpio, _, _, _, _, _, _, _),
> +	[102] = PINGROUP(102, cam_mclk, qdss_gpio, _, _, _, _, _, _, _),
> +	[103] = PINGROUP(103, cam_mclk, qdss_gpio, _, _, _, _, _, _, _),
> +	[104] = PINGROUP(104, cam_aon_mclk4, qdss_gpio, _, _, _, _, _, _, _),
> +	[105] = PINGROUP(105, cam_mclk, qdss_gpio, _, _, _, _, _, _, _),
> +	[106] = PINGROUP(106, cam_mclk, qup2_se7, _, _, _, _, _, _, _),
> +	[107] = PINGROUP(107, cam_mclk, qup2_se0_l3_mirb, pll_clk_aux, _, _, _, _, _, _),
> +	[108] = PINGROUP(108, _, _, _, _, _, _, _, _, _),
> +	[109] = PINGROUP(109, cci_async_in, qup2_se0_l2_mirb, _, _, _, _, _, _, _),
> +	[110] = PINGROUP(110, cci_i2c_sda, qdss_gpio, _, _, _, _, _, _, _),
> +	[111] = PINGROUP(111, cci_i2c_scl, qdss_gpio, _, _, _, _, _, _, _),
> +	[112] = PINGROUP(112, cci_i2c_sda, qdss_gpio, _, _, _, _, _, _, _),
> +	[113] = PINGROUP(113, cci_i2c_scl, qdss_gpio, _, _, _, _, _, _, _),
> +	[114] = PINGROUP(114, cci_i2c_sda, qdss_gpio, _, _, _, _, _, _, _),
> +	[115] = PINGROUP(115, cci_i2c_scl, qdss_gpio, _, _, _, _, _, _, _),
> +	[116] = PINGROUP(116, cci_timer, phase_flag, _, qdss_gpio, _, _, _, _, _),
> +	[117] = PINGROUP(117, cci_timer, phase_flag, _, qdss_gpio, _, _, _, _, _),
> +	[118] = PINGROUP(118, qup2_se4, cci_timer, _, _, _, _, _, _, _),
> +	[119] = PINGROUP(119, qup2_se4, cci_timer, phase_flag, _, _, _, _, _, _),
> +	[120] = PINGROUP(120, cci_timer, phase_flag, _, qdss_gpio, _, _, _, _, _),
> +	[121] = PINGROUP(121, i2s1_sck, _, _, _, _, _, _, _, _),
> +	[122] = PINGROUP(122, i2s1_data0, cmu_rng, _, _, _, _, _, _, _),
> +	[123] = PINGROUP(123, i2s1_ws, _, _, _, _, _, _, _, _),
> +	[124] = PINGROUP(124, i2s1_data1, audio_ext_mclk1, audio_ref_clk, _, _, _, _, _, _),
> +	[125] = PINGROUP(125, audio_ext_mclk0, _, _, _, _, _, _, _, _),
> +	[126] = PINGROUP(126, i2s0_sck, _, _, _, _, _, _, _, _),
> +	[127] = PINGROUP(127, i2s0_data0, cmu_rng, _, _, _, _, _, _, _),
> +	[128] = PINGROUP(128, i2s0_data1, cmu_rng, _, _, _, _, _, _, _),
> +	[129] = PINGROUP(129, i2s0_ws, cmu_rng, _, _, _, _, _, _, _),
> +	[130] = PINGROUP(130, uim0_data, atest_char, _, _, _, _, _, _, _),
> +	[131] = PINGROUP(131, uim0_clk, _, _, _, _, _, _, _, _),
> +	[132] = PINGROUP(132, uim0_reset, atest_char, _, _, _, _, _, _, _),
> +	[133] = PINGROUP(133, mdp_vsync, atest_char, _, _, _, _, _, _, _),
> +	[134] = PINGROUP(134, uim1_data, gcc_gp1, atest_char, _, _, _, _, _, _),
> +	[135] = PINGROUP(135, uim1_clk, gcc_gp2, atest_char, _, _, _, _, _, _),
> +	[136] = PINGROUP(136, uim1_reset, gcc_gp3, _, _, _, _, _, _, _),
> +	[137] = PINGROUP(137, mdp_vsync, _, _, _, _, _, _, _, _),
> +	[138] = PINGROUP(138, _, _, qdss_gpio, _, _, _, _, _, _),
> +	[139] = PINGROUP(139, _, _, qdss_gpio, _, _, _, _, _, _),
> +	[140] = PINGROUP(140, _, _, qdss_gpio, _, _, _, _, _, _),
> +	[141] = PINGROUP(141, _, _, qdss_gpio, _, _, _, _, _, _),
> +	[142] = PINGROUP(142, _, _, qdss_gpio, _, _, _, _, _, _),
> +	[143] = PINGROUP(143, _, _, qdss_gpio, _, _, _, _, _, _),
> +	[144] = PINGROUP(144, _, _, qdss_gpio, _, _, _, _, _, _),
> +	[145] = PINGROUP(145, _, _, qdss_gpio, _, _, _, _, _, _),
> +	[146] = PINGROUP(146, _, _, _, _, _, _, _, _, _),
> +	[147] = PINGROUP(147, _, _, _, _, _, _, _, _, _),
> +	[148] = PINGROUP(148, coex_uart1_rx, qdss_gpio, atest_usb, _, _, _, _, _, _),
> +	[149] = PINGROUP(149, coex_uart1_tx, qdss_gpio, atest_usb, _, _, _, _, _, _),
> +	[150] = PINGROUP(150, coex_uart2_rx, _, vfr_0, qdss_gpio, _, _, _, _, _),
> +	[151] = PINGROUP(151, coex_uart2_tx, _, qdss_gpio, _, _, _, _, _, _),
> +	[152] = PINGROUP(152, _, qdss_gpio, _, _, _, _, _, _, _),
> +	[153] = PINGROUP(153, _, nav_gpio2, qdss_gpio, _, _, _, _, _, _),
> +	[154] = PINGROUP(154, nav_gpio0, qdss_gpio, _, _, _, _, _, _, _),
> +	[155] = PINGROUP(155, nav_gpio1, vfr_1, qdss_gpio, _, _, _, _, _, _),
> +	[156] = PINGROUP(156, qlink0_request, qdss_gpio, _, _, _, _, _, _, _),
> +	[157] = PINGROUP(157, qlink0_enable, qdss_gpio, _, _, _, _, _, _, _),
> +	[158] = PINGROUP(158, qlink0_wmss, _, _, _, _, _, _, _, _),
> +	[159] = PINGROUP(159, qlink1_request, qdss_cti, _, _, _, _, _, _, _),
> +	[160] = PINGROUP(160, qlink1_enable, qdss_cti, _, _, _, _, _, _, _),
> +	[161] = PINGROUP(161, qlink1_wmss, qdss_cti, _, _, _, _, _, _, _),
> +	[162] = PINGROUP(162, qlink2_request, qdss_cti, _, _, _, _, _, _, _),
> +	[163] = PINGROUP(163, qlink2_enable, _, _, _, _, _, _, _, _),
> +	[164] = PINGROUP(164, qlink2_wmss, _, _, _, _, _, _, _, _),
> +	[165] = PINGROUP(165, _, _, _, _, _, _, _, _, _),
> +	[166] = PINGROUP(166, _, _, _, _, _, _, _, _, _),
> +	[167] = PINGROUP(167, _, _, _, _, _, _, _, _, _),
> +	[168] = PINGROUP(168, _, _, _, _, _, _, _, _, _),
> +	[169] = PINGROUP(169, _, _, _, _, _, _, _, _, _),
> +	[170] = PINGROUP(170, _, _, _, _, _, _, _, _, _),
> +	[171] = PINGROUP(171, _, _, _, _, _, _, _, _, _),
> +	[172] = PINGROUP(172, _, _, _, _, _, _, _, _, _),
> +	[173] = PINGROUP(173, _, _, _, _, _, _, _, _, _),
> +	[174] = PINGROUP(174, _, _, _, _, _, _, _, _, _),
> +	[175] = PINGROUP(175, _, _, _, _, _, _, _, _, _),
> +	[176] = PINGROUP(176, _, _, _, _, _, _, _, _, _),
> +	[177] = PINGROUP(177, _, _, _, _, _, _, _, _, _),
> +	[178] = PINGROUP(178, _, _, _, _, _, _, _, _, _),
> +	[179] = PINGROUP(179, _, _, _, _, _, _, _, _, _),
> +	[180] = PINGROUP(180, _, _, _, _, _, _, _, _, _),
> +	[181] = PINGROUP(181, prng_rosc3, _, _, _, _, _, _, _, _),
> +	[182] = PINGROUP(182, prng_rosc2, _, _, _, _, _, _, _, _),
> +	[183] = PINGROUP(183, prng_rosc1, _, _, _, _, _, _, _, _),
> +	[184] = PINGROUP(184, _, _, _, _, _, _, _, _, _),
> +	[185] = PINGROUP(185, _, _, _, _, _, _, _, _, _),
> +	[186] = PINGROUP(186, prng_rosc0, _, _, _, _, _, _, _, _),
> +	[187] = PINGROUP(187, cri_trng, _, _, _, _, _, _, _, _),
> +	[188] = PINGROUP(188, _, _, _, _, _, _, _, _, _),
> +	[189] = PINGROUP(189, _, _, _, _, _, _, _, _, _),
> +	[190] = PINGROUP(190, _, _, _, _, _, _, _, _, _),
> +	[191] = PINGROUP(191, _, _, _, _, _, _, _, _, _),
> +	[192] = PINGROUP(192, _, _, _, _, _, _, _, _, _),
> +	[193] = PINGROUP(193, _, _, _, _, _, _, _, _, _),
> +	[194] = PINGROUP(194, _, _, _, _, _, _, _, _, _),
> +	[195] = PINGROUP(195, _, _, _, _, _, _, _, _, _),
> +	[196] = PINGROUP(196, _, _, _, _, _, _, _, _, _),
> +	[197] = PINGROUP(197, _, _, _, _, _, _, _, _, _),
> +	[198] = PINGROUP(198, _, _, _, _, _, _, _, _, _),
> +	[199] = PINGROUP(199, _, _, _, _, _, _, _, _, _),
> +	[200] = PINGROUP(200, _, _, _, _, _, _, _, _, _),
> +	[201] = PINGROUP(201, _, _, _, _, _, _, _, _, _),
> +	[202] = PINGROUP(202, _, _, _, _, _, _, _, _, _),
> +	[203] = PINGROUP(203, _, _, _, _, _, _, _, _, _),
> +	[204] = PINGROUP(204, _, _, _, _, _, _, _, _, _),
> +	[205] = PINGROUP(205, _, _, _, _, _, _, _, _, _),
> +	[206] = PINGROUP(206, i2chub0_se8, _, _, _, _, _, _, _, _),
> +	[207] = PINGROUP(207, i2chub0_se8, _, _, _, _, _, _, _, _),
> +	[208] = PINGROUP(208, aon_cci, _, _, _, _, _, _, _, _),
> +	[209] = PINGROUP(209, aon_cci, _, _, _, _, _, _, _, _),
> +	[210] = UFS_RESET(ufs_reset, 0xde000),
> +	[211] = SDC_QDSD_PINGROUP(sdc2_clk, 0xd6000, 14, 6),
> +	[212] = SDC_QDSD_PINGROUP(sdc2_cmd, 0xd6000, 11, 3),
> +	[213] = SDC_QDSD_PINGROUP(sdc2_data, 0xd6000, 9, 0),
> +};
> +
> +static const struct msm_gpio_wakeirq_map sm8550_pdc_map[] = {
> +	{ 0, 118 },   { 2, 90 },    { 3, 101 },   { 8, 60 },    { 9, 67 },
> +	{ 11, 103 },  { 14, 136 },  { 15, 78 },   { 16, 138 },  { 17, 80 },
> +	{ 18, 71 },   { 19, 59 },   { 25, 57 },   { 26, 74 },   { 27, 76 },
> +	{ 28, 62 },   { 31, 88 },   { 32, 63 },   { 35, 124 },  { 39, 92 },
> +	{ 40, 77 },   { 41, 83 },   { 43, 86 },   { 44, 75 },   { 45, 93 },
> +	{ 46, 96 },   { 47, 64 },   { 48, 110 },  { 51, 89 },   { 55, 95 },
> +	{ 56, 68 },   { 59, 87 },   { 60, 65 },   { 62, 100 },  { 63, 81 },
> +	{ 67, 79 },   { 71, 102 },  { 73, 82 },   { 75, 72 },   { 79, 140 },
> +	{ 82, 105 },  { 83, 104 },  { 84, 126 },  { 85, 142 },  { 86, 106 },
> +	{ 87, 107 },  { 88, 61 },   { 89, 111 },  { 95, 108 },  { 96, 109 },
> +	{ 98, 97 },   { 99, 58 },   { 107, 139 }, { 119, 94 },  { 120, 135 },
> +	{ 133, 52 },  { 137, 84 },  { 148, 66 },  { 150, 73 },  { 153, 70 },
> +	{ 154, 53 },  { 155, 69 },  { 156, 54 },  { 159, 55 },  { 162, 56 },
> +	{ 166, 116 }, { 169, 119 }, { 171, 120 }, { 172, 85 },  { 174, 98 },
> +	{ 176, 112 }, { 177, 51 },  { 181, 114 }, { 182, 115 }, { 185, 117 },
> +	{ 187, 91 },  { 188, 123 }, { 190, 127 }, { 191, 113 }, { 192, 128 },
> +	{ 193, 129 }, { 196, 133 }, { 197, 134 }, { 198, 50 },  { 199, 99 },
> +	{ 200, 49 },  { 201, 48 },  { 203, 125 }, { 205, 141 }, { 206, 137 },
> +	{ 207, 47 },  { 208, 121 }, { 209, 122 },
> +};
> +
> +static const struct msm_pinctrl_soc_data sm8550_tlmm = {
> +	.pins = sm8550_pins,
> +	.npins = ARRAY_SIZE(sm8550_pins),
> +	.functions = sm8550_functions,
> +	.nfunctions = ARRAY_SIZE(sm8550_functions),
> +	.groups = sm8550_groups,
> +	.ngroups = ARRAY_SIZE(sm8550_groups),
> +	.ngpios = 211,
> +	.wakeirq_map = sm8550_pdc_map,
> +	.nwakeirq_map = ARRAY_SIZE(sm8550_pdc_map),
> +	.egpio_func = 9,
> +};
> +
> +static int sm8550_tlmm_probe(struct platform_device *pdev)
> +{
> +	return msm_pinctrl_probe(pdev, &sm8550_tlmm);
> +}
> +
> +static const struct of_device_id sm8550_tlmm_of_match[] = {
> +	{ .compatible = "qcom,sm8550-tlmm", },
> +	{},
> +};
> +
> +static struct platform_driver sm8550_tlmm_driver = {
> +	.driver = {
> +		.name = "sm8550-tlmm",
> +		.of_match_table = sm8550_tlmm_of_match,
> +	},
> +	.probe = sm8550_tlmm_probe,
> +	.remove = msm_pinctrl_remove,
> +};
> +
> +static int __init sm8550_tlmm_init(void)
> +{
> +	return platform_driver_register(&sm8550_tlmm_driver);
> +}
> +arch_initcall(sm8550_tlmm_init);
> +
> +static void __exit sm8550_tlmm_exit(void)
> +{
> +	platform_driver_unregister(&sm8550_tlmm_driver);
> +}
> +module_exit(sm8550_tlmm_exit);
> +
> +MODULE_DESCRIPTION("QTI SM8550 TLMM driver");
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(of, sm8550_tlmm_of_match);
