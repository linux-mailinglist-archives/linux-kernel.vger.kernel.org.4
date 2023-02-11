Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD368692E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBKGZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKGZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:25:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2252A9B2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:25:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cq19so4045879edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wclVxROs/KOhkdBKAZ2AIDmogjpBrtC4H68/fmp9w94=;
        b=FDFmipJ/ZB8iumNTYCSHE6RNkf3DV2sJ+bD4uCOWaWzFwTuTLL25JpuadL0ZaPdCbB
         aPxHdSxkpLRjoQXjz7AicTxS/0hOu/fiPzuerF+sbIUDMVQGraGjsLFELxyfzPkFQec4
         KHiPImrfOTECE/AJsAICcrAZUYdomHLlCRHvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wclVxROs/KOhkdBKAZ2AIDmogjpBrtC4H68/fmp9w94=;
        b=cS8C7q+cfUl9hgw3aaDzcLaIPlmNhMkArSSxaqVRAoJgBQLd/1/3pkgZR1Hd4RYZvS
         SgwlEJiMYIfWhR2TW3XsQcRGfcpW4mrxoDK+/PQqtYYYOQzcUe0MjIXv5RLECsUk8HIa
         zoNiztlC676zL3YlUmev8n759eAepAQmFRzLjqsEyoG8yo2XqA2U72bycPDnh3eTkbMN
         Ct4fEthkGOLo/p7DtIZcIHNsTQyEhBTNvBIcZKFL/jYIm32zJr904G4TKyz+vmKhRv2L
         RTQ1N6baLbJXo+aYJ2fErD4vIBNZQgRTAgDrAIes2UcdihBbSUqeH6RdkX8cH7R53Uh7
         zZ4g==
X-Gm-Message-State: AO0yUKWy1ff02z+oFXDvkthT1Oq9EYcQ+y2zNstoKGS54Bfpn5Vpwh/p
        CNqyoTCI5cHfJblp4tvuREGCQhAFJ+3K/mJoGK+QUA==
X-Google-Smtp-Source: AK7set9VtlKVpbrUtjbbdAIwBqvaa2fLQ1yaa3qkiprEdOKclYW5ywBLl1KfZiA7WbPK1VEfQmf0mt8ioWRrwZp49To=
X-Received: by 2002:a50:9f65:0:b0:4ac:b38f:51a1 with SMTP id
 b92-20020a509f65000000b004acb38f51a1mr798148edf.6.1676096724220; Fri, 10 Feb
 2023 22:25:24 -0800 (PST)
MIME-Version: 1.0
References: <S1728511AbfHaSEm/20190831180442Z+580@vger.kernel.org>
 <08fbdf25-faa1-aa13-4f13-d30acbf27dda@mipisi.de> <20190902074917.GA21922@piout.net>
 <alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de>
 <4fc3a016-ec2f-a15e-5fd1-6794a001e2d9@mipisi.de> <alpine.DEB.2.21.1909040047210.1902@nanos.tec.linutronix.de>
 <Y+O+VBSNywC7LKhn@panicking> <87edr02fsc.ffs@tglx> <CAOf5uwn1SKBR+pREZy9f-wnQf6Lw3epyHxiX_hjf_pOaiiSDWA@mail.gmail.com>
 <87zg9m26f2.ffs@tglx> <CANDhNCopf___L_3cARqK8WDHSJWFYYikxvANHh2CRMjDRag9yw@mail.gmail.com>
 <CANDhNCqaawcr6hxxKsk1Vd8e4kvwd8-qgVv--uLtWnB1AoJdig@mail.gmail.com>
In-Reply-To: <CANDhNCqaawcr6hxxKsk1Vd8e4kvwd8-qgVv--uLtWnB1AoJdig@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sat, 11 Feb 2023 07:25:13 +0100
Message-ID: <CAOf5uwnnJKTd2sQvN2Ooi+zVy+yvPY78BLkYJvAvkjSGft9iwg@mail.gmail.com>
Subject: Re: Problem when function alarmtimer_suspend returns 0 if time delta
 is zero
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Michael <michael@mipisi.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John

On Sat, Feb 11, 2023 at 2:18 AM John Stultz <jstultz@google.com> wrote:
>
> On Fri, Feb 10, 2023 at 5:04 PM John Stultz <jstultz@google.com> wrote:
> > Thomas' patch fixes the erronious 0-as-invalid initialization issue
> > using KTIME_MAX but also simplifies the logic getting rid of the
> > freezer handling.
> >
> > I don't have as much familiarity with the freezer handling change, so
> > while it looks sane, I can't say I would likely catch an issue doing a
> > visual review.
>
> Actually, because of this, I'm going to split Thomas' change in two.
>
> The first to just use KTIME_MAX as the invalid initialization value,
> and the second to cleanup the freezer logic.
>
> That way if the freezer change is problematic we can revert it and not
> lose the fix here.
>
> thanks
> -john

I'm not that Michael but it's ok I think to add both as a reporter. I can try to
test on my side too and then send a tested-by

Michael

-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
