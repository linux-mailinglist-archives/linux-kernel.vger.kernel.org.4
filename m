Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED986E7627
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjDSJW2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Apr 2023 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjDSJW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:22:26 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEDD7D96;
        Wed, 19 Apr 2023 02:22:21 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pp410-002ld4-Hz; Wed, 19 Apr 2023 11:22:14 +0200
Received: from p5b13a017.dip0.t-ipconnect.de ([91.19.160.23] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pp410-002ALy-AP; Wed, 19 Apr 2023 11:22:14 +0200
Message-ID: <198f478ac0415c906dafbcf1202238cacb3069a4.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: pci: Remove unused variable in SH-7786 PCI
 Express code
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Apr 2023 11:22:13 +0200
In-Reply-To: <CAMuHMdXx9a9dV4GApYQNMYsTO7E1fGXFr4DFJXKmpYhdNN_fAA@mail.gmail.com>
References: <20230419070934.422997-1-glaubitz@physik.fu-berlin.de>
         <CAMuHMdXx9a9dV4GApYQNMYsTO7E1fGXFr4DFJXKmpYhdNN_fAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.23
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-19 at 09:30 +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 19, 2023 at 9:14 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > Addresses the following warning when building sdk7786_defconfig:
> > 
> > arch/sh/drivers/pci/pcie-sh7786.c:34:22: warning: 'dma_pfn_offset' defined but not used [-Wunused-variable]
> >    34 | static unsigned long dma_pfn_offset;
> >       |                      ^~~~~~~~~~~~~~
> > 
> > Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
> > Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > ---
> > v2:
> > - Fix formatting in commit message
> 
> My
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> on v1 is still valid.

Thanks, pushed to my for-next branch:

> https://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git/?h=for-next

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
