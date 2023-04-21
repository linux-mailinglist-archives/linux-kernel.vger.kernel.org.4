Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1356F6EA8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjDULOX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 07:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDULOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:14:21 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A5AD17;
        Fri, 21 Apr 2023 04:14:20 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ppoiU-001aBB-QR; Fri, 21 Apr 2023 13:14:14 +0200
Received: from p57bd9bea.dip0.t-ipconnect.de ([87.189.155.234] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ppoiU-001Fju-JN; Fri, 21 Apr 2023 13:14:14 +0200
Message-ID: <cfcfc689de8480a3ab0a03826e4c95f22c5af937.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Replace <uapi/asm/types.h> by
 <asm-generic/int-ll64.h>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Apr 2023 13:14:13 +0200
In-Reply-To: <26932016c83c2ad350db59f5daf96117a38bbbd8.1679566927.git.geert@linux-m68k.org>
References: <26932016c83c2ad350db59f5daf96117a38bbbd8.1679566927.git.geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.155.234
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Thu, 2023-03-23 at 11:22 +0100, Geert Uytterhoeven wrote:
> As arch/sh/include/uapi/asm/types.h doesn't exist, sh doesn't provide
> any sh-specific uapi definitions, and it can just include
> <asm-generic/int-ll64.h>, like most other architectures.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Rebased for SPDX-License-Identifier addition in 2017.
> 
>  arch/sh/include/asm/types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/include/asm/types.h b/arch/sh/include/asm/types.h
> index 68eb24ad201383ef..9b3fc923ee28701c 100644
> --- a/arch/sh/include/asm/types.h
> +++ b/arch/sh/include/asm/types.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_SH_TYPES_H
>  #define __ASM_SH_TYPES_H
>  
> -#include <uapi/asm/types.h>
> +#include <asm-generic/int-ll64.h>
>  
>  /*
>   * These aren't exported outside the kernel to avoid name space clashes

It seems that many (most?) architectures don't even provide their own types.h
header. Does it even make sense to still carry that header or can it be provided
from somewhere else?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
