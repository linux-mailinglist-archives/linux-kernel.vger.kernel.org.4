Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80405BA363
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 01:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIOX5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 19:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIOX5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 19:57:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E0750181
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 16:57:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lh5so3932953ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 16:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RsQe7nphqHbU0PAhl5+uvSXohwaK5GRUowgk9iZmnMU=;
        b=HzLQ0C8YNtKK238UtoGDCLXb9p2pNbvNAUaFmiJhQE2F7+LJWTIQJWfHOWC+5Pp6P2
         tfY9xMV5A0bL+psxgczMAPdBzlIOs1kcSKjYkHt1D1IyIGnPaoTcv0zbNLxBO3Uf/fTz
         GjdyS33axKfIOtI4S3iOEzeLEr+noyI5GGy+taah+z98TR1f56ys/QfjnaiuhbQj3edI
         PtcKq9vocIdQZfQVx9j9/RTRvkOdDAe9V5wNFfsm5KFOfnrOU2OrDidC8uzC+/QRp390
         kYXAtdE2kJ4jAOp+lyozMpAqMIW4Y0Rni6YtQh/QGBdxExgFIKISqmB/zsxRFxVoO7CI
         qpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RsQe7nphqHbU0PAhl5+uvSXohwaK5GRUowgk9iZmnMU=;
        b=zPxp2mdgITzg99rvAtpylAEoJ8pd6ibf9v6p6SUlvTSV0Q1k/EuKKKHWCxLNxh/QXQ
         UaQyc85SQ0/OPw//M/c0dhtVZdmrB9bKEY1W6Qz9wc2SG7FhiOIZTXI9qumK1d90/eDH
         2iWf9kbQj/iiuXghlYvnw+o/+C6eYXkX1TXh8S7C/5jq1EmJHVKEIMwNt6sabZiZgSaw
         zPGORcWvKbvFT0enyqYhtia3XNA6PVa9gPHf64S/ffJZkju4yH+h6rkJergMZtgmn4CB
         YnUSYZmQYyMftG4rAZKdZxwBRU2PRlSktz7SUuQ20icMN5hBfbG+xBCR9BS86fDrGBLg
         KPaw==
X-Gm-Message-State: ACrzQf1OWpvqkkKOHfHj2fPeryyyJaCFlEubEndVjnmbv7bS2LvILNIa
        UrcptmQnC+qdKeQ2JtkD5Wx61dcZWKLoJEr7oAxfIQ==
X-Google-Smtp-Source: AMsMyM4Rndho8mlic/vcoNp7Cbmzxg0scU8YjgroeXWWcgexuw3ccGmisz/E1lqc7voWrBwlgj5kYWE+bMgOItYphLU=
X-Received: by 2002:a17:907:7f07:b0:779:7f94:d259 with SMTP id
 qf7-20020a1709077f0700b007797f94d259mr1584691ejc.525.1663286232160; Thu, 15
 Sep 2022 16:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220829173830.3567047-1-f.fainelli@gmail.com>
 <20220829173830.3567047-3-f.fainelli@gmail.com> <YyNN/IZgOAlbSHnF@lx2k> <3dc9d86d-7b98-33ab-880e-a9584b8fac4b@gmail.com>
In-Reply-To: <3dc9d86d-7b98-33ab-880e-a9584b8fac4b@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 15 Sep 2022 16:57:00 -0700
Message-ID: <CAOesGMghG46a8V-VAbaR8+g2kZPDvEV3=_ejGr=14zvdWCjyfA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: Kconfig.platforms: Group NXP platforms together
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        krzysztof.kozlowski@linaro.org, arnd@arndb.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        william.zhang@broadcom.com, anand.gore@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 1:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 9/15/22 09:08, Olof Johansson wrote:
> > On Mon, Aug 29, 2022 at 10:38:29AM -0700, Florian Fainelli wrote:
> >> Group the three NXP platforms under an ARCH_NXP menuconfig symbol to
> >> make make selection of similar vendor SoCs visually nicer.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >
> > Hi,
> >
> > While these are convenient if they're done right from the beginning, the result
> > of adding a new dependency like this is that old defconfigs stop working if you
> > just go with the default.
> >
> > Was there a reason to group these now and cause this config churn for
> > downstream users?
>
> No reason to cause churn, and no specific reason other than visually and
> logically group options from the same vendors. I had clearly not
> anticipated the defconfig breakage, too bad that Kconfig does not allow
> menuconfig items to be enabled by default, or does it?

My local workflow is normally that I update my trees, then run a "make
oldconfig" and go with the defaults on new options. When I do that,
the layerscape arch option drops off, which turned out to be
unfortunate since it was the machine I was running on.

It's less of an issue if you use an in-tree defconfig (presuming they
get updated). I worry that distros will have similar issues if they
supply their own config.

Again, this is a one-time thing but it's easier for everybody if we
find ways to avoid them. Giving these new groups a "default y" might
not help either, since that would need to come off at some point, and
at that time the same issue will arise.


-Olof
