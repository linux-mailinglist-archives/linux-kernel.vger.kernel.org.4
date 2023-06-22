Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2DE73A8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjFVTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFVTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:02:25 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4072100;
        Thu, 22 Jun 2023 12:02:16 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D9D685FD1D;
        Thu, 22 Jun 2023 22:02:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687460534;
        bh=yqwFHUHVsnfkRLDg+tlWSM2fF7T9GBR3AoTi2RuucbA=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=ZyVUu9sawIlSc80T3PPczeJ9nWjxgxUWCED7U529qtl0aj8cLCC7m30XV7U6iMHl1
         wXtBYpQyxgY1Y5SVcH2n2dbxnvcyGAbwTk9NEQ0lVgQEca1j9nQ0UjbWVCGX7e16P4
         gZ0XogXRbbnywqxRgWNGR94SRieGsZNLzqwAICbQEzMXkLBADT66hQpqLKfe0ZknII
         z1mfiOOGfTqKH08ZqJ+EAZ64cxX3BsQF6l9TRkXbMncjq1eZZJJ7oXHxMSZ/Mv5c7F
         FEWOuOeuHwqR10DsB9GG/14iu2z1A9bNHsoOg3ttHhTa7e/WtvCoDCyLqB4hyqUecB
         TKpcl7W51551w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 22 Jun 2023 22:02:13 +0300 (MSK)
Date:   Thu, 22 Jun 2023 22:02:13 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Jian Hu <jian.hu@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        <linux-amlogic@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: repair pattern in ARM/Amlogic Meson SoC
 CLOCK FRAMEWORK
Message-ID: <20230622190213.r3ru44ghucxnk7rc@CAB-WSD-L081021>
References: <20230614084212.1359-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230614084212.1359-1-lukas.bulwahn@gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/22 14:26:00 #21556046
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Lukas,

I want to express my sincere gratitude for promptly correcting my
mistake. Your help is truly appreciated. Thank you very much!

On Wed, Jun 14, 2023 at 10:42:12AM +0200, Lukas Bulwahn wrote:
> Commit e6c6ddb397e2 ("dt-bindings: clock: meson: add A1 PLL clock
> controller bindings") adds a file entry with pattern
> "include/dt-bindings/clock/a1*" to the ARM/Amlogic Meson SoC CLOCK
> FRAMEWORK section. However, all header files added in the patch series to
> add Amlogic A1 clock controller drivers carry the prefix "amlogic,a1", and
> there are not header files matching "a1*".
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Adjust the pattern of this file entry to match the headers actually added.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 08c7efe271c3..08f7c69c67c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1887,7 +1887,7 @@ L:	linux-amlogic@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/amlogic*
>  F:	drivers/clk/meson/
> -F:	include/dt-bindings/clock/a1*
> +F:	include/dt-bindings/clock/amlogic,a1*
>  F:	include/dt-bindings/clock/gxbb*
>  F:	include/dt-bindings/clock/meson*
>  

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

> -- 
> 2.17.1
> 

-- 
Thank you,
Dmitry
