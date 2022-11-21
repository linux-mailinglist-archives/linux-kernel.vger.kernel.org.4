Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A563252F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKUOLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiKUOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:10:55 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9CCD119;
        Mon, 21 Nov 2022 06:07:41 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id x18so8028335qki.4;
        Mon, 21 Nov 2022 06:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nCp6eJnEVzWDEtPCziQPCYGKd6IyiDKcam0fNT4ySd8=;
        b=ZFrvdWBICMrI5FQi8GfrxZhCAuhDV5oMZdAuWOWdqN6VHCQsFvk0xTjeiBi1Q/PfRQ
         6obNkfIpD4pGSUZV42QtpkU3eRCbkt7dK4Mg431hyKkYre4DHZJpeDP8+rb9WfSgxm2m
         cGxKOaH8LeT1ko9x9gmUGbLWusPg0N3UvuD73wM7683eozXTKVz6iQ/Zvr/1z2aED35K
         qAp6SYx63j87519h33cF8CkTrWoCWrwl/4pfFKSJkQUQktX7rb4floXnPrOoYxYXnVMZ
         Ko8KxDee9/N0lS5K5+tsCwgAJQ1AN3W+xNrNlv4OfoOFE3uHudR8FUTggVXkJQypxYms
         0Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCp6eJnEVzWDEtPCziQPCYGKd6IyiDKcam0fNT4ySd8=;
        b=c5KqHHW4kPCqyiP1fvEW55t/km2HM/ZaReQjWQ6Y/O0nRXy/BuO48d/EBDi8I3MAKU
         hlHsvmtpIDJGtYua3SktgE5HBHVe/RZ94UgXRo9a98s/XDN3xaAIkOyRw7VfPwSPnGYU
         6Yx8Fp07X8mDdP1uH2qK7tbI+kkh0ooNkjTVtyDoDarlMp69kTqxBkFuGQn6wBfe/Nr0
         iFEEwXmz/c9oDnDPQh7u+QPpiaAm1TzLP2f0JBc3n+KcXmNZ9cN3dwQgMx9h4G+hD2ZK
         lxUgdIBheqb/MW3RM7Qi+pBEbHqaH1s50qwheXZBr7OPJZ94vyKG1C936L12FUEwPAFu
         ZmEA==
X-Gm-Message-State: ANoB5plLDoXyYVyqTRM+7x+XhyMs185EpGHc3CUuFaiSdChLi1zTD90Y
        TOk0LS8eiRexD6alLFeGHvY=
X-Google-Smtp-Source: AA0mqf5DB27OwbiHThtWOcpu43UNLe8yZQ0Ii1NmM+LUpg4jVu8h8dTp1s40do5Ovmudf1pROsfQqg==
X-Received: by 2002:a37:444b:0:b0:6fa:389e:7228 with SMTP id r72-20020a37444b000000b006fa389e7228mr16525237qka.141.1669039657938;
        Mon, 21 Nov 2022 06:07:37 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id fa9-20020a05622a4cc900b0039cc944ebdasm6731297qtb.54.2022.11.21.06.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:07:37 -0800 (PST)
Date:   Mon, 21 Nov 2022 09:07:35 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v5 13/14] serial: liteuart: add IRQ support for the TX
 path
Message-ID: <Y3uGJ3D4OH0vPLqj@errol.ini.cmu.edu>
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-14-gsomlo@gmail.com>
 <7e2e76f8-5d88-4df4-2335-9f7b129b2e26@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e2e76f8-5d88-4df4-2335-9f7b129b2e26@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:58:41AM +0100, Jiri Slaby wrote:
> On 18. 11. 22, 15:55, Gabriel Somlo wrote:
> > Switch the TX path to IRQ-driven operation, while maintaining support
> > for polling mode via the poll timer.
> > 
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ...
> > @@ -154,6 +148,8 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
> >   	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
> >   	if (isr & EV_RX)
> >   		liteuart_rx_chars(port);
> > +	if (isr & EV_TX)
> > +		liteuart_tx_chars(port);
> 
> Wait, how do you ensure the OFF_EV_PENDING reg contains EV_RX and/or EV_TX
> in the polling mode?

The hardware (well, *gateware*) is coded to populate the EV_PENDING
register regardless of whether IRQs are enabled via the EV_ENABLE
register (or indeed, whether IRQs are even "wired into" the design at
all). See

https://github.com/enjoy-digital/litex/blob/master/litex/soc/cores/uart.py
and
https://github.com/enjoy-digital/litex/blob/master/litex/soc/interconnect/csr_eventmanager.py

for a starting point on why it's OK to just assume that...

Thanks,
--Gabriel
