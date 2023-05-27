Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E2713311
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjE0Hjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjE0Hjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:39:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05542134
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9678360B14
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 07:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98317C433EF;
        Sat, 27 May 2023 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685173175;
        bh=JicBv+V/s9eE627xqKdQDBgHyA8/oY5+KtkcLzLvObs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrKQ1uNcCuhSRhoSJ44BxjpbCs8UVqzYqMCPWmdq2nV6pK7mXYrdQe8Ad8qgGPwjo
         v7TpjbfDObBPjmtxtbHEcxg8o2Ph2h675Fg8gHN2Ks2XgU6DjuJAelyzSXyXTBtoVD
         VBdQ2Wb+vt8aICG/05W4jhfB5Z7JFflG43ZLppA4=
Date:   Sat, 27 May 2023 08:39:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] Staging: rts5208: rtsx: Moved else statement to same
 line with else if
Message-ID: <2023052758-taco-clarinet-5d7e@gregkh>
References: <20230519101920.27342-1-kartikey406@gmail.com>
 <20230519101920.27342-2-kartikey406@gmail.com>
 <CADhLXY6HuOZK3atwP8FBXU2Yxojkx9SKL87L3dg_SBfrPVN-Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADhLXY6HuOZK3atwP8FBXU2Yxojkx9SKL87L3dg_SBfrPVN-Cg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 03:56:29PM +0530, Deepanshu Kartikey wrote:
> Hi Greg,
> 
> Any update ?

Please do not top post.

> On Fri, May 19, 2023 at 3:50 PM Deepanshu Kartikey <kartikey406@gmail.com>
> wrote:

This was one day later, please realize that coding style cleanups are
usually at the bottom of my review lists (for obvious reasons).  You
only need to resend if I haven't responded within 2 weeks.

Take the time to do other work, like review other patch submissions,
making my (and other maintainers), lives easier.  Don't just ask others
to do work for you :)

thanks,

greg k-h
