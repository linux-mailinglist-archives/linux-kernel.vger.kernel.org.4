Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BA46056CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJTFb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJTFb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:31:57 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2296194221
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:31:55 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id s17so10994903qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke+DoHhz1XKy9xeNSiWO0Eq/IHfSDBUW8TnozKir+yg=;
        b=TySompZSaWj8ilygpbslEMOvJTyRDnsYlgZ7bhvmjaCxBESJPZDRCdfrFYuDYx9oZu
         451dsTbKp4i9rwAtT+BFxZzipZwyc8Wv3aoE3j08Z07k+CF6nvXckaV1k9uOf97oZxiC
         FhrlGnntM2FeFAOCw5dwNL8d8s3NbsokJObDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ke+DoHhz1XKy9xeNSiWO0Eq/IHfSDBUW8TnozKir+yg=;
        b=WdbTrmut/fWUpt9UNACkOllfynWuSrAJ8L8nlMaZ7tpZ+96qjuGYwnL3mhHtQnWC4H
         KFglGV8GopQ2TS8N2TkS1+usQBkaK/CQOwqsQ5A5D/M/tQhrjc+bxpPdqCAvL1e9YfCC
         5dRPiz64q9p5CHpyBx4cs9Aodg84ZO2YjeK9yg4ZKr6QXNfD1AKscfM2nb98THIEJqqq
         zENYcL+vVPRpur7vqeVtjEp1OFnZiaJ+k3yDmZ3SZNBysOpiLvxupJ0eoCd5oxNCggnh
         1uOs22dMnc/cLhAQAEDXedHCs7vv2bj96qv4iZzbDbNspbeEmmBCIHBd6pN8b9uRxmaX
         O1DA==
X-Gm-Message-State: ACrzQf29a8w0APwPu8Zir3C6Oj6Wuyy0/hTRSJGfXPo9spokbxtqtO58
        hA43IyPugHB5WkNzZnAxhVFff/Bkikh2uBjyZ7YmIA==
X-Google-Smtp-Source: AMsMyM7rbr3SeVf2uq/UjmCaSllheYSnF+G+Nq3nkPhZYx70376dLOjGbkDbvp1MKM63ck4gxD61zyrIdQpk52EU2bQ=
X-Received: by 2002:a05:620a:4510:b0:6ee:e6de:828d with SMTP id
 t16-20020a05620a451000b006eee6de828dmr8382571qkp.70.1666243914644; Wed, 19
 Oct 2022 22:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221019125254.952588-1-mitja@lxnav.com> <20221019125254.952588-3-mitja@lxnav.com>
 <CAHp75VcCORhVefBoQgnbe+aRJfJHfJ7PTk=Xr1eQaEYFsdJvLQ@mail.gmail.com>
In-Reply-To: <CAHp75VcCORhVefBoQgnbe+aRJfJHfJ7PTk=Xr1eQaEYFsdJvLQ@mail.gmail.com>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Thu, 20 Oct 2022 07:31:28 +0200
Message-ID: <CACbQKWeRVXw_78-OoZFHCNX+tgRx_OfCaK7OaYBBwzjMAxcYng@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: iio: pressure: ms5611: added max SPI frequency
 setting to the example
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 3:23 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Oct 19, 2022 at 3:55 PM Mitja Spes <mitja@lxnav.com> wrote:
> >
> > Added max SPI frequency setting to the example. It is now honored by the
> > driver.
>
> Is it possible to add a constraint here? So the schema validator will
> issue the warning / error if the speed is too high.

The constraint is already there:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/iio/pressure/meas%2Cms5611.yaml
```
spi-max-frequency:
    maximum: 20000000
```

But in any case the patch 2/3 limits the max frequency.

Kind regards,
Mitja Spes
