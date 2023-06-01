Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9A271F08C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjFARVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjFARU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0973B136;
        Thu,  1 Jun 2023 10:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B96664835;
        Thu,  1 Jun 2023 17:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81995C433D2;
        Thu,  1 Jun 2023 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685640056;
        bh=9EaqC1DnJMuk4AMWEh9JBON4F0FRodQtCo6RrSC2wsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZdpfz5JapOz2Y0YELeTlVq+OU8fVjl+6hfGwZNBz3pxMSdwsyuN1PoPIxtCi6WhT
         Nq9efP1eCyxIOXD3HPrwhWWvJiIOlgH6Sqk4XYk5YEaEmSXVpz6CenikE5KiEmiP89
         6SYgjpMPdkF9aCLQsMnNr/htH5TflxeDBbVKGAOo=
Date:   Thu, 1 Jun 2023 18:20:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Danila Chernetsov <listdansp@mail.ru>
Cc:     stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5.10 1/1] xfs: verify buffer contents when we skip log
 replay
Message-ID: <2023060127-flick-velcro-ca45@gregkh>
References: <20230601164439.15404-1-listdansp@mail.ru>
 <20230601164439.15404-2-listdansp@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601164439.15404-2-listdansp@mail.ru>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 04:44:39PM +0000, Danila Chernetsov wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> commit 22ed903eee23a5b174e240f1cdfa9acf393a5210 upstream.
> 
> syzbot detected a crash during log recovery:

XFS patches for stable come from the XFS maintainers, so please work
with them if you feel any specific patch is missing from a stable tree.

thanks,

greg k-h
