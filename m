Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125D60F8EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiJ0NVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiJ0NVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:21:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAFBAB834
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F70B82638
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7224C433C1;
        Thu, 27 Oct 2022 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666876895;
        bh=uUSpxEVe6BcMFJseHMkvWzGv+SrhS09+byNm28WWHeE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r/xaOfpDj8272rEm55Fhsmx68VHMXsUY9+pQQVMvVJ4fUud6NeteGfCor2eFRRJfT
         JwX4d9W7+1CA9VCMo5s+LTqiHg8yRbAwDqQ09ecj5l3DZZ+t4pz5jOY2Z9ccqP4j/f
         RljnuvgqqK3WOOjKFSH9B3rjL39WmyElnJzW4idruEj8ta57zf0Q9aOjP8KA3iXiog
         1rQykHHnGd6OKBcnJd2g7BSTI9Jrl7KJMEtYVtU+JMZyj1SQlwED1KtsiImv2kWboz
         fKaYZiCH0mWt+ZCk9GArz4IW8lm1JS1FptBUrLm4/NakBmlEhRpKsV5f2LJGsdu/Ns
         7c+D0j/XP43og==
Message-ID: <db6d8470-47f5-39e4-a692-efdc16603144@kernel.org>
Date:   Thu, 27 Oct 2022 21:21:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] f2fs: fix return val in f2fs_start_ckpt_thread()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221027102447.75708-1-frank.li@vivo.com>
 <20221027102447.75708-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221027102447.75708-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/27 18:24, Yangtao Li wrote:
> Return PTR_ERR(cprc->f2fs_issue_ckpt) instead of -ENOMEM;
> 

Fixes line?

> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
