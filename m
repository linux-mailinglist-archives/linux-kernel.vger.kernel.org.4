Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE146A924F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCCIW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCCIW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:22:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA859427;
        Fri,  3 Mar 2023 00:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85609B816AA;
        Fri,  3 Mar 2023 08:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EE7C433D2;
        Fri,  3 Mar 2023 08:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677831660;
        bh=z9KGA8lifz4GxgKkvFAFo8F3BsEmgUIp9Nq/FkbpkmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvE1S47lMNo8DVfvjD/Q301UZtCJKC6SKoCWMEdn/qYUpaBtZKVp6TX+5Y0UOHEs9
         gxGKxUzbJ3zAA7IDF0EBaXBWJdv6jmPCKwrF3Nj/gfMZz3dFaDkiAXMpqdHDaFM74A
         Z62s1LzobHTNHBXiKLHb66bSKadFsSzAHfaKt1tfNtB/b2tQvtE8UTMy1GVDisShAs
         QmxtO1fFNqIafwEN6V2mqxOhFk9zLh1ClIF8l1fpiyLxxapy+MzUfSPfpRZNRyRDn8
         XclNNSL95rsc+FbsZhFm8Zs4fR7Lc8u+FKxQ+N5vay2ZyRXV/aya3MGBYVlUkMttZi
         hTnbJ/ZG/S8aA==
Date:   Fri, 3 Mar 2023 08:20:55 +0000
From:   Lee Jones <lee@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ssbi: use devm_platform_get_and_ioremap_resource()
Message-ID: <20230303082055.GE2303077@google.com>
References: <202302081735440864562@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202302081735440864562@zte.com.cn>
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
>  drivers/mfd/ssbi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
