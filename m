Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9060E1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiJZNOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiJZNOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:14:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB3FC1D3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CED2AB821D9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2562BC433D7;
        Wed, 26 Oct 2022 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666790050;
        bh=EKXNLice97kAr2uVDDpkZXUKKHoPsgT66AngNNyUu+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRitB/41lFj3EbBy6J0ZaAv8dloOHeDKi108ghtMuRG2Nf1d4HkoYW1kviVZV28xy
         zjSViml/VG2WYNm8eMVMGLtkcs9Aq9cCoz4uBLy0a8mtgkXTguu9wYK8lZexIxcXCL
         QoJ6KBm6NhBoJyBY20JMy2qdUlg03ivJKlWF5fCI=
Date:   Wed, 26 Oct 2022 15:15:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     UMWARI JOVIAL <umwarijovial@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: most: dim2: hal: aligning function parameters
Message-ID: <Y1ky11EhAfgpqD4U@kroah.com>
References: <20221026110607.GA37960@rdm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026110607.GA37960@rdm>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 02:06:07PM +0300, UMWARI JOVIAL wrote:
> According to Linux Kernel Coding Style, lines should not end with a '('
> Fix-issue reported by checkpatch.pl script.
> 
> Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> ---
>  drivers/staging/most/dim2/hal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

You sent 2 copies of this, but I have no way to determine which one was
correct :(

Please resend a v2 only once so that we know which one is the one to
review.

thanks,

greg k-h
