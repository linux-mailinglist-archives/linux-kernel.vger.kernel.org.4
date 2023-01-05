Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5303A65EED9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjAEOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjAEOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:36:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56502016;
        Thu,  5 Jan 2023 06:36:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4181B61AB6;
        Thu,  5 Jan 2023 14:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EC2C433EF;
        Thu,  5 Jan 2023 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672929362;
        bh=rj+lBnmpjw7DH/jSzQ5xt4rCprGS/8VNpsvNnx0AZ9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dl2qHX8lzOnp0A1fg8ujFOjWrD7jOlyskDPdafh28mlgIvqO1tvimL28vK47bKwwV
         N0tsYoaYsEbY/MZp/vg79h/ptdKmejorgtRpMHKr6pMxu9PdFdBE+tw8oQj7PBdaTK
         Bc1fvZ4j55fqpUCS20irhwCfooPKfxIHtCOxqpTlHYlUMC9ed+K/JNls/RycPC0PDX
         sYrusEarqdbKfWBknuyEBjw/0vMny3Pxf/yVCYLVDG+URxH9Mr1Q0tJr8MmisAEBcz
         085ElZAQRhR0sj4LB7ZFhrAP6A8ucDUeM9HjRMGxr8ZB04AQvV3+y3TrYijp5LaGns
         P/hcijdssLgaw==
Date:   Thu, 5 Jan 2023 14:35:58 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the backlight-fixes tree
Message-ID: <Y7bgTjUJAuZDHFfu@google.com>
References: <20230105082925.3a0a1c43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105082925.3a0a1c43@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023, Stephen Rothwell wrote:

> Hi all,
> 
> The following commit already exists in Linus Torvald's tree as a
> different commit (but the same patch):
> 
>   ac3fbaec13ec ("mfd: palmas: Use device_get_match_data() to simplify the code")

Good spot.  I've asked the offender to remove it. :)

-- 
Lee Jones [李琼斯]
