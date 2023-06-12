Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A78472CB34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFLQOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjFLQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:13:53 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F17810FA;
        Mon, 12 Jun 2023 09:13:38 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-39c77cf32deso2332041b6e.0;
        Mon, 12 Jun 2023 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686586417; x=1689178417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKBNzSXY/vY0cFqpkWRcs+uoflex4mBM8ViuJygh9Vo=;
        b=Vxmq5LyWTCuhpzcmPi4pJ/6ZG13mKk3z+M+96jA1X28BZs9w7uuSHouC2DRMaIVZTB
         svlA0gF6dX/rIe/E6Mnh9UzmNOcXqMHqmg68hTz2njlCNwe4mHZ7lWJmINlK70xQ2AfO
         eMmwhbPFPhumPmHvYbIihw0OzWjhF9ZPU4BVUHuGjVxVEcWH5t2etdXaTF+zMVck+k6d
         ODH42T1/mZK1r8WpiE7JL1HVdHcLMkKKHZgQifkAwZV4woZBh+jSSY0mA+PCVG/+Yl/I
         +/7YJD7joEfMRWz2pHoZMYh1wmhYgyLAgU97DUHNDT6TQcnlk/AV0FxjEpn8NtARBn3g
         Mcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586417; x=1689178417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKBNzSXY/vY0cFqpkWRcs+uoflex4mBM8ViuJygh9Vo=;
        b=bMNsC2FKMOHg6Mv1oIimfyRzN986h46tDStRNI5tEZR788emrM+mq4FV32xN8/429d
         p3tJlwvaecIbhviESXouQ7w8WBf9v0hhYzDGkbC5jel7PWB7hLDlF6BWe94YpqMihR3a
         wlTsVRPHE62VBleBuV08/wsXbp+DmTp+bKl0SEYMBeVBp3eYDKkQHbMDQTcd+oCrzpVg
         smZZ/6dlWg8Twc8OdvcPHPqR65LVcjKkbzOa+XbDmphN+ulaL/6Xeigtl/SSl5dxczXc
         7XsS8iR71m2ozyHkbWXiylOzm8M9SQmSExhgh+mkcoF6Uiql7AUftSTiLw6VHyNyUkNt
         o/Kg==
X-Gm-Message-State: AC+VfDwKV00WLIdeUOXFBB8kTT460DMEkv/bWeEW96nO7aKJzpWBxbWp
        p7/uOhnmsxJ/pCv8dUXfEeA=
X-Google-Smtp-Source: ACHHUZ4MNVc0Omd5f3maGhNTkxOOLilw9uJb9UlOzkqZO7T6Sib/3GdMmHHOLS+VWqB3W9e4McAIcA==
X-Received: by 2002:aca:f255:0:b0:39c:7d50:ab86 with SMTP id q82-20020acaf255000000b0039c7d50ab86mr3364178oih.29.1686586417256;
        Mon, 12 Jun 2023 09:13:37 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q82-20020acaf255000000b003982a8a1e3fsm4335874oih.51.2023.06.12.09.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:13:36 -0700 (PDT)
Message-ID: <11fe7426-1d7b-78ff-f848-33ce6d7d3747@gmail.com>
Date:   Mon, 12 Jun 2023 13:13:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] rust: kernel: add SgTable abstraction
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
 <20230610104909.3202958-4-changxian.cqs@antgroup.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230610104909.3202958-4-changxian.cqs@antgroup.com>
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
> SgTable is similar to `struct sg_table`, consisted of
> scatterlist entries, and could be chained with each other.
> 
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
> [...]
> +impl<'a, const N: usize> SgTable<'a, N> {
> +    /// Construct a new initializer.
> +    ///
> +    /// # Errors
> +    ///
> +    /// The length of `entries` should exactly be the available size of [`SgTable<N>`],
> +    /// or else an error is returned.
> +    ///
> +    /// If the table is `chainable`, the available size is `N - 1`, because one entry
> +    /// should be reserved for chaining.
> +    pub fn new(
> +        entries: &'a [Pin<&mut [u8]>],
> +        chainable: bool,
> +    ) -> impl PinInit<SgTable<'a, N>, Error> {
> +        build_assert!(N > 0);
> +        // SAFETY: `slot` is valid while the closure is called, the `entries` are
> +        // pinned and valid.
> +        unsafe {
> +            init::pin_init_from_closure(move |slot: *mut Self| {
> +                let mut nr_entry = N;
> +                if chainable {
> +                    nr_entry -= 1;
> +                }
> +                if nr_entry == 0 || entries.len() != nr_entry {
> +                    return Err(EINVAL);
> +                }
> +
> +                for i in 0..nr_entry {
> +                    // `slot` contains uninit memory, avoid creating a reference.
> +                    let opaque = addr_of!((*slot).entries[i].opaque);
> +                    let sgl = Opaque::raw_get(opaque);
> +
> +                    bindings::sg_set_buf(sgl, entries[i].as_ptr() as _, entries[i].len() as _);
> +                    if i + 1 == nr_entry {
> +                        (*sgl).page_link |= bindings::SG_END as u64;
> +                        (*sgl).page_link &= !(bindings::SG_CHAIN as u64);
> +                    }
> +                }
> +                Ok(())
> +            })
> +        }
> +    }
> +
> +    /// Chain two [`SgTable`] together.
> +    ///
> +    /// Transfer the last entry of this table as a chainable pointer to the
> +    /// first entry of `sgt` SgTable.
> +    ///
> +    /// # Errors
> +    ///
> +    /// Return an error if this table is not chainable or has been chained.
> +    pub fn chain_sgt<const M: usize>(&mut self, sgt: Pin<&mut SgTable<'_, M>>) -> Result {
> +        if self.count() != N - 1 {
> +            return Err(EINVAL);
> +        }
> +        self.entries[N - 2].unmark_end();
> +
> +        // SAFETY: `sgt.entries` are initialized by the `new` constructor,
> +        // so it's valid.
> +        let next = unsafe { ScatterList::as_mut(sgt.entries[0].opaque.get()).unwrap() };
> +        self.entries[N - 1].chain_sgl(next);
> +        Ok(())
> +    }
> +
> +    /// Chain [`SgTable`] and [`ScatterList`] together.
> +    ///
> +    /// Transfer the last entry of this table as a chainable pointer to `sgl`
> +    /// scatterlist.
> +    ///
> +    /// # Errors
> +    ///
> +    /// Return an error if this table is not chainable or has been chained.
> +    pub fn chain_sgl(&mut self, sgl: Pin<&mut ScatterList<'_>>) -> Result {
> +        if self.count() != N - 1 {
> +            return Err(EINVAL);
> +        }
> +        self.entries[N - 2].unmark_end();
> +        self.entries[N - 1].chain_sgl(sgl);
> +        Ok(())
> +    }
> +
> +    /// Split the first table from chained scatterlist.
> +    ///
> +    /// # Errors
> +    ///
> +    /// Return an error if this table is not chainable or has not been chained.
> +    pub fn split(&mut self) -> Result {
> +        if !self.entries[N - 1].is_chain() {
> +            return Err(EINVAL);
> +        }
> +        self.entries[N - 2].mark_end();
> +        Ok(())
> +    }
> +
> [...]
> +}

I'd suggest being more explicit in the `# Errors` section by
mentioning that `EINVAL` is returned, but do as you prefer.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
