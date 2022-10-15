Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989A85FF81B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 04:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJOCvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 22:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJOCvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 22:51:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9F591848
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 19:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9786B82343
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 02:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC641C433B5;
        Sat, 15 Oct 2022 02:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665802290;
        bh=VUzYc7vln6MW5boe7TlZjCsMEETvQw6gIcTI5Irv10A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VaFp1o9jeNsXGBtWMuHkRhPSAuNTk6/BP2W0Rx5ssqxsgj1GOctx9A2eRcGfDTCzF
         oz5kIAulDIIUpSO2i4NlsXq/slKVuaoMtrvcJXOkUIfRM06DL7+7WBZWuLLfvnUjMC
         Rt7h0Fdx/DDRkwj4jIGSwKEV9Ldq51L3PD99fn5tqroqRA/5fBJ0rojLNBPfQKL4Fk
         mCgiZMtCMCJYoO6EKimEnXvD6hDxCNCFXim+mNwSN8ReUM/EgbZ0nS+0Ca9jiyLTTy
         ST2bSmXV46AVAoFumYEK7WQkA6vV+u6ZOEr9HVVbIppV16xm9VIyWi7yOmSNrjpngi
         t785Bnw/RMOTg==
Message-ID: <48b98130-4ebb-61b9-85fc-58d49aa9de88@kernel.org>
Date:   Sat, 15 Oct 2022 10:51:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] erofs: fix up inplace decompression success rate
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20221014064915.8103-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221014064915.8103-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/14 14:49, Gao Xiang wrote:
> Partial decompression should be checked after updating length.
> It's a new regression when introducing multi-reference pclusters.
> 
> Fixes: 2bfab9c0edac ("erofs: record the longest decompressed size in this round")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
