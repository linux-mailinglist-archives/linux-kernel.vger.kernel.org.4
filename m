Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42156720A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjFBUro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjFBUrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:47:40 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E071A6;
        Fri,  2 Jun 2023 13:47:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6af7fef214cso1862274a34.0;
        Fri, 02 Jun 2023 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685738857; x=1688330857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vlvu5fxlbt+iK8+GfOik6qbjxaFq2sKQgl1pUCSXh2E=;
        b=WzgM3nHXxtNPwCNtzK69FQhIWYGssM6qd3qNwClz+Rkb6IBV7AnTM/2LFCvcsPFdp3
         p75Ri8F99hCQhdwr+DR2QS7JyY4Dhnml8+6XhSvjRED6TEe2Ic+qBEJY7Fjp6dg2oN9W
         JHrIA3efNet7edorjdT38f9XbrgxAnnRp/YIz/kMARm1ZZd43VisTon2xRicgjR2fsNl
         07OAhJHY93m2PjbNJRFMI56S7776NogNvWFyAqty/jbsNR4ZKvu5ptrFUhwJ16qPwP78
         kJRoKHjd6Dr0Rz0onYq9J/nmt/zZWr7GLDOD0tYe5MguIgHHFLNbGdD3KuLnyTV9wuiY
         S6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685738857; x=1688330857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlvu5fxlbt+iK8+GfOik6qbjxaFq2sKQgl1pUCSXh2E=;
        b=U5TMwaHd69tlU0Bk7iHSCT+LdQ8vnzZopZXyvLCHA8y1YywH/15jIkgMK1FueSz+E1
         rqdFUPFzSBYCWScH6rVQT4kftKCOtAfXnIubL4VrMtb3/NKDjuKTQu2SHNaMtbqcd1xJ
         FyqGiWnyI2niNVL5flzrCyEUTyMXnTOkZvfP37U4jd//OqouImWOLZxiiTJgRjcyA7VD
         iUuKMCXivDBXLjoxtV8Hta/dVE2BnT0b0AKMGq1JNiiKUIGFNq+yWKUYvUsJ9hzdtNHT
         4sL7yy/hqWbzVfTD5iHnN53r/M4XH0QSfA+/qIWW0aNxtXMmBKsVNlF4vkV5W9i2xhJm
         ZIOg==
X-Gm-Message-State: AC+VfDw2SI0wMeJlfCJvNTBoMwqtmmctmztChFZo5akGeoV0Z6+i84u8
        jewIGG91ECMXVMU+CPZ0W9Y=
X-Google-Smtp-Source: ACHHUZ4LB9y2ElfxLIF93sRG8ot+NvDvmknCSJWkMJBBvTQNSr4b0tdhDgKaW1GmKwaYYTjFNPasPw==
X-Received: by 2002:a9d:798b:0:b0:6b0:37ea:d444 with SMTP id h11-20020a9d798b000000b006b037ead444mr1965522otm.11.1685738856726;
        Fri, 02 Jun 2023 13:47:36 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id s4-20020a056830148400b006ab26c69534sm1011419otq.23.2023.06.02.13.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 13:47:36 -0700 (PDT)
Message-ID: <a3a2c04b-16d9-ec77-c127-50f2036221b4@gmail.com>
Date:   Fri, 2 Jun 2023 17:47:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] rust: kernel: add SgTable abstraction
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
 <20230602101819.2134194-4-changxian.cqs@antgroup.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230602101819.2134194-4-changxian.cqs@antgroup.com>
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

On 6/2/23 07:18, Qingsong Chen wrote:
> SgTable is similar to `struct sg_table`, consisted of
> scatterlist entries, and could be chained with each other.
> 
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
> [...]
> +
> +impl<'a, const N: usize> SgTable<'a, N> {
> [...]
> +
> +    /// Chain two [`SgTable`] together.
> +    ///
> +    /// Transfer the last entry of this table as a chainable pointer to the
> +    /// first entry of `sgt` SgTable.
> +    pub fn chain_sgt<const M: usize>(&mut self, sgt: Pin<&mut SgTable<'_, M>>) -> Result {
> +        if self.count() != N - 1 {
> +            return Err(EINVAL);
> +        }
> +        self.entries[N - 2].unmark_end();
> +
> +        let next = ScatterList::as_mut(sgt.entries[0].opaque.get()).ok_or(EINVAL)?;
> +        self.entries[N - 1].chain_sgl(next);
> +        Ok(())
> +    }
> +
> +    /// Chain [`SgTable`] and [`ScatterList`] together.
> +    ///
> +    /// Transfer the last entry of this table as a chainable pointer to `sgl`
> +    /// scatterlist.
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
> +    pub fn split(&mut self) -> Result {
> +        if !self.entries[N - 1].is_chain() {
> +            return Err(EINVAL);
> +        }
> +        self.entries[N - 2].mark_end();
> +        Ok(())
> +    }

To these methods I'd suggest adding an `# Errors` section in the doc
comment to explain why would you get an `EINVAL`.

> +
> [...]
> +
> +    /// Get an iterator for immutable entries.
> +    pub fn iter(&self) -> Iter<'_> {
> +        Iter(ScatterList::as_ref(self.entries[0].opaque.get()))
> +    }
> +
> +    /// Get an iterator for mutable entries.
> +    pub fn iter_mut(&mut self) -> IterMut<'_> {
> +        IterMut(ScatterList::as_mut(self.entries[0].opaque.get()))
> +    }

Same as the previous commit, the `SAFETY` comment.

> +}
