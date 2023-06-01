Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7DF71A133
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjFAO67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjFAO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:58:51 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF84E47;
        Thu,  1 Jun 2023 07:58:16 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6af812703b6so532603a34.1;
        Thu, 01 Jun 2023 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685631493; x=1688223493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7JUXb4aekIO7D0dwVI5AuAQfE3+chmPdfkriZKP4oc=;
        b=hUtoI2Xw9zWxiDj/JBLrkcDDAhfU/tIFo3Ygbc1lvfNWZeeMG/Y0A2tU/mGCGwp5vX
         Em13bPhvXK/egyjaa2iz2O92KWyyEFX6flvLFNvKPP8k7hww5wkwMmOJ3OkNXIYpneB7
         DDe2Qn3htGY7pp6PKL/E2r8etImEyb4WkeqYRRA8OmWldZmZX06VoQ8EqEEb1NWMvwCf
         nhhE2DsdGl5ELAF0nhgeL/J0z5r6b29PlWpK29HRKv4sbPhozZ6S/bxZWYEgeIBCxf1V
         XLyvXmdfb8PdUEjExyV76DzTMKNg6Ciq9IuM+HaiODcBQqmKySJpDx59DJn8L9f8mmEV
         /pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631493; x=1688223493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7JUXb4aekIO7D0dwVI5AuAQfE3+chmPdfkriZKP4oc=;
        b=NRDGD+K08TUmwMJPDk2MtedTxvICKoGXEgj98ojmmjG75ZqTQ9zSGMAuJUzNXfjnbT
         pcC0Rw9IK58P+fCg8pXmrNGGMgPTFCLPs+AEIBDBPfyaZZs7nIlzOUBSR0ydyMkVv7ev
         ubYx4gp5GL0lU7n5W3gvAYkezoMI6K+AYGeD1/CztdPePhLDItUxkep8FBlE+M2qUyE8
         6+DCKoXNaF+Jz+vGnrFKO5P+avc0Tu/z0e/7ET7FO8h00Ad45zBuoJp9vKbRHVcF5MMI
         kqpCaRE9v/qzk+TyCs+WcE7je3giam48mSMW1/kOJEL8n4GCvzFZhY2UmMsA3pRJ6y2t
         /P3w==
X-Gm-Message-State: AC+VfDy0+KWF8qcdyB8tikY5iODwAct+jeMbKMZqe2fNl4SGsjFVhtVo
        XVsY5wetvcIs8aLtZY9YodQ=
X-Google-Smtp-Source: ACHHUZ4YgNF1X1qC5DtatbgdKTWP9tAFJUDfB6mX3y1C/RZoBttT9v2AoVM3fzFwTLLeRJ3zs0p8sA==
X-Received: by 2002:a9d:6213:0:b0:6b0:c711:8dd1 with SMTP id g19-20020a9d6213000000b006b0c7118dd1mr3410348otj.14.1685631493201;
        Thu, 01 Jun 2023 07:58:13 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id w15-20020a9d638f000000b006a42e87aee4sm1593045otk.32.2023.06.01.07.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:58:12 -0700 (PDT)
Message-ID: <77706c31-7fc6-9af7-bcbc-bd27a9757806@gmail.com>
Date:   Thu, 1 Jun 2023 11:29:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/8] rust: workqueue: add low-level workqueue bindings
Content-Language: en-US
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
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-2-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230601134946.3887870-2-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 10:49, Alice Ryhl wrote:
> Define basic low-level bindings to a kernel workqueue. The API defined
> here can only be used unsafely. Later commits will provide safe
> wrappers.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

My Reviewed-by is missing.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
