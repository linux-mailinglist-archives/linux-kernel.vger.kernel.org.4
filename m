Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB66BB78D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjCOPXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCOPXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:23:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E71FF4;
        Wed, 15 Mar 2023 08:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 045ABB81E57;
        Wed, 15 Mar 2023 15:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E41C433D2;
        Wed, 15 Mar 2023 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678893795;
        bh=u7XlcOkBTM2hmMVSp1B+GKpW2QknwCikp3VfZ5GkHlc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nFfKDVIHA4VsrAIWn51KHhTd4AoATIt1MkofjvntQsNQz8sYhsdeq5baKS1t9DqZL
         I3Hlz6I4e85dLds12GDepRszhPq/DEQU+XSKjfzJ1LEbBqytYlJPscHUl1DeD0co+r
         Q0DaeBf7bEJMEtLEZv1QRrLQOWBd/+7+hXUr0UjlZ3LVcalJoBURM3RWSOkhHDFvKe
         GE47XzNdWME4yVvrX/jt+3OBLRr25Q2TWOIdr7GwE383eReM6OGqOcizEdIev1VDzi
         d88P120Dx4syTZbQRrQucKMSm133ukMJvUr5UnpCGfhOBMePK34RyPycA3LqNl6tJE
         SrQh8CcD1oSLA==
Message-ID: <aea59bed-12b6-d020-a09e-1ff35c1b4410@kernel.org>
Date:   Wed, 15 Mar 2023 17:23:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 06/27] interconnect: remove MODULE_LICENSE in non-modules
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        linux-pm@vger.kernel.org
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-7-nick.alcock@oracle.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230224150811.80316-7-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Thanks for the patch!

On 24.02.23 17:07, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.

I think that it might be better to remove not just the MODULE_LICENCE,
but also the other module related code in this file.

Thanks,
Georgi

> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Georgi Djakov <djakov@kernel.org>
> Cc: linux-pm@vger.kernel.org
> ---
>   drivers/interconnect/core.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 25debded65a8..de61a639fab4 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1146,4 +1146,3 @@ device_initcall(icc_init);
>   
>   MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
>   MODULE_DESCRIPTION("Interconnect Driver Core");
> -MODULE_LICENSE("GPL v2");

