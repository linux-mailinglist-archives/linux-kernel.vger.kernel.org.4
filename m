Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9B70A5D1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjETF4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETF4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:56:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E177128;
        Fri, 19 May 2023 22:56:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q0FZz-0006Cv-Ia; Sat, 20 May 2023 07:56:35 +0200
Message-ID: <a5b7f3dd-e7b9-3bab-01a7-b632db23d1b1@leemhuis.info>
Date:   Sat, 20 May 2023 07:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAJZ5v0g9RmqJm=bpc9SQryYo4r+9Ctj7_aXQcfFRWTS3=xs6qw@mail.gmail.com>
 <CAHk-=whZqMhLk6qbcO-pQSPFh2v-iu8v0A8U=mppYjLVHkf0Pw@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [GIT PULL] ACPI fix for v6.4-rc3
In-Reply-To: <CAHk-=whZqMhLk6qbcO-pQSPFh2v-iu8v0A8U=mppYjLVHkf0Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1684562203;35014479;
X-HE-SMSGID: 1q0FZz-0006Cv-Ia
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.05.23 20:43, Linus Torvalds wrote:
> On Fri, May 19, 2023 at 8:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> This adds an ACPI IRQ override quirk for LG UltraPC 17U70P so as to
>> make the internal keyboard work on that machine (Rubén Gómez).
> 
> I've pulled this, but those overrides are just odd. How does Windows
> work on those machines?
> 
> This feels like we're missing something...

FWIW, as this is related and some of you might not be aware of it:

That question recently came up[1] for the AMD Ryzen based machines that
recently needed overrides like that one. Mario looked into this and a
solution for them is in the works[2].

[1]
https://lore.kernel.org/all/68d017d9-d815-01d4-23c1-49c0aaf5f20b@amd.com/

[2]
https://lore.kernel.org/all/20230518183920.93472-1-mario.limonciello@amd.com/

Ciao, Thorsten
