Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F1B637B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKXOVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKXOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:21:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5BD20E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:21:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7107F62134
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56F4C433D6;
        Thu, 24 Nov 2022 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669299686;
        bh=jCX9ZgHFTBOM2D/hY3GhY26io0Yi+TGwAvmul0YeWJA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nydjkvx+OF5lVTYV8rH43vkpHcKhQQqC6tEEYd07Oiqzn1WiXzZu0kYGbU+uywXil
         6wk/zH42/un26PPPmGaLOCJLOpByZTQ3SRitmI/pw8miyBrezuOSODRkF0gn6K/VSP
         Mj8TCXFkOaRxAQ5nsY+6BuoC0k8fQRPTadr3FtLfkV6NPdsH/4nif3jjy5GKClYJ5V
         znpKU/cONFfmS68Yx56gyKLBBgwcxVV9Y8XA61i4AH6KV/UNv1k4Q/P7uNz4DZYFYL
         t4YFS122XHyyjPyKjBIUHViCYx1peSrTpLMBRLnbQj2ypFUcZVW1FCaoU+QnrO6Ilf
         XhS3VeTJsJe+w==
Message-ID: <84482d90-289d-7575-ebf3-2affa16a370d@kernel.org>
Date:   Thu, 24 Nov 2022 22:21:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] f2fs: define MIN_DISCARD_GRANULARITY macro
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221123164402.13849-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221123164402.13849-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/24 0:44, Yangtao Li wrote:
> Do cleanup in f2fs_tuning_parameters() and __init_discard_policy(),
> let's use macro instead of number.
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
