Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C7734B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 07:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjFSFUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 01:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjFSFUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 01:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF5A4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 22:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2927060B7A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA02C433C0;
        Mon, 19 Jun 2023 05:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687152019;
        bh=ZxpwI7dfhBwFKwaQNvHNP489mvSi6n3Qqmaud4rDcBI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sJlEq6GcOw1C6O2vsuGdQu7YZKvTkEbH4hDdMSlyNizSUeNbMuh/DBrLTM1MjDqQv
         xCrHiTjINLySXaeAiCwwbJwgb/JPusYGtqtNpDcfo9iHlL6kVYjDb2bkX2uLH+WnpK
         /j2jdeevX1ZO0JllzJsGDbZRmsdQEuhCjSJGhm0/wDTrwefTgbAcvbflQ1uXkb1iI5
         SP2pkusiWgJCi625UnM0uCXW2eOwPXZMrUNMqr7o7qiKVTBGhuFZuo5UtOuAfOWrV0
         BfcTIaqqBLYpccvtuTRpdnPSIzmFv9wb1+VBjLlFf7sb0yc7I2yfknG0Z67VqbnDGE
         +khQk7iSsGA/w==
Message-ID: <5409930b-4379-b279-886b-a05149436a68@kernel.org>
Date:   Mon, 19 Jun 2023 13:20:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] f2fs: no need test opt for f2fs_issue_flush
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230425165857.29175-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230425165857.29175-1-frank.li@vivo.com>
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

On 2023/4/26 0:58, Yangtao Li wrote:
> This information can now be obtained from the mount, and there isi
> no need to print it out every time the trace event is triggered.

It makes sense.

Jaegeuk, is it intentional to print mount option in f2fs_issue_flush
tracepoint?

Thanks,
