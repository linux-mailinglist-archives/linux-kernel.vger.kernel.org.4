Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9C696C85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjBNSLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjBNSLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:11:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19D5F5B9F;
        Tue, 14 Feb 2023 10:11:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68B7E1042;
        Tue, 14 Feb 2023 10:12:25 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 049FA3F663;
        Tue, 14 Feb 2023 10:11:40 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:11:38 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Bastian Germann <bage@debian.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: hwlock: sun6i: Add missing names
Message-ID: <20230214181138.4a8f4beb@donnerap.cambridge.arm.com>
In-Reply-To: <43336959-643d-4041-d11a-b0c030fbf050@linaro.org>
References: <20230213231931.6546-1-bage@debian.org>
        <20230213231931.6546-3-bage@debian.org>
        <20230214104554.35338faa@posteo.net>
        <43336959-643d-4041-d11a-b0c030fbf050@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 13:37:20 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

Hi Krzysztof,

> On 14/02/2023 10:45, Wilken Gottwalt wrote:
> > On Tue, 14 Feb 2023 00:19:29 +0100
> > Bastian Germann <bage@debian.org> wrote:
> >   
> >> The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names
> >> and reset-names set to "ahb" as required by the driver.  
> > 
> > Hmm, this one is a bit odd. If you look into my earlier versions of the
> > patchset, you may notice, that I actually included these bindings and they
> > were refused. I think the argumentation was like
> > "there is only one bus = no need for it".
> > 
> > If it gets accepted now, I really like to know why. (It was some trouble
> > back then to get the documentation properly done and accepted.)  
> 
> The clock names and resent names are not correct. They should have never
> been added. If you got comments about this and did not update driver,
> that's not nice. You just shoved incomplete bindings. :(
> 
> So indeed to avoid precedence - people pushing fake bindings and
> avoiding review - NAK on this.

Maybe it's just me, but I don't think this tone is necessary.

Wilken's original submission was correct. Later there was a comment just
on the binding patch, to remove the not needed clock-names and reset-names
properties. But there was not a word in there that the driver requires
changing as well, and I don't think it's fair to blame Wilken on this, or
somewhat even implying intention. There were several patch revisions after
this was raised, and this just slipped through review. But surely no one
wanted this or pushed for that.

If anything, it tells us that we should be more careful when merging
drivers without users: if there would have been a DT patch, possibly even
a consumer, this would have been flagged by dtbs_check.

Cheers,
Andre
