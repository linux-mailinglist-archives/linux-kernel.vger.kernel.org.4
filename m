Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC56A9248
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCCIUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCCIUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:20:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A0F149BB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:20:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70B48B81181
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A85FC433EF;
        Fri,  3 Mar 2023 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677831603;
        bh=TEgOAapYZLLoFRbyY5wx87S26h3VAfUdRuUwzNjkUiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdQlNA3UbWBkJlJDHDG8WQmZzqtq8jwCLHm1MkOErAdP4GI+ZmenYJ/lTZmd2i7qc
         z/H5u/vttwpEVIlzyHNgkrJvG5Vrhc3jVtG5IijXkGSqAnl0nkh+Z5EeXmXL2vAcMN
         fvBfG/QbDcmBMcUndupwSPOKuhvVRY3N9Z8QWAqbV/4WUxk5wv5j6VfX4Vn3swDdRI
         vRyf2xorgoiH9eWdbrkTGt2X53T9dhXohmbk8RWJAE6rzdgpu/I+EHphBNQMN7CyYn
         r6iRKKz8NYVRhyr5KRK+LL7O33m4zMa+/7pvsmA+eyulOfs8+bp6GKFV/yUhzCH+wZ
         /E4BWIQxug0+w==
Date:   Fri, 3 Mar 2023 08:19:59 +0000
From:   Lee Jones <lee@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: =?iso-8859-1?Q?hi6421-pmi?=
 =?iso-8859-1?Q?c=3A_use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Fresourc?=
 =?iso-8859-1?B?ZSgp?=
Message-ID: <20230303081959.GC2303077@google.com>
References: <202302081733017704501@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202302081733017704501@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Feb 2023, ye.xingchen@zte.com.cn wrote:

> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/mfd/hi6421-pmic-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Next time, could you please submit these as a set?  It makes it easier
to apply them than having lots of completely separate patches.

Applied, thanks

-- 
Lee Jones [李琼斯]
