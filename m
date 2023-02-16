Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88551698D63
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBPGvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBPGvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:51:31 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B21FA9F;
        Wed, 15 Feb 2023 22:51:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BB2388050;
        Thu, 16 Feb 2023 06:51:27 +0000 (UTC)
Date:   Thu, 16 Feb 2023 08:51:26 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Rob Herring <robh@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: omap: add phytec pcm-049 som
 and pcm-959 dev board
Message-ID: <Y+3Sbnau5qtmFabI@atomide.com>
References: <20230209025525.148872-1-colin.foster@in-advantage.com>
 <20230209025525.148872-2-colin.foster@in-advantage.com>
 <20230209173534.GA539622-robh@kernel.org>
 <Y+yGYycS7rrBRBPN@atomide.com>
 <Y+0Ma9En4JLbR41t@COLIN-DESKTOP1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+0Ma9En4JLbR41t@COLIN-DESKTOP1.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Colin Foster <colin.foster@in-advantage.com> [230215 16:46]:
> On Wed, Feb 15, 2023 at 09:14:43AM +0200, Tony Lindgren wrote:
> > * Rob Herring <robh@kernel.org> [230209 19:35]:
> > > OMAP maintainers, if no one is going to convert all of omap.txt over to 
> > > schema, can we at least start an empty schema and add to it instead of 
> > > here...
> > 
> > That sounds like a good plan to me as it allows moving one device at a
> > time.
> > 
> > Colin, care to add the initial yaml binding file with your board?
> 
> I'll give it a go. To be clear, this would be
> Documentation/devicetree/bindings/arm/omap.yaml and it would
> include my device? I'm taking
> Documentation/devicetree/bindings/arm/sunxi.yaml as inspiration (for no
> reason other than it was the first one that I came across that seemed to
> solve this same issue)

Yes just something minimal to start with.

Thanks,

Tony
