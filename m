Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325DB63425D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiKVRUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiKVRUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:20:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADCB78193;
        Tue, 22 Nov 2022 09:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E137EB81A02;
        Tue, 22 Nov 2022 17:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503AAC433C1;
        Tue, 22 Nov 2022 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669137608;
        bh=CkDkYxYumzSqVOlmgiodWCPA5slheCSG76bDEVMll58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRD74yudS4/gNW7keEQHVwVnYPOWkIkFjHjwzbIVo1GnxR/IXoWHGFY1HasUCWwLd
         Zfg7bY2lCGixxjiwlcAlLyQlJtW3fJGkeYsPeMY5HNtDxc1EWVOLcZMfbYbNnzSyPW
         ugIArDJwdTxXpaIGxUWH65V/4O/FoJ8tIKRH6oA4=
Date:   Tue, 22 Nov 2022 18:20:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fix for 6.1-rc
Message-ID: <Y30ExTAswA4kcxD6@kroah.com>
References: <20221117135146.9261-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117135146.9261-1-djakov@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:51:46PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains a tiny fix for the current cycle. The
> details are in the signed tag. It has been in linux-next for a week.
> Please pull into char-misc-linus when possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:
> 
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.1-rc6

Pulled and pushed out, thanks.

greg k-h
