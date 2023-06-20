Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5C173639C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjFTGca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFTGc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:32:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15328E6E;
        Mon, 19 Jun 2023 23:32:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9741caaf9d4so524892266b.0;
        Mon, 19 Jun 2023 23:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687242745; x=1689834745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUvrsoyBTmnKwq3+8NmvZjbs7IhL2HPMWhiZTI6kb+Y=;
        b=ZEE334ZWv8vcBQ/MCJ00ulzngLHrVcY1wTQSPc+SpMZ6rg6D+I3zxUuRQhClkRjmDk
         muXVm7pM6RQVMIIqSJs9sati3YdpcMyOQyI81m5xpyt10qCdmHng7G1eWqm6ENVXz8au
         PHHiXA2hlcWKgVXnvYJLyvQTH6RDk1rVJXE9wrLtps8mP0khJ0DmLfjYrEuwsacjZ1q+
         ZRiZoMHJlaelzcWetMRVN8ky7urpa8MF8g91sD70T5YcnexoEB12Y1g6YyrGjwIoKDpE
         ddHbW5hLxd60G+KWF45fifg/S3hwYukd//CA8b/rtofjX+yUyRN2OElvuOw25Nv+O+ho
         N/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687242745; x=1689834745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUvrsoyBTmnKwq3+8NmvZjbs7IhL2HPMWhiZTI6kb+Y=;
        b=TmlsnBKQDPMkKMc6i6qN1xK0/gYDX8MnR2KzQr1hswKJVbALmyO2QK+d4Eha+H6/QU
         5DYQKEjPGI6EW5hy40hnroHI0ZTvTbE2UhIzF8M/AsY40xo9j1ltKyM4D2A+ntxFe/Rv
         SgNv4pFvCIUBASx2tvLqBNAWcSQqPM+awziHo6nANN+t/GZJhJ+EtdqxXl+RMKud3nuc
         lKXpXjVmLuXi1zqL/cUcedc+RWjDiwWApFMdxFhWcQHoAtjShiU+I9zycKt2sdc0s/L1
         rps3Y0RfYs4Xtu+eTWCNFkuAnOvlamzJ+3JHnyQql99/AYRxL88YAWb/BrvMZo/yQxJg
         3IpA==
X-Gm-Message-State: AC+VfDwYw8tjfNAsGPx4vwuQDb77JOLbspAyfiq4JoOBPOK+cAOE2DtP
        nH+/XBag4SwYqXx+RzcIEgYIw/LaeN70TSDqvio2erIzNXQ=
X-Google-Smtp-Source: ACHHUZ7U1T13g/LzdepRWVqy66RRXWlJzNeRXfB7bSb8JDJlYZRZDL82+nYiuGLc3eSPGbeYp4jH7QInpQ1S6WRUv/M=
X-Received: by 2002:a17:906:eecd:b0:988:699d:64d0 with SMTP id
 wu13-20020a170906eecd00b00988699d64d0mr4877634ejb.32.1687242745230; Mon, 19
 Jun 2023 23:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230531134606.3385210-1-sashal@kernel.org> <20230531134606.3385210-8-sashal@kernel.org>
 <ZIy4GjSrV654NsBw@duo.ucw.cz> <CAOLZvyHQL7T33O9fSdBZMtjrLKO2uN6Gr6g_p0oKVUtnMuXheQ@mail.gmail.com>
 <ZI7GorATfHRiqOn9@duo.ucw.cz>
In-Reply-To: <ZI7GorATfHRiqOn9@duo.ucw.cz>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Tue, 20 Jun 2023 08:31:49 +0200
Message-ID: <CAOLZvyGhOpZ1NAfOKTOOq34Khh6nXAuLYVVB0DhLa4VRqsi-Vg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 08/10] MIPS: Alchemy: fix dbdma2
To:     Pavel Machek <pavel@denx.de>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 10:56=E2=80=AFAM Pavel Machek <pavel@denx.de> wrote=
:
>
> On Sun 2023-06-18 07:43:10, Manuel Lauss wrote:
> > On Fri, Jun 16, 2023 at 9:33=E2=80=AFPM Pavel Machek <pavel@denx.de> wr=
ote:
> >
> > > Hi!
> > >
> > > > From: Manuel Lauss <manuel.lauss@gmail.com>
> > > >
> > > > [ Upstream commit 2d645604f69f3a772d58ead702f9a8e84ab2b342 ]
> > > >
> > > > Various fixes for the Au1200/Au1550/Au1300 DBDMA2 code:
> > > >
> > > > - skip cache invalidation if chip has working coherency circuitry.
> > > > - invalidate KSEG0-portion of the (physical) data address.
> > > > - force the dma channel doorbell write out to bus immediately with
> > > >   a sync.
> > > >
> > > > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > >
> > > I believe author's signoff is missing here.
> > >
> >
> > As the author, I say this patch should not be applied to 4.xx at all.  =
Same
> > for my other 2 MIPS patches.
>
> Thanks for info, where is the threshold, do we need them for 5.10?

Drop this one "MIPS: Alchemy: fix dbdma2" from all stable,
the other 2 can be applied to 5.10 if need be.  I seem to be the only activ=
e
user of this hardware and I only test mainline, so it's probably not a big =
issue
if you drop the all from stable.

    Manuel
