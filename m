Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1160093E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiJQIwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJQIwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:52:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7AD43146
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:51:32 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1okLqL-0004vh-Er; Mon, 17 Oct 2022 10:51:29 +0200
Message-ID: <1a69fba3-6a10-e78a-f1ee-70eefbd59a62@pengutronix.de>
Date:   Mon, 17 Oct 2022 10:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [tip: x86/misc] Documentation/x86/boot: Peserve type_of_loader=13
 for barebox
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org
References: <20221002125752.3400831-1-a.fatoum@pengutronix.de>
 <166599647272.401.15990841004146726447.tip-bot2@tip-bot2>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <166599647272.401.15990841004146726447.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Boris,

On 17.10.22 10:47, tip-bot2 for Ahmad Fatoum wrote:
> The following commit has been merged into the x86/misc branch of tip:
> 
> Commit-ID:     f0a8dec99a55aee896a1e6739ecf737f4524094a
> Gitweb:        https://git.kernel.org/tip/f0a8dec99a55aee896a1e6739ecf737f4524094a
> Author:        Ahmad Fatoum <a.fatoum@pengutronix.de>
> AuthorDate:    Sun, 02 Oct 2022 14:57:53 +02:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Mon, 17 Oct 2022 10:11:09 +02:00
> 
> Documentation/x86/boot: Peserve type_of_loader=13 for barebox

Thanks for applying. In case the branch is not non-rebaseable:

s/Peserve/Reserve/ in the commit message title.

Cheers,
Ahmad

> 
> barebox[1], a bootloader for mostly ARM and MIPS embedded systems, can
> also be built as EFI payload for x86[2] to provide redundant power-fail
> safe, watchdog-supervised boot up.
> 
> Since its v2015.09.0 release, it has been booting Linux on x86 with
> type_of_loader=0xff[3]. Reserve 13, the next free id, so that can be
> used instead in the future.
> 
> [1]: https://www.barebox.org/
> [2]: https://www.barebox.org/doc/latest/boards/efi.html
> [3]: https://elixir.bootlin.com/barebox/v2022.09.0/source/common/efi/payload/image.c#L217
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lore.kernel.org/r/20221002125752.3400831-1-a.fatoum@pengutronix.de
> ---
>  Documentation/x86/boot.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> index 894a198..240d084 100644
> --- a/Documentation/x86/boot.rst
> +++ b/Documentation/x86/boot.rst
> @@ -455,6 +455,7 @@ Protocol:	2.00+
>  	11 Minimal Linux Bootloader
>  	   <http://sebastian-plotz.blogspot.de>
>  	12 OVMF UEFI virtualization stack
> +	13 barebox
>  	== =======================================
>  
>    Please contact <hpa@zytor.com> if you need a bootloader ID value assigned.
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
