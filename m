Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695117015F6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjEMJ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbjEMJ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:59:53 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C2C26BD
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TOpzh42Zbu0c8cntQo3eEPOm9O5aWTHf5PpNZO/eKbQ=; b=AapkldZbumoSSoYt8DigmCM5LG
        mAyrxd/1XfceIDu9SNL6LUaK6kJO9k39KsLDW1QXTMd73T+msBahUdlkFGzZ2gUY7JDFHxVNHrfBD
        swJDygxX+kJlXdWkhHXkPnGtVSbahqxUyX+16CIITWZ/bcTovj5tuRA1F0wz7Pv39cGdg7YX9O+n8
        4Vd9PuTOxQPFHtperVCfa7vMSP45p86D4FdZyrUNCMLQ/IAyhALDKtSol2w1QjCDcElGVUV+vVHwb
        ejqnuuTMBwHkmjDlytmbhJe69ltmyfaOQlIvYzgZU+Yhqjg5IP5tUR9oBNjT4XS2rL69xjHdrFmWY
        amz+B4dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46468)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pxm2T-0001Cn-0H; Sat, 13 May 2023 10:59:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pxm2R-00060P-No; Sat, 13 May 2023 10:59:43 +0100
Date:   Sat, 13 May 2023 10:59:43 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     SikkiLadho <mushi.shar@gmail.com>
Cc:     mw@semihalf.com, linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: Re: [PATCH] net: marvell: fix error checking for debugfs
Message-ID: <ZF9fj9SEQbBLNgWB@shell.armlinux.org.uk>
References: <20230513014628.39727-1-mushi.shar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513014628.39727-1-mushi.shar@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 06:46:28AM +0500, SikkiLadho wrote:
> This commit fixes error checking in by using IS_ERR inline function to
> check for errors.
> 
> Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: SikkiLadho <mushi.shar@gmail.com>

The modern wisdom for debugfs is not to check for any errors, so if
we're going to touch this, that's the route that any patch should be
taking.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
