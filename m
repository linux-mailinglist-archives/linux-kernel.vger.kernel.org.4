Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3E17356F4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjFSMfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFSMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:35:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAD491;
        Mon, 19 Jun 2023 05:35:03 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.195]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M7s1M-1q7OKy2RNa-0054s7; Mon, 19 Jun 2023 14:34:22 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 01E303E9B6; Mon, 19 Jun 2023 14:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1687178060; bh=IiwVpF5r5BNsW/AliB2hKvy37hPs7k+/ZJCAuSdVtnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdy75r3J5X+wP1JRjD9sGiB4DLoDHiMwahZlLEhBmqc8LJ3lJJOAPX7kR/EO2ZQX2
         vnC15WyeCvq+3QgkI3rhOj+N0S8vInSBoByTSCMwQFr8AS5wYuntYVA8tfwk7/CxP0
         zXVYl3vI5j2TMxQG5SU0TXo+JEelTBh7KersUj+w=
Date:   Mon, 19 Jun 2023 14:34:19 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-snps-arc@lists.infradead.org,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] kbuild: make modules_install copy
 modules.builtin(.modinfo)
Message-ID: <ZJBLS+Dzcj5wOJTb@fjasle.eu>
References: <20230615111743.883891-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230615111743.883891-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:lGiBjMXuiyOpcn1NmIsG6Em6LaomC9AlZNR8VnFYV7P47rGqGzk
 gEdj4HKoWC+rkXjD09fJlcx2yrq1icBbr0M0DaeYm2TH28MF8GeX7aau8o21eEJGHGgRH4W
 XRWOG/ps07jwoOpd0XclweJqSuCVVGxFtP5WamHLjd8FVfHxa3BhsPNh45ofbxU2LUzTsHj
 rqLvWgF5j+qXA21TEg7gg==
UI-OutboundReport: notjunk:1;M01:P0:fJLWB0XZUWo=;aBsZVDORVX7MHFJqgDDY2IeZC6l
 7U5O9PgErYt95oFdXHkjxE76yzbCCHXlhYpjaVDmtfJD1qfjOiYpKJ+E/x0wta5sygmTMpgWH
 mcUg1uBgRgWNpq6x/5gubCm17l55pVaLgTwJV0+yb6e7t5/yxJ8/csXxr82Z0h1m68MsueBdo
 Z6szlkTkiZjkd/cX1VMgiBeQJgdXVrAMDN+SVXDeeT53uVypLRiVxrvVzC369e3aljQ8UeQeo
 PKtRkPX5jSZN8spyLFUTjBewuQoUzc3zzEcvHdJBcmfnaK15a6rjOurMVBixpSD/utXrTzyzD
 MQ8UJVLv6eNyHApP6nFMERc+6j7BgrZzgyYBBSrigImt6dJuvc9KiN4pHtckK53DZmFEXegd6
 IUIZYj8Wqke9JZdKK8U8bttdW5HxpgPRNqHIUh6MdJebPJGnfD8a2CdPyLmKVbjKNX5PjxX1T
 bte1ep+Ui8NLqGIPEg2HIoxI1TFJjKE0ZY9+byakuD0hyrzhkGaK3ra5GpgzzNCs6SqH6VvR5
 tWIKVcSQarao0ZggzHgsKs+kU5J6GwE1j8guuve5xtBo7zBx2TjbpljMRLaPOikl2vaSWw5pR
 UIYZYmKgGdIuMY2H3r6kE7ojLSZC7yc5efeqa1uS5fu6pkw8y0efKI7pKs3h99ZOJMGcpSNx+
 EtG4zDsy9rRmCotKCbChGpGSu7b8Pes5+ukVO/elew==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 08:17:43PM +0900 Masahiro Yamada wrote:
> Josh Triplett reports that initramfs-tools needs modules.builtin and
> modules.builtin.modinfo to create a working initramfs for a non-modular
> kernel.
> 
> If this is a general tooling issue not limited to Debian, I think it
> makes sense to change modules_install.
> 
> This commit changes the targets as follows when CONFIG_MODULES=n.
> 
> In-tree builds:
>   make modules          -> no-op
>   make modules_install  -> install modules.builtin(.modinfo)
> 
> External module builds:
>   make modules          -> show error message like before
>   make modules_install  -> show error message like before
> 
> Link: https://lore.kernel.org/lkml/36a4014c73a52af27d930d3ca31d362b60f4461c.1686356364.git.josh@joshtriplett.org/
> Reported-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nicolas Schier <nicolas@fjasle.eu>

>  Makefile | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index cc3fe09c4dec..f18d59c81241 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1545,6 +1545,8 @@ modules_sign_only := y
>  endif
>  endif
>  
> +endif # CONFIG_MODULES
> +
>  modinst_pre :=
>  ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
>  modinst_pre := __modinst_pre
> @@ -1555,18 +1557,18 @@ PHONY += __modinst_pre
>  __modinst_pre:
>  	@rm -rf $(MODLIB)/kernel
>  	@rm -f $(MODLIB)/source
> -	@mkdir -p $(MODLIB)/kernel
> +	@mkdir -p $(MODLIB)
> +ifdef CONFIG_MODULES
>  	@ln -s $(abspath $(srctree)) $(MODLIB)/source
>  	@if [ ! $(objtree) -ef  $(MODLIB)/build ]; then \
>  		rm -f $(MODLIB)/build ; \
>  		ln -s $(CURDIR) $(MODLIB)/build ; \
>  	fi
>  	@sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.order
> +endif
>  	@cp -f modules.builtin $(MODLIB)/
>  	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
>  
> -endif # CONFIG_MODULES
> -
>  ###
>  # Cleaning is done on three levels.
>  # make clean     Delete most generated files
> @@ -1908,6 +1910,13 @@ help:
>  	@echo  '  clean           - remove generated files in module directory only'
>  	@echo  ''
>  
> +__external_modules_error:
> +	@echo >&2 '***'
> +	@echo >&2 '*** The present kernel disabled CONFIG_MODULES.'
> +	@echo >&2 '*** You cannot build or install external modules.'
> +	@echo >&2 '***'
> +	@false
> +
>  endif # KBUILD_EXTMOD
>  
>  # ---------------------------------------------------------------------------
> @@ -1944,13 +1953,10 @@ else # CONFIG_MODULES
>  # Modules not configured
>  # ---------------------------------------------------------------------------
>  
> -modules modules_install:
> -	@echo >&2 '***'
> -	@echo >&2 '*** The present kernel configuration has modules disabled.'
> -	@echo >&2 '*** To use the module feature, please run "make menuconfig" etc.'
> -	@echo >&2 '*** to enable CONFIG_MODULES.'
> -	@echo >&2 '***'
> -	@exit 1
> +PHONY += __external_modules_error
> +
> +modules modules_install: __external_modules_error
> +	@:
>  
>  KBUILD_MODULES :=
>  
> -- 
> 2.39.2

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
