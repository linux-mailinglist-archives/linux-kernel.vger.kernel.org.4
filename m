Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA596F9297
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjEFPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjEFPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:00:18 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6231F49E
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:00:14 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a44a2637bso43198057b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683385213; x=1685977213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNkRsBy8jmIVOhIRX+lWXHSIur+vpg4Wn3ELaF1i2/0=;
        b=ZmdzqLS7xSvYD2Tbhfh/xD6/b0N0VaYrB7D3bpjpM36biGof/ncmLOhzLWoIRM4cxF
         rMZuyK/868Q8/3/uztmdNnPJk14WbMEzNvGdrov5+03ZViNqoXppPMxy9vrvL9j84D7g
         GSuNPVcmceAtcQ9+Uzt80t8DcXKwULrXUvm48lNt3y8Yhi8l2Zhx+QwAMG5ni2+AlBiJ
         8hz3UAsQRprdGU/DBRYQE+5axbtEwRQoIz9QJ9KDBWWuU6JvPsIvZxjBedCh6FVtzjaJ
         vFtbxStWRajPCnXrtPlPHoocAmC6K5oWlSKo82gT/zfZCUHufdmxCEtmM7/o8TDNNtM9
         sMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683385213; x=1685977213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNkRsBy8jmIVOhIRX+lWXHSIur+vpg4Wn3ELaF1i2/0=;
        b=IKhVAg8YeTZZF6Tpfmjh89dxznLDcRiH3X77vhHOCLR655g0KRnpsqmypVtXsTLeai
         gxeBDg/5LPtK7miAVUcfAm/i6r/6tjJ9ZiYNbo4iabByHK5/S2GlH29P9HTcZtOkReV+
         hsBRSLzX0K6fYkX4Te2BS4Ar2GO5J0JQMQ/moYlmQqA1tqhBPj7nX3PZgEQgToS+AGW6
         l0sDFovTGDDcmHA+z+QzomNzlZJB25OFFIh0gdyHW/Jv1sU+frA7/+5T7VDgsx5JLbWb
         MuulfrsfC1eHlAAsR8YB5vNBAIlUYAY7i3S7dyhzBF3Wuy7XgKj+nZR+P9LF383fU/HG
         GfOQ==
X-Gm-Message-State: AC+VfDwMRz3w/dxPocOeUon4V7mf7vd+ZY4Q8VicnpB9s89y8juf2+Ym
        9DSkFmPrGqfz0iUZKGSgWJXP2RyeYrJb/Y7oy6M63Q==
X-Google-Smtp-Source: ACHHUZ5ED6NTeLKj6ZlWakj64JmtHbV7+2WxtnKr2jb5gYyUufWJOGNRCQ+8FBR8LT9KgvEWrmKoBkfq7E5K8qY84V8=
X-Received: by 2002:a25:abec:0:b0:b9e:7ec8:5d41 with SMTP id
 v99-20020a25abec000000b00b9e7ec85d41mr4713885ybi.55.1683385213473; Sat, 06
 May 2023 08:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230506111628.712316-1-bhe@redhat.com> <20230506111628.712316-2-bhe@redhat.com>
In-Reply-To: <20230506111628.712316-2-bhe@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 6 May 2023 17:00:02 +0200
Message-ID: <CACRpkdYo+NPtqjbUCrohE8yhyvc3vuqycP6RctY5rsiZXiiQWw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] pcmcia : make PCMCIA depend on HAS_IOMEM
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 1:16=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:

> On s390 systems (aka mainframes), it has classic channel devices for
> networking and permanent storage that are currently even more common
> than PCI devices. Hence it could have a fully functional s390 kernel
> with CONFIG_PCI=3Dn, then the relevant iomem mapping functions
> [including ioremap(), devm_ioremap(), etc.] are not available.
>
> Here let depend PCMCIA on HAS_IOMEM so that it won't be built to
> cause below compiling error if PCI is unset.
>
> -------------------------------------------------------
> ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
> cistpl.c:(.text+0x1202): undefined reference to `ioremap'
> ld: cistpl.c:(.text+0x13b0): undefined reference to `iounmap'
> ld: cistpl.c:(.text+0x14a6): undefined reference to `iounmap'
> ld: cistpl.c:(.text+0x1544): undefined reference to `ioremap'
> ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
> cistpl.c:(.text+0x3f14): undefined reference to `iounmap'
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
