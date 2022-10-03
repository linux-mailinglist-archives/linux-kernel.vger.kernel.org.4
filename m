Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8485F2F78
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJCLT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJCLTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:19:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E77BBC0E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 04:19:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kg6so6050371ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TdEm/PUli0yRiX2vO1oLj/279IL2MbdY4jtp8LnO49E=;
        b=PTNMbPa2ErEk6BStiVtWpHh3mVCAqOKzK7TDg3+utRzo258K2PCsDPwB/lu2ALk+8U
         d1i4sCb2s7eIFlQl9+oObiLgNnF3Kx+3B2t66Ita40ijGAlufd0qa+pmjdch32EuYhzZ
         wEBIcuIbZcX68bVp22bTEGV8VUIPR6yVe5Y46qe3es9yMQGJqecIBVXK1XCnB+6kD04c
         qnvPDGw2pY61KRHm51ItE56U9z4+rALhJJ2O9MXQSHx65ecm3MXCLAkcKJ2aPhbmxi2x
         ZG3i6wh2mO9SyRCcoNDMJU3ho2jb+njjfd+0cWBZ9thIhaFW3HxJjvEpcrDX6tfHNL2k
         +SgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TdEm/PUli0yRiX2vO1oLj/279IL2MbdY4jtp8LnO49E=;
        b=OvjNu5/E/s+ouDoLi5zWPLdBhkM9Qu29XOkUq4yQOy9dXsWAh0RopuFueBTGoX7zjZ
         D0CGZpBGfP5a5k6ntq/1ZgIkueloRcyVDef9b1Q358t0WBqisqpip5yOUWA/kJM4xjaW
         HVVhnJdI3kx0cVGIaKLvOyitn6BUZmT2G9w0G67PlcecyPkRTRmdpfmzzxfHctsIwUel
         MKXdjr2n6VoMDa8MV87Ih4YpZSpo5lighB2yXpfmFAmIqBTlrvKuIDEZpnGXcv6HYANX
         0kwnhcBTQ7AmDrcPjqITyustJWSdRGIwM7uCHTE6HcVbAybDqbGwj+PjgZfHtPsHLfn0
         VcYA==
X-Gm-Message-State: ACrzQf1EZhl7vf8r59/Z4i5GDRLgV4X8lpZ7xWKBUuumUd+oNKaRZAR4
        4N4r7EqBo7RRLNn83+cSgCq88wwJ63QkiwOoco8=
X-Google-Smtp-Source: AMsMyM54FiGI3AtHJndm3zwtqE4G5IQ43HNvmkPVhv45GQWmuu04HlmsPk/vAxQyC+armpPaNwrALIvgEELDC6e1Dvw=
X-Received: by 2002:a17:907:1c08:b0:782:a340:56d7 with SMTP id
 nc8-20020a1709071c0800b00782a34056d7mr14456152ejc.98.1664795990203; Mon, 03
 Oct 2022 04:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2209231912550.29493@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2209231912550.29493@angie.orcam.me.uk>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 3 Oct 2022 12:19:14 +0100
Message-ID: <CADVatmMBMgk1Uga46FWs4CysiCQ2JQhyfSyp4OK1VDnLdAXSCg@mail.gmail.com>
Subject: Re: [PATCH] parport_pc: Avoid FIFO port location truncation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 7:52 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> Match the data type of a temporary holding a reference to the FIFO port
> with the type of the original reference coming from `struct parport',
> avoiding data truncation with LP64 ports such as SPARC64 that refer to
> PCI port I/O locations via their corresponding MMIO addresses and will
> therefore have non-zero bits in the high 32-bit part of the reference.
> And in any case it is cleaner to have the data types matching here.
>
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/linux-pci/20220419033752.GA1101844@bhelgaas/

Thanks for the patch Maciej.

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Greg, can you please add it to your tree. I know I am late and the
merge window is now open.


-- 
Regards
Sudip
