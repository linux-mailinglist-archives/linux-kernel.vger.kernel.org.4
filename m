Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A165ED4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiI1GVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiI1GVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:21:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146C1684C7;
        Tue, 27 Sep 2022 23:21:32 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1odQRm-0003xV-03; Wed, 28 Sep 2022 08:21:30 +0200
Message-ID: <ff413763-6cac-576f-7671-2f883bb56c51@leemhuis.info>
Date:   Wed, 28 Sep 2022 08:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, de-DE
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>
References: <20220927160559.97154-1-corbet@lwn.net>
 <20220927160559.97154-8-corbet@lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 7/7] docs: add a man-pages link to the front page
In-Reply-To: <20220927160559.97154-8-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664346093;af66278c;
X-HE-SMSGID: 1odQRm-0003xV-03
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.09.22 18:05, Jonathan Corbet wrote:
> Readers looking for user-oriented information may benefit from it.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/index.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 5a700548ae82..85eab6e990ab 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -76,6 +76,8 @@ developers seeking information on the kernel's user-space APIs.
>     User-space tools <tools/index>
>     userspace-api/index
>  
> +See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
> +which are kept separately from the kernel's own documentation.

People following that link might be inclined to click on the section 1
and then find a lot of stuff that has nothing or not much to do with the
kernel and then might feel lost. So how about a text like this instead:

```
See also the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
as that where some of the kernel's documentation is kept. Among it are
for example descriptions of Linux' `system calls
<https://man7.org/linux/man-pages/dir_section_2.html>`_ and `devices
<https://man7.org/linux/man-pages/dir_section_4.html>`_; the sections
`files <https://man7.org/linux/man-pages/dir_section_5.html>`_ and
`overviews, conventions, and miscellaneous
<https://man7.org/linux/man-pages/dir_section_7.html>`_ also contain
many documents dedicated to aspects of the kernel.
```

The last section (e.g. everything after the semicolon) might not be
worth it.

Ciao, Thorsten
