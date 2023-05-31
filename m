Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE33717848
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjEaHbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjEaHbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:31:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3B5E5
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:31:25 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.214]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0X0U-1qG8Jq33SO-00wVdq; Wed, 31 May 2023 09:29:30 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 16F453E7CB; Wed, 31 May 2023 09:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1685518165; bh=HpS8LrsnY/89NscygVkPsEBgTNTbHKpEGmsUMP/4T6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wEOslFOPWf2p08nC8zApP5Rcoc6tiv/v6ERy4dGWcUUWrmTuj6q11wGLLkqqrj706
         WLz0JzJsYSw/tI8bK5P97oE2bMKPLd3buMdXXfQ2Qr59505Ib/EfH3BZx9F1loHHxU
         zTbg1mJTFRQv59eeJ32gfP9BJgg0wxr3D571i3Bg=
Date:   Wed, 31 May 2023 09:29:24 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Leo Li <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org,
        Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 RESEND] soc/fsl/qe: fix usb.c build errors
Message-ID: <ZHb3VD4OgqDd2oKR@fjasle.eu>
References: <20230521225216.21795-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230521225216.21795-1-rdunlap@infradead.org>
X-Provags-ID: V03:K1:7aNwyNIJJGSwsSWIPPBCoqlbrWM1lrCsSwYfhj+nxprnIqzghd8
 j/UnBB7xn4z/O3bMZdwCnwu+sllhHuHQ67c9LORIPuBxHfh00uZ5KUPq/5MpX+jjxwUJMAJ
 Y6C00Sq4tZuCPiz6F1aURO30MU18l/y9gyUYnLTRdQvdQFteOKGecgPvTCZxvy6ZWMI0Rl2
 2TGI7d6XRMv9fuzxYZKJQ==
UI-OutboundReport: notjunk:1;M01:P0:I6wVgntK3Sg=;NSHbAXchRpYgja/Vb1QeEf5BXvp
 Z6oKfGH5z15YYNvK+7PnhU90nHWaN6Fqiw80Nwqa2UR8XgUl+ghc5lIDrYEqsG/aYtqeO+D9m
 hL6LOrbQKIPGS/c8uItjcNe2Y2ghWCUBc3PjYcQ71tDS1mvXiMdhPSeB94LFa+m8VL19BVn5/
 oVKbZOLnwwOPHQTqhivyIS5WtKkq01o5OAApkHtVaOoq+jp3wwdp7j5dS/8cdhA45aw6XD2dm
 4bDFJJdLA0585If+XghsqRf9J+85XhztF11bbNx8aguCQpktsgw62vRLEPk46IdS4PbJzNuF2
 1So3DrL8Gq4MjZfb4qHludFSRt5kETH5aq9UqNrv4BvkfHFByXLW6u3gETKJhU9YN65VQYuk5
 AMmGn52mjNBLn664WdNnH6H1APClRvMbiS5Qlw2dim0C1Z20LhZ+IiDtVXjAQt08rxJpF1rAI
 wBr8o1OYq7wABebD/gzrDR6y6nn2qT7iOVT+p7p82MoJd8C8RqzHFKiCXV1JqLUQiImjVAsH5
 0zYJt0FZGxIrWBQQO3LVnQEkb2iGcdtiqRODFUSw9FHqwUqCK607DQ8vBYm0lFR1cMAlxjbOD
 PgjcuvKvj6frxNEb/x+bZURa3QRdmARwr0W5Lbi3qYnKoX5wJ8VsBbPUWsma2n/M4SWjbDDrh
 3q39eVjP9FAtvmok8Uq6GfSQMnMKjPY1r/kH3zI5ww==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 03:52:16PM -0700 Randy Dunlap wrote:
> Fix build errors in soc/fsl/qe/usb.c when QUICC_ENGINE is not set.
> This happens when PPC_EP88XC is set, which selects CPM1 & CPM.
> When CPM is set, USB_FSL_QE can be set without QUICC_ENGINE
> being set. When USB_FSL_QE is set, QE_USB deafults to y, which
> causes build errors when QUICC_ENGINE is not set. Making
> QE_USB depend on QUICC_ENGINE prevents QE_USB from defaulting to y.
> 
> Fixes these build errors:
> 
> drivers/soc/fsl/qe/usb.o: in function `qe_usb_clock_set':
> usb.c:(.text+0x1e): undefined reference to `qe_immr'
> powerpc-linux-ld: usb.c:(.text+0x2a): undefined reference to `qe_immr'
> powerpc-linux-ld: usb.c:(.text+0xbc): undefined reference to `qe_setbrg'
> powerpc-linux-ld: usb.c:(.text+0xca): undefined reference to `cmxgcr_lock'
> powerpc-linux-ld: usb.c:(.text+0xce): undefined reference to `cmxgcr_lock'
> 
> Fixes: 5e41486c408e ("powerpc/QE: add support for QE USB clocks routing")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202301101500.pillNv6R-lkp@intel.com/
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Leo Li <leoyang.li@nxp.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Kumar Gala <galak@kernel.crashing.org>
> ---

I can reproduce the build error and confirm the build dependency fix (but I
have no hardware for testing).

Acked-by: Nicolas Schier <nicolas@jasle.eu>



> v2: drop Anton Vorontsov <avorontsov@ru.mvista.com>; rebase/resend
> 
>  drivers/soc/fsl/qe/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
> --- a/drivers/soc/fsl/qe/Kconfig
> +++ b/drivers/soc/fsl/qe/Kconfig
> @@ -62,6 +62,7 @@ config QE_TDM
>  
>  config QE_USB
>  	bool
> +	depends on QUICC_ENGINE
>  	default y if USB_FSL_QE
>  	help
>  	  QE USB Controller support

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
