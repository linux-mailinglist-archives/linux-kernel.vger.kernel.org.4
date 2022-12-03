Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339E96417AD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiLCQH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLCQHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:07:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD91EAF4;
        Sat,  3 Dec 2022 08:07:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43F0860B1A;
        Sat,  3 Dec 2022 16:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2F4C433C1;
        Sat,  3 Dec 2022 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670083643;
        bh=Cxm5cX1/vRr6rTVftoIlwySvdfgJ/QgkmcVNP/aI/3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rZxwQvjDdNkLrpGiIC1dofLAzcSqRi2r+jlxMyuBRKl9bCsujpO+QhkAC5XndgNh6
         oz2RBT5LJwCuqzg3S1tmbbMJBgM4gkTbu5plpNTfdfjQyxy5GmNWFF/BTytFREh7ya
         X6w7Du1Y3o1u5XqVaHuKyebCjTCAm9GBkaXrkyBBhNFQEFr64LR7blH8/Z9Z2DAFFb
         BpIfc7CNKJ4VJ3Dm/ZRONw8MaKayBodAcE7llWu6FHQsD2WZ7J0YwD0oFhtYeY8q0Q
         5yMWH4B6CZfP5jlgfHts1bhjUq3r4otcHjraXOUDstOe0GIfmVzwxpUSEFg6rzNRg7
         vTHyQtftG4RLA==
Date:   Sat, 3 Dec 2022 16:20:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, lars@metafoo.de,
        benjamin.gaignard@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Removing the last of IIO_COUNT (stm32-timer-trigger)
Message-ID: <20221203162008.007df587@jic23-huawei>
In-Reply-To: <Y4KuBicVeRAsfqxq@fedora>
References: <Y0vzlOmFrVCQVXMq@fedora>
        <ec6b8983-1567-92c8-f1cd-baf970ca4046@foss.st.com>
        <Y4KuBicVeRAsfqxq@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

...

> > ---
> > To conclude, there some open items here, but hopefully nothing blocking.
> > In case we sort all these, this will allow to remove the IIO_COUNT
> > channel (along with the IIO device) being registered.  
> 
> I'm certain Jonathan will want some sort of deprecation schedule first
> to make sure any existing users have time to migrate to the Counter
> interface before we remove the IIO one, but it will give me a nice
> feeling of completion to see the last of IIO_COUNT superceded by the
> Counter interface. ;-)

If there is nothing in tree, I'm fine 'removing' it. However, note
that we'll have to keep a placeholder for some of the defines to avoid
renumbering other types etc.  So probably just stick a couple of underscores
in front to make it __IIO_COUNT and add a comment to say it should not be used.

Jonathan

> 
