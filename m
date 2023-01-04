Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A365CDE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjADHvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjADHuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:50:54 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7525AF60
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672818652; x=1704354652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DRe0onl7YTTCOkDpa9QQx6RzsX7z1YI7hLJ273ULKZU=;
  b=BbFjR2r3tWQfES5VvJkShVZssXex+BNzO0FGgN/Nd109qCD8MQaZUCEL
   JuHmqfC0KyiOfCsHj3m8MJfPdi8ZUlHSUB5V0+l+Wy3FuRfHYDy3frvl1
   mGsqQDKhCQ+qG4lijAfjtV5LXA3EQMHnhfeAitECbmW7/kOQTYgSZSzUH
   libTT30lp3t2WK5ObN5v1Rz9Kp2WAhyO2vw670y0IarXrv33mrYn09xNw
   DDkYc/2yo/ryjH4s8IQA2LlBWZtfW3NClOMlj9kpSBPJwbgWSzLtuDBU4
   JLTYT3+kIbNO7BScLYI24uuUEEi8bWQiTz6ieQsXEA/FrnV1m467O2Soo
   w==;
X-IronPort-AV: E=Sophos;i="5.96,299,1665439200"; 
   d="scan'208";a="28232829"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Jan 2023 08:50:49 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 04 Jan 2023 08:50:49 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 04 Jan 2023 08:50:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672818649; x=1704354649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DRe0onl7YTTCOkDpa9QQx6RzsX7z1YI7hLJ273ULKZU=;
  b=V/2kTp8lEwBUpeUrYLIlm+bhjsdFMfB2W16Rhgtjntdu0Ttvv9IyTNHp
   DFo0vRISzj+/FUu5W8b8fc/Ucu8ZsEI5ZemUekaDg1c7opFnJDTfHlRMO
   3PIDCMk1MPJJkuYQGoVMqkMCssRxSLAPDQMF5hjMIA+mwWEyUczZIoP/G
   cpE2lusKVL8+eQ9h925WDWr5U+ORXAAaDcNmQVCZKUcH+2DG9psYBAuh9
   hTvHdWvuFQGSMzfyVndScAJTFjraTQR5RtCg/jmjY20lky5BSPr2hcZlS
   HsHPTYbI9XBbN49qcXuB2JdOg12heLWZVznWPIT5hdnmm3PBIE1G/wNxF
   g==;
X-IronPort-AV: E=Sophos;i="5.96,299,1665439200"; 
   d="scan'208";a="28232828"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Jan 2023 08:50:49 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 7DB46280056;
        Wed,  4 Jan 2023 08:50:49 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, xiaolei.wang@windriver.com,
        l.stach@pengutronix.de, Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH] soc: imx8m: fix wrong return value check of of_clk_get_by_name()
Date:   Wed, 04 Jan 2023 08:50:47 +0100
Message-ID: <1882509.eGJsNajkDb@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230104064136.1695102-1-yangyingliang@huawei.com>
References: <20230104064136.1695102-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 4. Januar 2023, 07:41:36 CET schrieb Yang Yingliang:
> of_clk_get_by_name() never returns NULL pointer, it will return
> ERR_PTR() when it fails, so replace the check with IS_ERR().
> 
> Fixes: 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the
> register") Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 28144c699b0c..32ed9dc88e45 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -66,8 +66,8 @@ static u32 __init imx8mq_soc_revision(void)
>  	ocotp_base = of_iomap(np, 0);
>  	WARN_ON(!ocotp_base);
>  	clk = of_clk_get_by_name(np, NULL);
> -	if (!clk) {
> -		WARN_ON(!clk);
> +	if (IS_ERR(clk)) {

Nice catch. But wouldn't
> if (WARN_ON(IS_ERR(clk)))
be even better instead of doing the check twice?

Best regards,
Alexander

> +		WARN_ON(IS_ERR(clk));
>  		return 0;
>  	}




