Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D706C003A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 10:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCSJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCSJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 05:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02D412CDB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 02:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E2CD60F56
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4881AC433EF;
        Sun, 19 Mar 2023 09:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679216913;
        bh=muQIyS8L0u+wQYk7fHuS9Tv5nL+xkWTZyobwqrXUzPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDJQV9ZvXoMtD+VHedCLXDysgjyX6XK17CG6ZqVp2mUeZvlIEJ1tM2HJeTvoXyISV
         zhJCtPNBhQY5figas78NE4HiIVw1L7yo9qyc0CJcRmzrhmGKK2iodCRcjI2nS98BGP
         7V1uqqnPJ4xNqyiSM3AqPcDFNX/ZS34emfzQOcMs=
Date:   Sun, 19 Mar 2023 10:08:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] kobject: introduce kobject_del_and_put()
Message-ID: <ZBbRDl4OYGZIlx7E@kroah.com>
References: <20230319084134.11804-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319084134.11804-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 04:41:24PM +0800, Yangtao Li wrote:
> There are plenty of using kobject_del() and kobject_put() together
> in the kernel tree. This patch wraps these two calls in a single helper.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -add kobject_del_and_put() users
>  include/linux/kobject.h |  1 +
>  lib/kobject.c           | 17 +++++++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)

Any reason you only sent me one patch?  I guess you don't want me to
review them?  :(

