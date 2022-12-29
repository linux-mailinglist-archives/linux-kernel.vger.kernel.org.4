Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93846589E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiL2HPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiL2HPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:15:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0132BF7F;
        Wed, 28 Dec 2022 23:15:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F3B061722;
        Thu, 29 Dec 2022 07:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F94C433EF;
        Thu, 29 Dec 2022 07:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672298108;
        bh=2fA6Sq9NqC2aCmtbfFOV/twRnlM34/b9KZeZf/oWcfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJDXu41xL7mRYdMBfobooHtmmJ2gYf8/Kru3kwzywI9wnG2UMQ1WeNbF2RCuSzQGv
         GAduGH14waQzESCerpa/uMKjeQPg5ttwnrGiNDEe2TIufyHKD1fZtFJpIwFmlcbW1V
         A/fBnFmF6gAt99C3uxLMEgT9Y7fqTpEkGscWjGXk=
Date:   Thu, 29 Dec 2022 08:14:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tanmay <007047221b@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: media: omap4iss: Fix null dereference
 for iss
Message-ID: <Y60+cx0Q+kdcfcWp@kroah.com>
References: <7f4fe87ef8a9995bc2c64bf2e5a03ef6948b8692.camel@gmail.com>
 <Y6y0r9fPnfWvwlua@pendragon.ideasonboard.com>
 <CAKKF0qA8oB7ZkkQ5-bj=66sP+WmjL6gUDV5EMTBM3SSW5_+qXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKKF0qA8oB7ZkkQ5-bj=66sP+WmjL6gUDV5EMTBM3SSW5_+qXA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 11:19:54PM +0100, Tanmay wrote:
> Hi Laurent,
> 
> Thank you. I will take care of the wrapped lines. I haven't personally seen
> it return Null so yes
> in the best scenario it is a speculation but in the worst scenario it
> shouldn't hurt.

We do not add checks for when things are "impossible" to hit, otherwise
the kernel would be full of unneeded and useless checks everywhere.
Only test for things that can actually happen please.

thanks,

greg k-h
