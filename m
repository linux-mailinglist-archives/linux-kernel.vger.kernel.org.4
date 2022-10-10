Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112F5FA175
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJJP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJJP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:56:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676FE74CE1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YpOA3yDkOhhLvlnmsAVbYcm3nzeMbmZuIBkpzhRIZOI=; b=p65M3v9WQrCi7bcHQV5xlVnK0j
        ot7O6nOZ+yKjc2xMvbK2eh0JaV/tXy/1MT1h7isK40qeoia4HhmjixqIkQrjDFl8hkC367qySghQ2
        9gHZLaAOWh+k33Q9tX1uC+QLgWtUTwq2nUWwOFm6+dfc4630y7z8zOyPNcPGIQRU5BCeVP0mx7Ele
        VG4UdCfEVmrxZx6md1TyyyrmcgA6/7rTEzuA0ZsmYhN1tkIhcZCzItA+1dlkXXKvPs1+jwGQ/bLtl
        Wor54DMrLbmQY1CFFXnIVDaxKlHi4dWGVrCHEnrTN1ywby77xz/py6ihrJrwPvm99mWTXZUoprGkO
        sb34A6SA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34664)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ohv8G-0004qc-3Z; Mon, 10 Oct 2022 16:55:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ohv8B-0001xp-P9; Mon, 10 Oct 2022 16:55:51 +0100
Date:   Mon, 10 Oct 2022 16:55:51 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: mm: Provide better message when kernel fault
Message-ID: <Y0RAh/6e60fXUex6@shell.armlinux.org.uk>
References: <YzF7X2PBdps2MaG/@shell.armlinux.org.uk>
 <20220927062134.99019-1-wangkefeng.wang@huawei.com>
 <4339e1f4-b5c1-0b61-3a37-e63aafe22857@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4339e1f4-b5c1-0b61-3a37-e63aafe22857@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 07:24:15PM +0800, Kefeng Wang wrote:
> 
> On 2022/9/27 14:21, Kefeng Wang wrote:
> > If there is a kernel fault, see do_kernel_fault(), we only print
> > the generic "paging request" or "NULL pointer dereference" message
> > which don't show read, write or excute information, let's provide
> > better fault message for them.
> 
> Hi Russell, what's your option about this one, if no object,

LGTM.

> I will send to ARM patch system, thanks,

Yes please, if not already done.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
