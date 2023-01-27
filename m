Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD36767E03B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjA0JcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjA0JcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:32:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C42E0D0;
        Fri, 27 Jan 2023 01:32:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D227261A3F;
        Fri, 27 Jan 2023 09:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3B1C433EF;
        Fri, 27 Jan 2023 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674811928;
        bh=ry/oIi0OHXzdRTXNsss+PckkCY4X4TbKoAbI71uIw24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKQhgIhLpVwrGYHjlhbIHiUxqNUHnKe/n2gIKDebQMMIqYU7KT9kR+QN7EfAKWwzd
         GlN6pK7YuLZh/2VqJie7wd0ylB2NtYsmETspW7Xz0T6MfwnWXtqDZaZoGzeLLCBRoO
         BYUWUDFHr0lBwVid73N0OX2DM4OQ1frlYm5+89Nddv22BjHEpmKpMLhu8rl7mES5uV
         eHJFRgV+1uZbefi2wJAtG354UIgfBzF90wMX3i8C850di3V6s+mHV/5KzRQZQBbCtz
         hAt/4W5luPgEuGXObP+Mz84eBTRLNMSMI7owsvLt9B+qDY2prLVnDHCIYjsb1rIKoJ
         OJIPpIGk1qgPA==
Date:   Fri, 27 Jan 2023 09:32:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the backlight tree
Message-ID: <Y9OaE6M9CaGYvVZD@google.com>
References: <20230127161233.5c21c04f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127161233.5c21c04f@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023, Stephen Rothwell wrote:

> Hi all,
> 
> The following commit is also in the arm-soc tree as a different commit
> (but the same patch):
> 
>   6e9b5cad13f0 ("backlight: Remove pxa tosa support")
> 
> This ia commit
> 
>   9041bd1aff23 ("backlight: remove pxa tosa support")
> 
> in the arm-soc tree.

This should be removed from the arm-soc tree.


-- 
Lee Jones [李琼斯]
