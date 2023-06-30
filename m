Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523DB743F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjF3QJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjF3QJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:09:16 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8119E199B;
        Fri, 30 Jun 2023 09:09:13 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 51004120008;
        Fri, 30 Jun 2023 18:59:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 51004120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688140782;
        bh=AiyUTaQfmfU+3VE/gItxQHz0hqpdNFW3IG8wVLoP4yk=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=TDONc09uuAn5/UWTB1FWrYRyUvL7jmXbwYuwdSAbrBmKMbb1wfcUI9HyPEb6CBcIw
         5LUEv9RmIIhvKc4ksj8gBqOdg0g9+KqzND3XXG52kUcLFjkcEMBiHL8SOpTO6jiolP
         A/TNfVr7MHf+JBxqmmkKDADHkOpBSftaEMXpiCfZVxKOawYCJ3Z1aO+TmvBhhiAXpK
         T9PBrLPKMapUG06U6iocsPHobeuSntZx1QIQrgXjJFyGLVi1tiYaN+bQfjkaMfXSwc
         gLe+QxkogBIFGURQWDO2lq+J+oB7yITkG37w591xO4UaNJGFPvUpsxRXjDkk+m2F5m
         On1WGeqxGffFA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 30 Jun 2023 18:59:41 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 30 Jun
 2023 18:59:26 +0300
Date:   Fri, 30 Jun 2023 18:59:39 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     zelong dong <zelong.dong@amlogic.com>
CC:     <narmstrong@baylibre.com>, <p.zabel@pengutronix.de>,
        <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
        <martin.blumenstingl@googlemail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <jbrunet@baylibre.com>,
        <devicetree@vger.kernel.org>, <kelvin.zhang@amlogic.com>
Subject: Re: [PATCH 2/3] reset: reset-meson: add support for the Meson-C3 SoC
 Reset Controller
Message-ID: <20230630155939.l2natpf5nbusjoq6@CAB-WSD-L081021>
References: <20230630121059.28748-1-zelong.dong@amlogic.com>
 <20230630121059.28748-3-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230630121059.28748-3-zelong.dong@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178380 [Jun 30 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;lists.infradead.org:7.1.1;sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/06/30 14:28:00
X-KSMG-LinksScanning: Clean, bases: 2023/06/30 14:28:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/30 12:24:00 #21606311
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 08:10:58PM +0800, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add a new compatible string to support for the reset controller
> on the C3 SoC. The count and offset for C3 Soc RESET registers are
> same as S4 Soc.
> 
> Change-Id: I65113f6a90545cd46015abf60b4bcb63fa148267
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

> ---
>  drivers/reset/reset-meson.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 13878ca2779d..ee1d5caf0ee4 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -109,6 +109,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
>  	 { .compatible = "amlogic,meson-axg-reset",  .data = &meson8b_param},
>  	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
>  	 { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
> +	 { .compatible = "amlogic,meson-c3-reset",   .data = &meson_s4_param},
>  	 { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
