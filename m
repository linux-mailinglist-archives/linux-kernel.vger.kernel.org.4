Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8073F6C1B42
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjCTQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjCTQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:21:37 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4862C132F6;
        Mon, 20 Mar 2023 09:14:19 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KF4Yt6019970;
        Mon, 20 Mar 2023 17:13:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=NgXwip3o4wXvf5NxUnDvu10B6XH84zMDeQuJvYMe7Vg=;
 b=K9zLZUzMadtdLq2tG/MTTTVQfBEic3JY21LeF+gOr89GdIgdZH8EOLeQSSthS7VGhcSv
 Uo8kxadvOjMJ8gAmqRJulD0dRgNn8IeXhqb8NvGzifjLd0Uee2cKwHWc8l80cd0ygVVx
 gNQW/ULIcHGc1HqW0iqMKxfOSH/B/VFc+Ns/hfNk9pl/B+mH4KYETXOY4nWIixVeb8bP
 cYDVo1myfPxdzylphr88capYzDlMTYqgSDkE2UyxWXoGlOZUvL15uCJ1yAH2uWDp7BPb
 Yt+mXJJ+C7nOBn/ETUzIXkeM/D1qIUzS3uHD6BaAhJ6egDwYV2GD2FXViTthZkCTtz9b LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pekqx3bh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 17:13:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D7D610002A;
        Mon, 20 Mar 2023 17:13:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 276AB216EFE;
        Mon, 20 Mar 2023 17:13:56 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 20 Mar
 2023 17:13:55 +0100
Message-ID: <37b5bf6c-c290-1283-1dca-6e8fdbf7f430@foss.st.com>
Date:   Mon, 20 Mar 2023 17:13:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1] ARM: dts: stm32: Add coprocessor detach mbox on
 stm32mp15xx-osd32 SoM
Content-Language: en-US
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <kernel@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230310092650.1007662-1-l.goehrs@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230310092650.1007662-1-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_13,2023-03-20_02,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard

On 3/10/23 10:26, Leonard Göhrs wrote:
> To support the detach feature, add a new mailbox channel to inform
> the remote processor on a detach. This signal allows the remote processor
> firmware to stop IPC communication and to reinitialize the resources for
> a re-attach.
> 
> See 6257dfc1c412dcdbd76ca5fa92c8444222dbe5b0 for a patch that does the
> same for stm32mp15x-dkx boards.
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>   arch/arm/boot/dts/stm32mp15xx-osd32.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> index 935b7084b5a2..a43965c86fe8 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> @@ -210,8 +210,8 @@ &ipcc {
>   &m4_rproc {
>   	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
>   			<&vdev0vring1>, <&vdev0buffer>;
> -	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
> -	mbox-names = "vq0", "vq1", "shutdown";
> +	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>, <&ipcc 3>;
> +	mbox-names = "vq0", "vq1", "shutdown", "detach";
>   	interrupt-parent = <&exti>;
>   	interrupts = <68 1>;
>   	status = "okay";
> 

Applied on stm32-next.

Thanks.
Alex

> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6

