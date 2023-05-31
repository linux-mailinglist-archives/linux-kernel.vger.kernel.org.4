Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEFD71761E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjEaFZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjEaFZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:25:21 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76B7A107;
        Tue, 30 May 2023 22:25:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BA8AB8164;
        Wed, 31 May 2023 05:25:19 +0000 (UTC)
Date:   Wed, 31 May 2023 08:25:18 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bcousson@baylibre.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap4: add initial support for Epson Moverio
 BT-200
Message-ID: <20230531052518.GU14287@atomide.com>
References: <20230313110409.2294154-1-andreas@kemnade.info>
 <20230327082137.GH7501@atomide.com>
 <20230515191735.6d671ef1@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515191735.6d671ef1@aktux>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230515 17:17]:
> Hi,
> 
> On Mon, 27 Mar 2023 11:21:37 +0300
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Andreas Kemnade <andreas@kemnade.info> [230313 13:04]:
> > > yes, epson,embt2ws is unknown, is the txt->yaml conversion around the
> > > corner? I would then resubmit it includding an addition
> > > to that yaml. If not probably I resubmit the conversion patch with
> > > the compatible added. But that should not stop the rest of this patch from
> > > being reviewed.  
> > 
> > Yeah let's do the yaml conversion first as otherwise we'll be adding some
> > extra warnings for the dt folks.
> > 
> > Your patch looks otherwise OK to me.
> > 
> do you expect any action from me here? As Krzysztof has given his
> Reviewed-by on the conversion patch, I would expect that it gets in right
> after that omap.yaml conversion patch if nobody objects.

Applying this into omap-for-v6.5/dt thanks. And thanks for getting the
omap.yaml conversion going, that will get merged by the dt folks.

Regards,

Tony
