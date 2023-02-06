Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEC168BD10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjBFMjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjBFMjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:39:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF2B15CAC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:39:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 899B960EC7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77560C4339E;
        Mon,  6 Feb 2023 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675687192;
        bh=zAt6NAmuVFJkic5yLYRqo4aWyeBcpv5QKooJeGdQucw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIeOe70Bu/af0gGOTBMnMEsjxjUI3rytcWzxittmF7WnGOAb3q0doGRrRPxD5l/OX
         UjD9OP/Wrc7Rpm2L71A3vPnsCfYukHPjp6Lg2x6GacRaDD3rasx4iHlYa/Mej60v3F
         MLuPXrez4MaSN4Cl4wG2jAtlLPJ+iDj9KPkPd5/E=
Date:   Mon, 6 Feb 2023 13:39:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>
Subject: Re: [RESEND PATCH 30/37] nvmem: core: fix
 nvmem_layout_get_match_data()
Message-ID: <Y+D1FN0rXwCPJtBz@kroah.com>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
 <20230206102759.669838-31-srinivas.kandagatla@linaro.org>
 <Y+Dst2V9mfJbVrzD@kroah.com>
 <b16d137b-56ee-5aa2-346d-8ab02d590bf8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b16d137b-56ee-5aa2-346d-8ab02d590bf8@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 12:08:09PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 06/02/2023 12:04, Greg KH wrote:
> > On Mon, Feb 06, 2023 at 10:27:52AM +0000, Srinivas Kandagatla wrote:
> > > From: Rafał Miłecki <rafal@milecki.pl>
> > > 
> > > This function was trying to match wrong OF node (parent device's)
> > > against an of_match_table. It was always returning NULL.
> > > 
> > > Make it match layout's OF node against layout's of_match_table.
> > > 
> > > Note: __maybe_unused is needed to avoid:
> > > warning: variable 'layout_np' set but not used [-Wunused-but-set-variable]
> > > (of_match_node() is no-op without CONFIG_OF).
> > > 
> > > Fixes: 61a093b4a0e0 ("nvmem: core: introduce NVMEM layouts")
> > 
> > Nit, how can you have a git commit id if you are sending me patches to
> > be applied to my tree?
> > 
> How should I deal with this situation?
> I apply patches to nvmem-next tree and developers fix issues on top of it.
> On the other hand I send patches as list to you to go via char-misc, so the
> fixes tag is really not relevant to char-misc.
> 
> Should I drop those fixes tag before sending it out?

Probably as the git commit id makes no sense anymore.

thanks,

greg k-h
