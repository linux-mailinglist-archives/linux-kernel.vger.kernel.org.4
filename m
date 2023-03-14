Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B86D6B879F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCNBfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCNBfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C3F8F50F;
        Mon, 13 Mar 2023 18:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3EED61572;
        Tue, 14 Mar 2023 01:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF61C433EF;
        Tue, 14 Mar 2023 01:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678757745;
        bh=ajascUjSBJkC6YidStXTpH1e4W+hUu+o0Jx76v8V6C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=se0ogZ702sRMgoXN/Xp2mZuLXhrBCP8O0BpHdtrKz58h7aAnYI5hrRaXuWnhVggql
         pfZEEs2IhUeQbs2FfloML3EJIhLjaPDKnvEhojstu+SyBINEVMug/VGzohtrgIplQK
         6MJ5j5taAHQZKaDnUCE88AnjJeKOOkQT2jCUJ/VZ8qgdBxch6bRZVRWSjIOeRGwSOq
         VoT8Mz7qXxiRXnGTTV68ii0ux57Pkr/Kk7ooU5MVmXy58P3ncgskiiPCM7PAW5/aRw
         NIBlZGo5SsmKo0sKBaRU4xhdbQAL8TbvOVIUEBMx04n4b/Pv5rYsWHJgBIQnzFokeT
         wkI/dHZfKGjCw==
Date:   Tue, 14 Mar 2023 09:35:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 14/24] kbuild, firmware: imx: remove MODULE_LICENSE in
 non-modules
Message-ID: <20230314013539.GA143566@dragon>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
 <20230217141059.392471-15-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217141059.392471-15-nick.alcock@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:10:49PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>

Should I apply it as a fix for 6.3-rc with Cc stable tag, or can it be
a material for -next?

Shawn
