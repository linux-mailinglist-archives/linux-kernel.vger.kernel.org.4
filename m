Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC86F6C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjEDMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjEDMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:40:37 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA376194;
        Thu,  4 May 2023 05:40:35 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-549f0b45ac6so134745eaf.0;
        Thu, 04 May 2023 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683204034; x=1685796034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35PE1h4pn1H3d9SWO+8b0I5Y/uShSGFf9sil//g3S48=;
        b=HO2Mrqz66zmORlnliP7P/qqLTd7aBsXSFdRsEd9qam/1QTKL+5Id65vN4S/svCm6HN
         m/sycne3kjRoy0ScrIFGrqQ9yZWnVrhTBan7e2BBuxcbMzvOTNs6evdO4v8Vo13l55yp
         FTVtKuNsUCvRJnzEO3IlicLkpcaIwe72FlKVTKDf8K/m4RmVC2te5AXXGjA4xQFeqCud
         TVNUf6KFcWQ9lQ73h2ZGriwNXQOTVAT4VXU5jnXRirUldThOvLuVzUu/CQXkUuYRCG3U
         vQtGHcoZw0VfILZjwBt1J3sf8/ZBYK3nyc/Fps6iX1X6V3pWQkPiRyejNlzZhTwdD8le
         KLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683204034; x=1685796034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35PE1h4pn1H3d9SWO+8b0I5Y/uShSGFf9sil//g3S48=;
        b=L7b7qJm1Ym1MTP6S6qOlDyKShn94zkOYLDcUoQwR/qp+3WyP+K+7gikqXjOccz0pN+
         afN6V04ZqPdHT1xpwq9AO4cs0Z4PZ30jTo1CaVM11CdhyB7GrZaAg11hwwjzOLl1MQzo
         nRamRMdOXRQHBqWZ0pfoEQEeETrHbk34IX82bD6mQH9ZzH9wNgiHsbugJHfrLfJZ3YkJ
         AXnWyUuQdqShx1aBeLeFojLiFT4kGA9hUA6V1+lXA4PlHvar4/LO/2nEDytpLqS8DIUp
         ow7KD8BjWZZ1QhBuTzP7EjDFwbwO+8Y34EZTwH8LhaO5KJtE2Ee2Z5wl5BanaaXTsf+/
         33hQ==
X-Gm-Message-State: AC+VfDyv95e2lAEsgmGuF5QFhBsuRyLnFlxsrrXBAD5odKR6rYWezUVs
        YngcLjjyB1OgAeXTi9mLNEo=
X-Google-Smtp-Source: ACHHUZ4r0+KY1d0rd8nU9V16WDWrIjDjYajmTUEyv85OdpnQF4ASPMu/ZnHHR+GkxdcEAnHXGOoioA==
X-Received: by 2002:a05:6808:23c1:b0:389:4c8c:d069 with SMTP id bq1-20020a05680823c100b003894c8cd069mr1589556oib.57.1683204034303;
        Thu, 04 May 2023 05:40:34 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id k12-20020a05680808cc00b0038dd5bf922bsm1540620oij.22.2023.05.04.05.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:40:33 -0700 (PDT)
Message-ID: <bc2cbdf3-16fc-7b16-375c-a753afff42cb@gmail.com>
Date:   Thu, 4 May 2023 09:40:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] rust: error: add missing error codes
To:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230504064854.774820-1-aliceryhl@google.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230504064854.774820-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 03:48, Alice Ryhl wrote:
> This adds the error codes from `include/linux/errno.h` to the list of
> Rust error constants. These errors were not included originally, because
> they are not supposed to be visible from userspace. However, they are
> still a perfectly valid error to use when writing a kernel driver. For
> example, you might want to return ERESTARTSYS if you receive a signal
> during a call to `schedule`.
> 
> This patch inserts an annotation to skip rustfmt on the list of error
> codes. Without it, three of the error codes are split over several
> lines, which looks terribly inconsistent.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>   rust/kernel/error.rs | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
