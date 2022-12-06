Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19026444EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiLFNty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiLFNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:49:52 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A727CE00
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:49:51 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y135so14067760yby.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 05:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+SBgDf21nE7Fz3DEe+AUeblmVxcRq4JLFAaeQh0074k=;
        b=HMspc9TmlnuApAZpE9HFknz/zaPGdRa8yhRZdQUd9Jb5lztXIxnwpk5yTzg8JKIJke
         Ahe5W1KJ23WU42G6eaEQIfMVl8ED8nI4z4NuK9lUAwCKIVv5ox6guQy/uer6p2WjRIws
         Sn4Di8RN9kjKsGxKNxMD+mzo4XcasifOzDAQFEqR5b5qCe7iWbMn21cjexSk+tsJMEfD
         fOFzJ5SKSF33RR2oz5AqZDQ8DZ0IJVNY+XsQhPmauE64K9UGwCWSGYEsFbwVKdmOLxNT
         D1qrOqYQ5mZCkOQQq8TGB5Dwxrro858u2maQg5Bt4faJ1upH8fqgROBI5ayZsoDzytci
         l02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SBgDf21nE7Fz3DEe+AUeblmVxcRq4JLFAaeQh0074k=;
        b=Y1yfEmiL7H8DR1nwXtRfm+rt9AM6B1heOUpv75cDsfmEwwbMN2dNfa5OCU+isAIK3i
         ZZNS2qg53Zi/hvQnd+GAiyJBBQ43tkdHxfR1OKJt8dl724q6GJBtsf/Bj6hPOai0rwiT
         CnzrlIvm4hRVi3PnQpk1Jt0rhzfZ0CaFRhsXPLCs/A7CZASKTWYGndbtagOPHXtiCeBu
         ey82P9Fhn/jiVFiHsniZWYfBl17PDOYG2JiDwk3lqsn7i/WkUnOCJRCV68JzVtctq5XL
         gtMDuxllylPSJFeuyOmnG0X2fpIgeTF9DOSOOaeLXRSLj0c1J4YTmMN8ZZkNwClr1HXs
         ME2A==
X-Gm-Message-State: ANoB5pkL4fqvRiqnA42yvvRMoYNysN5gkR9p/zXzS+8ktg8uGhJBTDxo
        +pEvpc3erNCxa4Aof6PlbuaYYrCXMIePEn6JPKBmdA==
X-Google-Smtp-Source: AA0mqf6PPhad0dT7AQIq72om4eiZw0XHpyFWIjc/NSq9ASGSg9Iv/RYo/rQ1EvHP5JLLxgvc3vGDT/5EA2EgEcJas3A=
X-Received: by 2002:a25:d8d4:0:b0:6f0:36e2:5fc2 with SMTP id
 p203-20020a25d8d4000000b006f036e25fc2mr58067021ybg.52.1670334590231; Tue, 06
 Dec 2022 05:49:50 -0800 (PST)
MIME-Version: 1.0
References: <a989b3b798ecaf3b45f35160e30e605636d66a77.1669044086.git.geert+renesas@glider.be>
 <CACRpkdZPhKT=wjToSiY+iyXk2_WdBZ1hEvmNvQQLJPZGN==-xQ@mail.gmail.com> <CAMuHMdVDYsCPko9NJfa+JLk_MRFAR1dgSF3GahtTeABysDFyBA@mail.gmail.com>
In-Reply-To: <CAMuHMdVDYsCPko9NJfa+JLk_MRFAR1dgSF3GahtTeABysDFyBA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Dec 2022 14:49:38 +0100
Message-ID: <CACRpkdb+eXGwdDgMP6VXnObfz-_k=xQ=Er8b4=cvhmYEzt5j9w@mail.gmail.com>
Subject: Re: [PATCH] usb: USB_FOTG210 should depend on ARCH_GEMINI
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Fabian Vogt <fabian@ritter-vogt.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 9:01 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Dec 5, 2022 at 11:24 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Nov 21, 2022 at 4:22 PM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > The Faraday Technology FOTG210 USB2 Dual Role Controller is only present
> > > on Cortina Systems Gemini SoCs.
> >
> > As it turns out, this is not true. The TI nSpire uses this too, I should have
> > noted since the nSpire maintainer was patching the driver...
> > https://lore.kernel.org/linux-usb/20210324141115.9384-1-fabian@ritter-vogt.de/
> >
> > Shall we revert it or just add another clause for the nSpire?
>
> Oh, but the integration is not (yet) upstream, as I didn't find any
> "faraday,fotg210" outside gemini.dtsi.

Ah it is still brewing, sorry.

> I guess another clause would be the most-userfriendly solution.

Yeah we can just add it when adding nSpire II.

Yours,
Linus Walleij
