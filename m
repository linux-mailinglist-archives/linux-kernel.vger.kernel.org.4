Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F125FFE03
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 09:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJPHhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJPHhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 03:37:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E704A3ED72;
        Sun, 16 Oct 2022 00:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7670B80B35;
        Sun, 16 Oct 2022 07:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E64C433D6;
        Sun, 16 Oct 2022 07:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665905828;
        bh=nHSBy09q1eBXtLfd49RsfBDDrhOjOIOGh/EZaugCF04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e8xZDSJK9x/42cDrlmxPjc+wAgufJD9cXxfYOM/bQD7EUgRiWLsOLO3Onmd7jwSgu
         ZShEBJ42JDvJR2oLvHUZ5vmy/m+6aC1iJIzpYb+cgCsy8BWFtQQMbXhTMNsmJySRqF
         NSLXc4HojnF4GiDXLGUxDk5Cip6uJXNJtiTv6YKE=
Date:   Sun, 16 Oct 2022 09:37:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     ematsumiya@suse.de, lsahlber@redhat.com, pc@cjr.nz,
        stfrench@microsoft.com, stable-commits@vger.kernel.org
Subject: Re: Patch "cifs: destage dirty pages before re-reading them for
 cache=none" has been added to the 4.19-stable tree
Message-ID: <Y0u004u9tJ68ACUs@kroah.com>
References: <16659053001758@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16659053001758@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 09:28:20AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     cifs: destage dirty pages before re-reading them for cache=none
> 
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      cifs-destage-dirty-pages-before-re-reading-them-for-cache-none.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Nope, breaks the 4.14 and 4.19 builds, so dropped from there.
