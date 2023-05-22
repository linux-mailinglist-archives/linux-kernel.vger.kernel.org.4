Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2A70BA01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjEVKYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjEVKYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09826E0;
        Mon, 22 May 2023 03:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93B1A61F44;
        Mon, 22 May 2023 10:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D23C433D2;
        Mon, 22 May 2023 10:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684751040;
        bh=7gyHWfJxjBRp8IRZk+ZX2Kw5scLGoK+T4UUE7i/MG6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRPYJTDni06v0lMgnXz8PQ1gmsrUmRJaxcIyRxn+2/cRHi/fXaD7x+GLJm28Hj+3C
         YrazWBjDmVUb3fPIgPpHvi4Lq+L66dmFew0hmLXstbi2/brEzqKWkWD68XEB1OiLZ+
         7Ly6hqU1s26CQAR2T862OYEZeb+nNuifpNlVxolRfezvC/xQchyxEvqS1q4VJRHRzf
         DLwXxgCC4yLoGdmJH5MvIZUOR+sNyw+fyM7d2POqpG1y4je+AnkeevixyY4yQ7aLHC
         dAidiaQzyyIKRJGxTs5ADpRppiGY+9aq85DCH6oyAfSYzqEQfQAuGlwiC8IlTQkbJY
         Z/ZsXzw/hS/Gw==
Date:   Mon, 22 May 2023 11:23:55 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 5.15.104
Message-ID: <20230522102355.GA2009088@google.com>
References: <1679511203203220@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1679511203203220@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023, Greg Kroah-Hartman wrote:

> I'm announcing the release of the 5.15.104 kernel.
> 
> All users of the 5.15 kernel series must upgrade.
> 
> The updated 5.15.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
> ------------

[...]

> Budimir Markovic (1):
>       perf: Fix check before add_event_to_groups() in perf_group_detach()

Anyone know why this didn't make it into v5.10 with it's friends?

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=80102f2ee715ab07be476df443bba388d5458fd1

-- 
Lee Jones [李琼斯]
