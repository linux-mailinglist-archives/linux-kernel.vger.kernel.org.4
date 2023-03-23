Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3B6C6FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCWSDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWSDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:03:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE81287F;
        Thu, 23 Mar 2023 11:03:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D941F44A;
        Thu, 23 Mar 2023 18:03:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D941F44A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679594591; bh=+xHHWQp8VXbDvAJBU4F2A9md5mJ9aPYLwDogCK11j40=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ngXfyF8kIpi28nfKM9CzDsGW2P0coVdaYmX4c29ISSY6TRre9q8bBTZ0t/rNmO9a7
         o0zpAhPm4hnzCCJLB2cCqPd/aHSoYLbtAAnp4K4Z4cCPz6xpMnm93hGVZwY+Xu0JO9
         btlvkmmhT6SEaKPM+sqaac7WpUFtyncacKZz4HMXIoGPIJmVW9jcxgpY4xPp2J3vKK
         s85ViORlQiOIGxgLJFqkj7166Fr1jh3uxJnqvdfr1Qgz5g+NUZHIYcTGaNp7/E9nQY
         ifmz518iIIhPkM4IltITlMN4TCPu/tokX8esbOuER5jpvDaOS4+uLwqWKxMJivMrBS
         gQZXFTuIaNo3Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] Documentation/x86: Update split lock documentation
In-Reply-To: <20230315225722.104607-1-tony.luck@intel.com>
References: <20230315225722.104607-1-tony.luck@intel.com>
Date:   Thu, 23 Mar 2023 12:03:10 -0600
Message-ID: <87ttybbb1d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Luck <tony.luck@intel.com> writes:

> commit b041b525dab9 ("x86/split_lock: Make life miserable for split
> lockers") added a delay and serialization of cplit locks. Commit
> 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
> provided a sysctl to turn off the misery.
>
> Update the split lock documentation to describe the current state of
> the code.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/x86/buslock.rst | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied (with the typo pointed out by Fenghua fixed), thanks.

jon
