Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C31708CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjESA3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjESA27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:28:59 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6803310E3;
        Thu, 18 May 2023 17:28:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ac8ede63ccso1991435a34.2;
        Thu, 18 May 2023 17:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684456130; x=1687048130;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OSFENBt/zyLmxBAw3RVTXpbG4Rk4EEr4uJ7eZEA1Bvk=;
        b=NsA92l2NeEZt3bLIWlShHKqkIN6z/yTqVBwk4rcmWb/bIkdk0QTF9J2NjYr7Mf02Vx
         IcmZY24N1xJa099XLoMMlaEDrv4lWsTJ4gyqfumkU6TeCAm71JQDZQ25JgzOxwH+9dR2
         a0XSJ55P7rqCroaDSbk78vkTRqXl4LCGV0rtyrnF+R6Pz1IfI2lhg7o36f6R9wowRo1d
         1AwxYXagUtb0Mzz2hvUNEBycdWuNf/JmG1zNxPjdpoSwm55t4SvKJUsBVeKVwVexZ4d9
         4P0bA0irm1dMcABjxdhokgThO4zdh6VJiLf7JXyJoZ2Zx5Z2u0SmiimrLx2/2Yu1SmOK
         ghLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456130; x=1687048130;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSFENBt/zyLmxBAw3RVTXpbG4Rk4EEr4uJ7eZEA1Bvk=;
        b=ZB1BetkyZZdwDCteH5IPDggQffhFkfa/m5rAk5eXI/yrrgLeg2U6Fpxqxy0pqzb0+M
         RCbVtxrX2zfjLx0bD/D9OgvlohrpS0qrjjTJ9hgLHDigbLo0ZGdsNXma3kPMkJO6a1Eo
         gwz9jw3yEXQeoDc3h5E0A52NrfKYQlwydz1sr+ZaC8gF9j1XIz2IU9qMLx+yTgO6F36H
         7VLRBi9UNpaSMGl/0BCo5t/ndwV1tdRjWvyQbv67CDKA1sC2ohs3vkNQX5Lq0rvFszl0
         RB9M6wNSLC5K0BuJG3DlUJNWvFKWgozuP4JGWblfxUSt8M3wjEFFDmKpm5pvMxk1EjD5
         OF5w==
X-Gm-Message-State: AC+VfDy8buPiW7kBjQPNdaM7PWJT8SMQ67t180+qwi8tYC/bjTSGVvSV
        +NkSYT3rq5bHbmFzd4Lf4wY=
X-Google-Smtp-Source: ACHHUZ42ZxwdYP/yb7j19gJwj6zpvdzcAaklXDT2EJzihujviHWGn2qVJpzJ0h/eWiTZuHnPgas6/w==
X-Received: by 2002:a9d:7ad1:0:b0:6a4:2e3a:6e29 with SMTP id m17-20020a9d7ad1000000b006a42e3a6e29mr162554otn.24.1684456130654;
        Thu, 18 May 2023 17:28:50 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id r4-20020a056830134400b006ab36a64f6bsm1173608otq.51.2023.05.18.17.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 17:28:50 -0700 (PDT)
Message-ID: <f73f1caf-a1a5-5bce-58af-2a961c301789@gmail.com>
Date:   Thu, 18 May 2023 11:51:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v1 3/7] rust: sync: add `Arc::{from_raw, into_raw}`
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230517203119.3160435-1-aliceryhl@google.com>
 <20230517203119.3160435-4-aliceryhl@google.com>
Content-Language: en-US
In-Reply-To: <20230517203119.3160435-4-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 17:31, Alice Ryhl wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> These methods can be used to turn an `Arc` into a raw pointer and back,
> in a way that preserves the metadata for fat pointers.
> 
> This is done using the unstable ptr_metadata feature [1]. However, it
> could also be done using the unstable pointer_byte_offsets feature [2],
> which is likely to have a shorter path to stabilization than
> ptr_metadata.
> 
> Link: https://github.com/rust-lang/rust/issues/81513 [1]
> Link: https://github.com/rust-lang/rust/issues/96283 [2]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
