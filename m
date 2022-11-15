Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A29D6295E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbiKOKcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKOKct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:32:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEC91A83B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:32:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7616A615F5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D845C433D6;
        Tue, 15 Nov 2022 10:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668508367;
        bh=J0AqUCNbx/Nxfw1cajX4O1nZtC6ckY4c4ixhv+h6pe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFb1hsWA8wetK2APjkF+q18gGGqZqpI8+yLsuswnkUuqVjce9x1bqHG0PpCxAMlo/
         PX5r9ZijPvovg/xpqtjJIXABL0UJUSITERWFJMSAzBTu8XD+dVOf7G+fTrotZjbpL6
         JzsTWalzUxEmWvtAC32IagpEtMnP6rEIRJtudOyU=
Date:   Tue, 15 Nov 2022 11:32:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     guo.ziliang@zte.com.cn
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] kernfs: use strscpy() is more robust and safer
Message-ID: <Y3NqyDDGz/UKPgxM@kroah.com>
References: <202211150847452601249@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211150847452601249@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 08:47:45AM +0800, guo.ziliang@zte.com.cn wrote:
> From: guo ziliang <guo.ziliang@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.  That's now the
> recommended way to copy NUL terminated strings.
> 
> Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>

Note, your email is showing up as "unvalidated" with in invalid
signature based on your domain.  Please fix that up so that your patches
will be able to be accepted, otherwise we have to consider this as a
spoofed email :(

thanks,

greg k-h
