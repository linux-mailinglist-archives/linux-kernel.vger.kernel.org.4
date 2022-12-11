Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0512D649490
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLKNyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:54:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DD85FFB;
        Sun, 11 Dec 2022 05:54:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB3A60DC9;
        Sun, 11 Dec 2022 13:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C501C433EF;
        Sun, 11 Dec 2022 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670766875;
        bh=/oIhWuCh+Q64jTqco5ZfqZoA6e/lvC0GYIS0yDoT6ZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eFNwL5RwB8XGTG4cBuwpt3kfB2nz60+JwzxTCaOp8jJilPt76GTPDVN9zLHlJwh1x
         kAnK5IBilxYsWtr8ZREk6CrtgQMTj/kVq3h/qSnZlk6e5nldB/NRrMzOypzW/aSfc5
         6BDuR/dljq+YRQy3Bg4hAp4dbVeFklh/vNbkceqfx88Lgs5w2VMhBa7zQpFyMmBTFE
         kkQ9BVHjLFO//0CJkmRNvqHKnuHZttZUK7aVD+aHXDczXNffyFZuZd7ptUcUKDGgim
         YqKlV7j7QDlZFPum+qfYR8WeP4nJuxwL0k62ONaZgR54ZnSPn/GV0MyYXTWjq6D2T0
         St0THZGHm/TyA==
Date:   Sun, 11 Dec 2022 14:07:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Okan Sahin <okan.sahin@analog.com>, outreachy@lists.linux.dev,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: drivers: mfd: Add MAX77541 MFD and related
 device drivers
Message-ID: <20221211140727.6da705ac@jic23-huawei>
In-Reply-To: <Y5XcUtNInUJl98JP@smile.fi.intel.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
        <Y5B0btPjY6nHhYRm@smile.fi.intel.com>
        <20221211122043.424e095d@jic23-huawei>
        <Y5XcUtNInUJl98JP@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Dec 2022 15:34:10 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Dec 11, 2022 at 12:20:43PM +0000, Jonathan Cameron wrote:
> > On Wed, 7 Dec 2022 13:09:34 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Wed, Dec 07, 2022 at 12:08:39PM +0300, Okan Sahin wrote:  
> > > > This patchset adds mfd, regulator and adc driver and related bindings.The patches 
> > > > are required to be applied in sequence.    
> > > 
> > > You have an indentation / wrapping issues in the above text.
> > > 
> > > Nevertheless, why staging? What does it mean?  
> > 
> > The main reason to go via staging is because a driver is sitting out
> > of tree and it is useful to bring it in on the basis that it can then be
> > cleaned up in tree before moving out of staging.  
> 
> But files are not in staging. Me being confused.

I noticed that when I got to the patches :)
Odd indeed - I'm guessing some cut and paste gone wrong.

Jonathan

> 
> > For a relatively small driver like this, that's hard to argue.  Just
> > clean it up in response to review feedback and then we can take it
> > directly into relevant subsystems in the main tree.  
> 

