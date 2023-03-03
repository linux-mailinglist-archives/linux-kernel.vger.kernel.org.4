Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02D26A9258
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCCIX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCCIXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:23:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8164959E4B;
        Fri,  3 Mar 2023 00:22:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED4A0B8163C;
        Fri,  3 Mar 2023 08:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EADFC433D2;
        Fri,  3 Mar 2023 08:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677831735;
        bh=lGJEP1G1aXwyc1cF9DwcVYzXKaNqepv+08/yCIhZ9Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4pz+XOQ3ymqUOiMjAVFWoWHLVR1ka+CvMe1Ta+XzTzuWc5rOhhTd5KaeD/maawUN
         SUv8wKjlTmiOHxNnqqxBVjmm+mX1PwzT+uLlpgrqpOKNSnx70Uh8KBxMw8i7x1m1yz
         Dx9qBYTSaKvwdLXXX55vUk3z82xO3MD8kSJg1ixgE6dI5QL+xzOZnKUn0oVKyn9cvI
         IdpRhp2KI+0S9+J6NWNrvsG43NkgWonxuNZHh+a/Td+Fty5dgrw8WvPqWTTCENrAAo
         QAKv3uV0TV2JKP5/RrkMSqikVVukAOV8pGwlk+XIy4FjLYEQ4wOQF/DS74cYMX0Z5F
         4nRrJr57zsSjg==
Date:   Fri, 3 Mar 2023 08:22:11 +0000
From:   Lee Jones <lee@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: qcom_rpm: use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230303082211.GH2303077@google.com>
References: <202302081734511884545@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202302081734511884545@zte.com.cn>
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
>  drivers/mfd/qcom_rpm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
