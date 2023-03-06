Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64D6ACF50
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCFUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCFUkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:40:19 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2020D32515;
        Mon,  6 Mar 2023 12:40:18 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g17so14479916lfv.4;
        Mon, 06 Mar 2023 12:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678135216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5xCU+4K22QCJeXOZIHGB1ay03MsJ5ngq2oxjOOLycg=;
        b=NJdmp+Ih53tVRJHSWwb3N1EuGsX8p3LXbOFhDc9zAoykcqXPUYw4BFkwedbXOxYbxf
         EIyF9ueP7V1HSpPilQSjkXNTZUxB2p4/3pd4Xwq5klSjz1QBBRgAcoGyjv0jSIfN3Ay4
         pWor+BcuFZ+iG4pt2RQKy1VAx5Hz8wQNNjemMW17pZCqftpmn7b0tdW0DLxj/NlDb4K3
         95sUhGc6djMSAazA/qu3sg7/0dlixyKgEZNrOtw0w1Ej2klPlTa5YA4LO0mUB8Ys36zI
         lyt9Y4SkHBgcU+PkVJ/VCePT/OXHiRSWSvIEzd/TRGyDkd6+ZQuPINYL14xQxqU5hZ83
         5UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678135216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5xCU+4K22QCJeXOZIHGB1ay03MsJ5ngq2oxjOOLycg=;
        b=Vxn9KhZ+6G539+dNBHB7nphOtrer4qCMZBbRInh786HZDbRIBXrRpZzZR+3+JQXUc+
         5NnvYDwxCIB8PvyWD7e0ogxLsrpcw52UrezxtMdoChF84Yzg4WWAlp6C8Ijoc8oTRfL4
         adWbIZJ9xAME0MUADtJ/GHQ7MfgUJX/Vw065M9b/HTxuxWgi5idykQhrivAA5XMQEflS
         0gw3exHvWc3H1P7YJLX6O6sNRXSOfWvJ6sNqzsGrNfyj1KT8r9gT70G4qcn1r2NY5CsT
         msb6D/RLJibvz4QTRDZpQU8C9rwhjR1L6/QJ2DfQLflpVvzFmEHaLTr3XdP4P5emZe2g
         5eNg==
X-Gm-Message-State: AO0yUKU7H3WzV7rzz1MDHaVuI9RPt88E3+LHnoHsCM68JLm5xGRaJAbO
        BKkQCCYH0xEXd3Nv6XlP6FM=
X-Google-Smtp-Source: AK7set+mLoGDuEDuRacjtiEHNZGI3k/nmUsqCORyUapp8CCuUtxWS7KHPJu00VHORByMX2kVT8IwdA==
X-Received: by 2002:ac2:5a06:0:b0:4dc:260e:6b59 with SMTP id q6-20020ac25a06000000b004dc260e6b59mr3427147lfn.40.1678135216166;
        Mon, 06 Mar 2023 12:40:16 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id l30-20020ac2555e000000b004dab932248fsm1744188lfk.180.2023.03.06.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 12:40:15 -0800 (PST)
Date:   Mon, 6 Mar 2023 23:40:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Brad Larson <blarson@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 10/15] spi: dw: Add support for AMD Pensando Elba SoC
Message-ID: <20230306204012.dgfqczwcwh2hkbii@mobilestation>
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-11-blarson@amd.com>
 <20230306160017.ptd3ogundxvus5zm@mobilestation>
 <CAHp75VfFMiy35Q1bX3Az3HgkhK+4bfH+pCE2XwOYVpqT8UiFXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfFMiy35Q1bX3Az3HgkhK+4bfH+pCE2XwOYVpqT8UiFXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 09:59:29PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 6, 2023 at 6:00 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > On Sun, Mar 05, 2023 at 08:07:34PM -0800, Brad Larson wrote:
> 
> ...
> 
> > > -     node = of_parse_phandle(np, syscon_name, 0);
> >
> >         node = of_parse_phandle(dev_of_node(pdev->dev), syscon_name, 0);
> 

> Side note: I would rather see syscon_fwnode_to_regmap() instead of
> this. And IIRC syscon already has an API to find by name.

Ah, right. Though it's called syscon_regmap_lookup_by_phandle() and it
can be used to replace the entire pattern: "Parse property; Find node
by phandle; Get regmap by node". Basically the of_parse_phandle() and
syscon_node_to_regmap() methods invocation can be replaced with just a
single function call. Thus there won't be need to worry about
decrementing the found DT-node ref-counter.

> 
> > > +     if (!node)
> >
> > > +             return dev_err_probe(&pdev->dev, -ENODEV, "failed to find %s\n",
> > > +                                  syscon_name);
> >
> > Hm, using dev_err_probe() with known error value seems overkill.
> 

> It's allowed use and it helps to drop a few unnecessary lines of code.

Ok, seeing there is no alternative to that method which would return
the passed error but wouldn't have a name implying the silent
deferred-probe error semantics.

-Serge(y)

> 
> > > +     syscon = syscon_node_to_regmap(node);
> > > +     if (IS_ERR(syscon))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
> > > +                                  "syscon regmap lookup failed\n");
> 
> -- 
> With Best Regards,
> Andy Shevchenko
