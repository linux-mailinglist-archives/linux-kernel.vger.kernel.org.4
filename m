Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3546D6998
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjDDQz5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 12:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjDDQzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:55:52 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60353D1;
        Tue,  4 Apr 2023 09:55:34 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pjjwE-0000HT-RK; Tue, 04 Apr 2023 18:55:18 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for Pinephone Pro
 to 1.5 MB
Date:   Tue, 04 Apr 2023 18:55:17 +0200
Message-ID: <3999080.iIbC2pHGDl@diego>
In-Reply-To: <CAMdYzYqT=vVZxFK=P6xYDAht_KWk3CTsTtruPAbGqx1K9EcJsQ@mail.gmail.com>
References: <20230403175937.2842085-1-javierm@redhat.com> <3738011.44csPzL39Z@diego>
 <CAMdYzYqT=vVZxFK=P6xYDAht_KWk3CTsTtruPAbGqx1K9EcJsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Am Dienstag, 4. April 2023, 14:52:02 CEST schrieb Peter Geis:
> On Tue, Apr 4, 2023 at 3:55 AM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Hi,
> >
> > Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canillas:
> > > This baud rate is set for the device by mainline u-boot and is also what
> > > is set in the Pinebook Pro Device Tree, which is a device similar to the
> > > PinePhone Pro but with a different form factor.
> > >
> > > Otherwise, the baud rate of the firmware and Linux don't match by default
> > > and a 'console=ttyS2,1500000n8' kernel command line parameter is required
> > > to have proper output for both.
> >
> > The interesting question is always if this will break someone else's setup.
> > I've never really understood the strange setting of 1.5MBps, but on the
> > other hand it _is_ a reality on most boards.

> The 1.5M baud is default because the clock structure on rockchip
> devices does not allow a clean 115200 baud. By attempting to force
> 115200, it will always be slightly off (either low or high depending
> on how the driver decided to round). If this actually causes any
> problems is the subject of much debate.

thanks so much for this piece of clock-detail. As I wrote, I never really
understood the why _before_ but also never cared that much to dive
into it and find out.

So your explanation closes one knowledge gap in my head.

Thanks a lot :-)
Heiko



