Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52505B8B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiINPM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiINPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:12:12 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3C479697
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:12:10 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1278624b7c4so41827567fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dUULFqmfRMWFPRG0w2HpAhvn+lZZWbVqFSA6+Wlte24=;
        b=HNkYUrvMZ5EJ4Sbw3sERd4HJQ9JZ9Heu49ozVEtWK2TLowpnC9+ZKK/JYmMJHZljJF
         eCP7JYblTz8DCfYLgW4dQ6zplj88RiC/tTgo07TDQI24yNljOY07JYYACCf8TN6b41IF
         d6sU6lN6PC5eyj7RS2B6Gwc3rdsI8tyqttJb3KlRlE2l6y04W1BxTmrX/6QOaRsu5fZ4
         jyyrKzOGBulrvyjcPPHRIiXrf2SU+ZNvGvL2MzMF8gNdTkbDHZs+u9pRCgm88ouzkAVE
         eiGjlYQfMewPImiVyimyuUuXyU/y/Lhm78Yrtzz6kevHSARR4rCI5kJ9J5DzoTYaTZXS
         1kNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dUULFqmfRMWFPRG0w2HpAhvn+lZZWbVqFSA6+Wlte24=;
        b=Y6NbHkcl2IXPYsQ9kNzhnbouQlLSPs/j+CcdLq0vzW3nYRKGesGTfRh29Py844100e
         SBZyy2PNapgoMUYoWaHc0BT/iIzYazIC9+oBKyYRmyS0arwyaYNz7qT2+6xsxzQMzfwx
         +x5ZAz+tFZJiT/driTYFhm5Hhxd0Vibd+bpFptcOYDgdPfrOk1/Uf5RCZLQBEZMQjp7q
         9Fq8YqT0PLzPz73yXSEixRkkxBXsNE+O2BjPZm4NhP9jfugO62mbOIFhzBnmDs73cnvY
         SJ6sKagXe7l8wHz/54SZpLuY0tsbSsPQ6234Ztt3AFReehYdHXMasUykFY1+kj2qGZic
         fA6A==
X-Gm-Message-State: ACgBeo3Jr/TXTdrZmUl2hkmttZ1Ma/6HQN7M2dHmc+7EZ3Y7y2H6uuJw
        XeeccfGYBgJuyrLqNMEgnnQ7WLMkUc7Rht8X2h4OFA==
X-Google-Smtp-Source: AA6agR7lcWlo4UE+O269BoSyaeq0Ixm5EemFaeVO1H4uKxcbf+SS4CBTdqozGifeOADC54JI2Bw7dVeIIW0ZQQutDZE=
X-Received: by 2002:a05:6870:2488:b0:10c:3362:17ff with SMTP id
 s8-20020a056870248800b0010c336217ffmr2500649oaq.33.1663168329805; Wed, 14 Sep
 2022 08:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220913201557.2513488f@canb.auug.org.au> <CAJ+vNU2naFP=X1B3HwPCRez7Phft3OGA0sM6TMZUXJ78S5s6Aw@mail.gmail.com>
 <20220914034849.GI1728671@dragon>
In-Reply-To: <20220914034849.GI1728671@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 14 Sep 2022 08:11:58 -0700
Message-ID: <CAJ+vNU1vR8rTCR3m_7EhVaixB+MoZy_HbHZnvQAPD4=Vm8KFcQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 8:48 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Sep 13, 2022 at 10:08:16AM -0700, Tim Harvey wrote:
> > On Tue, Sep 13, 2022 at 3:16 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > In commit
> > >
> > >   c1f84a75babe ("arm64: dts: imx8mp-venice-gw74xx: fix port/phy validation")
> > >
> > > Fixes tag
> > >
> > >   Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400
> > >
> > > has these problem(s):
> > >
> > >   - Subject has leading but no trailing parentheses
> > >   - Subject has leading but no trailing quotes
> > >
> > > Please do not split Fixes tags over more than one line.
> > >
> >
> > Stephen,
> >
> > Sorry, that was my fault with my editor's word-wrap getting in the
> > way. I will be more careful in the future.
> >
> > Is there anything that I can and should do at this point to result this one?
>
> I fixed it up.
>
> Shawn

Thanks Shawn!

I guess this would be a nice thing for checkpatch to catch.

Tim
