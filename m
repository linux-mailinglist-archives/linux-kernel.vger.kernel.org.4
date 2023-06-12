Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896972CB33
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjFLQOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjFLQNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:13:51 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027A210C9;
        Mon, 12 Jun 2023 09:13:36 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b13e2af122so2564076a34.2;
        Mon, 12 Jun 2023 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686586411; x=1689178411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2E8I5KlscgLz/BhO77eZ+L4gqpBYzJDI1R3+cPj0I8s=;
        b=Vp8j+xtvbtcr38c4i9kgY07aKi70cuRJoJ1r5fNcvaYJCecHElPDE9o5ZhigbxAYLe
         7FiA11UeEjLbwfkoe82KpBi73huIeeO+PVNLPD09iLhLJT1zboDEbQI6AEoeLxE3B6wp
         6D4X2Xl3HWtMf/xR+LYA8hJesP3DQ7g0rlJGJm9fNW8p9TcNFskp8QmBfmKj2WS1E7Zs
         v03sEW1hKX+18aB8UO8Ef9wD9yZQ0cPuwF89GbsJqBVfxEIQKNS0HUK695QHNQYEBGhw
         TZgLfZTYJHRn6rmoCMfiT4WTeeua66yXA1jdSM+3yJTA/eFJ9MeVz8a6dGq9XxW7kq1W
         GYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586411; x=1689178411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2E8I5KlscgLz/BhO77eZ+L4gqpBYzJDI1R3+cPj0I8s=;
        b=HCEjLvcaI9rywmJP4+zfunVOcrvw9p9/gvAqQVX3z2qCOihYVnibzem7nzjbtVofzw
         Xc06QqyLdLPPlEDJXbi7SsKYGkRcTB5x5PKKMeLA1NDBg+vGZC8E+Dm3k2jwnNH3LAvu
         FAnir/udt8/mbtypYG4iW3Z3YwKuKKPrGNKLgYNnAHPTbItSMjjnL1YlWQCagNXOKKoC
         Huz5c7cCVVoEdLAJk9gaskfeNa8mCdLy7s0aIVJMuJ9DBXSq00HUW5LSckpQni3PokZ8
         XQIzaiCKdbj0h9YeWh5DqafhMK6KVrY04tnimiCbLBBmlEkCf/Y8njnCJ6YOkSpQ2DDp
         MswQ==
X-Gm-Message-State: AC+VfDwAl1lWTapLHBk/EjTYZ5im+HNpX48A5Jbs0ZXPTRJP2KtQVDgA
        eRkwIi2V76SyB5YxOUyltxdQGNY5kFY=
X-Google-Smtp-Source: ACHHUZ6p6vY/8R1Kw0CwyLEo1ZKr8GIYnv5lol3y1h97CHTAydEPo3R/INzFScpRVkxHnkJG+Em7GQ==
X-Received: by 2002:a9d:6a09:0:b0:6ab:2fb1:92d8 with SMTP id g9-20020a9d6a09000000b006ab2fb192d8mr7845807otn.12.1686586411260;
        Mon, 12 Jun 2023 09:13:31 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id c8-20020a9d4808000000b006b296562566sm3996663otf.79.2023.06.12.09.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:13:30 -0700 (PDT)
Message-ID: <eac2d2bd-d9df-f463-8c33-af8e83d214d2@gmail.com>
Date:   Mon, 12 Jun 2023 12:10:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/3] rust: kernel: implement iterators for ScatterList
Content-Language: en-US
To:     Qingsong Chen <changxian.cqs@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org
References: <20230610104909.3202958-1-changxian.cqs@antgroup.com>
 <20230610104909.3202958-3-changxian.cqs@antgroup.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230610104909.3202958-3-changxian.cqs@antgroup.com>
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

On 6/10/23 07:49, Qingsong Chen wrote:
> ScatterList could be transmuted from raw pointers of a valid
> `sg_table`. Then we can use those iterators to access the
> following normal entries.
> 
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
