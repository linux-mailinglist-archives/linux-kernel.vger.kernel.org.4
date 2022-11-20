Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149266315A9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 19:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKTSeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 13:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKTSeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 13:34:05 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C87310AD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 10:34:04 -0800 (PST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 859523F535
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668969240;
        bh=dG5PIPBE2GHp36S+UZp6jaADUVR1TUqcHiS7ewQr4PU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=OOfW4X9WAmhzquOYL/9Ch6Q+sF4hCdYRNArwmgM2RIMOvgG+sI4OWprzSErPc4X0u
         08ug1l9c6FkDZ3xVTMTVSebjPCQxVfJ0nQeDWjq2Uh/6E89TxEwq+Ys0E+lroMoQw6
         v8BSHZ+NzM2xv+Zcorlir28JYk6WihWTs4bxEawSu0HXgPA0Q8xHb5hdp2ETk2C8RR
         oc+MNRlOiTL4GkbY37xA0ADibOjHSB4LVihLrNN7EZJxOtpwRUc9TVvb/eA12IdXOR
         6MJoxkI1rP2QH4mAg14QMdsO/mLkZNUvGz2tptfvMqqFT86f1txAxDy2F9YwqYd2rr
         pI82xTBby17xw==
Received: by mail-yb1-f200.google.com with SMTP id f126-20020a255184000000b006cb2aebd124so9228286ybb.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 10:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dG5PIPBE2GHp36S+UZp6jaADUVR1TUqcHiS7ewQr4PU=;
        b=fDW2Qdt4lOSouvgtS8jKTTTlbOvw6J8+o9ZtqUOt2yC6PH5wsOX824XhZpiChs7DTh
         OWpbKEwciGp/MTmeKQTd4zNWb0lck0J8iZuY+su/4HBF6C9qyIkexd0Wt9Ne8F6HOkMd
         7mycGcHKbwe8bR6nAc+cilGDJ8rpzXrMdoAg/kXsDXDyud01b4UlMZuEohxDlkIEe6w6
         qf7fO5Xug+SsBjA5ZFHTbuA3qsNmF95M6x9+73AJDaqo53WitXkPZRYE8mpUHH8S4zZ4
         7vPKIHDVAFACSrUwzW9kGZSeiAz1PXKbGvakqJlpG75uLAQBMeH6jrMkYjH85H0ftOH6
         V7GQ==
X-Gm-Message-State: ANoB5pk9vVp0Tivy1IMMGunxFwqlwdSTO+/RETSWTL0CCOTA/liBeGRE
        ercdtz25q5UrCMXYZ/rtXkvrYoV8zwx7wB9nJJ4+QWH4EFFEfJQZ+no4r9ZUaKhmq4JfvoRtJaP
        O2EfdhllIWj2BdAmA23BtNQJi2ef7uJeymAc1LuwO9CUxdOvilRnVUMOeAA==
X-Received: by 2002:a25:ce45:0:b0:6de:39c1:9cb3 with SMTP id x66-20020a25ce45000000b006de39c19cb3mr4557856ybe.469.1668969238857;
        Sun, 20 Nov 2022 10:33:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7D5wi+VzurwIIfkrVA4oYQhDY3qKyG8JzAj9UB/Ym70XQ6dHirKxuyiYefeUUYc4HmKc2qyRnz8/hamiUIt4E=
X-Received: by 2002:a25:ce45:0:b0:6de:39c1:9cb3 with SMTP id
 x66-20020a25ce45000000b006de39c19cb3mr4557849ybe.469.1668969238637; Sun, 20
 Nov 2022 10:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20221120082114.3030-1-jszhang@kernel.org> <20221120082114.3030-6-jszhang@kernel.org>
 <CAJM55Z_f=zp3Z=wno_yr7csAUMQ472RiZXD19CrDTTxmGAmU4w@mail.gmail.com> <Y3ppF88SuYAPOjbU@spud>
In-Reply-To: <Y3ppF88SuYAPOjbU@spud>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Sun, 20 Nov 2022 19:33:42 +0100
Message-ID: <CAJM55Z95sJzn0zQJF5pGQkeMWTRj8FLyO6i+52idJ4ZMLOT5tg@mail.gmail.com>
Subject: Re: [PATCH 5/7] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
To:     Conor Dooley <conor@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022 at 18:51, Conor Dooley <conor@kernel.org> wrote:
>
> On Sun, Nov 20, 2022 at 03:57:17PM +0100, Emil Renner Berthing wrote:
> > On Sun, 20 Nov 2022 at 09:32, Jisheng Zhang <jszhang@kernel.org> wrote:
> > >
> > > Add a baisc dtsi for the bouffalolab bl808 SoC.
>
> > > +       xtal: xtal-clk {
> > > +               compatible = "fixed-clock";
> > > +               clock-frequency = <40000000>;
> >
> > This was discussed many times before, but I think the conclusion was
> > that the frequency is a property of the crystal on the board, so this
> > should be 0 in the SoC dtsi, and then overwritten in the board device
> > tree.
>
> Or set nothing in soc.dtsi so that dtbs_check can be used to see if
> someone forgot to set a clock for their board?

Sure. That sounds even better.

> > > +               clock-output-names = "xtal";
> > > +               #clock-cells = <0>;
> > > +       };
>
