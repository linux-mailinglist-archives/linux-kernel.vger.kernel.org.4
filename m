Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC036A95C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCCLDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjCCLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:02:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D010261B0;
        Fri,  3 Mar 2023 03:02:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84AA4B8184E;
        Fri,  3 Mar 2023 11:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE227C433D2;
        Fri,  3 Mar 2023 11:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677841375;
        bh=fPg3BkGyz7GB00IKDcCnzFu2MV8lEc0YT73oEOUPxlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYQGBLyXC3Ebzg4Yi5XDrXv+b8jyw0jNykLqHjPRYVEPklncnNOmursSWmrlFATr1
         Z4qKzXUtLjBydZaz3EN6HLI5dU/WAYDKF0qsiSppUgCpWZcgA4fH2Obfb8/PFhpaOc
         5ypBiBE4LaIGQzoqmxiKBo8IPUrT/4UOyAFwOCH5qd+5p6ETPIq1p4bAKNODW8Z6Qg
         tCNzWpFeMzYGbUEi/gQYnLd09AlwlAIVFr9wS2XX3DQQEAJxzov8554Y994c3/17xT
         Jh9B/ighF1VRr5GpqLa5f2XVjlpeRLbwmHN6Z/h6d4JcjfVcodTqM0eD1eZBlDtbsr
         ohmc75PMXiBJA==
Date:   Fri, 3 Mar 2023 11:02:50 +0000
From:   Lee Jones <lee@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 04/27] mfd: intel_soc_pmic_crc: remove MODULE_LICENSE in
 non-modules
Message-ID: <20230303110250.GE2420672@google.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-5-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230224150811.80316-5-nick.alcock@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023, Nick Alcock wrote:

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
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Lee Jones <lee@kernel.org>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
