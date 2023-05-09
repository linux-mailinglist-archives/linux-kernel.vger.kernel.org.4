Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31236FBE24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjEIESp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEIESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:18:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF87644B4;
        Mon,  8 May 2023 21:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hAweX2f1hu6oBbHEW7rwfHxKnrqr1h9EowLzMonuLeA=; b=OeLw5Y496lChWTtHlDSw3IgCq3
        awDnMHCY3st2vb0Sd+sZ0wMUD3UPIWoG5GQGFbvddOOL6CF1qUEq2KWqBF0DZmx14t45iElFrc555
        SBZGDTZgM7To8DJxR8cI8kKnlShBMFFpk2Vt0/CcEhZNoIkiFBerruiP8KpDDU+yqJdVADmoUyuQb
        TJdFP/qvtox7VOtoufdpNunEr5tqLZ6FUdnhKCMywQ094Ul6xlHi1u9QXSDTYNcuPRptQ01EdlXOK
        Ov8pwSmKxIWsZoTVBeAjpfsFgKYrt04EhG8eiYb/8HxSEyIQ0NXOUxQYzCJiCdu8lGx1KZz3TSxvO
        MwTRWAhg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwEo5-002EtN-0K;
        Tue, 09 May 2023 04:18:33 +0000
Message-ID: <62539831-1f8c-d908-bd7c-2a926702fa7f@infradead.org>
Date:   Mon, 8 May 2023 21:18:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH AUTOSEL 6.3 6/7] powerpc/fsl_uli1575: Allow to disable
 FSL_ULI1575 support
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        arnd@arndb.de, linuxppc-dev@lists.ozlabs.org
References: <20230509035455.59524-1-sashal@kernel.org>
 <20230509035455.59524-6-sashal@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230509035455.59524-6-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

Just a heads up. This patch can cause build errors.
I sent a patch for these on 2023-APR-28:
  https://lore.kernel.org/linuxppc-dev/20230429043519.19807-1-rdunlap@infradead.org/

Michael, I think this is your area if I'm not mistaken.


On 5/8/23 20:54, Sasha Levin wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> [ Upstream commit 22fdf79171e8509db54599fd2c05ef0022ee83f5 ]
> 
> ULI1575 PCIe south bridge exists only on some Freescale boards. Allow to
> disable CONFIG_FSL_ULI1575 symbol when it is not explicitly selected and
> only implied. This is achieved by marking symbol as visible by providing
> short description. Also adds dependency for this symbol to prevent enabling
> it on platforms on which driver does not compile.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://msgid.link/20230409000812.18904-7-pali@kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/powerpc/platforms/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index d41dad227de84..608ac0290e3aa 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -261,7 +261,9 @@ config CPM2
>  	  on it (826x, 827x, 8560).
>  
>  config FSL_ULI1575
> -	bool
> +	bool "ULI1575 PCIe south bridge support"
> +	depends on FSL_SOC_BOOKE || PPC_86xx
> +	select FSL_PCI
>  	select GENERIC_ISA_DMA
>  	help
>  	  Supports for the ULI1575 PCIe south bridge that exists on some

-- 
~Randy
