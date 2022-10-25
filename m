Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D261560C3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiJYGgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJYGf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:35:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8DD57D9;
        Mon, 24 Oct 2022 23:35:50 -0700 (PDT)
X-UUID: ccebf7460a9a45168cbc4bdc435dc7b0-20221025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID; bh=CfnTvI4GdsO3+FNOnQzLcJsES3nFkH0SLT+tjy22q1s=;
        b=SzizaYfA8XJzbvIk7BvYYJEc14oPI3xq5b7ZlVdO3D9aYwlTN5h/+2Qx4dBk7m/ph5lat3o4NrzSkKJWS8/zHoK00v1p3FTU+sepLemrA9oLsvbYIE4IW/kZD+qoZH5OQSjZfGd8Huo61nWMNaOiu9q7qGs/p6Kc9HYI1NIbYCw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:02ad6422-a7d0-4992-986b-602297c1141a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.12,REQID:02ad6422-a7d0-4992-986b-602297c1141a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:62cd327,CLOUDID:5ea394e4-e572-4957-be22-d8f73f3158f9,B
        ulkID:2210251435453GLI2UE9,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0
X-UUID: ccebf7460a9a45168cbc4bdc435dc7b0-20221025
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 639325440; Tue, 25 Oct 2022 14:35:44 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 25 Oct 2022 14:35:43 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 25 Oct 2022 14:35:43 +0800
Message-ID: <b5ab84b4d595713588f1d8a68a1585ca3ae5521e.camel@mediatek.com>
Subject: Re: [PATCH 1/2] pwm: mediatek: Add support for MT7986
From:   Sam Shih <sam.shih@mediatek.com>
To:     Daniel Golle <daniel@makrotopia.org>, <linux-pwm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Tue, 25 Oct 2022 14:35:43 +0800
In-Reply-To: <Y1K5ym1EL8kwzQEt@makrotopia.org>
References: <Y1K5ym1EL8kwzQEt@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel:

On Fri, 2022-10-21 at 16:24 +0100, Daniel Golle wrote:
> Add support for PWM on MT7986 which has 2 PWM channels, one of them
> is
> typically used for a temperature controlled fan.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/pwm/pwm-mediatek.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 6901a44dc428de..2219cba033e348 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -329,6 +329,12 @@ static const struct pwm_mediatek_of_data
> mt8365_pwm_data = {
>  	.has_ck_26m_sel = true,
>  };
>  
> +static const struct pwm_mediatek_of_data mt7986_pwm_data = {
> +	.num_pwms = 2,
> +	.pwm45_fixup = false,
> +	.has_ck_26m_sel = true,

For MT7986 SoC, I think the value of "has_ck_26m_sel" should be 'false' 

> +};
> +
>  static const struct pwm_mediatek_of_data mt8516_pwm_data = {
>  	.num_pwms = 5,
>  	.pwm45_fixup = false,
> @@ -342,6 +348,7 @@ static const struct of_device_id
> pwm_mediatek_of_match[] = {
>  	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data
> },
>  	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data
> },
>  	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data
> },
> +	{ .compatible = "mediatek,mt7986-pwm", .data = &mt7986_pwm_data
> },
>  	{ .compatible = "mediatek,mt8183-pwm", .data = &mt8183_pwm_data
> },
>  	{ .compatible = "mediatek,mt8365-pwm", .data = &mt8365_pwm_data
> },
>  	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data
> },

Regards,
Sam

