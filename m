Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B626732114
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjFOUqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOUqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:46:35 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539E826AA;
        Thu, 15 Jun 2023 13:46:31 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 022F0207D3;
        Thu, 15 Jun 2023 22:46:28 +0200 (CEST)
Date:   Thu, 15 Jun 2023 22:46:24 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     "Bajjuri, Praneeth" <praneeth@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, vikram.sharma@ti.com
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Johannes Pointner <h4nn35.work@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: DP83867 ethernet PHY regression
Message-ID: <ZIt4oNn5eDqfsDVy@francesco-nb.int.toradex.com>
References: <ZGuDJos8D7N0J6Z2@francesco-nb.int.toradex.com>
 <ZG4ISE3WXlTM3H54@debian.me>
 <CAHvQdo0gucr-GcWc9YFxsP4WwPUdK9GQ6w-5t9CuqqvPTv+VcA@mail.gmail.com>
 <ZG8PS/CSpHXIA6wt@francesco-nb.int.toradex.com>
 <827377ae-091b-8888-18b9-bb574d7ff3ca@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <827377ae-091b-8888-18b9-bb574d7ff3ca@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bajjuri, Siddharth and Vikram

On Thu, May 25, 2023 at 03:18:34AM -0500, Bajjuri, Praneeth wrote:
> On 5/25/2023 2:33 AM, Francesco Dolcini wrote:
> > On Thu, May 25, 2023 at 08:31:00AM +0200, Johannes Pointner wrote:
> > > On Wed, May 24, 2023 at 3:22 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > > > 
> > > > On Mon, May 22, 2023 at 04:58:46PM +0200, Francesco Dolcini wrote:
> > > > > Hello all,
> > > > > commit da9ef50f545f ("net: phy: dp83867: perform soft reset and retain
> > > > > established link") introduces a regression on my TI AM62 based board.
> > > > > 
> > > > > I have a working DTS with Linux TI 5.10 downstream kernel branch, while
> > > > > testing the DTS with v6.4-rc in preparation of sending it to the mailing
> > > > > list I noticed that ethernet is working only on a cold poweron.
> > > > > 
> > > > > With da9ef50f545f reverted it always works.
> 
> Thank you for bringing this issue to attention.
> I have looped Siddharth and vikram to further investigate and provide input.

Were you able to make any progress? If we are not getting anywhere in
the coming days I would be inclined to send a revert, what do you think?

Francesco


