Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16C95B5AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiILNQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiILNQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:16:58 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E2A2ED4B;
        Mon, 12 Sep 2022 06:16:56 -0700 (PDT)
Date:   Mon, 12 Sep 2022 13:16:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1662988614; x=1663247814;
        bh=PXpCeWIfMU0thXVU09ToJCINLqrrKacA/FW/4oxbc8A=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=fTh5g8Q84ATF3Ju1R5afljQ9UbiQFHZEEKXn0n6gkx0UMbQ+SKpLmHL2AG47z52gU
         TNZFPrasBxMwm+6qAzVKBpnMEbwPXZmbTIMY0BEdy+Ey/r+TtRQqO+sM7Jru69Snae
         +nGp8RqdMdaGM95qDvxIyvs7+ZPh5NR24lwdaNCQ=
To:     Dang Huynh <danct12@riseup.net>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH] clk: qcom: sm6115: Select QCOM_GDSC
Message-ID: <0a2bb48f-c67d-0544-5037-d02f658a3351@connolly.tech>
In-Reply-To: <20220910170207.1592220-1-danct12@riseup.net>
References: <20220910170207.1592220-1-danct12@riseup.net>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2022 18:02, Dang Huynh wrote:
> While working on the Fxtec Pro1X device, this error shows up with
> my own minimal configuration:
>
> gcc-sm6115: probe of 1400000.clock-controller failed with error -38
>
> The clock driver depends on CONFIG_QCOM_GDSC and after enabling
> that, the driver probes successfully.
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>   drivers/clk/qcom/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 1cf1ef70e347..d566fbdebdf9 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -645,6 +645,7 @@ config SM_DISPCC_6350
>
>   config SM_GCC_6115
>   =09tristate "SM6115 and SM4250 Global Clock Controller"
> +=09select QCOM_GDSC

=09depends on QCOM_GDSC
>   =09help
>   =09  Support for the global clock controller on SM6115 and SM4250 devic=
es.
>   =09  Say Y if you want to use peripheral devices such as UART, SPI,
> --
> 2.37.3
>

--
Kind Regards,
Caleb

