Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48BF73499A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjFSBBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFSBBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:01:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A16EC4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 18:01:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C05B60F2A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5629C433C0;
        Mon, 19 Jun 2023 01:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687136511;
        bh=RAEH/HZJxVt1SqbHjxeKJ/iamlj5YC4AzfMi22lYMk8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gbq+iFbNB0Zc/JrKRTUWGcNjQA1FWyS6GAXPr2dw8/YFQs40tchzbwPHykwW43oUi
         H/DPh8i/JJRiFTGWE2HfCbjC3gO6UUIevEz9lHmkHdVaARWjv/7JzBrIqtsPjGkoL3
         2owSK9cWkezqP3npodDc0Lb2WZkqBHi6X++GmLAFOrtNXOZvUK9TYRWHcs97uhKKFK
         KkKc2RiRlkzPn65Mp5C2pPt6ZQAI9YJc07Y4T8qwGqItTznNL4ZpFiY3ohwE+u58Jg
         5+N6dbLc3SGVK3ijNBcUlLqF8tKwJRdNm+TzX0UOqUZqahYP81ZwIklIBI1ZeAgjiD
         sp79mGSgFJP3w==
Message-ID: <60ba00c5-4f49-1b79-80a0-6d25c548e8db@kernel.org>
Date:   Mon, 19 Jun 2023 09:01:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3] f2fs_io: expend fallocate command
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230613065911.4304-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230613065911.4304-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/13 14:59, Yangtao Li wrote:
> Expend fallocate command to support more flags.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
