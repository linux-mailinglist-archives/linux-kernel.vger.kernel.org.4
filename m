Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D0C643EFD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiLFIqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiLFIqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:46:45 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87CFACE;
        Tue,  6 Dec 2022 00:46:44 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id q7so16409921ljp.9;
        Tue, 06 Dec 2022 00:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2CyyvjWQb02aPEt6EJDci069U7CWH+geZeCwCy/8e20=;
        b=I+SStnl653eOmW8BMVQ/Tq8EK24wPKeeaGU1aOoS4G9kBdSpYdJhRAM8cp5PaLGWYa
         +zduL0zCugd9tRq1FRpK6P50hXzOvdUQXOQzRo9K+jqXxzXktSa6mnoOdMd/16fAHqGv
         0sTAswz0qZe0dY34nK3K+GWke9YD9igfEV2DxU4AyBP+tEqdwsiFjcB4jupizbI4QaA1
         TcJqpfZGuxO13mD5a/x87Cp1JElEpH/RthZLLTjiewe7MesJXJFxWAEQCBhy98n74MWK
         CvX2qaB1tD7i2XNCuuIyj6b1xCq21Idmwr9SA8kwm2gri8ZGG94D525h15RuseAUvZ8d
         3DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CyyvjWQb02aPEt6EJDci069U7CWH+geZeCwCy/8e20=;
        b=YLomukGkquTrPTUwwuS/1tYvB49jcJFJHYbxiiY8qbwun9K8DuYOoZPU9Afjxbg8vo
         7sFkNnU7n5ywwJJSMXvukIMXqizrSW0Da8sqMqBiX+cxOdpCWsIGXgOc4+eWbyMjTCpU
         pjbvYIPNs27fbbkabuDdkPMi4aWoM+/q8nyMwDz1/oQRLA/7cXF0vah/aWtYpq92j0qv
         LsBkT13w1VSs62/ICqSXxOQHoLuOxkx4T7yHwLgBrybiTXGMDcYkSGIkVYZtMCVNP+HK
         PM+VcppMy62qHDRC8IisPAoBpZbAriH+QkakjkrUYIyK9q/SQd5cOSfmv77DV9ty0VEB
         2hmw==
X-Gm-Message-State: ANoB5pm307/bJYDpMCcwoftgZoUyeVp5gCRVdbZcls3Uh3XjU1ycfUmu
        kMlvhnkzT+01Eozyvf7ES/0=
X-Google-Smtp-Source: AA0mqf7YoXZId1IhidLJeAaGq6aSihedIXUqlNVlouCax97Js2CL00K/X717vD3cW272hddh+6p/ew==
X-Received: by 2002:a2e:a806:0:b0:277:4b35:d94a with SMTP id l6-20020a2ea806000000b002774b35d94amr18572615ljq.21.1670316402439;
        Tue, 06 Dec 2022 00:46:42 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id z5-20020a2eb525000000b0027973ba8718sm1577134ljm.37.2022.12.06.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:46:41 -0800 (PST)
Date:   Tue, 6 Dec 2022 11:46:37 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Carlos Hernandez <ceh@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Message-ID: <20221206084637.olaflvqmxwoo467a@mobilestation>
References: <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation>
 <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
 <20221017155246.zxal2cfehjgaajcu@mobilestation>
 <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
 <Y4cqcTRcni5H7UAU@x1-carbon>
 <CADYN=9KKGBXn-YkiiFxsUzsanTALbDV1c+tB0oUQPouE1idnuQ@mail.gmail.com>
 <20221205011105.4do4trbytq4bfw5b@mobilestation>
 <98670e23-6553-4788-8662-9403c480af82@app.fastmail.com>
 <f440a8ff-7657-c1be-e733-4ad69b6b7b0b@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f440a8ff-7657-c1be-e733-4ad69b6b7b0b@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 10:24:22PM +0900, Damien Le Moal wrote:
> On 12/5/22 19:08, Arnd Bergmann wrote:
> > On Mon, Dec 5, 2022, at 02:11, Serge Semin wrote:
> >> On Thu, Dec 01, 2022 at 12:48:32PM +0100, Anders Roxell wrote:
> > 
> >>>
> >>>   for (i = 0; i < hpriv->n_clks; i++) {
> >>> - if (!strcmp(hpriv->clks[i].id, con_id))
> >>> + if (hpriv->clks && hpriv->clks[i].id &&
> >>> +    !strcmp(hpriv->clks[i].id, con_id))
> >>>   return hpriv->clks[i].clk;
> >>>   }
> >>
> >> Indeed I should have taken into account that devm_clk_bulk_get_all()
> >> can get unnamed clocks too. But checking the hpriv->clks pointer for
> >> being not null is redundant, since the ahci_platform_get_resources()
> >> procedure makes sure that the array is always allocated. At the very
> >> least you shouldn't check the pointer in the loop, but can make sure
> >> that the clks array is available before it.
> > 

> > Do you think this is otherwise the correct fix then? Any chance we
> > can still get a version of it into 6.1?

I'll think of a better solution. But at this stage it seems like the
best choice seeing the bindings permit having unnamed clocks
specified.

> 
> If someone sends me a proper patch to apply, I can send a last PR for 6.1
> to Linus before week end.

I'll submit the patch today. Thanks.

-Serge(y)

> 
> 
> > 
> >      Arnd
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
