Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0D70AD24
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjEUJNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 05:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUJNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 05:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884AAD2;
        Sun, 21 May 2023 02:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFAD60C86;
        Sun, 21 May 2023 09:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AF2C433EF;
        Sun, 21 May 2023 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684660416;
        bh=9KfIOx+itQxU8NyXXIB5Io1Yi152RTWE9ltYXldIDoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OG4Xc+aQ8aqJOU8OR4GfqwPyIMccaLnoo+767S4YjlMeXoPHy8kbmwZ37iAklsDdf
         u65QOdpTxaJMKy0PuiVwkQdEN062i/k1jUKPbaJaavzAvq2b8HRdZB/Mme3ppwiTsm
         tkrFODIJsn1zVPem9eaeuqdUmR+tYTB/Y/uRc38TINr5cTC/FDSG0EQeUNgqSth3b9
         eT/56hnSD7weLsl0GWpyCtGWUzlAtC0RBAg229J2diNuCN7jwY19OazoxLNWTrlT03
         yLzoZI/TpQtfNNFMizU1agWXUmdmZpxhvyDdd29YEECA8H9nIMv6YGbEWMBACZuMbb
         8TaLz+5Lvzt4w==
Date:   Sun, 21 May 2023 17:02:23 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v4 01/10] dt-bindings: vendor-prefixes: add bouffalolab
Message-ID: <ZGneH+ApaQVvv3SW@xhacker>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-2-jszhang@kernel.org>
 <a45c9193-aa63-650f-dbb3-14b6c3f74eeb@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a45c9193-aa63-650f-dbb3-14b6c3f74eeb@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 09:53:12PM -0500, Samuel Holland wrote:
> Hi Jisheng,
> 
> Thanks for updating this series!
> 
> On 5/18/23 10:22, Jisheng Zhang wrote:
> > In the following commits, we will support bl808 SoC which is from
> > Bouffalo Lab Technology (Nanjing) Co., Ltd.
> > 
> > Add bouffalolab vendor prefix binding.
> > 
> > Link: https://en.bouffalolab.com/
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 82d39ab0231b..3566346f2f9e 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -200,6 +200,8 @@ patternProperties:
> >      description: BOE Technology Group Co., Ltd.
> >    "^bosch,.*":
> >      description: Bosch Sensortec GmbH
> > +  "^bouffalolab,.*":
> > +    description: Bouffalo Lab Technology (Nanjing) Co., Ltd.
> 
> Have you thought about using the "bflb" abbreviation as the vendor

I did think about bflb vs bouffalolab. Here is what I thought: I came
across "marvell" vs "mrvl" sevral years ago, I got an impression
"marvell" vendor prefix is preferred if I read the discussions
correctly.

As for Bouffalolab vendor prefix, I have no preference, maybe DT
maintainers can provide inputs here.
Rob, Conor, Krzysztof, what's your opinion?

Thanks

> prefix, like you use throughout the driver code? This would save quite
> some space in the DTB, and seems to be the most common variant seen in
> the vendor SDK:
> 
> bouffalo_sdk$ git grep -i bflb | wc -l
> 14364
> bouffalo_sdk$ git grep -i bouffalo | wc -l
> 1042
> bouffalo_sdk$ git grep -i bouffalolab | wc -l
> 179
> 
> So that is what we were using for bringing up Linux and U-Boot over at
> https://github.com/openbouffalo.
> 
> On the other hand, "bouffalolab" is certainly accurate as well, so I
> understand if you prefer it. And we will of course adapt to whatever
> gets merged, since our goal is upstreaming.
> 
> The vendor code drop[1] provided only one example, "bflb-uart,uart0",
> which is not very helpful. Maybe you have received further information
> from them?
> 
> What do you think?
> 
> Regards,
> Samuel
> 
> [1]:
> https://github.com/bouffalolab/bl808_linux/blob/main/linux-5.10.4-808/drivers/tty/serial/bflb_uart.c#L700
> 
