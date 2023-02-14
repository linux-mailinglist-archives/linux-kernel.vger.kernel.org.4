Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6669673C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjBNOpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjBNOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:44:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8A93586
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:44:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 433936171E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A7FC433D2;
        Tue, 14 Feb 2023 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676385897;
        bh=BpCjJ2aKu9c/zWe3SDTTfkT/dSP657acF+jv5YfyDb8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=khTJrD+xCTtVz3/EnUkDamqOcuiGNQofEc6tYSp5mPOnhndJWqbatR40ium3fyYjK
         thfyMM55rRY9oYrliJAnRaiiXGtvJIuNhbWo8/qNj3y8vOG6Xmjb4fjC0mwwxIuhAc
         DVctweJscFZHSnEOzS+kN461c7MkwEocxBHUNhh7QQyQjBh1I/Kc8JsJpx6x/i7Ch1
         hiPmQDePUKACpHGu7lGjW0pgOF9jqDmDXSIMGRNv6WUhozk9tyaTNTmY/CjKW4Sc+z
         tTMBOen5Nodg3IVshjV2g3DLU4mRsBsMR7v6YNJecMoyrGbOWhSUoTm02cVBC/ONU5
         4FFG5pdG4jAbg==
Message-ID: <7af50b7c-cf39-8da0-e73e-2f044a0b1fc7@kernel.org>
Date:   Tue, 14 Feb 2023 22:44:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/6] erofs: move zdata.h into zdata.c
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
 <20230204093040.97967-4-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230204093040.97967-4-hsiangkao@linux.alibaba.com>
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
> Definitions in zdata.h are only used in zdata.c and for internal
> use only.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

