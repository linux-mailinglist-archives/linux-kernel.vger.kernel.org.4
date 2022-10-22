Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01764608DA4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 16:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJVOVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJVOVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 10:21:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6440C29E5BD
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 07:21:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q19so15822651edd.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3y5NneVGSVHM3d4TxVK3DB/B/isDhSM9Gf6zlSsh6og=;
        b=fEYjzegl5no7TevDLOfHUBkm7rzl0qSt9KpunP6BMmHiN8kUy9GbodQAok8mD0UmDV
         wEw30+ospvHDZHn0EKinrLqjyUUm/bLG/pX10LHdXhqKCMlvbErPevVIYQwfY7i3LHPu
         ZRJRlIgra1wPEjLBdQqmAV+v6SVo+Ygsix4upYoPRPykuCLI//wlpNu7uv/q9JswYMEP
         24kyKfsD73+vSEmU6ecqkGGdTARi5ZfDnu3RKx2aOH4nvTZTmwGcYEWcFGdcM4Yh7FRx
         ZhlTgxqHt8kDNJUY2eiRetE1yuS7N1QBsDrcKn7Bt4k6JHjpGm0l9y9scyomloVsdMbu
         yB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y5NneVGSVHM3d4TxVK3DB/B/isDhSM9Gf6zlSsh6og=;
        b=pOEMfN5MmHee6aOdWZ9xQpMmE1h3T3A3dhj74Y2BuW6qA30NC424YQ2PFAVJQ2rPX7
         IWie5/SSBX6J4FgUNhB1RLuRElWtaSV7PQTYScOJgFjUuo1HZxJzt5T02YXjNWHySws3
         6JrcmMtxZ6uAJA75X+1+dqw+2jvN1WvDj9j37GCnA56ocFCqZgITjBd+rOVFvojEbdrg
         OFV1aJFXCeYfEhYxn5RprrdL5dAUrAatJADkdmQNwXk4wlnWeNtuug7nhEJcAeHNsPW8
         uHvaOrTOCYkkBWnGr1GzzExEce3KauVBSfqBCk8ojdMGw1A9qMWy1iFKyFfdfnhNEyor
         r9SQ==
X-Gm-Message-State: ACrzQf2dFUoUVd6xTGTZJPEGxDGvLxIKxX6C5ViDDrUbUKSf7qpAmvqP
        43bmQNHHhiCYoIQymx33HVcRWIjS7bQA3oT/GW2/va+mpCYQNQ==
X-Google-Smtp-Source: AMsMyM4X9zWrTzirAffhGB0WOX1DKzqBAFxwop6hJIJPvSwv25uxB4GP44x770IP/27iBsXBuJcOHtsaauk3b4N1BCw=
X-Received: by 2002:a05:6402:4029:b0:45b:d50c:b9b0 with SMTP id
 d41-20020a056402402900b0045bd50cb9b0mr22267578eda.126.1666448500471; Sat, 22
 Oct 2022 07:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221021181016.14740-1-ansuelsmth@gmail.com> <CACRpkdbfvr1pkVb3XhBZLnmn7vy3XyzavwVjW_VmFKTdh3LABQ@mail.gmail.com>
 <63531543.050a0220.b6bf5.284d@mx.google.com>
In-Reply-To: <63531543.050a0220.b6bf5.284d@mx.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 Oct 2022 16:21:28 +0200
Message-ID: <CACRpkdbOQq9hUT=d1QBDMmgLaJ1wZ=hd44ciMnjFVgpLCnK8Wg@mail.gmail.com>
Subject: Re: [PATCH] ARM: mach-qcom: fix support for ipq806x
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:55 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> On Fri, Oct 21, 2022 at 11:44:56PM +0200, Linus Walleij wrote:

> > Is it not possible to use Geert's linux,usable-memory-range in
> > the chosen node to make the kernel stay off the memory?
> > (See examples by grep usable-memory in the kernel.)
> >
>
> Hi,
> just to confirm this is one of the example you are suggesting?
>
> chosen {
>                 bootargs = "console=ttyS0,115200 earlycon";
>                 stdout-path = "serial0:115200n8";
>                 linux,usable-memory-range = <0x80200000 0x1fe00000>;
>         };

Yep that thing!

> Main problem here is that uboot in some case doesn't support dt and pass
> wrong ATAGS (with the memory not reserved) and AUTO_ZRELADDR calculate
> the wrong addr I assume?

You do have a DTB right, just that it is attached, and then the kernel
uses the ATAGs to augment the memory?

In that case what about disabling ARM_ATAG_DTB_COMPAT
and adding the actual valid memory to the top-level DTS
file? Just like that:

      memory {
                device_type = "memory";
                reg = <0x42000000 0xnnnnnnnn>;
        };


> I will test the usable-memory-range but isn't the same of declaring
> reserved space in the dts? Or the zimage decompressor checks
> linux,usable-memory-range bypassing atags?

As long as it just pass "too much" memory it should do the job,
I *think*.

Since I wrote this article:
https://people.kernel.org/linusw/how-the-arm32-linux-kernel-decompresses
Geert introduced some very elaborate low-level OF code and I
do think it kicks in and makes sure to reserve this memory even
before the decompressor goes to work (in difference from e.g.
"reserved memory nodes" that are not inspected until later).

See:
commit 48342ae751c797ac73ac9c894b3f312df18ffd21
"ARM: 9124/1: uncompress: Parse "linux,usable-memory-range" DT property"

Then if the memory node is in the DTB originally or patched in
by U-Boot shouldn't really matter, usable-memory-range should
kick in in either case.

It is described as used for kexec (which I never use) but I think it can
solve your problem too.

The DT property is (by agreement) an undocumented Linux extension,
so Geert knows the intended usecases better :)

Yours,
Linus Walleij
