Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE170159D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbjEMJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjEMJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:24:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B2540FB;
        Sat, 13 May 2023 02:24:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pxlTx-0005lU-9d; Sat, 13 May 2023 11:24:05 +0200
Message-ID: <10dfcc33-b3f9-57f7-1693-dd850f3adc6e@leemhuis.info>
Date:   Sat, 13 May 2023 11:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rong Tao <rtoax@foxmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230510183423.never.877-kees@kernel.org>
 <6c1f853b-b051-c390-267e-1ea1741e8537@leemhuis.info>
 <202305111135.D65457C24@keescook>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] docs: submitting-patches: Discuss interleaved replies
In-Reply-To: <202305111135.D65457C24@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1683969859;5f7505f3;
X-HE-SMSGID: 1pxlTx-0005lU-9d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.23 20:37, Kees Cook wrote:
> On Thu, May 11, 2023 at 11:21:36AM +0200, Thorsten Leemhuis wrote:
>> On 10.05.23 20:34, Kees Cook wrote:
>>> Top-posting has been strongly discouraged in Linux development, but this
>>> was actually not written anywhere in the common documentation about
>>> sending patches and replying to reviews. Add a section about trimming
>>> and interleaved replies.
>>
>> Thx for doing this.
>>
>>> [...]
>>> ---
>>>  Documentation/process/submitting-patches.rst | 23 ++++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>
>> For some reason we have duplicate code^w documentation for this, hence
>> I'd say the same or a similar text should also be added to one of the
>> filed in Documentation/process/[0-9].*rst ; from a quick
>> Documentation/process/6.Followthrough.rst might be the best one.
>>
>> Maybe in fact the text should move there and submitting-patches.rst
>> should have a much shorter version, as it's meant to be the terser of
>> the two docs about this.
> 
> Hm, The place where it is mentioned is even shorter,

Ohh, it is mentioned there already? I briefly looked, but had missed it.
Sorry. :-/

> so I kind of like
> it in submittingpatches. But, I'm open to whatever seems best.

Guess that is Jonathan's call to make. Your v2 patch to me looks a bit
like adding quite a bit of new and slow code to the fast path while
adjusting faster code in the slow path.

But the relation and interaction between those two texts in a bit messy
already, so maybe it doesn't matter that much.

Ciao, Thorsten
