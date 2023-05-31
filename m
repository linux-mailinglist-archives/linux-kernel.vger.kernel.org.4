Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8371850B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbjEaOeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjEaOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A66D93;
        Wed, 31 May 2023 07:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D20F463CC5;
        Wed, 31 May 2023 14:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCABC433D2;
        Wed, 31 May 2023 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685543645;
        bh=mUMjO1OdsoJvyDsLxetTPv8J33WqgzLK/1GWLYInHFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAXNydOE+GkDVpKqoWOZlRVZ/KfPMl00INzrkYzHu74AMD8gYPhkASWHup44uXJnU
         0OcJMyVwR9GqJwAZz0GdW5jfwSAvwih/PE61iH6KAY62sb4GOHRgOy7yPBNYILWvlQ
         cgkusdjrxXZQXDnJfMMK7OMiKyCrtMiG1rvt3tHA=
Date:   Wed, 31 May 2023 15:34:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 04/10] serial: bflb_uart: add Bouffalolab UART Driver
Message-ID: <2023053119-drab-cartwheel-29af@gregkh>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-5-jszhang@kernel.org>
 <2023053010-gondola-luminous-f5e7@gregkh>
 <ZHdVNIQpgfCzimRg@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHdVNIQpgfCzimRg@xhacker>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:09:56PM +0800, Jisheng Zhang wrote:
> On Tue, May 30, 2023 at 11:36:00AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, May 18, 2023 at 11:22:38PM +0800, Jisheng Zhang wrote:
> > > Add the driver for Bouffalolab UART IP which is found in Bouffalolab
> > > SoCs such as bl808.
> > 
> > New uarts are being created that are NOT 8250-like?  Why????
> 
> Hi,
> 
> I'm not sure I understand your meaning. I guess you mean writing the new
> uart driver following 8250 style. And the latest example is
> sunplus-uart.c, it can be used as an example how to write a 8250 style
> driver for new non-8250 uart IP. 

No, I mean, "why are hardware designers creating new UARTs in 2023 that
are NOT 8250-based"?  Why do they want to constantly reinvent the wheel?

thanks,

greg k-h
