Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E5F74DE75
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGJTqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJTqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7416A136;
        Mon, 10 Jul 2023 12:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 109C2611C1;
        Mon, 10 Jul 2023 19:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CEFC433C7;
        Mon, 10 Jul 2023 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689018378;
        bh=cWBikRqm4V+QGDEJy1FHTID+jQ9XAUzubNrpwx2bKHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0A0Cm+OgFgclQaBEOZbd54lsQg2oEzc/LNuQNMVmTEQoGnlvCdfgTWNsM/IO9TpXH
         Ttgw/Ul0zhw6BK7+L3ME0ijRWgCKk2w9ImhjEG2h/1M+KqWLr9Qcx7SB82ADfFXCIz
         uAlDXdGvH6snGmGtzD4l6ayCQUIL3njtAGJcYnnw=
Date:   Mon, 10 Jul 2023 21:46:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 3/3] docs: stable-kernel-rules: improve structure
 to optimize reading flow
Message-ID: <2023071035-pristine-plus-0c11@gregkh>
References: <cover.1689008220.git.linux@leemhuis.info>
 <e25941af193a99b70ee27fcbaa61974fc63a50fd.1689008220.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25941af193a99b70ee27fcbaa61974fc63a50fd.1689008220.git.linux@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 07:10:13PM +0200, Thorsten Leemhuis wrote:
> Optimize the text flow to make things more straight forward to follow:
> 
> * remove a subheading without real purpose
> * after outlining the three options add a section that explains them in
>   more detail; move the "Following the submission" text that set in the
>   middle of this to a later place in the document
> * a few small clarifications along the way

All of this churn makes it really hard to determine what the end result
is.  Do you have a before/after result anywhere?

Or maybe split this out into 3 different patches?

thanks,

greg k-h
