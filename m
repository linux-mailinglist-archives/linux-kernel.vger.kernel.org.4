Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5016A66FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCAEgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCAEgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:36:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2139437B66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:36:44 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id h8so9438701plf.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677645403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W9hQB51GTypbp+uatvOUzvRwGcaPVnhPF9GgCO6eqI=;
        b=AnRY7ccWRsYs3zRIdEKJLQBSCVf0fUPTLiAHT9XmcwNbQkcH9fMM4/cbAOQuVlZlKG
         5AqVm6xK/UPy/vjoQUo6l8HjIJQNRytHJ/ERoq9zI+OHpZNddVPpuv1/KHCJXT5bzmmS
         7udadIK8zer8L4x8agk+wvLESsQui9n5rxG2aDY7yV/AYyCElgO9m4C+6HAf/bWySF1G
         P5kptiIyZqdyHejGSAA7BlNQd2BDohPXC8H/0BttdYLY06mboW2II8QO6v+LmftLNujP
         ItXNxKHY9R9wrkkDuSY7R8NGlJfQFQTch97uCLcSVNjq8RUb/GJqKn4/U5sqjMNx8aCr
         WNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677645403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W9hQB51GTypbp+uatvOUzvRwGcaPVnhPF9GgCO6eqI=;
        b=mx5Pu9TJWvUcKz5LR/6uzw4PAmmh42+lUAXuKqQiLKlh7YlkMBJz/d7EjNluX9Fchb
         6d5y8GZAzZb6LsHWpiMJAYnAm5klMQ0fK2j/2D9IlsvvF0mZ7IndJT+zakbGYIS1/aBo
         g6l5BdTTKCxzOnU8xiDvkivHI907w3WKjtV9ZsNbq2KV1BcoqlduOB5LTPipq/3KQSWv
         3P5wwjfr3vWpQFXDPH3VjKxVCksog0mNIS9jNA1m/Ord4NXy0NoZ+qMQJQNXLU/o2C5J
         97aonhrRQnnD4QNu2Ycb6r/JpBBoigJ3U8/E5whQc+Pazh+dVBU5Rm1Q9m6eb+c07udt
         TpBw==
X-Gm-Message-State: AO0yUKXBffuOBlTLVtoq4iBsihliXOIm0DisYq5cjojd1x8hRvRXRgEh
        BM4+IO6DSbzc8tvfDvC+iHk96UFpybbFq3nuVZO6rw==
X-Google-Smtp-Source: AK7set+oKzqEVt4NgiziRq+yuTqy6i2IUUU+8AQGvoAw0MZB2Cj+yYzNgM6sZUXMm5wNsHDayS9TZkMZimB5vB0Dn1s=
X-Received: by 2002:a17:90b:368e:b0:233:d131:29be with SMTP id
 mj14-20020a17090b368e00b00233d13129bemr1967203pjb.9.1677645402446; Tue, 28
 Feb 2023 20:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20230227201340.2087605-1-sdalvi@google.com> <CAPOBaE4U4rCJ+4CcSoj597LsP-0ESBhiKKHz00bk+SvNHrOzKQ@mail.gmail.com>
In-Reply-To: <CAPOBaE4U4rCJ+4CcSoj597LsP-0ESBhiKKHz00bk+SvNHrOzKQ@mail.gmail.com>
From:   Sajid Dalvi <sdalvi@google.com>
Date:   Tue, 28 Feb 2023 22:36:31 -0600
Message-ID: <CAEbtx1mhMqZjJeU0L99xpwY9W5caJmpv69aRZG+b-hLfstK-Ww@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: Wait for link up only if link is started
To:     Han Jingoo <jingoohan1@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review Jingoo.
Sajid

On Tue, Feb 28, 2023 at 4:04=E2=80=AFPM Han Jingoo <jingoohan1@gmail.com> w=
rote:
>
> On Mon, Feb 27, 2023, Sajid Dalvi <sdalvi@google.com> wrote:
> >
> > In dw_pcie_host_init() regardless of whether the link has been started
> > or not, the code waits for the link to come up. Even in cases where
> > start_link() is not defined the code ends up spinning in a loop for 1
> > second. Since in some systems dw_pcie_host_init() gets called during
> > probe, this one second loop for each pcie interface instance ends up
> > extending the boot time.
> >
> > Call trace when start_link() is not defined:
> > dw_pcie_wait_for_link << spins in a loop for 1 second
> > dw_pcie_host_init
> >
> > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
>
> (CC'ed Krzysztof Kozlowski)
>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>
> It looks good to me. I also checked the previous thread.
> I agree with Krzysztof's opinion that we should include
> only hardware-related features into DT.
> Thank you.
>
> Best regards,
> Jingoo Han
>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> > index 9952057c8819..9709f69f173e 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -489,10 +489,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >                 ret =3D dw_pcie_start_link(pci);
> >                 if (ret)
> >                         goto err_remove_edma;
> > -       }
> >
> > -       /* Ignore errors, the link may come up later */
> > -       dw_pcie_wait_for_link(pci);
> > +               /* Ignore errors, the link may come up later */
> > +               dw_pcie_wait_for_link(pci);
> > +       }
> >
> >         bridge->sysdata =3D pp;
> >
> > --
> > 2.39.2.722.g9855ee24e9-goog
> >
