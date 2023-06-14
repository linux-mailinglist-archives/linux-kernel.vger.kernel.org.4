Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A423C730841
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjFNTat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjFNTar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:30:47 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F065106;
        Wed, 14 Jun 2023 12:30:47 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3408899f855so6920745ab.0;
        Wed, 14 Jun 2023 12:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686771046; x=1689363046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxMpoSEu3CVACFktb2udXJ4LI58KTtzAHuG2GDyeBD8=;
        b=T18gxPb/sX0WdH5sAzE2GqYJ3MJ4I7LPFi6Et6djYof6phaBKsYnABXWXKzDp0EcUy
         VinC81ZbjKFhnzc8+v+6zrXB5GGeTy45AIxlCgP9jOuoyvyT3P7cA4VraGbBmUP9miMP
         zlG31MJBclGVs7n8dAf/rQLNXCoWW04uR9Eo6lu3hAytpXMNqLbcPAzn4OY+Sh70wWO/
         v8UiGDVVEFTnvcfUoYLdcZaV7G4OI74UBAcYhdm7rAvGNKokbdNXQT9+pMMEOo01PtLt
         nz/ByItvHfC4MOIjbgJPzk6/acSnR4mNyA74urypauXuvsPuvA4/vbdnig7fvf2Dilqd
         w7bA==
X-Gm-Message-State: AC+VfDwlSXc5eyEnk7QsQsfPN0KczsEIsK1iaWKXoEcSQv/Wqhk3/Izy
        Q+p1rDP26TWU5Hd6YixDvw==
X-Google-Smtp-Source: ACHHUZ7+3kuvwn5Kyo1f8vSMpErUCx9TJdaZKlDVLtLNnmOoUeV4N0K+ebUQnEgk/TYccK1/dLrO1Q==
X-Received: by 2002:a92:ce0b:0:b0:33f:dfd1:fe4a with SMTP id b11-20020a92ce0b000000b0033fdfd1fe4amr12573037ilo.8.1686771046401;
        Wed, 14 Jun 2023 12:30:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g24-20020a056638061800b004166c24e30dsm5053594jar.32.2023.06.14.12.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:30:45 -0700 (PDT)
Received: (nullmailer pid 2604138 invoked by uid 1000);
        Wed, 14 Jun 2023 19:30:44 -0000
Date:   Wed, 14 Jun 2023 13:30:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
Message-ID: <20230614193044.GA2595668-robh@kernel.org>
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
 <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk>
 <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:08PM +0200, Linus Walleij wrote:
> On Fri, Jun 2, 2023 at 2:22 PM Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Jun 02, 2023 at 01:52:00PM +0200, Matthias Schiffer wrote:
> 
> > > We have seen a number of downstream patches that allow enabling the
> > > realtime feature of the SPI subsystem to reduce latency. These were
> > > usually implemented for a specific SPI driver, even though the actual
> > > handling of the rt flag is happening in the generic SPI controller code.
> > >
> > > Introduce a generic linux,use-rt-queue flag that can be used with any
> > > controller driver. The now redundant driver-specific pl022,rt flag is
> > > marked as deprecated.
> >
> > This is clearly OS specific tuning so out of scope for DT...
> 
> In a sense, but to be fair anything prefixed linux,* is out of scope for DT,
> Documentation/devicetree/bindings/input/matrix-keymap.yaml being
> the most obvious offender.
> 
> On the other hand I think the DT maintainers said it is basically fine
> to use undocumented DT properties for this kind of thing. Having
> completely undocumented DT properties might seem evil in another
> sense, but I think Apple does nothing but...

I don't don't know where you got that impression. I'm fine with them in 
the sense that I don't look at downstream and anything goes there.

Rob
