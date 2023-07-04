Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C127468F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGDF2c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 01:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGDF2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:28:30 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E758FBD;
        Mon,  3 Jul 2023 22:28:29 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qGYaS-000KEh-Iy; Tue, 04 Jul 2023 07:28:28 +0200
Received: from p57bd997f.dip0.t-ipconnect.de ([87.189.153.127] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qGYaS-000dCz-BX; Tue, 04 Jul 2023 07:28:28 +0200
Message-ID: <898f6befcbeef9d685773143355088f38fe6e6e4.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/4] sh: move build rule of cchips/hd6446x/ to
 arch/sh/Kbuild
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Date:   Tue, 04 Jul 2023 07:28:27 +0200
In-Reply-To: <20230219141555.2308306-2-masahiroy@kernel.org>
References: <20230219141555.2308306-1-masahiroy@kernel.org>
         <20230219141555.2308306-2-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.153.127
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro!

On Sun, 2023-02-19 at 23:15 +0900, Masahiro Yamada wrote:
> This is the last user of core-y in ARCH=sh.
> 
> Use the standard obj-y syntax.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/sh/Kbuild   | 2 ++
>  arch/sh/Makefile | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/Kbuild b/arch/sh/Kbuild
> index be171880977e..056efec72c2a 100644
> --- a/arch/sh/Kbuild
> +++ b/arch/sh/Kbuild
> @@ -3,5 +3,7 @@ obj-y				+= kernel/ mm/ boards/
>  obj-$(CONFIG_SH_FPU_EMU)	+= math-emu/
>  obj-$(CONFIG_USE_BUILTIN_DTB)	+= boot/dts/
>  
> +obj-$(CONFIG_HD6446X_SERIES)	+= cchips/hd6446x/
> +
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index a9cad5137f92..0625796cfe7f 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile
> @@ -126,9 +126,6 @@ machdir-$(CONFIG_SH_X3PROTO)			+= mach-x3proto
>  machdir-$(CONFIG_SH_LANDISK)			+= mach-landisk
>  machdir-y					+= mach-common
>  
> -# Companion chips
> -core-$(CONFIG_HD6446X_SERIES)	+= arch/sh/cchips/hd6446x/
> -
>  #
>  # CPU header paths
>  #

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
