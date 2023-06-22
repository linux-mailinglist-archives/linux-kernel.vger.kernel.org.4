Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2573A14B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjFVMzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFVMzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:55:54 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52481BD0;
        Thu, 22 Jun 2023 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=in5rHbtZh5PnvNV43zTQNPPaKJwrcaBBdZKS4TMMpb4=; b=SskxjTwjUfLG+a9+5pE12sh3SD
        2qvMEdRG9sRPjcJNA6497NVv5eW2tDfp4pgAldqOx+prmWAJrFrVyHcQPcvZaIYZPBy+l+lwwK3sf
        iORxDOCbxmKs9wqzKVEaclWRxtK28kEQsTAoJYC8VE+91fFDEmzTnJmyd+R3g5rvNPsA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCJql-00HGQR-6a; Thu, 22 Jun 2023 14:55:47 +0200
Date:   Thu, 22 Jun 2023 14:55:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] docs: ABI: sysfs-class-led-trigger-netdev: add
 new modes and entry
Message-ID: <ae617bf0-945b-4ad7-a3ed-db6ad1c39418@lunn.ch>
References: <20230621092653.23172-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621092653.23172-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:26:53AM +0200, Christian Marangi wrote:
> Document newly introduced modes and entry for the LED netdev trigger.
> 
> Add documentation for new modes:
> - link_10
> - link_100
> - link_1000
> - half_duplex
> - full_duplex
> 
> Add documentation for new entry:
> - hw_control
> 
> Also add additional info for the interval entry and the tx/rx modes with
> the special case of hw_control ON.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
