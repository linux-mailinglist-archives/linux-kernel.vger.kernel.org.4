Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E69666705
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjAKXOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjAKXNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:13:31 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E4838AE9;
        Wed, 11 Jan 2023 15:13:31 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c26so8128953pfp.10;
        Wed, 11 Jan 2023 15:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IOcWBMR0I7FVv4GNPWUTOzclkfWx3/605R1kOX9/Zw=;
        b=TUA3xVFT+sX9VVVBiO/YCBmOe0MUnk5PMj8a/mlRKqD+kgUwjJbuYpv97RJXiZVJNv
         6WG+sXPFEu8w+zBOU+msJ/aE4EXYOGhlLVOjRDLz3Tvn4Ni1g/79LllbZ2BAkU+bHPd6
         vvgmAWBG6LhwZZLQtgQS6T+SU6G0dwhRzrdRVvujvedBTi7+eoC3TfV5qR0gEDtBCyB/
         1L2xO8iJZkSsTyVAGzoctNm37wegDHSEypFsvf/WASufUcq9v7sQXJWif20/miRpo8XP
         It1fueogmn+6iExlneX3dRkM0fFFcVfHuZ0bpuElzb4doZH2E4vq+gY4tSVne+Wg9Huq
         mlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IOcWBMR0I7FVv4GNPWUTOzclkfWx3/605R1kOX9/Zw=;
        b=ASscobNLqc2Ttq/iaFwNt1ljxehuupqZo4DmXIEITW8UKrTvirVowEoj7MRQ9d7O5/
         Gm1fQm5O6FdStH1iSiqUj1I3HmhBkjuTPRlXz/hotSosEoDWM9zV2apIQjX/IC3r01bf
         lp9KQqDCwW93KHGrmg+aJsEVhzStqcta59I1xNh75073ZLoJ15zeVbUrXx6mI9gpOVNJ
         R/7nqC+fSrlMcsJVjP9V+oAqHhZ+EcPXh2Ha+jMjVWomxbtdKS7IJULFIJ4nT7/Zpjeh
         Erm1l5I6W6gf6X8zKZs0BcU6OYZXJQVNI7rBMkK9DhDlGXcjps7cSjMjlPeaejkqNpUW
         W9JQ==
X-Gm-Message-State: AFqh2krAuPmz2LgDmJLhxGujpiO6lS0m4qmmTd67BlqerFPUqWxOLAwl
        sNtHGfk8vAOswcWQvAJt0qJHom/ci7A=
X-Google-Smtp-Source: AMrXdXs4MUTBW/HE0TQVNaBiNQnYthTLrJL3NAdDoKcLKX2k4OGbWYb01uZBpw4zurBuuoMEjMhwbA==
X-Received: by 2002:a05:6a00:e8d:b0:580:c223:90e9 with SMTP id bo13-20020a056a000e8d00b00580c22390e9mr64411019pfb.6.1673478810582;
        Wed, 11 Jan 2023 15:13:30 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k197-20020a6284ce000000b00574b86040a4sm10492029pfd.3.2023.01.11.15.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 15:13:30 -0800 (PST)
Message-ID: <bdd04f2e-64a4-e3ef-eb4c-3681c6f52c2f@gmail.com>
Date:   Thu, 12 Jan 2023 08:13:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs: Fix the docs build with Sphinx 6.0
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <87wn629ggg.fsf@meer.lwn.net>
 <cb916eae-fdf6-504f-8f38-7928e0fa8344@gmail.com>
 <20230108150135.060b0c7a@coco.lan>
 <6e81b372-d010-fb75-cdfe-b76c6b197f07@suse.cz>
 <e2d98136-3c4c-8910-d116-93070c48474d@gmail.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <e2d98136-3c4c-8910-d116-93070c48474d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 00:17:11 +0900, Akira Yokosawa wrote:
> On Mon, 9 Jan 2023 15:14:46 +0100, Martin Li=C5=A1ka wrote:
>> Hi.
>>
>> I can confirm the regression, I bisected Sphinx revision that caused t=
hat
>> and filled an upstream issues:
>> https://github.com/sphinx-doc/sphinx/issues/11116
>=20
> Thank you Martin for looking into this!

Thanks to Martin's inputs on the github issue, Sphinx 6.1.3 has released
and the issue is resolved for parallel builds.

However, for non-parallel builds, the memory hog still remains.
Again, this is a table comparing 5.3.0, 6.1.2, and 6.1.3.

 =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                     elapsed time                       maxresident
         -----------------------------------  ---------------------------=
----
 Sphinx     -j1     -j2      -j4      -j6       -j1     -j2     -j4     -=
j6
 =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
  6.1.3  15:03.83 11:31.99  9:35.15  8:49.01  2949056 1059516  978232  96=
7400
  6.1.2  15:11.74 18:06.89 16:39.93      OOM  2961524 5548344 5255372    =
  --
  5.3.0  14:13.04 10:16.81  8:22.37  8:09.74   711532  937660  846016  80=
0340
 =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    Note:
      - The -j1 run needs an explicit option given to sphinx-build:
        make SPHINXOPTS=3D"-q -j1" htmldocs

I naively assumed that the memory hog would be resolved all together,
but that's not the case.

Martin, could you report the remaining issue to upstream Sphinx?

        Thanks, Akira


