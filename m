Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B787735AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjFSPNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFSPN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D890170D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CEDB60D27
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 15:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A43C433C8;
        Mon, 19 Jun 2023 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687187602;
        bh=Hl7F8i4Ns4/cDlktPkFvVf3oBrdex8Xe+VfOdoYx0AU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dE/WewfevgPXCW5Hin+aFVsdV3ekEMtU+RpBbdYX316TB/jhQ6P1Jn9Ls2ARhGwvN
         +vMYa4hs9ZPhSV4HpfflFlCw2C5J42ghffIw1hcaUFZI1X8xmsPt+DoZGMI2dI3FIK
         XMYqnpUTd71Ulq3xdWdbXuo7iazjltbSO0xyP0UY=
Date:   Mon, 19 Jun 2023 17:12:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, y0.cho@samsung.com,
        yuni.seo@samsung.com
Subject: Re: [GIT PULL] extcon next for 6.5
Message-ID: <2023061936-extortion-banshee-4ba8@gregkh>
References: <2164491b-973d-3e54-fd28-f00d6efa3cce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2164491b-973d-3e54-fd28-f00d6efa3cce@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:33:18PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v6.5. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:
> 
>   Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.5

Pulled and pushed out, thanks.

greg k-h
