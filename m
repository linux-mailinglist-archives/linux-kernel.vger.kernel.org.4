Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F1067EC40
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjA0RPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbjA0RPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:15:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E071715A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:15:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8A1B61D54
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F265AC433D2;
        Fri, 27 Jan 2023 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674839751;
        bh=WQ+bZx3zrDb5yP0Otnt9aB2r+y4rdFc64tPdFRW7v68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFv6IlCzAgWWRcj/JKawt4C/W9Pmd4WaOiJkTD0dGvV3ykMgtX4Qf2T87XfGXy4zH
         4dOt0+6PftjZXAoI1RaIlKDUEa9NyfunVjEFyMNv69bUgfhfR7JZgduByTbHqr83wA
         +M6zXLRdEseQfUvPcYIjYSrDetJx5wLqS/y3Zwk8SfwkziBOUzTKAT/1fXbznIhQHa
         RSNSAn7bi4LZvb8lXHyz+WPVoTAdNOGD26CyaiTIws9RrfLHGHD+ffAL2d25Km5bNw
         ltWVnA1F+jDEy9T4cSxMmHLLCIys3ak40Wx5x5JRaYBHpnA/hIWx8s1EDD5zEmU9U3
         XrrxYFMyYCibw==
Date:   Fri, 27 Jan 2023 17:15:46 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Add version number for EC in Tolino Vision
Message-ID: <Y9QGwq2QK+pw/AZq@google.com>
References: <20230127165828.3256170-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127165828.3256170-1-andreas@kemnade.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023, Andreas Kemnade wrote:

> The EC firmware has a different version number than anything
> defined until now.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in V2:
>  use the same formatting as the other version numbers
> 
>  drivers/mfd/ntxec.c       | 1 +
>  include/linux/mfd/ntxec.h | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
