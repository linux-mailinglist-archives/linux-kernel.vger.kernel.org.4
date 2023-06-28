Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0867413F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjF1OkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:40:20 -0400
Received: from vps0.lunn.ch ([156.67.10.101]:40252 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230340AbjF1OkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=cW+45nW3hJrB+ORXPsF9u401T/nSilM4vjgp2/JRVK8=; b=U1WferOlqrpgddhvvlvTWes0zc
        gz9sFpyiKouuyXJTUYNzdFHYS6e6yVbKtT8Fkilt/42PZXz2BDJyjoEp+Q596vjZztfSB1KA5oUT3
        w0vosHmfbAFtJLPTH97RuCn3S9Mc5r/aU/LSSbblgfHMV0vEIB88AAaMTA20vfI+hZ7c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEWKW-0007sj-0E; Wed, 28 Jun 2023 16:39:36 +0200
Date:   Wed, 28 Jun 2023 16:39:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     yunchuan <yunchuan@nfschina.com>
Cc:     Hao Lan <lanhao@huawei.com>, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, irusskikh@marvell.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        steve.glendinning@shawell.net, iyappan@os.amperecomputing.com,
        keyur@os.amperecomputing.com, quan@os.amperecomputing.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        mostrows@earthlink.net, xeb@mail.ru, qiang.zhao@nxp.com,
        yangyingliang@huawei.com, linux@rempel-privat.de,
        ansuelsmth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] Remove unnecessary (void*) conversions
Message-ID: <ecd70c28-1629-4b6c-96fc-a0b8f8713a04@lunn.ch>
References: <1f5652f7-7eb2-11f0-4a07-c87f2992e509@huawei.com>
 <734b846f-3235-f2e3-db06-6e852803cd7f@nfschina.com>
 <badb3550-e157-4a31-9e49-ad184990c06d@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <badb3550-e157-4a31-9e49-ad184990c06d@lunn.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:37:43PM +0200, Andrew Lunn wrote:
> > Hi, Hao Lan,
> > 
> > Sorry for that, I just compiled these patches in the mainline branch.
> > I know now, it's also necessary to compile patches in net and net-next
> > branch.
> > Thanks for your reply!
> 
> net-next is also closed at the moment due to the merge window. Please
> wait two weeks before reposting, by which time net-next will be open
> again.

Your email threading also seems to be broken, there is no
threading. That might cause pathworks an issue.

	Andrew
