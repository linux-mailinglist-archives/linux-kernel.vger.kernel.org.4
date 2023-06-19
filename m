Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7310C73576E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjFSM6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjFSM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7A119
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BE460B6E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899F4C433C8;
        Mon, 19 Jun 2023 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687179478;
        bh=lvQFynrSlluUDfKEQRaFguLfTs4F/l2Y7cwjnHAJVMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAp6/Cl5pH0cVIqqLi8S/dSa6nxYS/1OV+34wN1Hn45/wZOgdGKjOWD8j1cmucpvc
         sMgV1vQG6OC1KjqPRE0Vm5OKgxbbkfQdmUemwUp7rey9/u6/kAg1CNWc05/3MhpgHh
         ByI6S1k3IGPNdDKShufq/kF6ss9imOB7wL3hjruM=
Date:   Mon, 19 Jun 2023 14:57:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Yogesh Hegde <yogi.kernel@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: Re: [PATCH v3 0/4] Trivial code cleanup patches
Message-ID: <2023061938-unbounded-unbent-e706@gregkh>
References: <cover.1687092111.git.yogi.kernel@gmail.com>
 <e80d385d-5515-ed42-e5dd-f9c977f7d4d1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e80d385d-5515-ed42-e5dd-f9c977f7d4d1@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 10:26:37PM +0200, Philipp Hortmann wrote:
> On 6/18/23 15:03, Yogesh Hegde wrote:
> > Rename variables in struct rtllib_device to avoid CamelCase which is not
> > accepted by checkpatch.
> > 
> > ---
> > v3: The driver is split into 2 modules, calling the functions directly which
> >      the v2 of the patchset does breaks compile. So reverting back to v1 of
> >      the patch as suggested by Greg Kroah-Hartman <gregkh@linuxfoundation.org>.
> > 
> > v2: Removed the variable and called the function directly instead of
> >      just renaming the variable as suggested by Greg Kroah-Hartman
> >      <gregkh@linuxfoundation.org>.
> > 
> > 
> > 
> > Yogesh Hegde (4):
> >    staging: rtl8192e: Rename variable SetWirelessMode
> >    staging: rtl8192e: Rename variable SetBWModeHandler
> >    staging: rtl8192e: Rename variable LeisurePSLeave
> >    staging: rtl8192e: Rename variable InitialGainHandler
> > 
> >   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  4 ++--
> >   drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  8 ++++----
> >   drivers/staging/rtl8192e/rtl819x_HTProc.c      |  4 ++--
> >   drivers/staging/rtl8192e/rtllib.h              | 12 ++++++------
> >   drivers/staging/rtl8192e/rtllib_rx.c           |  2 +-
> >   drivers/staging/rtl8192e/rtllib_softmac.c      | 12 ++++++------
> >   drivers/staging/rtl8192e/rtllib_softmac_wx.c   |  6 +++---
> >   7 files changed, 24 insertions(+), 24 deletions(-)
> > 
> This patch series alone is fine. But when my patch series ([PATCH 0/9]
> staging: rtl8192e: Remove unsupported modes a and 5G) is applied before it
> fails as we change same lines. Will see what happens.

Yes, none of these apply :(

Yogesh, can you rebase this on my staging-next branch and resend?

thanks,

greg k-h
