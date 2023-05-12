Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6970056E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbjELK2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjELK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E325F1491C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:26:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2418561554
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F9CC433D2;
        Fri, 12 May 2023 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683887183;
        bh=9BDmfoZuBPkbK1ZCLt7rh0uIS2qGSlS805RbZ3+nNas=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SHSt9d04W7mzK7GDELDQmwV2Qq4lp4vZlys2gQQ4hj3Zd8ANgnfXxWXicgHadPJvz
         l/YfYeioKj8/6euHdWmprwDRDVs7hPxBocqGj8JSyZ/P3jG36Fsly3adLB1JcvkBdA
         rIsFl37pduSjrYK8QM2TF9Wj2jpvtGoNXN05vcubd4RuVig3Nh8msV+rpCsbW1J0XE
         iHrvGfSNnSNnCjl57GHsYzVoSt9d5NfxMVGBUsmanhXCvD5rA47DnDMfcwVjotRDu/
         WBaMilAfu4Vs5o/nbQ9ra1KwdJoMcDhktvOZBRAIF+XLDa36DhnV2yuDBLfsLeMNHa
         LVE9L/RdX03Fg==
Message-ID: <12a57688-6e9a-a21d-41cb-978a274c8b2b@kernel.org>
Date:   Fri, 12 May 2023 12:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] w1: Replace usage of found with dedicated list
 iterator variable
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
References: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com>
 <c626e464-64e2-3cdb-7cf3-c76770feb1f0@linaro.org>
 <xxs6zv5j7s6zmko5b5idhynzotx4nnyjktj35sdvelr6ha4aeh@w52ylfmwguva>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <xxs6zv5j7s6zmko5b5idhynzotx4nnyjktj35sdvelr6ha4aeh@w52ylfmwguva>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 12:19, Jakob Koschel wrote:
> How strange, I just checked and my checkpatch doesn't complain.
> 
> I also redownloaded and double checked 
> (b4 am 20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com).
> 
> What's the exact issue you are seeing?

  ✓ [PATCH v2] w1: Replace usage of found with dedicated list iterator
variable
    + Link:
https://lore.kernel.org/r/20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com
    + Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  ---
  ✗ No key: ed25519/jkl820.git@gmail.com
  ✓ Signed: DKIM/gmail.com
---
Total patches: 1
---
 Base: using specified base-commit eeac8ede17557680855031c6f305ece2378af326
Applying: w1: Replace usage of found with dedicated list iterator variable
[Checking commit]  12b61e664c29 w1: Replace usage of found with
dedicated list iterator variable
[Checkpatch]
CHECK: Alignment should match open parenthesis
#70: FILE: drivers/w1/w1.c:849:
+			if (iter->reg_num.family == id->family &&
+					iter->reg_num.id == id->id &&



Best regards,
Krzysztof

