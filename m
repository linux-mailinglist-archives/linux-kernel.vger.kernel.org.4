Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3868744CF5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGBJ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 05:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:27:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5621CE4D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 02:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4BEF60BAA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 09:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B256C433C7;
        Sun,  2 Jul 2023 09:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688290049;
        bh=aztMAMD4OWWotTcUcWcq9B4VxqpXV7yvEBBwkcTZyW8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DS2vUhLKDMJ3RwZQNxjAqd24o0UXge1LGSBLrZ8SO69fCueSbWRg2m3gcMqJJRMt/
         s5DmqM7j5gxtwulu7M7oiWUtNo6/jPEekdwiwST6XJDnayVJBXdwR8DDTCydHvPwfi
         LgwnkXxjPjeRuIFZgzS29Kx1ql/qGfDOyeTCdY2IMQDYcV6T9yzHs3S//iCuBNmmNV
         NLjAkKxnGSoywF8P8OXsoBt2VfNGR8oztpKUTXOwKtGyfRTD+wqqM/tUjRMablM5bX
         0ao3hGz96LVBkrFJkWHEdoXn5wP0SiXrE8QVvLYyUxmhCfdpWIhw1RMvSo6ORoXbCA
         26Phvnk+2eDkw==
Message-ID: <09016817-0f5f-54ed-cac4-9674f7723725@kernel.org>
Date:   Sun, 2 Jul 2023 11:27:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/6] dt-bindings: Add YAML schemas for Marvell Odyssey DDR
 PMU
Content-Language: en-US
To:     Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     sgoutham@marvell.com, bbhushan2@marvell.com, gcherian@marvell.com,
        lcherian@marvell.com
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-7-gthiagarajan@marvell.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230630120351.1143773-7-gthiagarajan@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 14:03, Gowthami Thiagarajan wrote:
> Add device tree bindings for Marvell Odyssey DDR PMU.

For all patches:
1. A nit, subject: drop second/last, redundant "YAML schemas for". The
"dt-bindings" prefix is already stating that these are bindings.

2. Please use subject prefixes matching the subsystem. You can get them
for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
directory your patch is touching.

3. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC.  It might happen, that command when run on an
older kernel, gives you outdated entries.  Therefore please be sure you
base your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by our
tools. Performing review on untested code might be a waste of time, thus
I will skip this patch entirely till you follow the process allowing the
patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


>  

Best regards,
Krzysztof

