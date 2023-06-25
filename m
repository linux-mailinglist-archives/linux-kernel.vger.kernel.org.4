Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7436C73CE20
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjFYCtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjFYCta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C56E48
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 19:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB09960B29
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 02:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8130DC433C8;
        Sun, 25 Jun 2023 02:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687661368;
        bh=tL3Gj1PIk7UuZH0l9O4zgOWekRCYpOwLBRqQia9M+ok=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=lEvAu9XPj2y/JfnXjJdiGEx728X/4xT7syjWHZ/gPoajwdRwmYXX1Kl3O3MGTzCMC
         nZXa9JRdhIx5Rvw8Bitwrrpc0aK+34re3QEZ4JjK57UdaFFVaX6YjuU4IGs5ZAgg5N
         xTopSIMt/EUj2gp28HxowRp/AVTZPZtvYwKCduRE66w+itp5hiqqOAYGdo4rpX7se4
         8wxWVeJU3EevYYaNubP3mSOCPOzySOB6xb9c71V4MBmxcWwYvX5zf5md11JNkrdazG
         uQyJ98fpPB3lyhJxBlCDj66pUrXbbI99+387LEBiD/ozhklZf0LxUrK5ZQLufMOR1E
         E4TZcRxDSjR/w==
Message-ID: <3dcc04bc-7388-42ab-a771-1fc07e0b772d@kernel.org>
Date:   Sun, 25 Jun 2023 10:49:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress tmp files given extension
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
 <ZIjqKHDUmN6u9pXa@google.com> <ZJP0aoy03Vx2Q2K1@google.com>
 <ZJXvYG/q7gZwEuap@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZJXvYG/q7gZwEuap@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/24 3:15, Jaegeuk Kim wrote:
> Let's compress tmp files for the given extension list.
> 
> This patch does not change the previous behavior, but allow the cases as below.
> 
> Extention example: "ext"
> 
> - abc.ext : allow
> - abc.ext.abc : allow
> - abc.extm : not allow
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
