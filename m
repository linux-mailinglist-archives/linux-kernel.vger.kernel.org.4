Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1B56F8990
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjEETjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjEETi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:38:59 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB072127;
        Fri,  5 May 2023 12:38:58 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1aaf7067647so15059565ad.0;
        Fri, 05 May 2023 12:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683315538; x=1685907538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnLgUpvg01C7PYBgC6vlYHIqP9eMrmASTJDXxCb+5To=;
        b=juJzTBCl1uNp/6qy6YEzOPHFIc4a1it8Aupu2q7bPf2TeVsbq/6ro9kJ1DAspDhSPb
         KsUpKujLXIzqCQlnt8ucJpYCU+jXgBbzxUo4CmcUct4/PKpKT6HVLinglH59DA5u/4lE
         Z3OYRt2VQDQr5+ww9bdxGY83CXP4JHwkay7oxgTl3L8Uf8grPE2WiYLTleXDKNcqA5y4
         S2d6YWg/JDC3nqYwUx3LVu1nXH6P6qUg/AYhRfgVMsKC9SBCyIAwKYK4VfswywnBOkFl
         NK4RJZX2L97gJjmYPnzFceLBHWn68S7o2a/eNfoi2L3xht4FdMldqLaGxR/fs0VrD3A2
         rylg==
X-Gm-Message-State: AC+VfDyg4JSQZW6QfVC4q4N1b/bwvUPUT5lx5elR88clKFx8D8z3Aavv
        CWpsh6mLEPjzQ1XSJ5ZER80=
X-Google-Smtp-Source: ACHHUZ6DdlL8h1oDpxSXo045aPjWXyPGk2fZG3YwLg7cT6FJGxM1GZt3aKM9n1ymI0sDPcTo+ZtP+w==
X-Received: by 2002:a17:902:d902:b0:1a9:86ca:38cd with SMTP id c2-20020a170902d90200b001a986ca38cdmr2453191plz.2.1683315538062;
        Fri, 05 May 2023 12:38:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:127d:5561:7469:3abc? ([2620:15c:211:201:127d:5561:7469:3abc])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b00194d14d8e54sm2188942plg.96.2023.05.05.12.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:38:57 -0700 (PDT)
Message-ID: <0931c4ba-a217-1422-7e6a-bb396ce45251@acm.org>
Date:   Fri, 5 May 2023 12:38:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Daniel Vetter <daniel@ffwll.ch>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org> <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com>
 <80ed2c0e-54db-777a-175b-1aa3ff776724@kernel.dk>
 <CANiq72=3kGRy-3Lq5oxUEhu5d-377QrhuzhvoKRL+_QvbnJE7A@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANiq72=3kGRy-3Lq5oxUEhu5d-377QrhuzhvoKRL+_QvbnJE7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/23 03:53, Miguel Ojeda wrote:
> Definitely, in the end subsystems know best if there is enough time
> available (from everybody) to pull it off. I only meant to say that
> the security angle is not the only benefit.
> 
> For instance, like you said, the error handling, plus a bunch more
> that people usually enjoy: stricter typing, more information on
> signatures, sum types, pattern matching, privacy, closures, generics,
> etc.

These are all great advantages of Rust.

One potential cause of memory corruption caused by block drivers is
misprogramming the DMA engine of the storage controller. This is something
no borrow checker can protect against. Only an IOMMU can protect against
the storage controller accessing memory that it shouldn't access. This is
not a criticism of Rust - I'm bringing this up because I think this is
something that is important to realize.

Bart.

