Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B730264BBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiLMSaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiLMSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:30:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE84224BE9;
        Tue, 13 Dec 2022 10:29:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p36so6315197lfa.12;
        Tue, 13 Dec 2022 10:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OgbDqAXzpdR8zItLz3MaWKSx6SVGunJ2KagECaiz7Q=;
        b=VmAc+jbXnjIcuckHLTkGwNKr+sgfLerodVPW1VllN+iZ71cUAVyLqC1xq7meJAJiQH
         kKe/DIqbbV6IbSrsyA+yKP6JJoF5RXVEgoU9RXbljPdm+ie2QjVmcRp2RmEklNVNwr0+
         IQtpAvpA/5Kp90YEsdNN2MXhOkVM3x4ez68kVi04ALrmIiX2/1nmDtguDnWt1wwTTTdW
         is3MX0lsk8P3TtZicYXExtiyyEAtbHXwLX6sPR0+elMkkeYDKWaxz6RgAgvBPWF+HT/L
         OPRMELXV707FHyfX4bCGqzjMrZIXT0dcwLxQ/Od/ye19LVK+YuOtu5WrBmYH6FynjYGA
         Kv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OgbDqAXzpdR8zItLz3MaWKSx6SVGunJ2KagECaiz7Q=;
        b=KrgJ0s20UE8drZmrztMI8cXghtREk91jfELLKLOe781lHgXN4zMEg8iGSHuNTnSUTm
         QfiXJCCaUEJUfFAAHwNm0cPq8EAjZ3F7IIZuYUlv1eLn83klMxvibPR1EtIoN7Mqqza3
         ovExSH6OLTfPWahYlAdN6e5YedWiFNuprHkoxoiAgG7UBbLWRWo6T/jAxSnj8jHNUk7a
         N6ZsGosalmxTjbIuNKRhgFlrLkzfRW1qkHhiknFMO4EsvWaPo/O1UiBLQdnhAeiH4613
         lx72vKkCkcTjKBm4WFO+KEwRmxlczLUjAowkg8eysrSFMkLJr9XVYvzZY0EC+9RNxSGq
         FHxA==
X-Gm-Message-State: ANoB5pmCyX6jz9nOAG8bl44lxjwgfkbNRo/PrQ08aEeRujze9RFJzi78
        NjeeqiyhcIYD63ZpMWQP5Ig=
X-Google-Smtp-Source: AA0mqf6pP4S+k6bY9FqhlexOH4zcn1kI/arGiHA+s7t9yRdql1QW3W5ZhJf2TZE31iGxa0EfCc4UOQ==
X-Received: by 2002:a05:6512:2a8f:b0:4aa:8811:4c59 with SMTP id dt15-20020a0565122a8f00b004aa88114c59mr6466889lfb.28.1670956196942;
        Tue, 13 Dec 2022 10:29:56 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id j13-20020ac2550d000000b004b56de48f05sm470593lfk.27.2022.12.13.10.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:29:56 -0800 (PST)
Date:   Tue, 13 Dec 2022 21:29:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/15] spi: dt-bindings: snps,dw-ahb-ssi: Add generic
 dw-ahb-ssi version
Message-ID: <20221213182954.sfe7sud7bhxgnpou@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-15-sudip.mukherjee@sifive.com>
 <20221213163209.GA1684072-robh@kernel.org>
 <Y5ivfCku1P4CTFn8@sirena.org.uk>
 <CAHyZL-c--gtWUHjBwnKcy6fSUu7yCUaiEYqK7kKMtwnakwR6jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHyZL-c--gtWUHjBwnKcy6fSUu7yCUaiEYqK7kKMtwnakwR6jw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 05:47:53PM +0000, Sudip Mukherjee wrote:
> On Tue, Dec 13, 2022 at 4:59 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Tue, Dec 13, 2022 at 10:32:09AM -0600, Rob Herring wrote:
> > > On Mon, Dec 12, 2022 at 06:07:31PM +0000, Sudip Mukherjee wrote:
> >
> > > > Add new snps,dw-ahb-ssi version to the bindings.
> >
> > > Really, this should probably only be a fallback with an SoC specific
> > > compatible. Future quirk properties which are not board specific only
> > > will be rejected. You've been warned.
> >
> > Given how widely used DesignWare stuff is and usage in FPGAs it does
> > seem reasonable to have compatibles for just the IP rather than SoC
> > specific ones - we do have quirked versions that have been modified but
> > these are things that people manage to deploy without needing that and
> > SoC specific compatibles for FPGA instantiations would get painful.
> 

> Also, this patchset adds the autodetect procedure as discussed in the review
> of the previous series at
> https://lore.kernel.org/lkml/20220826233116.uulisbo663cxiadt@mobilestation/
> 
> So, we should be able to replace "snps,dw-apb-ssi" and
> "snps,dwc-ssi-1.01a" with "snps,dw-ahb-ssi" after this.

Just "snps,dwc-ssi-1.01a". That is the IP-core
https://www.synopsys.com/dw/ipdir.php?c=dwc_ssi
which support was added in
https://lore.kernel.org/linux-spi/20200505130618.554-4-wan.ahmad.zainie.wan.mohamad@intel.com/
Since the IP-core version is auto-detectable there is no need in
having the version attached to the compatible string. That's why I
asked @Sudip to introduce a new generic device name free of the
version suffix. It should be used instead of "snps,dwc-ssi-1.01a"
from now.

The "snps,dw-apb-ssi" compatible string will stay since it corresponds
to another IP-core:
https://www.synopsys.com/dw/ipdir.php?c=DW_apb_ssi

Answering to the @Rob note regarding the quirk properties. All the
features added by Sudip here were supposed to be auto-detectable.
So the generic IP-core name will be still useful as before with no
need in adding any quirks.

@Rob AFAIR you used to be against the generic fallback compatible
names, but had nothing against just generic compatibles. Has something
changed?

-Serge(y)

> And, also this generic compatible has been tested with the new 1.03a
> version we are working with, which was
> mentioned in my v1 at
> https://lore.kernel.org/lkml/20220826233305.5ugpukokzldum7y5@mobilestation/
> 
> -- 
> Regards
> Sudip
