Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0772A5E8F19
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiIXR50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiIXR5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:57:24 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B043F57272;
        Sat, 24 Sep 2022 10:57:23 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id r125so3577736oia.8;
        Sat, 24 Sep 2022 10:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MNOSZz5lgglfdVhYVEsjBp40JWxVfkPldnmOTbA13Os=;
        b=xVnaZ9R40dX+676GMVW6h/C0Az/p9Ft3ZiDTvVKT8Rhw8xk9Hy1iWE1Fp0Ud0rlZiN
         6tvb8M9676a1oWNhHbTfYo8FGc5N+88iv4mA5MWjzQKS+iOTK7QjQfvJ4UL2Lj2npu1J
         BSfWQ3K0e+C26cbLMnoKzEPeL+ZsDhhj3kdN4zTqllwDPGcYaXz60XMGHaVe5WsKrpzG
         ldEAElSBn72BgC65NyLTw1E1kAQuz6MFtGfb7UULyu2pYe0UMFd8eScThW7bUCpP3oSD
         yvMU1WkC4XAtAAARp4kwLu3WmBqgBEqzPn8beUAatvSU5h2i5GFmcAhM/muRpq56G345
         RZUA==
X-Gm-Message-State: ACrzQf2GyWodpJO76aJJPp2B2aJi7Ea/4Ts8KdNeYiNBOCX8tEXKXrIL
        VuOsWIVXbvVSrKO0OySd7eTlMwWUG7ub
X-Google-Smtp-Source: AMsMyM6oyPLVaeViQti/HxPQuX6anjWMfjhjh3Jm8yYM5cghzCKRbfOr/ouhp8go5OYafCTsPE8RHQ==
X-Received: by 2002:a05:6808:2c8:b0:350:504b:ee10 with SMTP id a8-20020a05680802c800b00350504bee10mr10798246oid.103.1664042242955;
        Sat, 24 Sep 2022 10:57:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i12-20020a056871028c00b0010d5d5c3fc3sm6205331oae.8.2022.09.24.10.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 10:57:22 -0700 (PDT)
Received: (nullmailer pid 1055544 invoked by uid 1000);
        Sat, 24 Sep 2022 17:57:21 -0000
Date:   Sat, 24 Sep 2022 12:57:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3] dt-binding: gpio: publish binding IDs under dual
 license
Message-ID: <20220924175721.GA1051922-robh@kernel.org>
References: <20220905145555.674800-1-etienne.carriere@linaro.org>
 <CAMRc=Mcq3u+1JjvXJ2X774vknq-LOeCfE7hLj2As7Q5A13tx0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcq3u+1JjvXJ2X774vknq-LOeCfE7hLj2As7Q5A13tx0w@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:37:03AM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 5, 2022 at 4:57 PM Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Changes gpio.h DT binding header file to be published under GPLv2 or
> > BSD-2-Clause license terms. This change allows this GPIO generic
> > bindings header file to be used in software components as bootloaders
> > and OSes that are not published under GPLv2 terms.
> >
> > All contributors to gpio.h file in copy.
> >
> > Cc: Stephen Warren <swarren@nvidia.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Laxman Dewangan <ldewangan@nvidia.com>
> > Cc: Andrew Jeffery <andrew@aj.id.au>
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > Cc: Nuno Sá <nuno.sa@analog.com>
> > Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> 
> Applied, thanks!

I don't think anyone is really going to care, but you first need acks 
from the Cc list to re-license or a lawyer to tell you it's not 
copyrightable anyways and doesn't matter. Your choice. ;)

Rob
