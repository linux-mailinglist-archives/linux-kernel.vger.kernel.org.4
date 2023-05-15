Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FAD7033FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbjEOQnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbjEOQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:43:38 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F4049C7;
        Mon, 15 May 2023 09:43:30 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pybIG-0007b4-AX; Mon, 15 May 2023 18:43:28 +0200
Message-ID: <547c4c61-26af-ee0d-146f-d0db077dc53f@leemhuis.info>
Date:   Mon, 15 May 2023 18:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Fwd: Freeze after resuming from hibernation (culprit is brcmfmac
 change?)
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Broadcom 80211 Devices <brcm80211-dev-list.pdl@broadcom.com>,
        SHA cyfmac Subsystem <SHA-cyfmac-dev-list@infineon.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc:     Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, julien.falque@gmail.com
References: <018f62d0-ee1d-9198-9c38-e45b10921e2e@gmail.com>
 <f629341e-5920-8061-6120-cb954d22ffe9@redhat.com>
 <b3bb9fc7-c7ec-ad32-5d6f-e6ba55e2dd7d@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <b3bb9fc7-c7ec-ad32-5d6f-e6ba55e2dd7d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684169010;5867046c;
X-HE-SMSGID: 1pybIG-0007b4-AX
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.23 15:09, Bagas Sanjaya wrote:
> On 5/15/23 15:56, Hans de Goede wrote:
>> On 5/15/23 04:21, Bagas Sanjaya wrote:
>>> I notice a regression report on bugzilla [1]. Quoting from it:
> [...]
>>>> A bisect on linux-git gave commit da6d9c8ecd00 as the cause of the problem.
>>
>> da6d9c8ecd00e2 is known to cause a NULL pointer deref on resume,

Bagas, fwiw, to prevent situations like these I usually search on lore
for a shorted variant of the commit-id[1] before telling regzbot about
it. In quite a lot of cases I find something useful that might mean that
tracking is not worth it.

Ciao, Thorsten

e.g. [1] https://lore.kernel.org/all/?q=da6d9c8*

