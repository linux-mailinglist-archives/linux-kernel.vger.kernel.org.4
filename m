Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0D718A71
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjEaTsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjEaTsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:48:33 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0409D;
        Wed, 31 May 2023 12:48:32 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-19f68a583a7so973411fac.1;
        Wed, 31 May 2023 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685562511; x=1688154511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4Wcgl0rHsjPEzn2Tf0MuvPr782eDL8Xj3y55NIs4UI=;
        b=Y3gH3jzjra2jFRV8Sv0VyvPZUpq1haLVKBPrHLAJSu+lhIq8GupxcqLGx67HXO4941
         bVXZ76fkQNBwiTc4cEDL2Jgd+70woAzpIk3IJVCSaBYvJWrMEmOONY2xG78CS2WYz3jL
         yrgZsLTROQwslkJ9c5fHcHzIUx7cSCgpVdH0/RqRcgeePjwW9D9MdSEXXVkbz3IkXdHP
         HEvBSPDsktsCh3Kaijj9kRu0DZBnTT8emJS0nfqDYW21Ixp6dvTR6tI24kIR7ZZbi1HZ
         W7yuUWs3gpE5AN7ey47pXIYMVYZOOnlUET4Gp12tMkqSeYtsl26uYc0h2xyk4VfynvEi
         xaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685562511; x=1688154511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4Wcgl0rHsjPEzn2Tf0MuvPr782eDL8Xj3y55NIs4UI=;
        b=C93kcRjicE+MCU9851f9DH5rB5ZBisL57SQqlVKhiWPT5bGCxvX1VKbvtxrKRY9ZOh
         gDYryhlU5Ob4PoKasBWyl+vfCy+1siEO+2ER61GbP3jLwcuxIien1UFVDXmO068EGFUk
         1NB8EgA4KM/QuiXW75fXjw7yxwBg+nmDcmkbD6FvT5vQd7/pvMSk0PaNhkZ5X5UyOk7u
         c9lfgUTBhEuKkdMxPmMa9UDLYQGBNe9VOwQG2NqZxqr582uf0XFxmvGR0ZnEeP0PUVR+
         j4GIy02RmN2a54OwokK5F64b8kYBSCP+H2zkcDHE0Ztlh69L1OXvSkHkhEebg1VVLYNW
         QyAA==
X-Gm-Message-State: AC+VfDyxBTs15JwQoOnKNz7x4AwVuBkn8eg7GmUnZVKq+08xbipIBnxn
        /PUfOeP2nEqjVyE8L8whHfM=
X-Google-Smtp-Source: ACHHUZ5YvVXylqQGY0foLp4Ey+r/irkQjeCZLrWViC4Aae+jMtqh3si45xqC9phUz+jjk16oL6F9lg==
X-Received: by 2002:a05:6871:a78a:b0:19a:1324:5875 with SMTP id wj10-20020a056871a78a00b0019a13245875mr2605771oab.26.1685562511717;
        Wed, 31 May 2023 12:48:31 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id e20-20020a05683013d400b006b0f58724d8sm785339otq.66.2023.05.31.12.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:48:31 -0700 (PDT)
Message-ID: <22ac8a99-d243-c537-41c7-ff2c5e69d28f@gmail.com>
Date:   Wed, 31 May 2023 16:48:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.68.2
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     ojeda@kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        gyakovlev@gentoo.org, jan.steffens@gmail.com, jistone@redhat.com,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        william.brown@suse.com
References: <20230418214347.324156-4-ojeda@kernel.org>
 <20230419030243.540348-1-yakoyoku@gmail.com>
 <CANiq72knVpyaKdT2iwrBNYorAt3Y5M-r6pXHc9JAZRCVmBYusQ@mail.gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CANiq72knVpyaKdT2iwrBNYorAt3Y5M-r6pXHc9JAZRCVmBYusQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 14:02, Miguel Ojeda wrote:
> On Wed, Apr 19, 2023 at 5:02 AM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
>>
>> Kinda bunch to review, although may I ask if each time the `alloc`
>> crate is updated is worth to mention the changes upon it [1], can be
>> skipped otherwise.
>>
>> Link: https://github.com/rust-lang/rust/commits/master/library/alloc [1]
> 
> That could be nice if we could give a link similar to, say, what:
> 
>      git log 1.62.0..1.68.2 -- library/alloc/src/
> 
> produces (or perhaps a list of PRs) -- is it possible to do so with a
> GitHub URL? If so, please let me know!
> 
> Cheers,
> Miguel


It seems that kind of URL comparisons in GitHub aren't supported yet
per the docs say [1]. Sad but maybe in the future they are going to be
supported, or at least I hope GitLab or Gitea do it.

Link: https://docs.github.com/en/pull-requests/committing-changes-to-your-project/viewing-and-comparing-commits/comparing-commits [1]
