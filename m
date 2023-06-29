Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA31974279F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjF2Noa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjF2No2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:44:28 -0400
X-Greylist: delayed 430 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 06:44:23 PDT
Received: from smtpout11.ifi.lmu.de (smtpout11.ifi.lmu.de [IPv6:2001:4ca0:4000:0:141:84:214:246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5F30C4;
        Thu, 29 Jun 2023 06:44:22 -0700 (PDT)
Received: from tobhe.de (p200300eeaf18710014db52e6e13db9f4.dip0.t-ipconnect.de [IPv6:2003:ee:af18:7100:14db:52e6:e13d:b9f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: heidert)
        by smtpin1.ifi.lmu.de (Postfix) with ESMTPSA id 81692AE99FB;
        Thu, 29 Jun 2023 15:37:07 +0200 (CEST)
Date:   Thu, 29 Jun 2023 15:37:05 +0200
From:   Tobias Heider <me@tobhe.de>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Michael Chan <michael.chan@broadcom.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
Message-ID: <ZJ2JARrRUUd4YRvX@tobhe.de>
References: <ZJt7LKzjdz8+dClx@tobhe.de>
 <CACKFLinEbG_VVcMTPVuHeoQ6OLtPRaG7q2U5rvqPqdvk7T2HwA@mail.gmail.com>
 <aa84a2f559a246b82779198d3ca60205691baa94.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa84a2f559a246b82779198d3ca60205691baa94.camel@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 03:05:23PM +0200, Paolo Abeni wrote:
> On Tue, 2023-06-27 at 18:31 -0700, Michael Chan wrote:
> > On Tue, Jun 27, 2023 at 5:13 PM Tobias Heider <me@tobhe.de> wrote:
> > > 
> > > Fixes a bug where on the M1 mac mini initramfs-tools fails to
> > > include the necessary firmware into the initrd.
> > > 
> > > Signed-off-by: Tobias Heider <me@tobhe.de>
> > 
> > Thanks.
> > Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> 
> This is a borderline situation, but ... 
> 
> Is there a suitable 'Fixes:' tag we can add here?
> 
> Thanks!
> 
> Paolo
> 

Would "Fixes: c4dab50697ff ("video: remove unnecessary platform_set_drvdata()")"
work?
