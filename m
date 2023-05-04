Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6206F7280
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjEDTDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjEDTCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:02:51 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9212B9023
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 12:02:22 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-331b05a02d1so238315ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683226941; x=1685818941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kokGgBmsivYrS4h0ovGxDZD5iT0X66Vb9h/9IHCj8JU=;
        b=F9RRz6nkWKwFgHf/kB5A51SSDAsFLUUG00DC6sv+tf5k9ZheXvuwlHxI/RfsKeUsk4
         qb/9es9HRtjQB0Hyh/Phza/Ur3ANl5Y9tD5hxn322/J9LMPwRO+U5ph/VaZ6yi84a0iO
         vycnRrEgZ7BIIGiq7s5z23x/f17du5vKjBZcPj8uVf6SkyS8/ndrUSJQJM4TJjYKw8Xp
         gqVos48Q10gDjy9Txf28ywZKu3lAADiVp9jPr7dT0656VV6uBRRd0wPEQFEW7CGmk8FH
         4JbJhWOi82/HECfi4XSLKLUAIIFDjr+FGcBomC+s9gkAtrMoBgIqk++WpykT+AX5MHAr
         B7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226941; x=1685818941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kokGgBmsivYrS4h0ovGxDZD5iT0X66Vb9h/9IHCj8JU=;
        b=iJzuIBmVVJqL1xw+OKFb8/vYv8FdLPid+o3wS+x798cmNT7Hs0wku0Sqy05Axlsign
         RDdQziMRwHpHsrhZvkNq36S2lOV9ApDMdJJS1Kwpk744GaL2gBnvxIQo+znKBAZo6gK8
         lCimEdOMX471KU8u7eItTBH6f82FiZnLwmAsHwy96ApxhSaPQ3sXLbzEQXu6p6Uxo8zx
         1wNmX7Cdnlku3qBUpCw1wSnuQME8q6zA1FwroWwJ3gjhp51WGKTRqnT6qUzfKgRbDj2A
         fhLqMz7JMgiRak6pCLOecREvutUX9zxcBtXSD3Yu36pb0fhWhcqjIcEBxvslwuuFj6jO
         6WRQ==
X-Gm-Message-State: AC+VfDwLIzF2VaWIWJrI/PqOh2VNKmUNVXc9EW7MlWktX1nP3SYvuTSe
        br3x6utv1tkL2YxKwxeiL9vJ2Q==
X-Google-Smtp-Source: ACHHUZ4yTaVNqNDRB9CXiVSLXr7FpVbofli3A6J/WPstUSeaMiLHEmOTKBLTJWq1vroY/LfboUKVjA==
X-Received: by 2002:a05:6e02:1baa:b0:32a:8792:7248 with SMTP id n10-20020a056e021baa00b0032a87927248mr6720817ili.2.1683226941450;
        Thu, 04 May 2023 12:02:21 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b27-20020a056638389b00b0041643b78cbesm34802jav.120.2023.05.04.12.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 12:02:20 -0700 (PDT)
Message-ID: <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
Date:   Thu, 4 May 2023 13:02:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Andreas Hindborg <nmi@metaspace.dk>,
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
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org> <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 12:52?PM, Keith Busch wrote:
> On Thu, May 04, 2023 at 11:36:01AM -0700, Bart Van Assche wrote:
>> On 5/4/23 11:15, Andreas Hindborg wrote:
>>> If it is still unclear to you why this effort was started, please do let
>>> me know and I shall try to clarify further :)
>>
>> It seems like I was too polite in my previous email. What I meant is that
>> rewriting code is useful if it provides a clear advantage to the users of
>> a driver. For null_blk, the users are kernel developers. The code that has
>> been posted is the start of a rewrite of the null_blk driver. The benefits
>> of this rewrite (making low-level memory errors less likely) do not outweigh
>> the risks that this effort will introduce functional or performance regressions.
> 
> Instead of replacing, would co-existing be okay? Of course as long as
> there's no requirement to maintain feature parity between the two.
> Actually, just call it "rust_blk" and declare it has no relationship to
> null_blk, despite their functional similarities: it's a developer
> reference implementation for a rust block driver.

To me, the big discussion point isn't really whether we're doing
null_blk or not, it's more if we want to go down this path of
maintaining rust bindings for the block code in general. If the answer
to that is yes, then doing null_blk seems like a great choice as it's
not a critical piece of infrastructure. It might even be a good idea to
be able to run both, for performance purposes, as the bindings or core
changes.

But back to the real question... This is obviously extra burden on
maintainers, and that needs to be sorted out first. Block drivers in
general are not super security sensitive, as it's mostly privileged code
and there's not a whole lot of user visibile API. And the stuff we do
have is reasonably basic. So what's the long term win of having rust
bindings? This is a legitimate question. I can see a lot of other more
user exposed subsystems being of higher interest here.

-- 
Jens Axboe

