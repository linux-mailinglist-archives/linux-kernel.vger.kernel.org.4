Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32AD67F3E6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjA1CBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1CBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:01:06 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ED6FF0D;
        Fri, 27 Jan 2023 18:01:01 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j9so5225580qvt.0;
        Fri, 27 Jan 2023 18:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCJs7O03whIEGaIFF4vXtW596T1gv2Fh9Gz+8ZKNk/Y=;
        b=Up26oqpW8J+tIaMx+urIRFxrGNWcAiJGqEnM2kXMzedavwdpFuMwqDg5alv+udxgpN
         KHvPcYXKuEdOSHPISShCek5SBSdz72BboW2LInZ/t1QW1z4pXVoiV7WIPCJbgrJDU+K4
         UL9ndCMJppyYXLrtSbIupTR44a9nbC0sbAP4Vucwq/e++327HbXPcChQVswXKBaLZWqv
         +M4SZdQAT3jfFiK91BpmEBiByriTIwWz/4BiaQLZjRPICC8BcioANnCdJO2LtVdMXxcO
         7vIRfy15yR3JGOLjDIDYH7w6vReaVTdsj0Dxb1k05UukW0acK49lRtfYxzWaAHbeF4pN
         rwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCJs7O03whIEGaIFF4vXtW596T1gv2Fh9Gz+8ZKNk/Y=;
        b=lP+g+RMaLJPbEE8T7YMsQoi3YQ2Z4Cxxw6tVTHyw1jVAwpEnGL+lGFFaxMDXTg4cFn
         ox5TSnkAGE+XGZ1BnUDDn0nyYVyHVW1fjJDEhTj/74++Yd+NtsKAwWE4g6Z9cvhQvrD7
         QB1Tiq0VcEqyXmNeczsxMeVR5fsW/airzcdrAK7KVSCfvFzoJWWGnnnWSLpx9N79uDpm
         HoDOP4eDYM1ULtZkCzly1YYX42ieUNQBuq488d8uEJifs/HrH9RpaSbiXYXLEhAaettH
         T0aCRSpb1WyJqclLt9DRklXlM/U6aLI5a8jSl0SZwe1ezCWxqZt7ogC0QPcKvLglmuH7
         +edw==
X-Gm-Message-State: AO0yUKULixoeuipZ66rJr+ptfGWIa0cesf7r6yjAzDXHS3igwbT6InSK
        pZbxFD1gviLMbHMhh6tO/WOx2ONyvkdjtSDb2Y4=
X-Google-Smtp-Source: AK7set/sb+VvbJBcBgfEtvwvohVn73bpXCu66iCRn+WF+hPFe+TqYr4so5movgndD+RAT5Mvj9JuhXqaF1HQqNnVEMk=
X-Received: by 2002:a05:6214:a8b:b0:537:7aa3:20ac with SMTP id
 ev11-20020a0562140a8b00b005377aa320acmr685586qvb.126.1674871260078; Fri, 27
 Jan 2023 18:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20230123214924.27476-1-afd@ti.com> <f8922fbc-13cc-4f08-a8e8-08d39ab7d63c@app.fastmail.com>
 <3ab320ef-dfbb-eee4-f895-6f1caa6cc66f@ti.com>
In-Reply-To: <3ab320ef-dfbb-eee4-f895-6f1caa6cc66f@ti.com>
From:   Daniel Tang <dt.tangr@gmail.com>
Date:   Sat, 28 Jan 2023 13:00:49 +1100
Message-ID: <CAPnH9dnGZxbMGy7c_7PFqw6R1PSVba00XWK8rUN4MEsWU7=9=g@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] TI-Nspire cleanups
To:     Andrew Davis <afd@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Tue, 24 Jan 2023 at 10:56, Andrew Davis <afd@ti.com> wrote:
>
> On 1/23/23 3:57 PM, Arnd Bergmann wrote:
> > On Mon, Jan 23, 2023, at 22:49, Andrew Davis wrote:
> >> Hello all,
> >>
> >> This series is an extended version of the series started here[0]
> >> and here[1].
> >>
> >> We break out what was the first patch into one for DTS change and
> >> one for code changes as suggested by Krzysztof. Those are now patches
> >> 2 and 8 of this series (I kept the ACKs, hope that is okay).
> >>
> >> As also pointed out by Krzysztof syscon nodes need a specific
> >> compatible, add that as patch 1.
> >>
> >> While I was adding that, I noticed some other dtbs_check issues,
> >> so while here fixed some of those up too (patches 3-6).
> >
> > Looks all good to me, if there are no final comments within the
> > next few days, can you send this all to:soc@kernel.org, either as
> > separate patches or as two pull requests (dts and code) based
> > on 6.2-rc-1?
> >
>
> Sure thing.
>
> > I think I previously commented on the lack of an entry in
> > the MAINTAINERS. It would be nice to have one more patch to
> > add this, whichever way you want to split this with Daniel,
> > adding one or both of you as maintainer and/or reviewer.
> > I'd keep that separate from this series though, to not hold
> > it up any longer.
> >
>
> Daniel,
>
> Do you want to do this? If not I can add myself as a reviewer, the
> point of this series is to boil down the support to just the DTS file,
> at which point hopefully we won't need too much maintenance.
>
> Andrew
>

I would prefer that someone who is more active in this project be the
maintainer (I've not been working on this platform for many years now,
and don't currently have the means to test changes).

Fabian, would you be OK being listed as a maintainer for now? If not,
I'll get in touch with some other project team members to find a
maintainer.

Cheers,
Daniel

> >       Arnd
