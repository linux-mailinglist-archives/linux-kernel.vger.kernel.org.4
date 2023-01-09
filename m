Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB82662C8F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjAIRWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjAIRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:22:14 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5A83FA24
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ttpey8e22bb5fjPsr4NHOCagFDyabQZULxmMJsRWVEk=; b=wh3nA418Dq6VkqIOxQz0hD3Bg+
        UI1PyspgLd0sOmQD3x8BC2pBsfp+Y30jgWO8788opuSoHIZ0C33Kq4UQGwOSbRlr2EcGtN1BECsx4
        u3oNCLcY0EMNlIOX1frLUnjlbkpxNpqX00BLihFIqmj0E4ibcOyoLm4w2gO5gaQxs9zxLL37FhXzs
        m47JEM6Gx4kEuaqPq5/m+3nd0CwOHfLfkUAw4VDLnNxlIQmNMCxWaDW6/jlkQoFTwilCFM1Ho2qWQ
        dq10iuS/nrXV2RiaufA7jVlLHgU51YLnGqbaU226PctLkhoZHYinjiLEa93NmJBgy5nHtpsoD1BIw
        FImCkmuw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36026)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pEvqS-0002ll-Ra; Mon, 09 Jan 2023 17:22:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pEvqP-0007wy-Ug; Mon, 09 Jan 2023 17:21:57 +0000
Date:   Mon, 9 Jan 2023 17:21:57 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: stop nvme matching for nvmem files
Message-ID: <Y7xNNUpfQ6GiQ5+a@shell.armlinux.org.uk>
References: <E1pCkft-004hzL-0Q@rmk-PC.armlinux.org.uk>
 <20230108170520.GA19739@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108170520.GA19739@lst.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 06:05:20PM +0100, Christoph Hellwig wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0cccd40d7801..64cc6947099e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14711,6 +14711,7 @@ T:	git://git.infradead.org/nvme.git
> >  F:	drivers/nvme/host/
> >  F:	drivers/nvme/common/
> >  F:	include/linux/nvme*
> > +X:	include/linux/nvmem*
> 
> I think the proper thing to do would to just match the right files
> from the start:
> 
> F:	include/linux/nvme.h
> F:	include/linux/nvme-*.h
> 
> is it ok if I commit it with your original attributation with that
> change?

LGTM, thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
