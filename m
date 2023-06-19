Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F171734B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 07:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFSFQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 01:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFSFQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 01:16:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C4CE4C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 22:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2F3160F3A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E704C433C8;
        Mon, 19 Jun 2023 05:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687151759;
        bh=oh/Uy30JLFAXHrBdALilEBTlFzZjO4BfoHPSTJ8+6OU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=sB0CZ2Te9T2ZsTLS2qzTUhYWS2j3GnZIgXAoG3R+zG5JjMfYMmnfMWgdsuecW/NGU
         gEO9AfIt9H1iZ8AIOxDdJ3J/QrQ/eKrMGtvzjsfbO21MM7/k29GOeu5sh/q9U+zB/C
         qSnOrYG7mD+KrkKDvPdqDa2MVq3zANrmANAyKZuyMBxX26y7r+WVOXxyP/zbatV6Ea
         3UwtPhg5Hmq0tJcOEgzQxSRV/H+nH1tdBjiY+bVKhV/OwyCY4tQ0FjZDUQ9rXZTXou
         6bucWqBF2xIsGzPrPGk3ZmN7ukCCptYo+WFuE30CtzdM8MIfShL22V+rx25SteGhe1
         /cfEPBts6bzzg==
Message-ID: <1616c3a1-fe0f-c5f3-c6ee-e1298efee992@kernel.org>
Date:   Mon, 19 Jun 2023 13:15:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230613075157.41065-1-frank.li@vivo.com>
 <20230613075157.41065-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: convert to use sbi directly
In-Reply-To: <20230613075157.41065-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/13 15:51, Yangtao Li wrote:
> F2FS_I_SB(inode) is redundant.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
