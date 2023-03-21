Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0C26C2AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCUHAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCUHAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB962196C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BFCB619B5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F3FC433EF;
        Tue, 21 Mar 2023 07:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679382016;
        bh=OM2A4KB+UNyw53E93L75Z9ferf0e2d7Kz/bpVwCRhUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=03TSjr68IjtGdZIJEpx7J3RmYn+ZtBBng5lZ5bQEtmHGtfA4Wi8OnKYsFo7y6mtqf
         GhueYe0dlpUkA/V+HYtLMTVF4wYheVK+DclSjJQGx6Gmtv4G6eHV94WKcEtAPfGGFJ
         /JVJg23FQ2t5zyNaq4/uLGbq6jueVDY912KaSEDo=
Date:   Tue, 21 Mar 2023 08:00:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: Re: [PATCH v5 0/7] refactor file signing program
Message-ID: <ZBlV/ZEWmLlT9Wuz@kroah.com>
References: <20230320184345.80166-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320184345.80166-1-sshedi@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:13:38AM +0530, Shreenidhi Shedi wrote:
> From: Shreenidhi Shedi <yesshedi@gmail.com>
> 
> This patch series refactors the sign-file program, like:
> 
> - Improve argument parsing logic.
> - Add few more easy to remember arguments.
> - Add support to sign bunch of modules at once.
> - Improve the help message with examples.
> - Few trivial checkpatch reported issue fixes.
> 
> Version 5 changes:
> - Addressed review comments from David Howells.
> - Framgmented the patches into further small units.
> Link:
> v4: https://lore.kernel.org/all/20230221170804.3267242-1-yesshedi@gmail.com/
> 
> Version 1 - Version 4 changes:
> Did some back and forth changes. Getting familiar with patch submission
> process, nothing significant happened.
> 
> Links:
> v1: https://lore.kernel.org/all/dc852d8e-816a-0fb2-f50e-ff6c2aa11dd8@gmail.com/
> v2: https://lore.kernel.org/all/20230213185019.56902-1-yesshedi@gmail.com/
> v3: https://lore.kernel.org/all/20230213190034.57097-1-yesshedi@gmail.com/
> 
> Shreenidhi Shedi (7):
>   sign-file: refactor argument parsing logic - 1
>   sign-file: refactor argument parsing logic - 2
>   sign-file: refactor argument parsing logic - 3

"1 2 3" are not good ways to write changelog summaries, sorry.  Please
explain things better, or split them up into more logical and smaller
pieces.

thanks,

greg k-h
