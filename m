Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3806637C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKXPGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKXPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:06:43 -0500
X-Greylist: delayed 563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Nov 2022 07:06:41 PST
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B487A113FD9;
        Thu, 24 Nov 2022 07:06:41 -0800 (PST)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 6E6FC30B2963;
        Thu, 24 Nov 2022 15:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=eoslv
        1J/gv0WX26skGW/QE6lz0LkFm1+EhNv+jR/TnI=; b=qjwfEai8YDdrymDXSFsJZ
        yJk2J6OY5AX7yZKxm6/tWfDpnvFtixZb1WhpEWm3kYwXZzOYIwts9fSIOu+VsQ/N
        jNgkwyoE5+teR/sbfLK4jkLWnaX2iKwcADQfkKue6Sa/pD5M6ypv31zQgZv+K3RT
        kmk4lRMAjVySNOrIVq2B+WhqYOMmAe2rDpqw7Eqznyv3h7YUxLmg7dMRIcWgIiWC
        IsHgBK4gdyGfn6H2rAji0rqF7TNaxudeiPlEzRuBsc66fHNjS5NHhh0ZeobYfBa5
        ZjdwvoFGyi6/1VQMZulq5BhYamvDOzdSVtJ85Ll1EIGYVywmISEgeMpUpAUsLud+
        Q==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id A2B9130B2960;
        Thu, 24 Nov 2022 15:56:45 +0100 (CET)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 2AOEujLW018131;
        Thu, 24 Nov 2022 15:56:45 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 2AOEujZS018130;
        Thu, 24 Nov 2022 15:56:45 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] can: ctucanfd: Drop obsolete dependency on COMPILE_TEST
Date:   Thu, 24 Nov 2022 15:56:38 +0100
User-Agent: KMail/1.9.10
Cc:     linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ondrej Ille <ondrej.ille@gmail.com>
References: <20221124141604.4265225f@endymion.delvare>
In-Reply-To: <20221124141604.4265225f@endymion.delvare>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202211241556.38957.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the care. I cannot judge change on my personal opinion.
But if that is general direction even for other drivers
then I confirm the change.

On Thursday 24 of November 2022 14:16:04 Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
>
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Cc: Ondrej Ille <ondrej.ille@gmail.com>
> ---
>  drivers/net/can/ctucanfd/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-6.0.orig/drivers/net/can/ctucanfd/Kconfig
> +++ linux-6.0/drivers/net/can/ctucanfd/Kconfig
> @@ -23,7 +23,7 @@ config CAN_CTUCANFD_PCI
>
>  config CAN_CTUCANFD_PLATFORM
>  	tristate "CTU CAN-FD IP core platform (FPGA, SoC) driver"
> -	depends on HAS_IOMEM && (OF || COMPILE_TEST)
> +	depends on HAS_IOMEM && OF
>  	select CAN_CTUCANFD
>  	help
>  	  The core has been tested together with OpenCores SJA1000


