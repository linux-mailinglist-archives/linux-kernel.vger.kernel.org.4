Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51172D073
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbjFLU1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFLU1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:27:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D210CE;
        Mon, 12 Jun 2023 13:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686601648; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dKK6kjE1B9fmBToDUA2Af/B1GpTk1veKlKpNTto1m4ynYjY0yFQkpmHseD//1KTuF0
    r9qt1IUJAcvkx3nA/5EGZ3SmYITvXQbIXrcaL7N5wqeC30HL/FVhRzuJokBzfaxCMGWP
    c8kZUWccP13DlGPpuTS7ldPeTYMgZZvs7oJWqJe/yKAHsdcAfTlcCyjv9s8YW9os4Jh5
    tv8jLWaKSKoXgT6RO4NGZ95xU1SmE6PfxuNdrJg4plWx2aLiXF3Hsi3bpdjHLFJ9Q062
    rLV3jPIs4H7gDeyus5aWcsi23ytqDr+pC50GJElzaXu+sXE3HuUn6mp3pYFIp8FXHVfP
    Mf5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686601648;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+/8pzuF1RImyxQe66AcePgrM+A8lzFkbVzl6+XoBoOY=;
    b=kBjyXkWOpnWADPjnl4OFtW/eMTVANOKXEuhK1gc/nXZQ5cVEZYRH0tsUGI9m8N9aWx
    V4P0y3LA9CyRmA0AW5KOOkjZtFZIk4HNW7erxJLUf5nQ2774hTe9z6SC5BkBZYyawgKR
    XtxZjm/bEBb1X8DeRpo9zVar6RudAuthqurfNbnNERFr3evKiyrJQf8I5btVI8mIJday
    ofYbQAFxBnexKG5K1E9lU2SlITqNxTDPKrohO2laybB7Y4VEEhfBrUAAkpnogvUKK7I7
    Aqd/5pwv/qh/YHwsC37LwQxbBU1YgTAQezoCvnjh3JPyuDF/6XI1M+ch49eKcbLQVPZz
    cvdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686601648;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+/8pzuF1RImyxQe66AcePgrM+A8lzFkbVzl6+XoBoOY=;
    b=pKjldxal4PRRIJ+9ul9M6EeretRV+TYTtRw3kcITbSUonTvsSUVZLxC4W/ZFAG92A/
    x+7AnDxKqmo2EfKPVSQ/5shuGvkorvViLkn9ZSI0E2GWiP61n0YkBYfxdR7I+4BgC1NL
    yVCEE0KmNJX6LKGHOkfRO0ZkiUTGLt0gpdnMg1TF0WFpL1QiYNGfWUGL2mGoytf+JAGx
    YPbugP++A1FXH5rpWzjEHmGpWccK31gf2QTyBXJn45kuOmdqeoI9xGgfW/3rpcv+pasb
    eQp3fuNnz+ut1tz3aggEg+2ysNCtiM+i1cFENZi9BvfbNOqMGVw1gQBtzhKfSgL6p7M8
    wi3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686601648;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+/8pzuF1RImyxQe66AcePgrM+A8lzFkbVzl6+XoBoOY=;
    b=PL8zx/bkOEbcc6BWEnW8D/sGpkdcfIjr/oBX8siNMwvdaso5zth69I7c1G6y1EaSya
    HrQou0LEwrGk7Ha5NmBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8peN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5CKRSVyQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Jun 2023 22:27:28 +0200 (CEST)
Date:   Mon, 12 Jun 2023 22:27:20 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 07/23] interconnect: qcom: icc-rpm: Allow negative QoS
 offset
Message-ID: <ZId_qIAL8dvJOwai@gerhold.net>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
 <20230526-topic-smd_icc-v3-7-5fb7d39b874f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v3-7-5fb7d39b874f@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 08:24:24PM +0200, Konrad Dybcio wrote:
> In some very very very very unfortunate cases, the correct offset of
> the QoS registers will be.. negative. One such case is MSM8998, where
> The DDR BWMON occupies what-would-be-the-BIMC-base which we usually
> take into account with the register calculation, making the actual
> BIMC node start at what-would-be-the-BIMC-base+0x300.
> 
> In order to keep the calculation code sane, the simplest - however
> ugly it may be - solution is to allow the offset to be negative.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I'm a bit confused why this patch is part of this series. It doesn't
seem to be directly related.

Can you send it as part of the series that adds the MSM8998 interconnect
driver?

Thanks,
Stephan

> ---
>  drivers/interconnect/qcom/icc-rpm.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index d2c04c400cad..ba840a436cc0 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -29,10 +29,10 @@ enum qcom_icc_type {
>   * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
>   * @type: the ICC provider type
>   * @regmap: regmap for QoS registers read/write access
> - * @qos_offset: offset to QoS registers
>   * @bus_clk_rate: bus clock rate in Hz
>   * @bus_clks: the clk_bulk_data table of bus clocks
>   * @intf_clks: a clk_bulk_data array of interface clocks
> + * @qos_offset: offset to QoS registers
>   * @keep_alive: whether to always keep a minimum vote on the bus clocks
>   * @is_on: whether the bus is powered on
>   */
> @@ -42,7 +42,7 @@ struct qcom_icc_provider {
>  	int num_intf_clks;
>  	enum qcom_icc_type type;
>  	struct regmap *regmap;
> -	unsigned int qos_offset;
> +	int qos_offset;
>  	u64 bus_clk_rate[NUM_BUS_CLKS];
>  	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
>  	struct clk_bulk_data *intf_clks;
> @@ -108,7 +108,7 @@ struct qcom_icc_desc {
>  	bool no_clk_scaling;
>  	enum qcom_icc_type type;
>  	const struct regmap_config *regmap_cfg;
> -	unsigned int qos_offset;
> +	int qos_offset;
>  };
>  
>  /* Valid for all bus types */
> 
> -- 
> 2.41.0
> 
