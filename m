Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21F76D3E27
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjDCHeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDCHef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:34:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9007AB759;
        Mon,  3 Apr 2023 00:34:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so113334710edb.10;
        Mon, 03 Apr 2023 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680507272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iljKYoYT2ePjzYz9iCguWo2fputM/ySIgsJEj1WtGBA=;
        b=JwCBZ1C71BCvlADWk9aoGIeWpoywTmjsQBZUzDxTDT/EM3mDHzeEvxJ33aIVs1c+lv
         a3niccIrb9X480qtVHcGOCGKE84PZPd0OO7vN3qHO21fpyn6xV5M7vWXjIGlwklA/o8B
         kKNhuMxSN6Pv9se7VcoT3n5MjgrvwNbbv+2gGE6HWk7Up6ddPoTK1ZCeCK/kNB5adkbv
         8+Ry7zBOByXzq+LLbo0Ui3iYiwmBzpYYn5Rx6GK4xCOVAVf7EuHinsfBX76fkhzEqePx
         A1jpvuzKC966WbgaGXxMDCPq6aNRWAKCjrDvC3UdQaFWJA//l7Z6yvs2tF5yAkKeivyo
         Hstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680507272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iljKYoYT2ePjzYz9iCguWo2fputM/ySIgsJEj1WtGBA=;
        b=e5V6bUQ/3Hee16nsvtugjv+z7jt5qhRMz1nxnUO7qY2fZyWIzcJxLBV1b1hYlDne8O
         X5w5VvXvE6+Fz7g7P1YlaALNu+yXdbNkkVpr1M22Dt2IQfHImr7hKxlkx0ffFoKRRWND
         eSt+KzJVzc8QKWwHBf7NnFrY2n6fUz83TNyRx3jWCOkHF+MmcCvUWxYu6+eJP6nmNlDS
         LK9b64B0k+V9NGeoL/76CFQTz94ykvhOrBGyAtYyLmRQ87dlzpaUHrvSWn7nBVS8948H
         mIsR2keL+FoJS/Fp2ylR43rhQSCAq98YNJpoHmGQEHTmJ6HftS1606fFDY2nOzXcTBO4
         q3JA==
X-Gm-Message-State: AAQBX9fMw54k++MQsd1GQFXi5HOnuzvGoBSwvlmXCd0Qtjug18EkKxA3
        V7Jy0iaAR0NcUHs8w6vOtx4=
X-Google-Smtp-Source: AKy350ZyL7HCoS+UmhWQw5tsCxNlOY9WrpJgPpl2XGb/3NyoAlgaV2vhSA/j56EdGvqLCwQ4m4DPBQ==
X-Received: by 2002:a17:906:4f0b:b0:931:59f:d42 with SMTP id t11-20020a1709064f0b00b00931059f0d42mr36891514eju.29.1680507271690;
        Mon, 03 Apr 2023 00:34:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id cw16-20020a170906c79000b0093dce4e6257sm4095134ejb.201.2023.04.03.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 00:34:30 -0700 (PDT)
Date:   Mon, 3 Apr 2023 10:34:27 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Li Yang <lidaxian@hust.edu.cn>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: renesas: renesas-soc: release 'chipid' from
 ioremap()
Message-ID: <302d88ca-7d28-4450-8e60-d0bb40f4174d@kili.mountain>
References: <20230331095545.31823-1-lidaxian@hust.edu.cn>
 <CAMuHMdV5guFbo76nq27aZjWsYqneOfGNf0Ozyh0C53+VgnXgXw@mail.gmail.com>
 <d2688eb2-d7b6-4e80-a13e-55ed541ac9b8@kili.mountain>
 <CAMuHMdX2b+GV4+Ee0yQ2hfNCvHaU_jAsnmF28=4ffCmdVy58xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX2b+GV4+Ee0yQ2hfNCvHaU_jAsnmF28=4ffCmdVy58xg@mail.gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 09:12:55AM +0200, Geert Uytterhoeven wrote:
> Hi Dan,
> 
> On Mon, Apr 3, 2023 at 6:29 AM Dan Carpenter <error27@gmail.com> wrote:
> > On Fri, Mar 31, 2023 at 02:13:10PM +0200, Geert Uytterhoeven wrote:
> > > On Fri, Mar 31, 2023 at 12:14 PM Li Yang <lidaxian@hust.edu.cn> wrote:
> > > > Smatch reports:
> > > >
> > > > drivers/soc/renesas/renesas-soc.c:536 renesas_soc_init() warn:
> > > > 'chipid' from ioremap() not released on lines: 475.
> > > >
> > > > If soc_dev_atrr allocation is failed, function renesas_soc_init()
> > > > will return without releasing 'chipid' from ioremap().
> > > >
> > > > Fix this by adding function iounmap().
> > > >
> > > > Fixes: cb5508e47e60 ("soc: renesas: Add support for reading product revision for RZ/G2L family")
> > > > Signed-off-by: Li Yang <lidaxian@hust.edu.cn>
> > > > Reviewed-by: Dan Carpenter <error27@gmail.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/soc/renesas/renesas-soc.c
> > > > +++ b/drivers/soc/renesas/renesas-soc.c
> > > > @@ -471,8 +471,11 @@ static int __init renesas_soc_init(void)
> > > >         }
> > > >
> > > >         soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > > > -       if (!soc_dev_attr)
> > > > +       if (!soc_dev_attr) {
> > > > +               if (chipid)
> > > > +                       iounmap(chipid);
> > >
> > > We don't really care, as the system is dead at this point anyway.
> >
> > Why even have the check for NULL then?  The kzalloc() is small enough
> 
> Because else someone will submit a patch to add that check? ;-)
> 
> > to the point where it litterally cannot fail.
> 
> I still don't understand how it can be guaranteed that small allocations
> never fail... "while (1) kmalloc(16, GFP_KERNEL);"
> 

I read an lwn article on it and I think I once looked it up to try
figure out how small the definition of "small" was and it was
surprisingly large...  But I have no idea.  I think maybe small atomic
allocations can fail and GFP_KERNEL allocations sleep forever?  (These
guesses are worthless).

> Perhaps we need a different mechanism to annotate error handling code
> that cannot ever happen in a real product, so it can be thrown away by
> the compiler, while still pleasing the static checkers?  All these
> checks and error handling code do affect kernel size.  There are
> Linux products running on SoCs with 8 MiB of internal SRAM.

People sometimes call BUG_ON(!soc_dev_attr).  It's sort of rare these
days.  It would be easy to make a function which silences Smatch...

	__system_is_dead();

regards,
dan carpenter

