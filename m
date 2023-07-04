Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB2747909
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 22:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGDUcT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGDUcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 16:32:17 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD934E76;
        Tue,  4 Jul 2023 13:32:16 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qGmh1-001suX-Qh; Tue, 04 Jul 2023 22:32:11 +0200
Received: from p5b13a7a5.dip0.t-ipconnect.de ([91.19.167.165] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qGmh1-003X2y-JE; Tue, 04 Jul 2023 22:32:11 +0200
Message-ID: <d9f6fdf1ba8a3c57e80da0582a6dd8b83b1373df.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 2/3] sh: dma: Drop incorrect SH_DMAC_BASE1 for SH4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Jul 2023 22:32:10 +0200
In-Reply-To: <20230527164452.64797-3-contact@artur-rojek.eu>
References: <20230527164452.64797-1-contact@artur-rojek.eu>
         <20230527164452.64797-3-contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.167.165
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-05-27 at 18:44 +0200, Artur Rojek wrote:
> None of the supported SH4 family SoCs features a second DMAC module. As
> this define negatively impacts DMA channel calculation for the above
> targets, remove it from the code.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> v2: new patch
> 
>  arch/sh/include/cpu-sh4/cpu/dma.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sh/include/cpu-sh4/cpu/dma.h b/arch/sh/include/cpu-sh4/cpu/dma.h
> index 38187d06b234..e97fb2c79177 100644
> --- a/arch/sh/include/cpu-sh4/cpu/dma.h
> +++ b/arch/sh/include/cpu-sh4/cpu/dma.h
> @@ -13,6 +13,5 @@
>  #define DMAE0_IRQ	evt2irq(0x6c0)
>  
>  #define SH_DMAC_BASE0	0xffa00000
> -#define SH_DMAC_BASE1	0xffa00070
>  
>  #endif /* __ASM_CPU_SH4_DMA_H */

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
