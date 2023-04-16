Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342AF6E3987
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDPOxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjDPOxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12A2116
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4792460C8F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2027FC433D2;
        Sun, 16 Apr 2023 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681656823;
        bh=acLuCsGU+sHF10zE6PC+R+hrzrIz9BwAzVKxN2i6iwk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sZ26q8S6dVszAjfA1VKZ8rgKZwmbfp8kvmviUbP24wcVhuGpqQEbK3rWabGaMKQcB
         rwTX7ZdoHse1QJ8qTh+I4Dh+b1KZBf63p5PzY3E2y9bjJ/f7TPpFrOQWekrrL2MH7/
         fWzYzF3/KRJX5QNA4pOtitO0B1Gr99dq/woQ48thRxLSRjK5ejXuXNVBziK6SGdzSY
         JEKuAjVieFECTdnVZc86vm1BndFNojkRprbNcE+x+4VLHHB4AIdvvbRdFG9o+pU6dx
         z7nme3mVJVRH1fPlAhOKVKAPg+k62oDrco8DG7FEg4QLXP8xh0ONNxdTChTuUiFcYe
         WInCFIZVN6rnQ==
Message-ID: <11b3a324-9378-da72-a4eb-00f0b814b25f@kernel.org>
Date:   Sun, 16 Apr 2023 22:53:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] erofs: cleanup i_format-related stuffs
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
 <20230414083027.12307-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230414083027.12307-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/14 16:30, Gao Xiang wrote:
> Switch EROFS_I_{VERSION,DATALAYOUT}_BITS into
> EROFS_I_{VERSION,DATALAYOUT}_MASK.
> 
> Also avoid erofs_bitrange() since its functionality is simple enough.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
