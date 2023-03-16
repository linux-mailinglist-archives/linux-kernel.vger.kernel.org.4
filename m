Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514F16BD467
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCPPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjCPPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:54:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4222201C;
        Thu, 16 Mar 2023 08:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 398B6B81F9A;
        Thu, 16 Mar 2023 15:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8799C433D2;
        Thu, 16 Mar 2023 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678982050;
        bh=Thz5LaLV6QUrsRhwG8buUN+nTEqMpiCftRIbQ1Aj6d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rt802JHZuAZa33Bm4O8C5PbsnBWOKMPABDM8rGLl+TlrfpUqMhcLn9T98tfTqOGos
         l7OWDqonqzDvEY3lS+IiMZbTRAvOGCAPLxA65+D3tDHtLBBp5SG/GH674W8r8hpleu
         tVwYEYWKbYvCwCdAlMCp193yOB3Zar1BAY9U+M9/1L3kca28ZROEjFd5teyJRNt9gU
         Vv704OH3Emvntzubrc6UpBequkSfSeCG12+mqP9ZVScV1w4Xpbp7E52Cmf4rpgS0eC
         J+xXTJL0eNBQ/uZToqaaNFrwxN2tvuJjhXzotlyIy0g6SKpa3JpLQzqOB0Ji6HQzPV
         4aoWWMM1g8Pug==
Date:   Thu, 16 Mar 2023 15:54:06 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] mfd: Use of_property_read_bool() for boolean properties
Message-ID: <20230316155406.GM9667@google.com>
References: <20230310144712.1543449-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310144712.1543449-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023, Rob Herring wrote:

> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/88pm860x-core.c |  3 +--
>  drivers/mfd/wm8994-core.c   | 19 +++++--------------
>  2 files changed, 6 insertions(+), 16 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
