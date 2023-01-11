Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF99665C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjAKNFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjAKNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:05:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA44E0B6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:05:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C07BB81BDE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65091C433EF;
        Wed, 11 Jan 2023 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673442329;
        bh=wxL95L9kM3pNjTro7surwIWNv94zXXrKJe215fkwbdc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h3C5ZmsqQxn+bH8Mm7lWt4wTFKxe8HU9euwxp2vqUHOxQfZgcLCQb9GpERfSKCHuH
         3vbQ+iNKQ79BpLeYtDcvq66xtR6RsFLOAMlk6+TlEJjS6MpvHQahcDHGq6BrCHNjcN
         kAjExlfSYtzld94sV3k6+R7lbr0d3F/dejSK797NfmaEc6BXEMY+cFbkYZeWSYRkHp
         gEYEbNVGyqmZSTzTaRAU6T8KeSlQJl4h4cJjKLqaDeo1TYHOyBE29tR+UaszRLpEYi
         1W3Ujv4wokboCTuzhCaQ0Ra0TKV0bTfCeq07CFScVGSVbFVNO3ARtOm9iTqvYDLnrf
         IGw0k/4hU+yOQ==
Message-ID: <77048eb8-d482-26cf-73ac-7b0f1094e816@kernel.org>
Date:   Wed, 11 Jan 2023 21:05:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: mark f2fs_init_compress_mempool w/ __init
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221229131828.59116-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221229131828.59116-1-frank.li@vivo.com>
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

On 2022/12/29 21:18, Yangtao Li wrote:
> f2fs_init_compress_mempool() only initializes the memory pool during
> the f2fs module init phase. Let's mark it as __init like any other
> function.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
