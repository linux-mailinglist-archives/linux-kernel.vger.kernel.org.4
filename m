Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C1567CC48
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbjAZNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjAZNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:34:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF49B2719
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:34:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AF4D617D6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE09C433D2;
        Thu, 26 Jan 2023 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674740061;
        bh=to53vRo2E8+ZQwfM2dAtJdAuNh/BZOwCkTPbJBBxk1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbiydQE7PhGniIW4YlGyCqYEdUPSvHGpYDQNqRRKOOFN9Nu0JgHMHLPO3MVvXyNvC
         iLZgSCatCaMRIbA4uBuvpuo3sXwQxxNtHkPG5m6XNVmFk/HbHmcODUuQrPqWejdJ2W
         LOv6gCsKbtBnnDk0WAOAq6Dq5Qu4ID3WcMjxIiJQJBDeOljAYzmorxiLeEzqmt2Ig6
         aGec/EgJznklvoKAwsuyIFcShg81qx0XKZGqVkWjtnOMwzKJaemOkRRTd38ymFsebW
         NiTJUrX22V/RjUhgz8hkMhfL0mBW2zsWxN2fpFr4MfLfXZVKTpOXiXeDyA6/PLvGuH
         EHLShs/Y5pEkg==
Date:   Thu, 26 Jan 2023 13:34:16 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] mfd: Make .disable() callback return void
Message-ID: <Y9KBWKNJQo0yCw2I@google.com>
References: <20230113182427.257484-1-u.kleine-koenig@pengutronix.de>
 <20230113182427.257484-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113182427.257484-2-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023, Uwe Kleine-König wrote:

> All implementations return 0 unconditionally, so change the prototype to
> return void. This allows to get rid of error handling in callers that
> isn't actually used.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/asic3.c      | 17 +++++++++--------
>  drivers/mfd/htc-pasic3.c |  3 +--
>  drivers/mfd/mfd-core.c   |  4 +++-
>  drivers/mfd/t7l66xb.c    |  4 +---
>  drivers/mfd/tc6387xb.c   |  4 +---
>  drivers/mfd/tc6393xb.c   | 16 ++++++++++------
>  include/linux/mfd/core.h |  2 +-
>  7 files changed, 26 insertions(+), 24 deletions(-)

Doesn't apply to the MFD tree.

Please rebase and I'll merge it.

-- 
Lee Jones [李琼斯]
