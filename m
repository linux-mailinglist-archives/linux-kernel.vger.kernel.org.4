Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFA72DB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjFMHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjFMHkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68445AA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2C1861FC0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35AEC433EF;
        Tue, 13 Jun 2023 07:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686642035;
        bh=4y409Z4Eu1rh9icd4UWh1tWXkyxkDQTdIE6G/qeylyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5LvtlBIDtk6QZcyB/kcTnfiYSSyjgD0TdW7ZqyL3/X2kpaMncBMgA26hxyJ7kkVX
         vZvvbkJ6ldZzMD5k8paSNj/9KltZvqFFOcwfAidBOjc+nRvKsJ29fPswSUZq2zYxtz
         CQdwD4tqRmNXiZ1bok8IYUXiiIz1t936MZLrVrXU=
Date:   Tue, 13 Jun 2023 09:40:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     nikhil.agarwal@amd.com, Nipun.Gupta@amd.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, git@amd.com, michal.simek@amd.com
Subject: Re: [PATCH v4] cdx: Replace custom mcdi logging with
 print_hex_dump_debug()
Message-ID: <2023061300-mouth-suffering-8c20@gregkh>
References: <20230613065231.19932-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613065231.19932-1-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:22:31PM +0530, Abhijit Gangurde wrote:
> Replace custom mcdi logging for send and receive requests
> with dynamic debug method print_hex_dump_debug().
> 
> Fixes: eb96b740192b ("cdx: add MCDI protocol interface for firmware interaction")

This isn't a "fix", right?

> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Closes: https://lore.kernel.org/lkml/CAMuHMdWTCdQagFFANygMgA8D0sWaoGxWv2AjibC3vwSd0UxuRw@mail.gmail.com/

This wasn't a "bug report" this was a "the code should be changed to not
do this" type of thing.  Part of normal development.

Other than those nits, looks good, want to fix this up and resend a v5?

thanks,

greg k-h
