Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45A46932EA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 18:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBKRv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 12:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBKRvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 12:51:23 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037E21712
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 09:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=DmpoQmaKwwi+psIOM8QBfPbTJ7OKW0zXKm8toU9HU/Y=; b=iDTanqFfc3ash2GoCfiseHxCSs
        Gok2p2AxarBLDCwiMcsMJ8Q+9vwnvhwwRSGvHJIO6qJcjafzxiwPE2vBSvCX2Wpy5nC/btOxisEqY
        Rixmj2zXuALnDholIrOOJBjW+T2Fub4f9QYgKjji3aEuswL6y6hejkit/QNKusbFlKAU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pQu1u-004iT2-J9; Sat, 11 Feb 2023 18:51:18 +0100
Date:   Sat, 11 Feb 2023 18:51:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] soc: dove: release node before breaking child_of_node
 loop
Message-ID: <Y+fVlugBi3z9F97a@lunn.ch>
References: <Y+e+90hi6KwoB/xh@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+e+90hi6KwoB/xh@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 09:44:47PM +0530, Deepak R Varma wrote:
> The iterator for_each_available_child_of_node() increments the refcount
> of the child node it is processing. Release such a reference when the
> loop needs to break due to an error during its execution.
> Issue identified using for_each_child.cocci Coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>

Looks reasonable.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
