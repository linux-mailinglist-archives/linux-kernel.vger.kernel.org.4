Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A4622F38
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiKIPmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiKIPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:42:16 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FCA11C00
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:42:15 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1osnDQ-0000Uh-Cx; Wed, 09 Nov 2022 16:42:12 +0100
Message-ID: <7c5bbff7-298f-b38d-9409-3e8efef82619@leemhuis.info>
Date:   Wed, 9 Nov 2022 16:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [REGRESSION] Bug 216493 - Panic on __kernfs_remove (probably
 after 5.19.8)
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <c38235e9-b620-510c-4b53-6b190b83f997@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
In-Reply-To: <c38235e9-b620-510c-4b53-6b190b83f997@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668008535;dbb6641b;
X-HE-SMSGID: 1osnDQ-0000Uh-Cx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.22 11:56, Thorsten Leemhuis wrote:
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216493 :

#regzbot invalid: Patrick can't reproduce the problem anymore, Igor
didn't reply to a status inquiry
