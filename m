Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B76E5EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjDRKhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjDRKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:37:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FB8188;
        Tue, 18 Apr 2023 03:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4186562FF3;
        Tue, 18 Apr 2023 10:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566C2C4339B;
        Tue, 18 Apr 2023 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681814226;
        bh=gO4bVRgOrIIJmXe6DgoqgWS+0MkQUyJaUaSPCjAVhLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0mypcrtY6IyIS/qvWseQQhQKH7xdh1C0fNefrddVN+qUU8ZFw44DpvYpKZTu+4m6S
         IedyaHFduoMplCWklJ7wFgFLtE6LVjNdZWNCP6LrL3T9f/x9ffiDzk+ksbAM2+gIN+
         rJq/0xqp5t4Be0coFlQ/P8jAfwCWzWdL6TDrgscw=
Date:   Tue, 18 Apr 2023 12:37:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     ckuehl@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        yb203166@antfin.com, stable-commits@vger.kernel.org
Subject: Re: Patch "virtiofs: split requests that exceed virtqueue size" has
 been added to the 5.10-stable tree
Message-ID: <2023041858-repressed-comrade-928f@gregkh>
References: <2023041834-ferry-suitor-acc9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023041834-ferry-suitor-acc9@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 12:32:34PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     virtiofs: split requests that exceed virtqueue size
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Also now dropped.
