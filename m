Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1F670946F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjESKG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjESKGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5BB114
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC92265526
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34E6C433EF;
        Fri, 19 May 2023 10:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684490810;
        bh=iZQbgI4b1euzepcqqOQZ7Jmmbp+GXtXltd1nebvWE8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJbda/jMh+bmgx9kyhoTnTAn5X0jX0jDhE7Von5bL97Dhac6S3skxKetG3pk5uw1S
         +/TnEBOc9PSalgtgkIWSvcIphb5t2PY/59loQtDP36tcK1+ldQpfDkeLDkCxCJn6YO
         n+O/Yf46XcMoNipxajlhUYzj8nrwni+SOWwtYDdU=
Date:   Fri, 19 May 2023 11:06:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [PATCH v2] Staging: rts5208: rtsx: Moved else statement
 to same line with else if
Message-ID: <2023051905-riverside-harmless-177a@gregkh>
References: <20230519100119.25482-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519100119.25482-1-kartikey406@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 03:31:19PM +0530, Deepanshu Kartikey wrote:
> Moved else statement to same line with else if,
> this warning was given by checkpatch.pl
> 
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> ...
> Changes in V2:
>     - Moved else to the same line with else if
>     - Moved comment on else statement to inside of it

This needs to go below:

> ---

That line, so that these comments do not end up in the changelog.

thanks,

greg k-h
