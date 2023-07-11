Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA79674E992
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGKI5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjGKI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:57:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A031A2;
        Tue, 11 Jul 2023 01:57:38 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJ9Bg-0003aY-9c; Tue, 11 Jul 2023 10:57:36 +0200
Message-ID: <fa420ff8-1d9c-0ca5-0de2-c6e9a75a1b6f@leemhuis.info>
Date:   Tue, 11 Jul 2023 10:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, de-DE
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1689008220.git.linux@leemhuis.info>
 <29fb398b-a81c-70f9-f67c-21daaa42e4f7@leemhuis.info>
 <ZK0WAbB2P8wFWPCu@hovoldconsulting.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
In-Reply-To: <ZK0WAbB2P8wFWPCu@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689065858;cf2d1b24;
X-HE-SMSGID: 1qJ9Bg-0003aY-9c
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.23 10:42, Johan Hovold wrote:
> On Mon, Jul 10, 2023 at 07:18:43PM +0200, Thorsten Leemhuis wrote:
>> On 10.07.23 19:10, Thorsten Leemhuis wrote:
> 
>>>  * For patches that may have kernel version prerequisites specify them using
>>>    the following format in the sign-off area:
>>>
>>>    .. code-block:: none
>>>
>>>      Cc: <stable@vger.kernel.org> # 3.3.x
>>>
>>>    The tag has the meaning of:
>>>
>>>    .. code-block:: none
>>>
>>>      git cherry-pick <this commit>
>>>
>>>    For each "-stable" tree starting with the specified version.
>>
>> /me wonders if something like a "note, such tagging is unnecessary if
>> the appropriate version can be derived from a Fixes: tag" would be
>> appropriate and worth it here
> 
> Having these comments in the patch itself makes it easier to determine
> whether a fix addresses a recent regression or an issue that's been
> around since forever without having to copy-paste and look up each
> commit in the Fixes tag(s).

Hmmm. But that can be misleading, as something like "Cc:
<stable@vger.kernel.org> # 3.3.x" might only have been used because the
submitter only tested if the change applies and works there while not
bothering with earlier kernels; similar things can happen if 3.2 and
earlier required changes to the patch due to API changes or file
movements the submitter was not willing to handle.

But I don't care. I already integrated a change like outlined earlier in
my local WIP document, but I can quickly remove it again.

Ciao, Thorsten
