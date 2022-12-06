Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912D8644499
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiLFNcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiLFNcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:32:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD31638B;
        Tue,  6 Dec 2022 05:32:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so14769375pjd.5;
        Tue, 06 Dec 2022 05:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JdbNe9RNVtu6aOv2KKD8EJeEYMqx5NsqVe6zMYOrKR8=;
        b=GLQL78XTCT1xN9guX8HTNyf5f188IwhmtpvGu53pkYpm1YRYbW5gA7OIb4tq4SaCS6
         xBNCJHrnQqr0K2mQ7JQn7/IUMy6/ktZU25o/plNFbPqaixUzAdXnDM7Qavkwk3wrugBE
         xbr/0jVjDcCCo+QoVZs83nsfVqPfcLlSGVb8LEq5evJjzHLxh24GAq5+6SQCuZIapYqE
         0/DnbC5zyebhFYJs0itKucWQnB/B/4ltztRSB5SHuJ5sfXzLmcUzjxgLfCG449aBNy3O
         Lpm/1NCLTW/N2EBX+vu14rxukFSbv0M+lzb8ELNdTH6CluKKlHPx+3NtX7xtDBNV+Fjg
         Bcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdbNe9RNVtu6aOv2KKD8EJeEYMqx5NsqVe6zMYOrKR8=;
        b=mKb/Hi9qpIsDRVrBqAnFlkardBIxhQt1LUoJvuWEEzfnxJa3rclztm4fxL67e3EUbl
         z4RgDZRb7Kb+7YtyjJMXYUBqQRY+VwjLea0Ez9mLVIcXfCp5Ny7AQ9oB37gi23s7R5Dp
         5ihOslhoUhlQMkriGWJhjvs2XGq1O/53LJ8BCxvU09vWLS42QK6dIlZd1XjdlsRYzPKl
         xn57BmSPk4maRfskDPqewWvmAwYGJZfmN88MNQVQuEeWu0THP/5rQEuB+BCWRyC/QwaX
         w8QWBJgSVOf9ZGDozZvymxS3BIRR10oVdVthW4dF/3RXTM9/PCkmcGvOqwDQnzxGfLmQ
         3RJw==
X-Gm-Message-State: ANoB5pn027zveDyaoYNuihTuSAJmZwW1VxeQTHr7PsdCgOAJLsFLYssr
        ZEC5CkoO/CONuBJyDiE2Isw=
X-Google-Smtp-Source: AA0mqf4v+SI7WHfM9rGAhbUGCXuA/96aLyWVFbGEbuPO55mW1jbORcw2URka3CBYnFjO81RYXVD1fQ==
X-Received: by 2002:a05:6a21:8cc7:b0:a2:c45f:f0fc with SMTP id ta7-20020a056a218cc700b000a2c45ff0fcmr402022pzb.27.1670333566701;
        Tue, 06 Dec 2022 05:32:46 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78f27000000b0057462848b94sm11710065pfr.184.2022.12.06.05.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 05:32:45 -0800 (PST)
Message-ID: <e3523f33-847b-81da-7b20-83ee54597d9f@gmail.com>
Date:   Tue, 6 Dec 2022 22:32:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2] docs: Integrate rustdoc into Rust documentation
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, corbet@lwn.net, konstantin@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
 <CANiq72=ud1EB+jcKE=iudFSgKNcqd=8Xe-M0YgxikmUuQ+TjGA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANiq72=ud1EB+jcKE=iudFSgKNcqd=8Xe-M0YgxikmUuQ+TjGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 17:08:53 +0100, Miguel Ojeda wrote:
> On Mon, Dec 5, 2022 at 2:06 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>>
>> So, this means "make htmldocs" will require kernel .config if CONFIG_RUST=y.
>> I'm not sure this new requirement is acceptable for kernel documentation
>> testers who just want to build kernel documentation.
> 
> If the worry is that "full tree testers" (or CIs in general) cannot
> fully test the docs anymore without a config, that is definitely a
> change, and one of the reasons why I initially didn't add it to
> `htmldocs`.

Well, I'm actually worrying about additional TAT when I want to test
a particular change in a .rst file and test-build under the relevant
subdirectory using a command, e.g., "make SPHINXDIRS=doc-guide htmldocs".

This completes almost instantly when CONFIG_RUST is not set.

With CONFIG_RUST=y, in my test, it runs RUSTDOC even when rustdoc is
already generated once, as shown below:

------
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  RUSTDOC   /home/foo/.rustup/toolchains/1.62.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/lib.rs
  RUSTDOC H rust/macros/lib.rs
  RUSTDOC   rust/compiler_builtins.rs
  RUSTDOC   rust/alloc/lib.rs
  RUSTDOC   rust/kernel/lib.rs
  SPHINX  htmldocs --> file:///linux/Documentation/output/doc-guide
make[2]: Nothing to be done for 'html'.
Using classic theme
source directory: doc-guide
------

It takes 10 seconds or so (under a not-fast PC), 97% or more of which
is wasted for redundant RUSTDOC runs.

Why is RUSTDOC invoked when there is no change in rustdoc?

If those redundant runs can be resolved, I might change my mind and ack
the integration of generating rustdoc and htmldocs.

> 
> However, full tree testers will need other changes anyway (at least
> installing the Rust toolchain), even if there was no need for a
> config. So it may be not too bad, and putting it in `htmldocs` means
> not having to call another target in the CIs; and for humans, less
> chance of forgetting etc.

Full tree testers wouldn't mind the redundant runs of RUSTDOC.

I think you can add a new target in the top-devel Makefile which
runs both rustdoc and htmldocs for CIs. Something like 'htmldocsboth'
or 'htmldocsall'???

htmldocs and other *docs targets are the most primitive ones for
running Sphinx, so my gut feeling tells me _not_ to contaminate
htmldocs with rustdoc or vice versa.

> 
> (It is also why I wondered above about
> `CONFIG_WARN_MISSING_DOCUMENTS`: if `Documentation/` intended to
> require a config as a whole, then it would be fine. I assume that is
> not the case, though, but not doing the sync is nevertheless a bit
> confusing)

I have no idea. (Note: I was not around when the kernel documentation
transitioned to Sphinx.)

> 
>> By the way, is rustdoc's requirement of .config only for CONFIG_RUST?
>> In other words, are contents of rustdoc affected by other config settings?
>>
>> If not, I think rustdoc can be generated regardless of config settings as
>> far as necessary tools (rustc, bindgen, etc.) are available.
> 
> Yeah, at the moment the config affects what gets generated. However,
> that may change in the future: there has been some movement around the
> Rust features needed for this recently, so I want to try that approach
> again (it would require some other changes, though).

Interesting.
So rustdoc needs .config. I'm convinced.

        Thanks, Akira

> 
> Cheers,
> Miguel

