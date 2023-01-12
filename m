Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB356667386
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjALNtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjALNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:49:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED9948CC1;
        Thu, 12 Jan 2023 05:49:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9BD561FBB;
        Thu, 12 Jan 2023 13:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D68FC433EF;
        Thu, 12 Jan 2023 13:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673531371;
        bh=A7eHIkxPswE2dhvPZdZeM3L8qLICMWeWurMBGm2/+wU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKxSxjEEx51OoN6G9onWDuyj0+H3cyftoEl5oBM/kYlDQnxgNZZJ41PzR87FyitBg
         pzmcGoCaLIfUybn0DNvjz8ADG2R/Zi0bKnky2B/xUBsjAQIXoKa16MAT+yOtD+n83W
         vjwDwne03fz25T4xLw6sMeZVSoRyvt03LEb3eL6E=
Date:   Thu, 12 Jan 2023 14:49:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     kuba@kernel.org, pabeni@redhat.com, slipper.alive@gmail.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "net/ulp: prevent ULP without clone op from entering the
 LISTEN status" has been added to the 5.4-stable tree
Message-ID: <Y8AP6Lqo9sfX9Bb8@kroah.com>
References: <16735310493146@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16735310493146@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 02:44:09PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     net/ulp: prevent ULP without clone op from entering the LISTEN status
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Oops, nope, this broke the build for 5.4 and older kernels, now
dropping.
