Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D4722A28
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjFEPDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjFEPDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:03:01 -0400
X-Greylist: delayed 930 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 08:02:58 PDT
Received: from bagheera.iewc.co.za (bagheera.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722EDEA;
        Mon,  5 Jun 2023 08:02:58 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by bagheera.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1q6BUB-0000GD-5A; Mon, 05 Jun 2023 16:47:07 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1q6BUA-0003YV-BL; Mon, 05 Jun 2023 16:47:06 +0200
Message-ID: <36743946-9616-88f6-a1f0-5a617cc79c5c@uls.co.za>
Date:   Mon, 5 Jun 2023 16:47:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] net/pppoe: fix a typo for the PPPOE_HASH_BITS_1
 definition
Content-Language: en-GB
To:     Simon Horman <simon.horman@corigine.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230605072743.11247-1-lukas.bulwahn@gmail.com>
 <ZH3SEl7ZT+MBI7V0@corigine.com>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <ZH3SEl7ZT+MBI7V0@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/06/05 14:16, Simon Horman wrote:
> On Mon, Jun 05, 2023 at 09:27:43AM +0200, Lukas Bulwahn wrote:
>> Instead of its intention to define PPPOE_HASH_BITS_1, commit 96ba44c637b0
>> ("net/pppoe: make number of hash bits configurable") actually defined
>> config PPPOE_HASH_BITS_2 twice in the ppp's Kconfig file due to a quick
>> typo with the numbers.
>>
>> Fix the typo and define PPPOE_HASH_BITS_1.
>>
>> Fixes: 96ba44c637b0 ("net/pppoe: make number of hash bits configurable")
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>
Reviewed-by: Jaco Kroon <jaco@uls.co.za>

Sorry about that, that was indeed blonde.  Thanks for the fixup.

Kind Regards,
Jaco

