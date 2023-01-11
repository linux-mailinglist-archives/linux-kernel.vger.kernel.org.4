Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8B665BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjAKNBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjAKNBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:01:23 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76523B5;
        Wed, 11 Jan 2023 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iSdHfRVpGODWmSg9nfkf0TsMG1QEJMe2zb6sGOncxrI=; b=YcIW7x4gHAzydcf6BzN/HY31zZ
        GPZkrTBDFoJ+ool7tuMRb3vRzaXyn329CqMe/ngU25Xcc8YBKNizWwYfWqSGSWHNQBpBThvESYvBv
        Oof47Te8j+JCPaXE5eoncGAUw4yJWTTTOb97ADI82vqoEgkMDKskNJWkvPRogS4oueIlePYHvBPCK
        fgCtxhqKuCwepDdy39iMen1UzB0aPRyzz0h+14nJFK3BeFR73zlcyFHCTTM9XaIRkVSyq/CKNU6OA
        WdJSoSeJYH0ap0d+pEVjO/MBnRrgCkMBBwYsXtq1OXwNQbbMjR4Y9C6iDLvbg4AirlGDl3zJkXisY
        kVZl2u0w==;
Received: from [191.13.20.171] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pFaj6-005Igl-5B; Wed, 11 Jan 2023 14:01:08 +0100
Message-ID: <217ebecf-3630-b423-ea0b-037e0943e17b@igalia.com>
Date:   Wed, 11 Jan 2023 10:01:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] pstore/ram: Rework logic for detecting ramoops
To:     Mukesh Ojha <quic_mojha@quicinc.com>, keescook@chromium.org,
        tony.luck@intel.com
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1673428065-22356-1-git-send-email-quic_mojha@quicinc.com>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <1673428065-22356-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch Mukesh! I don't have a DT hardware at hand right
now, so cannot test this one myself. I'll just provide a (really) minor
feedback, something to address in a potential V2 or even in merge time,
see below.


On 11/01/2023 06:07, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This is not desirable
> in environments where it is preferred the region to be dynamically
> allocated at runtime, as opposed to being fixed at compile time.
> 
> Also, Some of the platforms might be still expecting dedicated

I'd write "Also, some" instead of upper "Some".

> memory region for ramoops node where the region is known
> beforehand and platform_get_resource() is used in that case.
> 
> So, Add logic to detect the start and size of the ramoops memory

Same here, maybe "So, add".

Really minor nits, though!
Cheers,


Guilherme
