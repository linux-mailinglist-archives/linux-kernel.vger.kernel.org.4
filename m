Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA56F5C37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjECQrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjECQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:47:32 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E159DD;
        Wed,  3 May 2023 09:47:29 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1aaef97652fso30184645ad.0;
        Wed, 03 May 2023 09:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683132449; x=1685724449;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umgEn3cqi31k8FAoc6eHggscu0a8wyQqY+YT1k4FgE4=;
        b=M4mwG7mL+dUSl3I2W3utKmlZWAheVeiFt2NuVhDdST8u3xvtQcfEw4u/V/LyEyNSpb
         KAH5XOOP0vrGhsdtW2Tp2FkUeq1S1wmZsfsdhl95U6PCj3M0CHlvyf0pdGCqyQ5FbWzN
         ZcYAiyiDzD7so7lYpj2ltcIErcBXi5q8FCK72ETNR4idwL+OWAbCGbZAIrdGa59TbGBq
         QLzm7t/GBk0CfzlOzP8paMIrSoVHjyJaetLWqtrkuq6ftmHnGgadadXE7/E9xZX0rXHZ
         xQFEvZYFJy/7hdMDCZj/u7LxKrGRnaAlHt2jvwdZUkgaXSYK6x/864UY2PQRg/FK3ijL
         kEQQ==
X-Gm-Message-State: AC+VfDxC5uTRBdWyugVQx0VW5MDZjJX13CzgEyvDJGhSQY9r9zTC4ffG
        HzHRxGbwGLLA02QUflSVqYM=
X-Google-Smtp-Source: ACHHUZ4pRU+8JVmqhik5EA6Xabeqqj93jGvFii5MsVXC+4XabS4MDDjGwO+ipEKbgomNvIjNIpwc5Q==
X-Received: by 2002:a17:903:1cd:b0:1a9:581e:d809 with SMTP id e13-20020a17090301cd00b001a9581ed809mr902959plh.7.1683132448605;
        Wed, 03 May 2023 09:47:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c683:a90b:5f41:5878? ([2620:15c:211:201:c683:a90b:5f41:5878])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a96496f250sm18247374plr.34.2023.05.03.09.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 09:47:28 -0700 (PDT)
Message-ID: <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
Date:   Wed, 3 May 2023 09:47:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
To:     Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
References: <20230503090708.2524310-1-nmi@metaspace.dk>
Content-Language: en-US
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
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

On 5/3/23 02:06, Andreas Hindborg wrote:
> This is an early preview of a null block driver written in Rust.

It is not clear to me why this effort was started? As far as I know the 
null_blk driver is only used by kernel developers for testing kernel 
changes so end users are not affected by bugs in this driver. 
Additionally, performance of this driver is critical since this driver 
is used to measure block layer performance. Does this mean that C is a 
better choice than Rust for this driver?

Thanks,

Bart.
