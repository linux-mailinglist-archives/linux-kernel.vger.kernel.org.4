Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91867696746
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjBNOq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjBNOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:46:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FBC2594B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:46:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADDCC61719
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B11C433D2;
        Tue, 14 Feb 2023 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676386003;
        bh=aLS5OGDK4ZjK3bEjx3IsmhzzlfzqQGTLuzZcxEx7vOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zY49zRpU3xo5Fzds+oKbdQEJnl1m0FPuOJ2iINMQcktkdqbS5DxPidx3pqle4B2Jy
         VxgZ8fLDIfM5b8XdYek011aMJRnj0cjqkcfvx5Rz2TzY4NUJkXAyGk3+7ZZkDrVrhN
         xbGS5ZxMrcBdXZHezVquRYk/uN9YyXJ8xf46gxpc=
Date:   Tue, 14 Feb 2023 15:46:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: class: move EXPORT_SYMBOL_GPL() lines to
 the correct place
Message-ID: <Y+ue0KDoe96VYxrc@kroah.com>
References: <20230214144117.158956-1-gregkh@linuxfoundation.org>
 <CAJZ5v0gi1VdxHvWdrmFYq4vQzbXnPpUhJa144wozp5Oaaz4yLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gi1VdxHvWdrmFYq4vQzbXnPpUhJa144wozp5Oaaz4yLQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 03:42:37PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 14, 2023 at 3:41 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > For some reason, the drivers/base/class.c file still had the "old style"
> > of exports, at the end of the file.  Move the exports to the proper
> > location, right after the function, to be correct.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> 
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks for the quick review!

