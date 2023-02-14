Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464EB69672B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjBNOme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjBNOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:42:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFCC233EC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:42:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF0D9B81DDD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915D6C433D2;
        Tue, 14 Feb 2023 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676385746;
        bh=I5MIc6MM9QXD5jdrFO1awtvLE1Ii2eWvzUjvvLQmKI0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VeyjyDkSNxgQ5Riew9CFnb7q7veDa9tanbxKKxtE2wZeDRZ3ELpM0iJU7khzGbCOw
         c/1F+UtEyfepxM2lK4NCXsKd+aip2m1/WsD+cYQ8oJ1YBsm1Q5FRbO6RYxvW9U0lkN
         2bj013xIlhI3n2g7CmXyhwjHyOQaQibzLdAdEYOBRCyw8Yrk/EPtZOKbHRTcxjK8RH
         0s4MeTHrIOsB4+6N17TVFvobxHLpZrydtw8RI95H5lBBeqojOoE1uubeLnNP+OWd/Y
         UrlIP/ji3feRQ6HEShrWmz52K5AcEEhOdqpu08qdrARDZTjFIgmnvq5YXwkcrloe8D
         01U+zv5KgMiaQ==
Message-ID: <36ccc325-47fd-7ba8-9643-f489495510a6@kernel.org>
Date:   Tue, 14 Feb 2023 22:42:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/6] erofs: avoid tagged pointers to mark sync
 decompression
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
 <20230204093040.97967-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230204093040.97967-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/4 17:30, Gao Xiang wrote:
> We could just use a boolean in z_erofs_decompressqueue for sync
> decompression to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

