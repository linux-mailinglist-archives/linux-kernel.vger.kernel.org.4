Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D7360D811
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiJYXk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiJYXjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:39:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB234205FF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666741169; x=1698277169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8qfNjTBYtwUau4In3Tab02Lmv40rKbP02BTtD+Q5E/Y=;
  b=rc7P6kFu6lgNnCxTorAHQoWz9SLZ/t+Jl17VghGTR2/Lb37WNi8ihd+8
   1tW0+bexxYW16asMQYSzmTugh4Ve8ptWS66Op6ZFqZqQ4Bt7MEEPKOEzw
   VHDhpjlE7c6rdjuQRMsEXV8mYHIsHftK8ZRcnWRPH0jJ5lku33Dy9rl93
   evtqopxrQXjVZ7Zp9+HlsOjQ9MJJcRJLTuaOlMZcGFXEWVdCcLKNqM16o
   1jytS8fNO/pG6KB5eqC97cePuuRxgHB4ajv6Jvk+4AydMQjlq8/wiiUIC
   KrCqo6S+bbC0jY4BdyyNDgYqAOJjX3qerkJSIFDno886wHTJAJixxTpTN
   g==;
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="197039100"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 16:39:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 16:39:25 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 25 Oct 2022 16:39:25 -0700
Date:   Wed, 26 Oct 2022 01:44:05 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <srinivas.kandagatla@linaro.org>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmem: lan9662-otp: fix compatible name
Message-ID: <20221025234405.wr3copoyi4mj472t@soft-dev3-1>
References: <20221025072217.3715634-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20221025072217.3715634-1-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/25/2022 10:22, Claudiu Beznea wrote:

Hi Claudiu,

> Documentation of lan9662-otpc driver (namely Documentation/\
> devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml) express that
> compatible for this driver contains "otpc" string at the end but not "otp"
> as currently present. Fix this typo.

Thanks for this patch.
I have also sent a patch for this some time ago[1], but there
is no reply on this.

Anyway for this patch:

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

[1] https://patchew.org/linux/20220928195112.630351-1-horatiu.vultur@microchip.com/

> 
> Fixes: 9e8f208ad522 ("nvmem: lan9662-otp: add support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/nvmem/lan9662-otpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
> index f6732fd216d8..377bf34c2946 100644
> --- a/drivers/nvmem/lan9662-otpc.c
> +++ b/drivers/nvmem/lan9662-otpc.c
> @@ -203,7 +203,7 @@ static int lan9662_otp_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id lan9662_otp_match[] = {
> -	{ .compatible = "microchip,lan9662-otp", },
> +	{ .compatible = "microchip,lan9662-otpc", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, lan9662_otp_match);
> -- 
> 2.34.1
> 

-- 
/Horatiu
