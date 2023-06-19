Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92873576B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjFSMzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjFSMzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F5E65;
        Mon, 19 Jun 2023 05:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D7D660C07;
        Mon, 19 Jun 2023 12:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A023C433C0;
        Mon, 19 Jun 2023 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687179342;
        bh=CvG/yi73ci9rMW9Aszwmnno5IR66Huown+A2ZSwfS+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c2HhJByQQjGWgcLt1+yITP9a99PlJ9zT3rzgw/IXTpUQNiSGcXRBqnUaNqzcyjIfM
         R9zZk5roeV55zyuJ5dXFbKikPMLjiYkIgeNYQvD/Vvkluz8rJ3KBoi5bthG/5ogdo3
         DcatcBf9wNbR6PNMNoXJAxT7UTI3Hshx09qYNhc0=
Date:   Mon, 19 Jun 2023 14:55:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] Documentation: update git configuration for Link: tag
Message-ID: <2023061925-savor-fetal-6c37@gregkh>
References: <20230619115533.981f6abaca01.I1960c39b1d61e8514afcef4806a450a209133187@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619115533.981f6abaca01.I1960c39b1d61e8514afcef4806a450a209133187@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:55:34AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The latest version of git (2.41.0) changed the spelling
> of Message-Id to Message-ID. Adjust the perl script here
> to accept both spellings.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  Documentation/maintainer/configure-git.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for figuring this out!

Tested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
