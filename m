Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B754D623D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiKJI2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiKJI2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:28:37 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0984A10C4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:28:36 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ot2vK-0004K0-BD; Thu, 10 Nov 2022 09:28:34 +0100
Message-ID: <3f1721d6-e5d9-8861-4e3c-802a711e71da@leemhuis.info>
Date:   Thu, 10 Nov 2022 09:28:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: BUG: kworker + systemd-udevd memory leaks found in 6.1.0-rc4
Content-Language: en-US, de-DE
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Tejun Heo <tj@kernel.org>,
        Florian Mickler <florian@mickler.org>,
        systemd-devel@lists.freedesktop.org
References: <0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr>
 <a6b76ce0-0fb3-4434-cc3e-ab6f39fb1cf9@alu.unizg.hr>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <a6b76ce0-0fb3-4434-cc3e-ab6f39fb1cf9@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668068916;f006bba5;
X-HE-SMSGID: 1ot2vK-0004K0-BD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.22 05:57, Mirsad Goran Todorovac wrote:
> On 04. 11. 2022. 11:40, Mirsad Goran Todorovac wrote:

> This bug is confirmed in 6.1-rc4, among the "thermald" and "systemd-dev"
> kernel memory leaks, potentially exposing race conditions or other more
> serious bug.

Maybe, but that sadly is also true for a lot of other known issues, for
example those in this quite long list:
https://syzkaller.appspot.com/upstream#open

It would help if you could pinpoint the problem, then we know who should
look into this. You CCed me and the regression list, so I assume it's a
regression. Hence: Could you try to bisect it?

Ciao, Thorsten
