Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E747160BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjE3M47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjE3M4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:56:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED23E57
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:55:55 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q3ysD-0007IU-2j; Tue, 30 May 2023 14:54:49 +0200
Message-ID: <3a5a127d-875e-97a0-af56-741b3690de62@leemhuis.info>
Date:   Tue, 30 May 2023 14:54:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cf4f50bf-99ca-f94f-f0cf-63081d531b4c@gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: regzbot dashboard stalled (no regressions reported generated for
 v6.4-rc4)
In-Reply-To: <cf4f50bf-99ca-f94f-f0cf-63081d531b4c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1685451355;7cf1a483;
X-HE-SMSGID: 1q3ysD-0007IU-2j
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.05.23 14:41, Bagas Sanjaya wrote:
> 
> Regressions list on regzbot dashboard [1] seems stalled. It was
> last compiled on last Sunday (2023-05-28 06:18:57 (UTC)). Is regzbot
> not running, and why?

Thx for letting me know, it ran into a bug that made it error out. And I
didn't notice yet myself, as other things kept me busy yesterday and
today. Will take a look soon!

Ciao, Thorsten
