Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC5F6A924C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjCCIUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCCIUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:20:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44C414EA0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:20:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E93761782
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C75C433EF;
        Fri,  3 Mar 2023 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677831627;
        bh=q11XVOc9ZAzh3Kr0FYmxP+pN1KeXquxG5CRvNVFVpt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTSg55h7ysIQSQfuMAlNf7W4RKx4yY37qJrZI21HYRTmpsmVRtpEvlU7rxDsL3X1k
         7zW8r463sWNL2ACvsYjZLoN1S9tafnW7r/sb2s8QvmvYwSci3VJJbxJA/0pgdgFNDY
         EkUhKwp7RJw5U34zhe5gMqPXr5QNtEkQMRdNbzLywINxomkZntjyoarXYAsjNCI/Tf
         y6RksdkS0x0EtoevqW8eJYw3LX3l/tfJQlie0VrixQTOLrVT5ChpKON0pA9pnxUD5n
         GkmTr08EWmlVf1vznDCnjE0fRu9WUHYdRxMt412tvE2w/opPlUMRD+yGQ2895ltkL7
         7YG2JDLQtezXw==
Date:   Fri, 3 Mar 2023 08:20:23 +0000
From:   Lee Jones <lee@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ipaq-micro: use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230303082023.GD2303077@google.com>
References: <202302081733542304522@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202302081733542304522@zte.com.cn>
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
>  drivers/mfd/ipaq-micro.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
