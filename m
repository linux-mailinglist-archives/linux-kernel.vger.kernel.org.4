Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21B468E8F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjBHHdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBHHdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:33:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9EE360B2;
        Tue,  7 Feb 2023 23:33:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC3C614CC;
        Wed,  8 Feb 2023 07:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1480C433EF;
        Wed,  8 Feb 2023 07:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675841584;
        bh=USNCS1tegjEH4VA3lC0DHgJkn0Q3PdFrpSVUUwFkX3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsI0bglPbPEsPBJZYj73ZKIpq2XCC7AYmYRz6oHff/Sj3oiIpudb6eNb089GN7m7F
         sFUaros6Lx6U9/5L1Jc2TCfnzF4VqNKOwwRsCxg1qAkW71GjoHrM1SaYyxN0wUfG1v
         3cIhqwfBmYJby0JEC3vLVpx++qVMc2f1a1lggvc6KJvY/aXtLZ5m7JsPoXiOJ0GuHT
         LcHM36odNzKDjsKENOQCeVQX+mMUKN5w1LR9scgRs+psmCYVEQfA6awdW9AAEWMk+L
         jNyY1DDSjcpBwrGcYM8z0aI8OINTkWq4lFr9KPy9iMBUz8CFbuOMgtSEipjalmxPcw
         Vzz/NE4UP5o4g==
Date:   Wed, 8 Feb 2023 15:33:00 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: Fix spelling mistake "Attenetion"
 -> "attention"
Message-ID: <Y+NQLOJ9IlbQJttd@google.com>
References: <20230207091443.143995-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207091443.143995-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On Tue, Feb 07, 2023 at 09:14:43AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_warn message, make it lower case
> and fix the spelling.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

It's about time to cut for the coming merge window.  I guess you would
like this simple patch to be included as a fixup for f54c013e7eef
("platform/chrome: cros_typec_vdm: Add Attention support").  Please apply
the patch if it makes sense.

One minor suggestion for the commit title:
"platform/chrome: cros_ec_typec: Fix spelling mistake" looks more clear
to me.

With that:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
