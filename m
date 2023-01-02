Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FBE65AE92
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjABJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjABJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:13:49 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7012810E5;
        Mon,  2 Jan 2023 01:13:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1A1B6447D7;
        Mon,  2 Jan 2023 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672650826; bh=xIaXBSD0dTetSbOrE8dXjuCDx2D5IOPDOUqyMzdMeFg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XWmiE17/tSVdKW7wQc9fHMbyDOTsUmiJVvTIUCTEMVB8m6WSQXrOWkfE6skNxit0f
         pjRoL/6iOascSh+HrVG/oo/ybSHmYF9Dvj6u5q/V/guBUkk49Pv356UwFKg7fQ7yjQ
         wnXHP71J+s2WQW/Q40kpbfusrDHAi2iW2+qoHhim5tXtzfoBtPRa9T3WflkmzgKEG5
         //oAKEvx3xo15T1nQvzvabolFh1fb64uZuYTTSpH34UH7vaED3htW/0ph6yreFG+GK
         uyZbCGJxzDdvWGrHZIhUfoUTgQDcHqWqolInVkqy0l7k8r5gWdyBUhcs0K1+Y964X9
         iYcST9lbCZhNQ==
Message-ID: <b472677f-c556-99a4-eef7-f3cbdc8f64c1@marcan.st>
Date:   Mon, 2 Jan 2023 18:13:41 +0900
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
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lina@asahilina.net" <lina@asahilina.net>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
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

On 2023/01/02 17:57, Aditya Garg wrote:
> 
>> You are using a downstream patched tree, specifically one with further
>> Broadcom patches not yet upstream from my Asahi Linux tree and probably
>> others.
>>
>> Please do not spam upstream developers with issues from downstream
>> trees. If you have an issue with my tree, you can report it on GitHub.
>> If you are using another tree, report it to its maintainer. If you can
>> reproduce this with *vanilla* 6.1 then you can report it upstream.
>>
>> - Hector
> 
> I am sorry for the same Hector, but I sent that cause bcm4364 wifi chip is already supported upstream. If I ain't wrong, don't the Asahi Linux patches provide OTP support only for these chips?

There are a pile of Broadcom patches in our tree and there is no way to
eliminate them as the cause a priori. If you think this regressed
upstream, then test it with upstream Linux 6.1 and find out.

As I mentioned to you on Discord previously, please bisect this to a
specific commit so we can do something about it. I don't have the
hardware and there's nothing I can do with a "the firmware is crashing
now" report until you at least tell me what commit caused the problem so
I can take a stab at identifying the root cause.

- Hector
