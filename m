Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ECA74E946
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGKImT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGKImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF24EAD;
        Tue, 11 Jul 2023 01:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D13C61384;
        Tue, 11 Jul 2023 08:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C37C433C8;
        Tue, 11 Jul 2023 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689064933;
        bh=QWqb6klTfmzfPW+ObPRcGzlmwX27fx2bnikx5E4aU60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBQfTfUvpoLnrtR0W+2pR+8XNjfYaY6d4/QQSdqWSykbFjvleVQtpGqlgzFO5556H
         IXw89gq/zYeahe1kOtiKC+EW5+HfDVvRcAsbG8M4ZBOngVHJZn/wt00sjzeuUvV1Od
         4hYkN2iUxChLyl/FR4WzFJxIKJx9hmRohycLafQ/ubJaffUCR505YGzHRFi3ndDESq
         VrQfrtEqR/CCT8NqKgzCS4NZ11Ir4LqGdA3yjM64481uSIV4AMxGy/+udPfQl5RIu/
         YFNE+MUyvovFuLGObmgEBFXgZmz0Ht9EnPUqtc6v66IXWRn1f6Wde6q2F28htCT+dv
         fCsvCS4y09SSg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qJ8xF-0007QV-2r;
        Tue, 11 Jul 2023 10:42:42 +0200
Date:   Tue, 11 Jul 2023 10:42:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
Message-ID: <ZK0WAbB2P8wFWPCu@hovoldconsulting.com>
References: <cover.1689008220.git.linux@leemhuis.info>
 <29fb398b-a81c-70f9-f67c-21daaa42e4f7@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29fb398b-a81c-70f9-f67c-21daaa42e4f7@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 07:18:43PM +0200, Thorsten Leemhuis wrote:
> On 10.07.23 19:10, Thorsten Leemhuis wrote:

> >  * For patches that may have kernel version prerequisites specify them using
> >    the following format in the sign-off area:
> > 
> >    .. code-block:: none
> > 
> >      Cc: <stable@vger.kernel.org> # 3.3.x
> > 
> >    The tag has the meaning of:
> > 
> >    .. code-block:: none
> > 
> >      git cherry-pick <this commit>
> > 
> >    For each "-stable" tree starting with the specified version.
> 
> /me wonders if something like a "note, such tagging is unnecessary if
> the appropriate version can be derived from a Fixes: tag" would be
> appropriate and worth it here

Having these comments in the patch itself makes it easier to determine
whether a fix addresses a recent regression or an issue that's been
around since forever without having to copy-paste and look up each
commit in the Fixes tag(s).

Johan
