Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F026565AE5E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjABIre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjABIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:47:32 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAED9D94;
        Mon,  2 Jan 2023 00:47:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7DC38447CB;
        Mon,  2 Jan 2023 08:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672649247; bh=Iri98/XMHObCV5g8WvmFmk4VxFpmQL0oBfMhS83NGLg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YLfaPGXQTYRmSqpJc4E1KludjXTBHczwtN754lSF6OSVK8P4DQhkZc8CpUB28EQz6
         c+fPiyvquZZzesUxEcUWqV4ywwIfvU5+9C5uIU6Z/gWKCWC8AlNCpp4njyo9YbYtpw
         bE6UR1EAVkIFKgE0CTaDc/HmZ0IzcuI05L+80+N9Zs2zrMXID/b2e2p7+Ke0U9bXXn
         tkNvrVLEdRFpZCR7ngNNe66uyaEwfdoo1jy2v7n9J5rrF8coWU64nCEcJ85R1HCaUd
         xTuIe1/tpjF9wT2tlMoQL5rgMjavKMqqqWB/MkSHUnzgMDedC2rVwHxStZoXssJBzx
         IJf4HgKPGOo0A==
Message-ID: <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
Date:   Mon, 2 Jan 2023 17:47:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [REGRESSION] Wi-Fi fails to work on BCM4364B2 chips since kernel
 6.1
Content-Language: en-US
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "ranky.lin@broadcom.com" <ranky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lina@asahilina.net" <lina@asahilina.net>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/02 16:46, Aditya Garg wrote:
> Since kernel 6.1, Wi-Fi is failing to work on Macs with the BCM4364 rev 3 chips and journalctl reports that the firmware has crashed.
> 
> The complete journalctl is given here :- https://gist.github.com/AdityaGarg8/a25b187e7f1462798de87e048f4840db
> 
> This bug has been reported by users of iMac19,1 as well as Macmini8,1.

You are using a downstream patched tree, specifically one with further
Broadcom patches not yet upstream from my Asahi Linux tree and probably
others.

Please do not spam upstream developers with issues from downstream
trees. If you have an issue with my tree, you can report it on GitHub.
If you are using another tree, report it to its maintainer. If you can
reproduce this with *vanilla* 6.1 then you can report it upstream.

- Hector
