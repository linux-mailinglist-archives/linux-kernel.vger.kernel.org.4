Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611DD71277B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbjEZN1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243376AbjEZN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E636C1B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E4B160F30
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8B0C433EF;
        Fri, 26 May 2023 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685107605;
        bh=tYTStZfurhFXtLGWzsuf3KQ4eXs6w6ShgbVqVxBaAnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XirUxCieKIurmpHSk/HUTgXzalsW/QzhWhYYQXE30vcmvv2qu+/vOGT2S/XyDVFbl
         bVW6SqvaxcPrdN+Pd+8o7BJh9BbLVr9dlCK3rYuksnEs6nb+R2NUckGBBn7Jt2dO3N
         gnj0lgWhlfEMxNqO/8Y3WzigFSZdnaF47kS4Rto4=
Date:   Fri, 26 May 2023 14:26:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Iglesias =?iso-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
Cc:     linux-kernel@vger.kernel.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        industrypack-devel@lists.sourceforge.net
Subject: Re: [PATCH] MAINTAINERS: Vaibhav Gupta is the new ipack maintainer
Message-ID: <2023052607-surfer-dilute-2322@gregkh>
References: <20230526100718.35531-1-siglesias@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526100718.35531-1-siglesias@igalia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 12:07:18PM +0200, Samuel Iglesias Gonsálvez wrote:
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

Why are these lines in the body of your email?

> 
> I have no longer access to the HW, nor time to properly maintain it.
> 
> Adding Vaibhav as maintainer as he currently has access to the HW, he
> is working at CERN (user of these drivers) and he is maintaining them
> internally there.
> 
> Signed-off-by: Samuel Iglesias Gonsálvez <siglesias@igalia.com>

For obvious reasons, I need an ack from Vaibhav :)

And a resend, without the email headers in the body.

thanks,

greg k-h
