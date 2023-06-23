Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6AB73B926
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFWNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjFWNwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:52:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F2B269A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:52:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51a3e6a952aso687351a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1687528348; x=1690120348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S6OHdItsTA1JwEPFdtVcZWMFJNNUsFlvqd8wRr+OUY=;
        b=nAce8ga+PROGouUoidmVoa9MzzT4VKceza4OhOuRIrN+5JqaA3WkDPC5LeYqt3YuZl
         2HDMZKlnXxn1GxbdtDj4lyz50v9F7oC2oDzNaI6940PB7TEop0jMQqAauMiaJIXqaIsi
         y/bLhiO9HDfI4+5QFBjf6fqhm03lni+3xdGXkzzxj3UrbrdjWks+kde/XVOEiw4kiQSV
         QhKvRfLnp0ekeVOI4extHqhCHK2JjEhKR6dCf5EvjVCuMe9mhUaWBqhHt+3X2csIE2au
         oaAovgYAxbXS4YbjQqIKfJUEYQGiMGXYyrzj6FCFF8rURCWTujhqLNueJ4wQjUXI0t+8
         N/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687528348; x=1690120348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9S6OHdItsTA1JwEPFdtVcZWMFJNNUsFlvqd8wRr+OUY=;
        b=XFPPlmYVvTj+q1C+DICFZw7DnMSxFr4yoMWNObc7wJNrnhjQKyz0Mmg5wtJqiLwz5Z
         8Wk7qzh8kYdnRUv830HE5WwmDqytHLUdIVDx7XWPlu8gYdsjK9z0uBy39eVcQr8fMTtK
         tsOC2tC9eUW2pI6POgxt8C+rbA3nveUtcBCUT9KICaOmzfqNd1l3hiLkieBeyXuiQXU9
         bqfwRRfGgKsdAh2jhsIM9WlLWC6E45mQYFCrT8tnjod9c83KEnG8KXc9SOdpvds6OdpK
         MFS99Iy6R8tmnMDo0sGjf7iRGfSEtuiyzOQxr1Z1q/ai9V1OXo3p1HkpAE3OnhVCPvzk
         QoZw==
X-Gm-Message-State: AC+VfDxGFyjaGjens2n6RPLxVyGZz3Zl4kTg8102+S0pRReGVQZd9hK3
        +VMaEejNHPhiNjhSn3/KWXt/vAjN7mLjMG5VpY+XKw==
X-Google-Smtp-Source: ACHHUZ5paNz1Cy14U0D10w5MW6F/Bi3rLn0+7A272F60E7dMKSk92KbX4Dy3Ud9Nb1GD+xk5zK+AHrmxfK2LTcZejxw=
X-Received: by 2002:aa7:d1d4:0:b0:51a:5ae1:b6e5 with SMTP id
 g20-20020aa7d1d4000000b0051a5ae1b6e5mr9949319edp.10.1687528347990; Fri, 23
 Jun 2023 06:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-9-apatel@ventanamicro.com> <CAGETcx-hoPNanAwe4++6roqBXwSdc7z6Ei=-r9z6qFG1U7xVXg@mail.gmail.com>
 <CAAhSdy3WH_nrKC-3AC4RHn9=crh6mPzaKO8jmAeo2j8-VJnT5g@mail.gmail.com>
 <CAGETcx_DkuyZ+c50QmA7eu8vUByfVosABugZpd7R8NgR8Wc-FA@mail.gmail.com>
 <CAK9=C2X4+aTs=+WdE0ba1qPDu67TiAKgE2Rx-qqD5+TJwYCKOQ@mail.gmail.com>
 <CAGETcx_KJURkxEuZOgPZR=fA4CaHnAwwRfU_JLJ28absFWAtzg@mail.gmail.com>
 <CAK9=C2XNAXaorxeNAB02o3_mYe3fsDSHS7rj=5+=q=d67Od60A@mail.gmail.com> <86mt0qbaxg.wl-maz@kernel.org>
