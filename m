Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF47720A8B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbjFBUrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbjFBUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:47:35 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC15E43;
        Fri,  2 Jun 2023 13:47:33 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-19f454bd2c8so2775472fac.3;
        Fri, 02 Jun 2023 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685738852; x=1688330852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+c2BilUm/fvWdview7xXjg65zJu3iciUS3T9hzkbg0=;
        b=ASgnE86cFIMmWdXg0AtjqI3pw3YI6ieAqyhG0TS+KK4uMBet1oYMYV6h9cQcPAaBpR
         8T1kMjPn/8suVGegK8JokDLXeoxm6aE76OdWOHkn3E6P3y4ylsjmfZ+p83Bm0IhTH/XJ
         e8z1LcIr2wEU+Vt8Q1xSKO/xjaGa8SljW6z90eg6VDMaJPvvLKwuOpriS5jWJ1cgvKwQ
         W0/MRf3HE7qhek/4uWPiqpQCyIzMrOMfW73besimU60VyJnkftR5Qlr1JDhlqgDdkD0Z
         P92SmT1hbx4q4OOG4w8hJzrHg/wzF3FWIhDplQOBTGMHl1UmKF4WvG2oa3DOZxfH/b2/
         VQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685738852; x=1688330852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+c2BilUm/fvWdview7xXjg65zJu3iciUS3T9hzkbg0=;
        b=Sc+Q9Ib8GQl2saCQMr1M7sgn4fffXpBWBUXvpaL8XsA+Xn8OBVFzLlmC860lGDaYcZ
         dTVB0jISxh3Xu02Bu/rI89R/My24mTD6kP0p6AnwHlXF6uePy24kWUuzeJm0HoZwUoip
         AObKZomEYnGwW9Rl9+eCn4yjmV+5XOv0km2UJFUhMawl6zx7/sfPik68kclpAX5Tk6Pk
         Sl+ktd2qG2yMv/2Wjfva0uuh9r0h89oW7odGJblToB70cO+57rFKQV7Mm7Q4yYgykXnk
         G9EXCbBE7xGnvAodiLupK7yYJa+ce36WGExl9Vnr1EMfPK/HcOFUZKJcxC0fRHj0/2z/
         H0OQ==
X-Gm-Message-State: AC+VfDyXv/UufcX3mOdioGFD3E49R2/T2EPTmnsrmNPHXXCCVqnPxs0o
        MQ47t9KyIdS46VDzHFCZZYaanoZ22fg=
X-Google-Smtp-Source: ACHHUZ6AKO4H4ka7VuZByjFB71vAva0g7j+L6gasLyAf8EMFMc0uQV2A64T9j2vaXYK57VEwdl+gGg==
X-Received: by 2002:a05:6871:6a82:b0:1a0:2fd1:8b1a with SMTP id zf2-20020a0568716a8200b001a02fd18b1amr3066802oab.14.1685738851948;
        Fri, 02 Jun 2023 13:47:31 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id ee16-20020a056870c81000b0019e59515a0bsm1015557oab.33.2023.06.02.13.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 13:47:31 -0700 (PDT)
Message-ID: <b792c9d8-3250-4dd6-19ba-06bb7cb9bc51@gmail.com>
Date:   Fri, 2 Jun 2023 16:59:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/3] rust: kernel: implement iterators for ScatterList
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
References: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
 <20230602101819.2134194-3-changxian.cqs@antgroup.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230602101819.2134194-3-changxian.cqs@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 07:18, Qingsong Chen wrote:
> ScatterList could be transmuted from raw pointers of a valid
> `sg_table`. Then we can use those iterators to access the
> following normal entries.
> 
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
> [...]
> +    /// Get an iterator for immutable references.
> +    pub fn iter(&self) -> Iter<'_> {
> +        Iter(ScatterList::as_ref(self.opaque.get()))
> +    }
> +
> +    /// Get an iterator for mutable references.
> +    pub fn iter_mut(&mut self) -> IterMut<'_> {
> +        IterMut(ScatterList::as_mut(self.opaque.get()))
> +    }

Per the previous commit, because both methods are unsafe you should put
the `SAFETY` comment on them.

> +}
> +
> [...]
