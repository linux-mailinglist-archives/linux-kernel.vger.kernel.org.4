Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0472E6E393C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjDPOaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjDPOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBAD30CA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB454611E3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B670C433EF;
        Sun, 16 Apr 2023 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681655404;
        bh=89mDZMg+xFD90cl8I+iHM3Ipz3bqJ7SUgk7XUSskT+w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MKfxBOgpd2hhrO2Y75pAox3UaFwmdLc6eF+v750eqizYlHV2Q4s8VqzljIVfY+HZn
         q95idOePRhMn97tre5JmMIEj88MBicX6YTQTMPc1xtmuS1tNRkDCW6y6rr+Xb0LLzs
         +6CrdzXnrfTDegmjsF/qyng2SjGSqFCYFzUaLArnBuqUjwtvvFuvNSoCxSooXXRtPf
         4UTGXOTc4Blfnuees7S3sec0Xt6Ds1a6dRyOwhIiLPrZxzs42BjsjjA32KT2QIuccu
         4P7UBja4fOZnp6PE9MufnnmljsQduab3ycCc1P2zuGqGsDIktvvb4qslZr8KOaNtCT
         u61EZ4o1TGBGg==
Message-ID: <90dcc3c0-2100-5c30-d4ad-1058b386fe8f@kernel.org>
Date:   Sun, 16 Apr 2023 22:30:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] erofs: don't warn ztailpacking feature anymore
Content-Language: en-US
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
References: <20230227084457.3510-1-zbestahu@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230227084457.3510-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/27 16:44, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The ztailpacking feature has been merged for a year, it has been mostly
> stable now.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
