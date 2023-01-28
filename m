Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8208B67F661
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjA1Ifn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjA1Ifb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:35:31 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA953E6E;
        Sat, 28 Jan 2023 00:35:26 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pLggF-0005NG-IE; Sat, 28 Jan 2023 09:35:23 +0100
Message-ID: <f48e8dab-2a68-88d2-7917-f8f34a39e322@leemhuis.info>
Date:   Sat, 28 Jan 2023 09:35:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
To:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230127234616.55137-1-skhan@linuxfoundation.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v2] docs: add workload-tracing document to admin-guide
In-Reply-To: <20230127234616.55137-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1674894926;f3f14f9d;
X-HE-SMSGID: 1pLggF-0005NG-IE
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lo! One small quick question.

On 28.01.23 00:46, Shuah Khan wrote:
> Add a new section to the admin-guide with information of interest to
> application developers and system integrators doing analysis of the
> Linux kernel for safety critical applications.

That intro made my mind go "neither 'application developers' or 'system
integrators' are admins, so why is this added to the 'admin guide' then?"

That made me look up the into for the admin guide, which is
```
The Linux kernel user’s and administrator’s guide

The following is a collection of user-oriented documents that have been
added to the kernel over time. There is, as yet, little overall order or
organization here — this material was not written to be a single,
coherent document! With luck things will improve quickly over time.
```

Adding another section that doesn't seem to a be a good fit feels a bit
like "making things worse than better".  So wouldn't this maybe be a
good opportunity to create a totally new top-level section for
application developers and system integrators, even if it's tiny for
now? The audience is likely big enough to justify that -- and the topics
are likely different enough, too (of course sometimes there will be
overlap, as always). Any maybe it will help to bring other stuff over
from admin guide that is more targeted for application developers and
system integrators, which will help to get more structure into the
admin-guide.

Anyway, I have no strong feeling about this, just wanted to get this of
my chest.

Ciao, Thorsten
