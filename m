Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD11166226A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjAIKC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjAIKCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:02:09 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488A4F00D;
        Mon,  9 Jan 2023 02:02:07 -0800 (PST)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 309A1XVK031444;
        Mon, 9 Jan 2023 19:01:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Mon, 09 Jan 2023 19:01:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 309A1X7A031439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 Jan 2023 19:01:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d1542ad3-9c9d-90e7-f18c-531cb1547b78@I-love.SAKURA.ne.jp>
Date:   Mon, 9 Jan 2023 19:01:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] tomoyo: remove a temporary output file
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>
References: <20230109091919.3160916-1-masahiroy@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230109091919.3160916-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/09 18:19, Masahiro Yamada wrote:
> Since this is a general problem, you can leave it to Kbuild instead
> of introducing unneeded complexity.

> If it is not too late, please squash this.

It is not too late to apply. But how do you handle a case where
the process who is responsible for deleting incomplete file was
killed by e.g. OOM-killer?

