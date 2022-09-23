Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8C5E76A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiIWJRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiIWJRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:17:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A6FAE6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46DF561FD4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC8DC433C1;
        Fri, 23 Sep 2022 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663924618;
        bh=clus6g41AIqVa7paiCNCIYFHv/LuCGUfx2Ubcz+209Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WO9mghRPo2jX/KC5XPzNR3gL2uuWU8vP/uT7y0gXoJMkikzXzjTE1ArAxqJCC7s8R
         ENggAF68zuW6DA1q8Rq1KtOTL6ISKcvhSVIe0rDvlaMKP1vX71ewcRmfNIjPmVDWFL
         W3RTU/XI9ARLFXgfZ5+2MoR71hPYMksLaEZ3rA+A=
Date:   Fri, 23 Sep 2022 11:16:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com, rafael@kernel.org
Subject: Re: aarch64 5.15.68 regression in topology/thread_siblings (huge
 file size and no content)
Message-ID: <Yy15h2vXFBhCRMrL@kroah.com>
References: <20220922113217.GA90426@meh.true.cz>
 <YyxVytqQDbGWPa+6@lorien.usersys.redhat.com>
 <YyxXoPmtTZHCr5pR@kroah.com>
 <Yyxgtx/Vr6Ar1xEe@lorien.usersys.redhat.com>
 <20220922140504.GA58265@meh.true.cz>
 <YyyY1LgHzQZpQkqM@lorien.usersys.redhat.com>
 <20220922200506.GC87797@meh.true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922200506.GC87797@meh.true.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:05:06PM +0200, Petr Štetiar wrote:
> Phil Auld <pauld@redhat.com> [2022-09-22 13:18:12]:
> 
> > Then I applied the fix and the problem went away:
> 
> I've just tried the same aarch64 and I can confirm, that the
> patch fixes the issue.

Wow, that's odd that the file size matters here.

Ok, I'll send this to Linus in a few hours, thanks.

greg k-h
