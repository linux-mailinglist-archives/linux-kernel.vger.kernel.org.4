Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFEE6A3B95
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjB0HPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:15:10 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D9483598;
        Sun, 26 Feb 2023 23:15:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 57FE180FC;
        Mon, 27 Feb 2023 07:15:08 +0000 (UTC)
Date:   Mon, 27 Feb 2023 09:15:07 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Colin Foster <colin.foster@in-advantage.com>,
        Andrew Davis <afd@ti.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: omap: add phytec pcm-049 som
 and pcm-959 dev board
Message-ID: <Y/xYe9IOsXWBxtxK@atomide.com>
References: <20230222203847.2664903-1-colin.foster@in-advantage.com>
 <20230222203847.2664903-2-colin.foster@in-advantage.com>
 <dd67f7c9-0867-47d0-a201-9316908d9d62@ti.com>
 <Y/eTZONJh8QdJVP8@COLIN-DESKTOP1.localdomain>
 <20230226172248.GA47940-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226172248.GA47940-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rob Herring <robh@kernel.org> [230226 17:22]:
> On Thu, Feb 23, 2023 at 08:25:08AM -0800, Colin Foster wrote:
> > On Thu, Feb 23, 2023 at 10:00:50AM -0600, Andrew Davis wrote:
> > > On 2/22/23 2:38 PM, Colin Foster wrote:
> > > > Add yaml documentation for TI OMAP devices for the Phytec PCM-049 SoM and
> > > > the Phytec PCM-959 development kit.
> > > > 
> > > > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > > > ---
> > > > 
> > > > v4
> > > >      * New patch, based on a WIP from Andrew Davis <afd@ti.com>
> > > > 
> > > > ---
> > > >   .../devicetree/bindings/arm/ti,omap.yaml      | 29 +++++++++++++++++++
> > > >   1 file changed, 29 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/arm/ti,omap.yaml
> > > 
> > > How will this work if I add the same file? Why not take my WIP patch, make
> > > the suggested changes from Rob, then have it as your first patch in this
> > > series?
> > 
> > Is your WIP intended to convert all omap.txt to ti,omap.yaml? Or chunk
> > off devices one at a time?
> > 
> > If the former, when your patch is done it should be a pretty simple
> > rebase conflict resolution. If the latter (which feels more digestable)
> > this offers that template. This was Rob's / Tony's suggestion, albeit
> > before you sent your patch set.
> > 
> > 
> > Anyway, I'm happy to do any of the following:
> > 
> > 1. Take Andrew's patches, add these references and re-submit.
> > 2. Keep this set as-is (with the typo fix) and when Andrew's WIP is done
> >    it should be an easy rebase before submission.
> > 3. Wait for Andrew's WIP to be done, then submit with this update.
> > 
> > 
> > I'd like to avoid #3 because I don't know where this might fall on your
> > priorities list.
> 
> If you are willing to do #1, that's certainly my preference.

That would be great!

Tony