In-Reply-To: <86mt0qbaxg.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 23 Jun 2023 19:22:15 +0530
Message-ID: <CAAhSdy3eW_urQ_716DdBp8SN2zFN3oMMOt695cW4EQbejraVhw@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] irqchip: Add RISC-V advanced PLIC driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 6:19=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> [here, let me trim all of this nonsense...]
>
> On Fri, 23 Jun 2023 12:47:00 +0100,
> Anup Patel <apatel@ventanamicro.com> wrote:
> > > No. My previous email asking you to NOT use IRQCHIP_DECLARE() and
> > > instead use IRQCHIP_PLATFORM_DRIVER_BEGIN/END() macros.
> >
> > I tried IRQCHIP_PLATFORM_DRIVER_BEGIN/END() macros but these
> > macros are not suitable for APLIC driver because we need platform devic=
e
> > pointer in the APLIC probe() to create platform MSI device domain (refe=
r,
> > platform_msi_create_device_domain()).
>
> Oh come on. How hard have you tried? Have you even looked at the other
> drivers in the tree to see how they solve this insurmountable problem
> with a *single* line of code?
>
>         pdev =3D of_find_device_by_node(node);
>
> That's it.

Please see the below diff. I tried the same thing but still the APLIC does
not get probed without the FWNODE_FLAG_BEST_EFFORT flag. Please
note that the current APLIC driver works unmodified for both DT and ACPI
but using of_find_device_by_node() here breaks ACPI support.

diff --git a/drivers/irqchip/irq-riscv-aplic.c
b/drivers/irqchip/irq-riscv-aplic.c
index 1e710fdf5608..9ae9e7fb905f 100644
--- a/drivers/irqchip/irq-riscv-aplic.c
+++ b/drivers/irqchip/irq-riscv-aplic.c
@@ -17,6 +17,7 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/smp.h>

@@ -730,36 +731,12 @@ static int aplic_probe(struct platform_device *pdev)
     return 0;
 }

-static const struct of_device_id aplic_match[] =3D {
-    { .compatible =3D "riscv,aplic" },
-    {}
-};
-
-static struct platform_driver aplic_driver =3D {
-    .driver =3D {
-        .name        =3D "riscv-aplic",
-        .of_match_table    =3D aplic_match,
-    },
-    .probe =3D aplic_probe,
-};
-builtin_platform_driver(aplic_driver);
-
-static int __init aplic_dt_init(struct device_node *node,
+static int __init aplic_of_init(struct device_node *dn,
                 struct device_node *parent)
 {
-    /*
-     * The APLIC platform driver needs to be probed early
-     * so for device tree:
-     *
-     * 1) Set the FWNODE_FLAG_BEST_EFFORT flag in fwnode which
-     *    provides a hint to the device driver core to probe the
-     *    platform driver early.
-     * 2) Clear the OF_POPULATED flag in device_node because
-     *    of_irq_init() sets it which prevents creation of
-     *    platform device.
-     */
-    node->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
-    of_node_clear_flag(node, OF_POPULATED);
-    return 0;
+    return aplic_probe(of_find_device_by_node(dn));
 }
-IRQCHIP_DECLARE(riscv_aplic, "riscv,aplic", aplic_dt_init);
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(aplic)
+IRQCHIP_MATCH("riscv,aplic", aplic_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(aplic)

>
> > Further, I tried setting the "suppress_bind_attrs" flag in "struct
> > platform_driver aplic_driver" just like the
> > IRQCHIP_PLATFORM_DRIVER_END() macro but this did not work.
>
> I'm not sure how relevant this is to the conversation.

It's relevant because the only difference in the platform_driver
registered by IRQCHIP_PLATFORM_DRIVER_END() and
"struct platform_driver aplic_driver" is the "suppress_bind_attrs" flag.

Unfortunately, setting the "suppress_bind_attrs" flag does not
help as well.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Regards,
Anup
