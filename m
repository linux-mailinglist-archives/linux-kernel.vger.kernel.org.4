Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6C465EF7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjAEO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjAEO4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:56:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5E84EC8A;
        Thu,  5 Jan 2023 06:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BDDD61AEF;
        Thu,  5 Jan 2023 14:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D42C433F0;
        Thu,  5 Jan 2023 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672930577;
        bh=aZkmHt7BZ4W7BSgA4pI9EXL29Drb2u1JkxXScLBVI/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3zwHTZNiMn9kAQkCP0ddPWBnTXXCxcU7CXj+d1U2YIoTTjWA8d3LwjbOUZhPf0kw
         RxvMzUldg7VRu/Vj45EvJm0DmKrYABT2lCxkqt4H0/x/ZA4ZiLIv+NQVieq5hrA3y8
         ugRuhYrkhecEGiC+z90Jg+P9VAxQd9PEzP1aUzocCRGCZi4POkElbGmFSeuR1XRBJ3
         q5OS0vx4HwL/YFUpByGWWu4z6m7/ppYnCTi0NjfM3B49uKouLMu/TIIYqsOhvdILSE
         AJKQScUdX5MZy3J/ao8PQ5OG2/GRI/ucZnD4DTwW7nmdafGpQXRcmHET81ZAN8WQqQ
         O8y8cg5/qnXCw==
Date:   Thu, 5 Jan 2023 14:56:13 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        lee.jones@linaro.org
Subject: Re: [PATCH v2] drivers/mfd: simple-mfd-i2c: Add generic compatible
Message-ID: <Y7blDaQ6cSYuuR7U@google.com>
References: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Dec 2022, Jesse Taube wrote:

> Some devices may want to use this driver without having a specific
> compatible string. Add a generic compatible string to allow this.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 1 +
>  1 file changed, 1 insertion(+)

Sounds like a good idea.  I've changed the subject line a little (no
need to say 'drivers') and applied the patch, thanks.

> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index f4c8fc3ee463..0bda0dd9276e 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
>  };
>  
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
> +	{ .compatible = "simple-mfd-i2c-generic" },
>  	{ .compatible = "kontron,sl28cpld" },
>  	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
>  	{}
> -- 
> 2.38.1
> 

-- 
Lee Jones [李琼斯]
