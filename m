Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6081A718901
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjEaSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEaSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF0128
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86060614BA
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 18:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F651C433D2;
        Wed, 31 May 2023 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685556209;
        bh=w8AonyURJ04ONWrhlkbHyaeNLkA8eDcfq7Npj+vnFGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBFj+9lLSoog8vQ1NVTqC8b4OCOdOG4vMnxLJN/oqC+0TmJWlpWpBSCNCrO7343SJ
         1tDaUlgwaPnGJS010Qpr943wTB90xzcyzwJJQq5v+AC2UthazNYy/TIbbJ/WceHk2O
         wf7shkT4l2NlL27AS6b4zz+Of+hLNO5dN2j4bw5g=
Date:   Wed, 31 May 2023 19:03:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rene Herman <rene.herman@keyaccess.nl>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] isa: Remove unnecessary checks
Message-ID: <2023053106-multitask-sultry-b4c8@gregkh>
References: <20230517125025.434005-1-VEfanov@ispras.ru>
 <ZGbU7YQgzGelwiGy@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGbU7YQgzGelwiGy@fedora>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 09:46:21PM -0400, William Breathitt Gray wrote:
> On Wed, May 17, 2023 at 03:50:25PM +0300, Vladislav Efanov wrote:
> > The isa_dev->dev.platform_data is initialized with incoming
> > parameter isa_driver. After it isa_dev->dev.platform_data is
> > checked for NULL, but incoming parameter isa_driver is not
> > NULL since it is dereferenced many times before this check.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: a5117ba7da37 ("[PATCH] Driver model: add ISA bus")
> > Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> 
> I don't think the Fixes line is needed because this is removing a
> superfluous check rather than fixing a bug. Regardless, here's my Ack
> for Greg as the patch itself makes sense.
> 
> Acked-by: William Breathitt Gray <william.gray@linaro.org>

Yes, the Fixes line makes no sense at all.  I'll delete it when
applying, thanks for the review.

greg k-h
