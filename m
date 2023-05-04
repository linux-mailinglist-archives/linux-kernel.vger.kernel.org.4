Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6A6F71FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjEDSgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjEDSgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:36:05 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D8555A8;
        Thu,  4 May 2023 11:36:04 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-642f5394651so816854b3a.3;
        Thu, 04 May 2023 11:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683225364; x=1685817364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6B4ouYpBn9E1mbPykalpiRSmus+k+IipP6/ASzDCUrc=;
        b=laUaItWBDO/uoSXWGET70Pzk7p1krjmoEBJymOxJab73aym65Clug6q4CAEkQsNJS9
         FruC0bZbYgiE+SMKFcjrkUT3GkhrjvtWT7QZZO5fI+MI7QPE8YVr5iosrTsk4qIK/X3M
         wuWWMUzIKyhA2/aB+FYzxHJqOueIhzy8B41klAw0bupJtrdZ8smZ542novn+6gU2x0C6
         ZBxYhst9fE4gr679BNscEjOmec8F67aOQtvJrUi4u2dDqFVI1ABxNNb6+m/GvF3sOLoS
         0aEz9ytDVIJ+ANAIjy6JDelABA1PkfSfrWUZfqKlCsEabUmtvh8fcpZp65RxnYZyYd9t
         30PA==
X-Gm-Message-State: AC+VfDxPwxcyi7cP/WH3vhcLRS6BpDT1/NdUwVPeDd6MuiNzFqn2+aug
        8sHIQPT1smva0qmX0NRzdM4=
X-Google-Smtp-Source: ACHHUZ6JtC2DBf9wDNkfuXcg/fqrTrOGPH7OjEZei26kTEMoq0zWE/lY9ODsleAMVxJhuq/t97e2Gw==
X-Received: by 2002:a05:6a00:2352:b0:63f:158a:6e7b with SMTP id j18-20020a056a00235200b0063f158a6e7bmr4363302pfj.6.1683225364012;
        Thu, 04 May 2023 11:36:04 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2c3b:81e:ce21:2437? ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id m22-20020aa78a16000000b0063d3d776910sm15737pfa.138.2023.05.04.11.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 11:36:03 -0700 (PDT)
Message-ID: <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
Date:   Thu, 4 May 2023 11:36:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <87jzxot0jk.fsf@metaspace.dk>
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

On 5/4/23 11:15, Andreas Hindborg wrote:
> If it is still unclear to you why this effort was started, please do let
> me know and I shall try to clarify further :)

It seems like I was too polite in my previous email. What I meant is that
rewriting code is useful if it provides a clear advantage to the users of
a driver. For null_blk, the users are kernel developers. The code that has
been posted is the start of a rewrite of the null_blk driver. The benefits
of this rewrite (making low-level memory errors less likely) do not outweigh
the risks that this effort will introduce functional or performance regressions.

Bart.

