Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7255B68D335
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjBGJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjBGJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:48:18 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E2F61BDC;
        Tue,  7 Feb 2023 01:48:14 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(17225:0:AUTH_RELAY)
        (envelope-from <chiaen_wu@richtek.com>); Tue, 07 Feb 2023 17:47:58 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Tue, 7 Feb
 2023 17:47:58 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Tue, 7 Feb 2023 17:47:58 +0800
Date:   Tue, 7 Feb 2023 17:47:58 +0800
From:   ChiaEn Wu <chiaen_wu@richtek.com>
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterwu.pub@gmail.com>
Subject: Re: [PATCH][next] power: supply: rt9467: Fix spelling mistake
 "attache" -> "attach"
Message-ID: <20230207094758.GA17541@linuxcarl2.richtek.com>
References: <20230206091742.45977-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206091742.45977-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 09:17:42AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
Hi,
It's really typo. Thanks!

Reviewed-by: ChiaEn Wu <chiaen_wu@richtek.com>

Best regards,
ChiaEn Wu

>  drivers/power/supply/rt9467-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
> index 96ad0d7d3af4..73f744a3155d 100644
> --- a/drivers/power/supply/rt9467-charger.c
> +++ b/drivers/power/supply/rt9467-charger.c
> @@ -970,7 +970,7 @@ static irqreturn_t rt9467_usb_state_handler(int irq, void *priv)
>  
>  	ret = rt9467_report_usb_state(data);
>  	if (ret) {
> -		dev_err(data->dev, "Failed to report attache type (%d)\n", ret);
> +		dev_err(data->dev, "Failed to report attach type (%d)\n", ret);
>  		return IRQ_NONE;
>  	}
>  
> -- 
> 2.30.2
> 
