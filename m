Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0244E673EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjASQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjASQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:37:10 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28576792B5;
        Thu, 19 Jan 2023 08:37:06 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g13so4046402lfv.7;
        Thu, 19 Jan 2023 08:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxOM0SJDbMq/E2lMPr2rz9jcbXZTrUs3W/H1oRDOJqU=;
        b=M5sK1iS6RP6Lgmn/t4+bnczYflVb4Bc7XGV6pFhDAGf6maIYd+ECAUzEfu9IH1DPaM
         1UL3iWbUAF+29ea5vTE1qduy/A5T8WATSm7PZSyCTIjBZQhv6wUKYVw4nlnlP7e9u0rE
         D7azd/hO4b0ZQrBkMBzcWiAorhzHGBj/f97o97tHvz7MGynif1qwrbNigAJMXVFgV0Zk
         c5s+5nndj4fcu9TSAqGiPO6nylXDl5iNyzUhq8TB2ePcQpBZYOYeYRIFFPfWOQFmXEh7
         ketYQZULfmer69j8PmYt79j9+0klV425LxtJUjzGR3PWabcdnhZslvZqH8hQ2rqCd9TW
         hADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxOM0SJDbMq/E2lMPr2rz9jcbXZTrUs3W/H1oRDOJqU=;
        b=wsReJUkqQoOWSgdDYfcd4jXIHHo9dHNuQFWxTwSShfW1YqVY4JAwOSgGcwNCwT1sFN
         4ruh+Xo27COxIdE/CAJAmujoapReWLQa0Ki2dW50HKDtpAZDOFEAUYCG1CYvoPk3ZlXv
         rY/bc0+kj4AI9DwRo0MRWlKE73hI2/VRgzRCIBfTmbIH+aUsEM3qusGkKJnrNLrU8v6a
         MvUiRLjFVJJI6OqhrZqUsOb4CbZ+Veepzs/pGRIFQFL1LNQZgnxLt7a5max0yB5KrnCu
         Hx11GmalKdJBI9rj0603jy6WEtG3U5we3i6ONBiDrIQ2hwF8K282w5/DJ8egIrZE7M/V
         dIcA==
X-Gm-Message-State: AFqh2krbyw1xpcehs7less2k3NO2FkByG9d9zcXcQZn9jXmlOQz011HF
        Et1MFv10rHUki8FNmA2CXas=
X-Google-Smtp-Source: AMrXdXscH/Iwsv/mR2G4A45F9IX6RTFBG9ghByeaede0LbTWwhyyRsWwI5Pdr+VF6zVI/DsnoAIO/g==
X-Received: by 2002:a05:6512:1108:b0:4d1:7923:3b92 with SMTP id l8-20020a056512110800b004d179233b92mr4083310lfg.50.1674146224464;
        Thu, 19 Jan 2023 08:37:04 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id d4-20020a05651233c400b004947a12232bsm5898873lfg.275.2023.01.19.08.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:37:03 -0800 (PST)
Date:   Thu, 19 Jan 2023 19:37:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Add support for enhanced SPI for Designware SPI
 controllers
Message-ID: <20230119163701.3g7g74zfzmbgvqfh@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221218174523.cke7ubh6nycd247c@mobilestation>
 <20230104222036.h4ke6maxkdvuqtqc@mobilestation>
 <20230109162505.o3clvmwu3eremlyd@mobilestation>
 <CAHyZL-foBcwQrMy1xAJ7LqnoB8B9DSxwtp6LtvLFBgVwC00avg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHyZL-foBcwQrMy1xAJ7LqnoB8B9DSxwtp6LtvLFBgVwC00avg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:26:58PM +0000, Sudip Mukherjee wrote:
> On Mon, Jan 9, 2023 at 4:25 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hello Sudip
> >
> > On Thu, Jan 05, 2023 at 01:20:39AM +0300, Serge Semin wrote:
> > > Hi Sudip
> > >
> > > On Sun, Dec 18, 2022 at 08:45:26PM +0300, Serge Semin wrote:
> > > > Hi Sudip
> > > >
> > > > On Mon, Dec 12, 2022 at 06:07:17PM +0000, Sudip Mukherjee wrote:
> > > > > The is v2 of the patch series adding enhanced SPI support. Some Synopsys SSI
> > > > > controllers support enhanced SPI which includes Dual mode, Quad mode and
> > > > > Octal mode. DWC_ssi includes clock stretching feature in enhanced SPI modes
> > > > > which can be used to prevent FIFO underflow and overflow conditions while
> > > > > transmitting or receiving the data respectively.
> > > > >
> > > > > This is almost a complete rework based on the review from Serge.
> > > >
> > > > Thank you very much for the series. I'll have a look at it on the next
> > > > week.
> > >
> > > Just so you know. I haven't forgot about the series. There are some
> > > problematic parts which I need to give more thinking than I originally
> > > expected. I'll submit my comments very soon. Sorry for the delay.
> > >
> > > Good news is that I've got the HW-manual for the DW SSI v1.01a
> > > IP-core. So I'll no longer need to ask of you about that device
> > > implementation specifics.
> >
> > Finally I managed to consolidate my thoughts regarding your patchset.
> > Here is the summary. Some specific comments will be sent in-reply to
> > the corresponding patches.
> >
> > First of all there is a crucial difference between eSPI capability
> > available on DW APB SSI and DW AHB SSI controllers:
> > DW APB SSI 4.x:
> > + Tx until FIFO is empty
> > + No clock stretching at all
> 

> Thanks for your detailed review and all the additional details about
> DW APB SSI. I did not have this datasheet to check.
> So, that will mean I can remove the APB versiom detection from my next series.
> But unfortunately, I don't have access to the hardware currently to
> prepare and test the v3 series. It will be delayed a bit and I am
> hoping I will be able to work on this by early March.

Ok. Thanks for the update. Whenever you're ready I'll be here for review.

-Serge(y)

> 
> 
> -- 
> Regards
> Sudip
