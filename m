Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A369DD82
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjBUKAZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Feb 2023 05:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjBUKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:00:23 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085BF2311D;
        Tue, 21 Feb 2023 02:00:17 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pUPRU-002FOl-1x; Tue, 21 Feb 2023 11:00:12 +0100
Received: from tmo-082-88.customers.d1-online.com ([80.187.82.88] helo=[IPv6:2a01:598:b9a2:3fca:fe76:4b76:93a9:5dda])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pUPRT-0039a5-P6; Tue, 21 Feb 2023 11:00:12 +0100
Message-ID: <7c95eaf44dc59f10c563d2088cb446a277a5ac73.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: SH2007: drop the bad URL info
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Date:   Tue, 21 Feb 2023 11:00:10 +0100
In-Reply-To: <20230221031004.18910-1-rdunlap@infradead.org>
References: <20230221031004.18910-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 80.187.82.88
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-02-20 at 19:10 -0800, Randy Dunlap wrote:
> This URL provided is no longer functional, so drop it.
> 
> Fixes: 3a598264436e ("sh: SH-2007 board support.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/sh/boards/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff -- a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -358,7 +358,6 @@ config SH_SH2007
>  	  intended for embedded applications.
>  	  It has an Ethernet interface (SMC9118), direct connected
>  	  Compact Flash socket, two serial ports and PC-104 bus.
> -	  More information at <http://sh2000.sh-linux.org>.
>  
>  config SH_APSH4A3A
>  	bool "AP-SH4A-3A"

Thanks, Randy! I will pick this one up as soon as my kernel.org account
is ready, so I can set up my SH tree.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
