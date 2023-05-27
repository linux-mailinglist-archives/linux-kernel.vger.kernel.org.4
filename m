Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F6713316
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjE0Hko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjE0Hkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D61B3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0252261182
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 07:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B004C4339E;
        Sat, 27 May 2023 07:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685173231;
        bh=glPRlksMtJ2Hb+GrjIgQbPVF8Ow+3Sn8rwCAHRqXvL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xgXmcE37h0KC1uf7uXe8n6yJw/tPoUIKIAbaQ1Qw0etyEBNDJYiTPo3XlMm2YUJCm
         O8XAuOhglujsN0sTZguQ4Rv6gBsTq5IqAvxnVkiaxRSW74TraL2R/a90rZEQVBKpEe
         ZMc4REx5EyRYoZQjVei7kJ4fvh9ihSrS3R/2Yrts=
Date:   Sat, 27 May 2023 08:40:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] Staging: rts5208: rtsx: Moved else statement to same
 line with else if
Message-ID: <2023052759-extrovert-resize-252d@gregkh>
References: <20230519101920.27342-1-kartikey406@gmail.com>
 <20230519101920.27342-2-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101920.27342-2-kartikey406@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 03:49:20PM +0530, Deepanshu Kartikey wrote:
> Moved else statement to same line with else if,
> this warning was given by checkpatch.pl
> 
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> ---
> Changes in V2:
>             - Moved else to the same line with else if
>             - Moved comment on else statement to inside of it

I have 2 v2 patches in my mailbox, which are different, so obviously one
of them is lying.  Please fix up and send a v4.

thanks,

greg k-h
