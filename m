Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28446730F04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjFOGEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbjFOGD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:03:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4DA26B0;
        Wed, 14 Jun 2023 23:03:25 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F5SG37012701;
        Thu, 15 Jun 2023 06:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=PJ/1Znm3xPH4qhX7g21KCyUELVzb7W7eFMUpfPfTkLg=;
 b=afq9XVM/TAowO+AL03ycwTc9tDxivEKnwqGnHXjiCW0mzOkak/I5GqdoDbHshH71EqAp
 TbQy66ClRSzS3XHEaFm8U8S8j4TjZLLyCRFIeLlAHORO4ZzBfJKtrRjIxA1Tkk+Mq9l9
 3tC7AVtBLXybZ017hOsDuDkRDtfhgw7Cc6RKNFKSR5nvyRP684jB06pt5+FQSv1ZPZQr
 asMjnUQg5kenNePwOA2NmqZJYHrBs0WxLcc0y9N2+op/CrBBTEeb9WKqCP3oe6isnZex
 HLUGOLgASBNme/PY6N2F4KsDwGNS7zNwCkJOdXfB5UP2mVSh6dNt36WF3ywkJVI5t2Kp TA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7auy2a58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 06:02:59 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F62wRv018823
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 06:02:58 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 23:02:49 -0700
Date:   Thu, 15 Jun 2023 11:32:40 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 4/9] clk: qcom: ipq5332: Fix USB related clock defines
Message-ID: <20230615060239.GE22186@varda-linux.qualcomm.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <3840e5b5795ef55ecbf25d0faa8c328f09c6d976.1686126439.git.quic_varada@quicinc.com>
 <87810fde-c824-d494-17b3-b6ff34237bea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87810fde-c824-d494-17b3-b6ff34237bea@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZbI92rQll4LM-qgKjLMcu-NqYmH-ri1Q
X-Proofpoint-GUID: ZbI92rQll4LM-qgKjLMcu-NqYmH-ri1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_03,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=986
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:19:09PM +0300, Dmitry Baryshkov wrote:
> On 07/06/2023 13:56, Varadarajan Narayanan wrote:
> >Fix the USB related clock defines and add details
> >referenced by them
> >
> >Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >---
> >  drivers/clk/qcom/gcc-ipq5332.c | 34 +++++++++++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 11 deletions(-)
> >
> >diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> >index a75ab88..2b58558 100644
> >--- a/drivers/clk/qcom/gcc-ipq5332.c
> >+++ b/drivers/clk/qcom/gcc-ipq5332.c
> >@@ -351,6 +351,16 @@ static const struct freq_tbl ftbl_gcc_adss_pwm_clk_src[] = {
> >  	{ }
> >  };
> >+static const struct clk_parent_data gcc_usb3phy_0_cc_pipe_clk_xo[] = {
> >+	{ .fw_name = "usb3phy_0_cc_pipe_clk" },
> >+	{ .fw_name = "xo" },
>
> gcc-ipq5332 uses DT indices, please don't mix that with .fw_name.
>
> >+};
> >+
> >+static const struct parent_map gcc_usb3phy_0_cc_pipe_clk_xo_map[] = {
> >+	{ P_USB3PHY_0_PIPE, 0 },
> >+	{ P_XO, 2 },
> >+};
> >+
> >  static struct clk_rcg2 gcc_adss_pwm_clk_src = {
> >  	.cmd_rcgr = 0x1c004,
> >  	.mnd_width = 0,
> >@@ -1101,16 +1111,18 @@ static struct clk_rcg2 gcc_usb0_mock_utmi_clk_src = {
> >  	},
> >  };
> >-static struct clk_regmap_phy_mux gcc_usb0_pipe_clk_src = {
> >+static struct clk_regmap_mux usb0_pipe_clk_src = {
> >  	.reg = 0x2c074,
> >+	.shift = 8,
> >+	.width = 2,
> >+	.parent_map = gcc_usb3phy_0_cc_pipe_clk_xo_map,
> >  	.clkr = {
> >-		.hw.init = &(struct clk_init_data) {
> >-			.name = "gcc_usb0_pipe_clk_src",
> >-			.parent_data = &(const struct clk_parent_data) {
> >-				.index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
> >-			},
> >-			.num_parents = 1,
> >-			.ops = &clk_regmap_phy_mux_ops,
> >+		.hw.init = &(const struct clk_init_data){
> >+			.name = "usb0phy_0_cc_pipe_clk_src",
> >+			.parent_data = gcc_usb3phy_0_cc_pipe_clk_xo,
> >+			.num_parents = 2,
> >+			.ops = &clk_regmap_mux_closest_ops,
> >+			.flags = CLK_SET_RATE_PARENT,
> >  		},
>
> Soo... As you are reverting this. Is USB0 PIPE clock required to be parked
> to the XO? I was going to write 'before turning USB0_GDSC' off, but then I
> noticed that gcc-ipq5332 doesn't declare GDSCs. Does this platform have
> GDSCs?
>
> >  	},
> >  };
> >@@ -3041,8 +3053,8 @@ static struct clk_branch gcc_usb0_pipe_clk = {
> >  		.enable_mask = BIT(0),
> >  		.hw.init = &(const struct clk_init_data) {
> >  			.name = "gcc_usb0_pipe_clk",
> >-			.parent_hws = (const struct clk_hw*[]) {
> >-				&gcc_usb0_pipe_clk_src.clkr.hw,
> >+			.parent_names = (const char *[]){
> >+				"usb0_pipe_clk_src"
>
> complete and definitive NAK. Do not use parent_names, we have just stopped
> migrating from them.

Will drop changes to this file and post a new patch.

Thanks
Varada
> >  			},
> >  			.num_parents = 1,
> >  			.flags = CLK_SET_RATE_PARENT,
> >@@ -3580,7 +3592,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
> >  	[GCC_PCIE3X2_PIPE_CLK_SRC] = &gcc_pcie3x2_pipe_clk_src.clkr,
> >  	[GCC_PCIE3X1_0_PIPE_CLK_SRC] = &gcc_pcie3x1_0_pipe_clk_src.clkr,
> >  	[GCC_PCIE3X1_1_PIPE_CLK_SRC] = &gcc_pcie3x1_1_pipe_clk_src.clkr,
> >-	[GCC_USB0_PIPE_CLK_SRC] = &gcc_usb0_pipe_clk_src.clkr,
> >+	[GCC_USB0_PIPE_CLK_SRC] = &usb0_pipe_clk_src.clkr,
> >  };
> >  static const struct qcom_reset_map gcc_ipq5332_resets[] = {
>
> --
> With best wishes
> Dmitry
>
