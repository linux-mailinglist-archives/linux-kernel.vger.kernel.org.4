Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3660367A192
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjAXSnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjAXSnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:43:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B3261BB;
        Tue, 24 Jan 2023 10:42:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C782461324;
        Tue, 24 Jan 2023 18:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37236C433A8;
        Tue, 24 Jan 2023 18:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674585767;
        bh=DBSo7OynaPiD3LOZ5Et+hWfS1NPFDENYrFZZTqaJ4Zo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RuxlPFOPF6nG3xhTMWTioiwTQkM78eHKGibjNQ4Ld2qVM6eMg+Pqb+1pVDyLlEO88
         pCYdM+O5ReIsLpkyvLRIL8D6J8ybMRFahWkSUIYHGGmpS8jhZzaK8678isY2qke6J2
         Cc4WWweSKl5bPOqJYmyqqauDgUrccGrX1l18oSf5R4CHQZk/4niQE1RwVUAD8XWJaR
         TwCmM300aL9mG3rYbQBV7zQVXNTDypTmog+KVAjaRBT2nOh06Tg7xGq2KZH3P2MUdk
         IYGcne5XS33CH7MmDjhdgIB4U4YYi0kmVixCDf3HSDRQD921jyFvl2U+H5qXGNjAMO
         DsXd2ZRZKdUcA==
Received: by mail-vs1-f49.google.com with SMTP id t10so17452873vsr.3;
        Tue, 24 Jan 2023 10:42:47 -0800 (PST)
X-Gm-Message-State: AFqh2kogD8gk997Ly8jqKxhPwk/3wFcKmHnlw6wmkYwFdlWvhxipBIbr
        XNiUK+W5oJ0jD+EUXb9955/nCw9QPqs22iOIDQ==
X-Google-Smtp-Source: AMrXdXvM0olT9jSHiUMDJsNqRTneaeFB/92hij1cU2Y+/6V74N/GT/dxRky2xzkFIbykeif2r193/563hWiLeZlWlho=
X-Received: by 2002:a05:6102:5490:b0:3b5:1fe4:f1c2 with SMTP id
 bk16-20020a056102549000b003b51fe4f1c2mr3941513vsb.0.1674585766048; Tue, 24
 Jan 2023 10:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org> <Y9ASq0VZ6G7Efe7s@kroah.com>
In-Reply-To: <Y9ASq0VZ6G7Efe7s@kroah.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Jan 2023 12:42:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJ8tFUCw-MbAsfJ7vKssRxu=p+3jG7dURmB77DOYoiSg@mail.gmail.com>
Message-ID: <CAL_JsqJJ8tFUCw-MbAsfJ7vKssRxu=p+3jG7dURmB77DOYoiSg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] dt-bindings: usb: Convert some more simple
 OHCI/EHCI bindings
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Lee Jones <lee@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:17 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 23, 2023 at 09:05:15PM -0600, Rob Herring wrote:
> > The 'ohci-usb' compatible is another 'generic' compatible for OHCI, but
> > isn't documented with a schema. Let's add it to generic-ohci.yaml
> > schema. While looking at this, I found a few other USB host bindings
> > which are simple enough to use the 'generic' schemas.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Am I supposed to take these in my USB tree?

Yes, please.

> I'm still confused if you all want me to take these types of things or
> not...

Yes. I try to only pick up what has less responsive subsys
maintainers, treewide (binding) cleanups, or otherwise falls thru the
cracks.

Rob
