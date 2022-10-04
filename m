Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0450D5F48C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJDRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJDRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:42:15 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741B7B7E6;
        Tue,  4 Oct 2022 10:42:13 -0700 (PDT)
Received: from [IPV6:2a00:f41:188c:1c74:b0eb:eb78:b659:16a2] (unknown [IPv6:2a00:f41:188c:1c74:b0eb:eb78:b659:16a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 62E923F479;
        Tue,  4 Oct 2022 19:42:10 +0200 (CEST)
Message-ID: <1d020f9b-c348-8875-b538-878db2838411@somainline.org>
Date:   Tue, 4 Oct 2022 19:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: [PATCH] clk: qcom: gcc-sm6375: Ensure unsigned long type
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev
References: <20221004172507.1599130-1-sboyd@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221004172507.1599130-1-sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/10/2022 19:25, Stephen Boyd wrote:
> This PLL frequency needs a UL postfix to avoid compiler warnings on
> 32-bit architectures.
>
> Fixes: 184fdd873d83 ("clk: qcom: Add global clock controller driver for SM6375")
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Not sure if this SoC can even boot 32bit kernels, however I like it for

the sake of correctness.


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>   drivers/clk/qcom/gcc-sm6375.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
> index a3188c462a8b..89a1cc90b145 100644
> --- a/drivers/clk/qcom/gcc-sm6375.c
> +++ b/drivers/clk/qcom/gcc-sm6375.c
> @@ -54,7 +54,7 @@ static struct pll_vco lucid_vco[] = {
>   };
>   
>   static struct pll_vco zonda_vco[] = {
> -	{ 595200000, 3600000000, 0 },
> +	{ 595200000, 3600000000UL, 0 },
>   };
>   
>   static struct clk_alpha_pll gpll0 = {
>
> base-commit: c3db5128e80e1437cb08d0d41aeb7163004897e7
> prerequisite-patch-id: eac168caa320346ed78dc95c27117106fc8dbc7f
