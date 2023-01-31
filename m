Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0373682BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjAaLll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjAaLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:41:39 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D31514EB5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:41:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 928434206F;
        Tue, 31 Jan 2023 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1675165296; bh=E02jK0HlPkJh0tyYFV8UsqvgBIJZaTRiVPCBOL462vo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dUt2YIRKEw1+TG9Jv2dQng0H9MMnJM9zEg0H/cTfORprdblyj0pqn0YfvM+hvKKHi
         vLD7pykyehWi/5rlGkk5IJq6P2VN18mTTiJltHbzxCUyPfv0OKpFxc8Ynv6Yi9Dujg
         EuFhswdBieNSnczEn+LKgKxwObOLcsiRA3wkVVgRl+Rmi88V7UTLD/+n5PjhnH7bhd
         yiuPBqkFOi6eH/R/LdlR/49yUMnzWv74eYtIGOsVVUbpNSevCcYB8M2GeJ9k9yXZAM
         bljzfvesJLaDPjNRYQ8PshlS+ZqnhEu4K8yFpLoQJTzC07aE0/nC2udkt5dtUTStNZ
         nL6QWRgg8hDzg==
Message-ID: <3b6e9efc-d415-bfa1-ff0c-3d20dd1dae3a@marcan.st>
Date:   Tue, 31 Jan 2023 20:41:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] soc: apple: apple-pmgr-pwrstate: Switch to IRQ-safe mode
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230123065125.26350-1-marcan@marcan.st>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230123065125.26350-1-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 15.51, Hector Martin wrote:
> This requires changing the reset path locking primitives to the spinlock
> path in genpd, instead of the mutex path.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/soc/apple/apple-pmgr-pwrstate.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Thanks for the reviews, applied to asahi-soc/soc!

- Hector
