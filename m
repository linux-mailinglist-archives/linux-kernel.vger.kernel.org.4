Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CCE665CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbjAKNhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239610AbjAKNgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:36:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B08D1EC4C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:34:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EA0161AFE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758EFC433EF;
        Wed, 11 Jan 2023 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673444057;
        bh=YVZANdPbH/3BTa60dWNOCN4zdiN2W1PrF5Me7iiAayY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dc2WvAuVHpGmhwqQXC+jB+D4VYt0AskCoXjZ1GcyLLMFV7w4gk6nYdHnwbP8mzstf
         mK+kVTuXq02t3QqaVTsTiErWYtPspdxBF63kmgUS68eOajhpogUZEZ7jHVgagTcVU+
         YxxV6yefsC0eWde+x6EZvPxYPMwlKdGM6TbRMhsiT6fLDETMqAQ0CyZeSbpTixzXXI
         xo8G4d9/KuqAxpbHc9sVUzrtpek1Zk4q8EpuI1pyxyo/NNJUZkfFqlXsmgGfG2fuX2
         +G41E9FS+GiAywYKtwIp7SiBHrv0RBV3uZpxEvCykEvU9Jptg56KFOEw8WMPpX4pJJ
         KlVbHfrJW3SKw==
Message-ID: <22eb9d58-f828-6094-00a4-c3cc9a9ce40a@kernel.org>
Date:   Wed, 11 Jan 2023 21:34:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: convert to use MIN_DISCARD_GRANULARITY macro
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221217052448.60656-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221217052448.60656-1-frank.li@vivo.com>
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

On 2022/12/17 13:24, Yangtao Li wrote:
> Commit 1cd2e6d54435 ("f2fs: define MIN_DISCARD_GRANULARITY macro")
> introduce it, let's convert to use MIN_DISCARD_GRANULARITY macro.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
