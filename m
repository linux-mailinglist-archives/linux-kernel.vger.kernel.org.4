Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4458968C7A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjBFU2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBFU2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:28:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA2329E38;
        Mon,  6 Feb 2023 12:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675715294; bh=UKZ91KlMlyPDiSEe667DpO0/2hE2Bw/He9ABW0qj/PQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=r6tgimBD7+gevlMnjaVPcN0xxlFx/JRazQS7xSIpEWf9JcW2Yv0mwUxBZuq/K5C7x
         CXEUKNj4xmQLhbvsEPIctTBr7bZRcyoLIks43Fnexd0BhtsatxeO9I8q4NMzZ6zGNd
         9riOKNPxysaee0eiV6bcu0UjKX1hIm9tIJCbJjGLBiAIeE5L5w/4astqd4CHMMr/IS
         0BO3JYl7vqLVrrLiWUC3/uR7Ei2KZN0NQUkIzOI42CZNWZkR33VqvZeb6osCXa4LHY
         slcu/DkgDipyM1xs9iFk824vofDGsjUyYZaLNQ1tS5tz/c47igc7VzX87V2hCBOJK4
         pEo7uie5gcBKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.187.227]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq6M-1oabqA0u3k-00tBQk; Mon, 06
 Feb 2023 21:28:14 +0100
Message-ID: <9ef640ec-e5da-eed0-3707-cd138504e1c1@gmx.de>
Date:   Mon, 6 Feb 2023 21:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] parisc: update kbuild doc. aliases for parisc64
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20230205163752.2535-1-rdunlap@infradead.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230205163752.2535-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dQ6w6Sso0DynHymSx1sSf884m02Cyx9zEt3tsu+PEwSKWK42qsx
 td9FbwJILXt6g4/giaaR1Kfrh6xsQjCZYalzxAlqUHuGR/AaYN0uiBTkiqyMYOHEUFxO/mo
 2GOo+c5I68ap6NAYKA8JbMKYgEjwKufeb0XFYejmrtgKoY+txzKmE7Y0wtInktqpwJmDh8+
 1Rdb3yY4SzcbSpuQiAmsw==
UI-OutboundReport: notjunk:1;M01:P0:odzB/JznoNo=;V6tBvW1VkD6tcAb7xj9ggL6C2af
 F2j4Os9fvNB0BI2HvMJKk13hCM/yD8DFlKJr4UGp+wOMSr7vsHEp0dB9HcF8YAiQXqNgzMPkX
 Sju94fRaOOKSYHB7KGjVk5t1U1hRSff4fwNfyN4ndGsipggBFC0ayJ36gECMKRuSGBOOoCmjX
 aHNijTsqcOw4KytMtUDoW3qBWRLkAkGcPA2wQxBXYIdSvdGc3EACYIXPAut18sc3yvoy1bC7r
 WW73vStGJDUi0mky6O7aIYkPSknusNppw02qC5RW2bevzuDQsDmr26Y4Y4aUrRXx8U6BiJ6aK
 b/r5fudoAtPFniWiOF2Aiz/0IRAu6Rp4+GT4OosIf7H4FIAWd22MC4JFc0GkIVO862kbcc+hG
 rcyd6phXitHpnQUSJKY87tmLraSKAmYE7poB5rnJvc6aGY2zCSLBzP4+UF1I79fYw5nQUtpmp
 Bb/GPuTCPVaNbqylx1BQsW+OWZ5XX8/OjfrzO7zCdzRSTK0Jde9pi7a+2WH3g5hvZfs5cwzXm
 G35JU1mrlbvmo/5lt5u6W7qZKh/2sMScXWmfSMQp+qk5RWSWXTATfQnBdnAKiDRql6wp75A4X
 Lm6vJdPYmpHKwE7AzXcCSHVsVt0zypX7NnqwBBMzAVlbQfK8/BIVYKXuvWFgRt7ofrVxQ9M74
 j1agDp0tFz0mQAUhsmsqz8v4vR7ubyLFz9l+FUl8tCRgMdENaiXKhLW1UppN/hSLE5p5RcDpl
 HBKnfxO1mPuwoLVG+KUhbYDvVgTm0n0KA8DETE+MCpPLiolT55ilfFscqqOPIn+hr0yy0z9w7
 WU4Lea1+al9hUMyziZ9aWc7uu9+hcN9lYiMSgsfXJEnBTjVPQV5KQinQkVEQYLyYTJDCjSOjw
 NsL9yxEuiIOmX6KLRfAi9/c3C9b/DXlq81+g3blNDi3YkMA4bXY0CEOJs4x54pAwQ1jr+EvOh
 nh5rDG0agzVkpyoKlxHJyM9hpS4=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/23 17:37, Randy Dunlap wrote:
> ARCH=3Dparisc64 is now supported for 64-bit parisc builds, so add
> this alias to the kbuild.rst documentation.
>
> Fixes: 3dcfb729b5f4 ("parisc: Make CONFIG_64BIT available for ARCH=3Dpar=
isc64 only")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
> v2: drop "parisc for 32 bit" part since "parisc" is not an alias

Acked-by: Helge Deller <deller@gmx.de>

Thank you, Randy!
I'll aplly it to the parisc tree.

Helge

>
>   Documentation/kbuild/kbuild.rst |    1 +
>   1 file changed, 1 insertion(+)
>
> diff -- a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.=
rst
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -160,6 +160,7 @@ directory name found in the arch/ direct
>   But some architectures such as x86 and sparc have aliases.
>
>   - x86: i386 for 32 bit, x86_64 for 64 bit
> +- parisc: parisc64 for 64 bit
>   - sh: sh for 32 bit, sh64 for 64 bit
>   - sparc: sparc32 for 32 bit, sparc64 for 64 bit
>

