Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B47303E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbjFNPal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbjFNPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:30:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BFC1FFB;
        Wed, 14 Jun 2023 08:30:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b2b7ca1c5eso4921802a34.0;
        Wed, 14 Jun 2023 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686756633; x=1689348633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOA7Y2/g359kO/OUlQWs/60uYSwoJsQ+eNPsqyoLC6A=;
        b=IHExyYknCYaNR++NT7KWQAcnorzZ/DTyWryslqKrhqzx45SLH+A8LegSKtd3EzgkVb
         tW3J8S7+d3/pvpRchov+vmYHgtbiMVHn29z/umpYT47vj7CK/HzYW/cFAoxbL2vU3LRP
         ZeiwVtBi6+gu8+kamPFjkjMdrHQcpnpHI5O9YBAzV6oEpwFi8a1XCtPhjzuxplxJjrNn
         7eo7tVEd3ulkPJiC8e1ezn95zAaPHQvzylrdLKXTdcZa953ykg14xRkJihxaHXKtD2LH
         LSu/K2jGI5Lq8rbUCyKaWSNQ/emRuguhY6Ix9f7rYeZhxp18xsZVh7d09gQYar+nt+1F
         fOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756633; x=1689348633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOA7Y2/g359kO/OUlQWs/60uYSwoJsQ+eNPsqyoLC6A=;
        b=k2SSSOG1mSy/o3z8/iOp0Z58GNQdpBBHTLAILXBLhyO2tr3wm62AGXixgSDXmqZaVj
         KpedlE4kNnRufvYn0wZGFj6PafH7BwGjEYYunP6at0k5SjyCXmsRpRLgsNPFKK9FHVpb
         l0rCLn583T/oOJnnaM9ttxc0vHhJ7/GVi96IKf/DhVlF1WM/XU4o+CDoLBt1OqY+qNMb
         As3R17PFSBgNzHy3C+khZiXpj8DBFpDxf4QQmuAjoUkLaslrrMiGI93jeuDZz4EWiCEz
         775poaPR1S+4VvuujbuFfS6E4FOo7jSGD281sp+p9bPOOOYwVnpCNfwpeFcxki2f0VXs
         sLlA==
X-Gm-Message-State: AC+VfDxu76X675KD5+IvJVrryA2OpNV6IKZRKbgpVvNa+e/xPRH7ZiBo
        wLOIC4gwFl1K1I00edeaWEyVlyH8THc=
X-Google-Smtp-Source: ACHHUZ6FakHIDN4yFpz0tDtI2ydPYV4hLaDjD7mRfadlZqUYSUOmebPcmNnoYLOzD1Zw1HQ8GyAjDA==
X-Received: by 2002:a9d:754c:0:b0:6b1:c635:b0fd with SMTP id b12-20020a9d754c000000b006b1c635b0fdmr12677424otl.32.1686756633095;
        Wed, 14 Jun 2023 08:30:33 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y2-20020a056830108200b006b168e0a41fsm4739886oto.11.2023.06.14.08.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 08:30:32 -0700 (PDT)
Message-ID: <7283dd30-79ac-b21b-3e99-2b8b0950879d@gmail.com>
Date:   Wed, 14 Jun 2023 12:30:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] rust: make `UnsafeCell` the outer type in `Opaque`
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230614115328.2825961-1-aliceryhl@google.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230614115328.2825961-1-aliceryhl@google.com>
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

On 6/14/23 08:53, Alice Ryhl wrote:
> When combining `UnsafeCell` with `MaybeUninit`, it is idiomatic to use
> `UnsafeCell` as the outer type. Intuitively, this is because a
> `MaybeUninit<T>` might not contain a `T`, but we always want the effect
> of the `UnsafeCell`, even if the inner value is uninitialized.
> 
> Now, strictly speaking, this doesn't really make a difference. The
> compiler will always apply the `UnsafeCell` effect even if the inner
> value is uninitialized. But I think we should follow the convention
> here.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
