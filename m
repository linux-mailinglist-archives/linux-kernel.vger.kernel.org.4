Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2262445F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKJOdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiKJOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:33:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535E5F0F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:33:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF27F618F7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02142C433C1;
        Thu, 10 Nov 2022 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668090811;
        bh=+rHJIUa3DRKlQrklPQi153v0vgi/mtpzdYW9aIbOaa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYvHGydPUtMr6U9+8ypPRydeMyiPJGQ6rakj+r6k8Gx8fdAWdZBGFbQ2NyvB6AgCw
         z70QISOT/2m0DOL++qT67fVZ10wD1BeQGqG++IviOGO9bvovEltqXjL2IF3wPm2EF9
         PVKFwDyNCjUYkLiXpNSw1+5wLyRW4vw+V5KWFZko=
Date:   Thu, 10 Nov 2022 15:33:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] virt: fsl_hypervisor: Replace NO_IRQ by 0
Message-ID: <Y20LuAqHljYI4Bo8@kroah.com>
References: <20dd37b96bac0a72caef28e7462b32c93487a516.1665033909.git.christophe.leroy@csgroup.eu>
 <bccb8729-7f0a-5f97-d1b1-5401ed9f3235@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bccb8729-7f0a-5f97-d1b1-5401ed9f3235@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 01:25:14PM +0000, Christophe Leroy wrote:
> Hi Greg,
> 
> Le 06/10/2022 à 07:27, Christophe Leroy a écrit :
> > NO_IRQ is used to check the return of irq_of_parse_and_map().
> > 
> > On some architecture NO_IRQ is 0, on other architectures it is -1.
> > 
> > irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
> > 
> > So use 0 instead of using NO_IRQ.
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Do you plan to apply this patch, or is any change required ?

It is in my review queue, give me time to catch up...

thanks,

greg k-h
