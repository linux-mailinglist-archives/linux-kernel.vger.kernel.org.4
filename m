Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764936999F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBPQ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPQ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:26:48 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C469171C;
        Thu, 16 Feb 2023 08:26:47 -0800 (PST)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 4018826F7A9; Thu, 16 Feb 2023 17:26:46 +0100 (CET)
Date:   Thu, 16 Feb 2023 17:26:46 +0100
From:   Janne Grunau <j@jannau.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 14/17] dt-bindings: sound: apple,mca: Add t8112-mca
 compatible
Message-ID: <20230216162646.GK17933@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-14-cb5442d1c229@jannau.net>
 <Y+5TGKoMuRr4XQ+b@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+5TGKoMuRr4XQ+b@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-16 16:00:24 +0000, Mark Brown wrote:
> On Sun, Feb 12, 2023 at 04:41:24PM +0100, Janne Grunau wrote:
> 
> > This trivial dt-bindings update should be merged through the asahi-soc
> > tree to ensure validation of the Apple M2 (t8112) devicetrees in this
> > series.
> 
> I didn't get a response to my query about the nearness to the
> merge window and the prospects of the series hitting v6.3, though
> I do see that there's a new version needed for some of the other
> patches.  I'm just going to go ahead and apply so it's there and
> I don't need to worry about or see resends, in case the rest of
> the series is going to go in it's not the end of the world if it
> gets applied twice anyway so

Sorry, I forgot to answer. The devicetree commit is too late for 6.3. If 
some of the binding updates make it into v6.3-rc1 it will get dropped.

> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks

Janne

