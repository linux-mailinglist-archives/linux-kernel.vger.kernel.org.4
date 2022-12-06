Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B4F644DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLFVEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiLFVEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:04:39 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7A30577;
        Tue,  6 Dec 2022 13:04:38 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y25so3416759lfa.9;
        Tue, 06 Dec 2022 13:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGfC41RTI6jgj8ywYESKxaRQC3IxCMppOBqs9HFb7hI=;
        b=bNQEtaR1NsMh9mBbNKD/Y01RTcj/56safmMbTV/XW62mfIJ4Q2KApj/steVorzOSvc
         ld9uCsyPAxJYAPy79UOF9M3rXiJQjqcLyWxuefpT7WA6VMckwzOhQnmPEhsgRjmzOxnc
         Iyw8R76JCvgW+E23NufgvCV4kagx6FLlbbdh6AnXqHigklPlbkuj50CzZhDJrkWGKFc5
         d4XrH3K95NJs5ju+3Neok+onvTqB2Qo9384vttmTufY3TTwvUQtr5gCzclfArNjX71QM
         r5EtdiKwXIS544o6qQWwwSKL/NX13b5zssd1zLHSuEO5eDBpSIix9DJhZd4B7T3yzZ//
         G7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGfC41RTI6jgj8ywYESKxaRQC3IxCMppOBqs9HFb7hI=;
        b=AD3Ac7qgHSl7YJb7g8bgYRl5nRX5fUWECUlipt+XJcPi3IKSN73xI/2UbOGGFrKy2d
         3ZqX3hFdb4bcLxmDOh5QrQtwg03ke2XW/VM7VtelW8sQPgn8HNFZqaBN3w4QoDrqt7hU
         sJqlnV1/qpk21fqN85CpUC7OE2Fc2p+QfX3YCVMRDCor2B01yH8lMMmg/XCOF8QRBann
         tl4y07QtLwjPd4BWlzXah0QfJWJh+PynRtVzMVqXsXKbPVRLla7MgNZrHp1ADWrxDiwP
         C8g8DeM8j7esnSAVLv+lSqYqLDBkfIir7fys9IS6VUINSXvvIelKxG0NjXxbcYwDnHLw
         DkaA==
X-Gm-Message-State: ANoB5pmYJGhtTTyMdSBD7tOGmLf1vcNxucB5yFlu8QjYb58alt/lWInE
        exNcBxIXSe5bOcgrkvoghqs=
X-Google-Smtp-Source: AA0mqf6lk8n1mSovdZxsNEks0iX3SYkOI7bB3GP+FfVi9H/dJoGvipfviaVx3C8lx6rPgOyVK/Nh3Q==
X-Received: by 2002:a05:6512:104e:b0:4b5:604a:5b24 with SMTP id c14-20020a056512104e00b004b5604a5b24mr5337245lfb.550.1670360676996;
        Tue, 06 Dec 2022 13:04:36 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b004991437990esm2618593lfr.11.2022.12.06.13.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:04:36 -0800 (PST)
Date:   Wed, 7 Dec 2022 00:04:34 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
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
Message-ID: <20221206210434.wdttz5aj7ipzsvcy@mobilestation>
References: <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
 <20221017155246.zxal2cfehjgaajcu@mobilestation>
 <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
 <Y4cqcTRcni5H7UAU@x1-carbon>
 <CADYN=9KKGBXn-YkiiFxsUzsanTALbDV1c+tB0oUQPouE1idnuQ@mail.gmail.com>
 <20221205011105.4do4trbytq4bfw5b@mobilestation>
 <98670e23-6553-4788-8662-9403c480af82@app.fastmail.com>
 <f440a8ff-7657-c1be-e733-4ad69b6b7b0b@opensource.wdc.com>
 <20221206084637.olaflvqmxwoo467a@mobilestation>
 <fa2bc2b9-d74a-51a3-cb5f-80d04e145b27@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2bc2b9-d74a-51a3-cb5f-80d04e145b27@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 06:12:48PM +0900, Damien Le Moal wrote:
> On 12/6/22 17:46, Serge Semin wrote:
> > On Mon, Dec 05, 2022 at 10:24:22PM +0900, Damien Le Moal wrote:
> >> On 12/5/22 19:08, Arnd Bergmann wrote:
> >>> On Mon, Dec 5, 2022, at 02:11, Serge Semin wrote:
> >>>> On Thu, Dec 01, 2022 at 12:48:32PM +0100, Anders Roxell wrote:
> >>>
> >>>>>
> >>>>>   for (i = 0; i < hpriv->n_clks; i++) {
> >>>>> - if (!strcmp(hpriv->clks[i].id, con_id))
> >>>>> + if (hpriv->clks && hpriv->clks[i].id &&
> >>>>> +    !strcmp(hpriv->clks[i].id, con_id))
> >>>>>   return hpriv->clks[i].clk;
> >>>>>   }
> >>>>
> >>>> Indeed I should have taken into account that devm_clk_bulk_get_all()
> >>>> can get unnamed clocks too. But checking the hpriv->clks pointer for
> >>>> being not null is redundant, since the ahci_platform_get_resources()
> >>>> procedure makes sure that the array is always allocated. At the very
> >>>> least you shouldn't check the pointer in the loop, but can make sure
> >>>> that the clks array is available before it.
> >>>
> > 
> >>> Do you think this is otherwise the correct fix then? Any chance we
> >>> can still get a version of it into 6.1?
> > 
> > I'll think of a better solution. But at this stage it seems like the
> > best choice seeing the bindings permit having unnamed clocks
> > specified.
> > 
> >>
> >> If someone sends me a proper patch to apply, I can send a last PR for 6.1
> >> to Linus before week end.
> > 
> > I'll submit the patch today. Thanks.
> 

> Anders just posted one. Can you review it please ?

Done. Thanks.

-Serge(y)

> 
> > 
> > -Serge(y)
> > 
> >>
> >>
> >>>
> >>>      Arnd
> >>
> >> -- 
> >> Damien Le Moal
> >> Western Digital Research
> >>
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
