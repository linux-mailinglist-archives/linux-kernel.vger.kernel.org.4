Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01786ADD90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjCGLgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCGLgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:36:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D072769C0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:36:22 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pZVc4-0005l9-2O; Tue, 07 Mar 2023 12:36:12 +0100
Message-ID: <3d8d39ad-2940-cd0f-df75-748db467329c@leemhuis.info>
Date:   Tue, 7 Mar 2023 12:36:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
To:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>
References: <cover.1674217480.git.linux@leemhuis.info>
 <bb5dfd55ea2026303ab2296f4a6df3da7dd64006.1674217480.git.linux@leemhuis.info>
 <20230301204602.5e9bf3c0@kernel.org>
 <ff62632d-7558-a86c-5541-a54de6e107e7@leemhuis.info>
 <20230301214023.610a9feb@kernel.org>
 <CACT4Y+bxUA1v14y0SGC887er5Nif3ZEanjO_m=K4WBwyNfmZHA@mail.gmail.com>
 <17fdf6f1-60ab-bfde-afc8-5afef6cc797b@leemhuis.info>
 <CACT4Y+Zm3d9jqK=R-E4xTihEUNdahagPyMPcinWowx8RABawrw@mail.gmail.com>
 <3275c17f-1a62-4e4a-4a5b-06b34098f8d2@leemhuis.info>
 <20230302181010.859456e24e8aaf0990b0dead@linux-foundation.org>
 <CACT4Y+brH-ygxHYzstC9dgFcQ=NnYgE48E4j+csE3JqH4FaM5w@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v4 2/3] checkpatch: warn when Reported-by: is not followed
 by Link:
In-Reply-To: <CACT4Y+brH-ygxHYzstC9dgFcQ=NnYgE48E4j+csE3JqH4FaM5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1678188983;08ba528e;
X-HE-SMSGID: 1pZVc4-0005l9-2O
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.23 09:53, Dmitry Vyukov wrote:
> On Fri, 3 Mar 2023 at 03:10, Andrew Morton <akpm@linux-foundation.org> wrote:
>>>> We can parse out our hash from any tag, but the problem is that the
>>>> current email api we use, does not allow to specify Message-ID before
>>>> sending, so we don't know it when generating the text.
>>>> We don't even know it after sending, the API is super simple:
>>>> https://pkg.go.dev/google.golang.org/appengine/mail
>>>> So we don't know what the lore link will be...
>>>
>>> That's... unfortunate, as from my understanding of things that would be
>>> the most important "Link:" to have in any patches that fix issues report
>>> by syzbot. But well, that's how it is for now. In that case I'd vote for
>>> this:
>>>
>>> Reported-by: syzbot@syzkaller.appspotmail.com
>>> Link: https://syzkaller.appspot.com/b/cafecafecaca0cafecafe
>>
>> As you previously mentioned, patch preparers should also include
>> the lore link so any followup discussion is easily located.
> 
> If the link we need to include is to lore, then we don't need to
> change the current syzbot Reported-by, right? Instead of asking 3
> tags, we can ask only for:
> 
> Reported-by: syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/cafecafecaca0cafecafe@google.com/

Yeah, that's not perfect (see below), but at least better. As mentioned
earlier: if the Reported-by: includes the sysbot-id (e.g. the
df61b36319e045c00a08) is up to you.

> But as I mentioned we can't provide the lore link at the moment, we
> can only add a text to ask to include it.

Yeah, that would be good. Normally it's the oblation of the developer
anyway to add Link: tags to any report (which most of the time means: in
lore) when fixing things. Obviously the chance that they actually do it
is a lot bigger when syzbot would suggest it.

> This also means that checkpatch does not need special casing for syzbot.

Yup

Ciao, Thorsten
