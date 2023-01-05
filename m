Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8196665E4DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjAEEwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjAEEvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:51:52 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7BF4883F;
        Wed,  4 Jan 2023 20:51:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9131E42165;
        Thu,  5 Jan 2023 04:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672894310; bh=FSHjjYcgCdUxJlYw10tk9VI7KLypna2ch+BPE9uDYv4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tYR+xE7ASU3Y6zoqYgfulNZCzm1g6ATSdWYipHBEtzwrP5lfbFNOI/54pokEBEiVP
         v5wDgBIMwubCFMCeliv1C5Fv+dJ8kUfaAZPm3w7pmI8CRaxYZ2mVsb739SFv/XQQ0A
         gxMyBGJ3zfGX8DxREIsE9GA+7gyfra/na5JnWCggJOWlZru+zfagZ+Fzj81DR9SP5H
         vzitfYXWzwjV5Ob/w6wh/MmRDoQf9vBmECsBR4bpl1DjkYGf+AkTlxDfDss9KQ8GnU
         rY4Gz0kmsfjUypCY0AoPdRuar1qcALt5XUaQ2bzh5k+rzu7O3DIVgsZ7WnmnXPVf9q
         c+zddCMLsVS+g==
Message-ID: <ad7ef8c4-c16b-28a8-7ccb-eea98da28f62@marcan.st>
Date:   Thu, 5 Jan 2023 13:51:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/7] iommu: dart: Support a variable number of TTBRs per
 stream
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-5-marcan@marcan.st>
 <6852ebfa-bebc-48cf-a31c-04801fc90af1@app.fastmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <6852ebfa-bebc-48cf-a31c-04801fc90af1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/04 22:18, Sven Peter wrote:
>> @@ -993,7 +1003,7 @@ static __maybe_unused int apple_dart_resume(struct 
>> device *dev)
>>  	for (sid = 0; sid < dart->num_streams; sid++) {
>>  		for (idx = 0; idx < DART_MAX_TTBR; idx++)
> 
> s/DART_MAX_TTBR/dart->hw->ttbr_count/ I think.
> 
> With that fixed:
> 
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
Yup, good catch, thanks!

- Hector
