Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B890073E03F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjFZNLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjFZNLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:11:48 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026D125;
        Mon, 26 Jun 2023 06:11:45 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1aa32d08f7bso2736553fac.1;
        Mon, 26 Jun 2023 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687785104; x=1690377104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GStg2GtkdOaT4hAtzhyiCQGhzyZSRaJuQj99Ahe45uU=;
        b=MJwBHnG/8c2OF9nxlktWJODDGkmebHuAY89PEHujeEklkDdxYsbc7xbOkBozdO8Tna
         p+q6knuq6O/WUxeYOGVL8pRx9sE5KICZH5EU9iVYsaQxOd87y+/3yRm8Dgn02tMIxfzu
         KHP+6X0pHZfZTr362MWBhO/iVCBDu4fgaRn2C1DiikYZOde3xEDus4/y6agXoa0ZMprC
         gBQuCprSMFxNhc35LBltx+AJQNipFeX45DEVAAqUIiyicPvnzUWdd2ORi0nhs3TSW1vb
         Q5CHcHDq/Cs96q/SugweI+caqvkvgcf7FTkUY72TZd3Fv7O0FlA/HHYe+HJVb2AGUNzW
         J7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687785104; x=1690377104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GStg2GtkdOaT4hAtzhyiCQGhzyZSRaJuQj99Ahe45uU=;
        b=M8u+B8XbKSv0wzahhdnA7i4AfNKo8SPqKdGofkXV2pVcEzH61VuX+VhceELmV8vAbi
         gTM7XEZ/pSSmELbNeeGkDZSNEeG15q0/npr8DTWWj561y2ewx8k/KLBeXm2RgfkdvOOr
         dCI36+5+D4Gh0X6uViRXNA2/xBD0FCn8ADKjO+RL6tmqZcvEctKwYrKIkOE32QLj7FPZ
         kHmyoRoh1xx1cHp506iljt+MRBkxp/S9YZgx/AapO/d1x4+2c8X60frxI6d7H/Ydwrcm
         LDd1dJU5yUzlJjYYTpFnqfO+N39mh9NPVbG2d84Y5WY/n6hbtB+GCnl4DsfpmcD9G2cM
         YGqw==
X-Gm-Message-State: AC+VfDx5vGpvdnSRUUS/6NFMiGalXpxLi4NGHIYWIWhiCdC9a7X7P2Yr
        N2uQwyqgzCY9lXUz4YolYOo=
X-Google-Smtp-Source: ACHHUZ7lPa1QhQLG0tY32m7EgvUcArsqi1nc6B9WTGf0egKpzSlEMB9nww5Irj0XMmF5bPdl38IUWg==
X-Received: by 2002:a05:6870:5b04:b0:1b0:a99:b4ae with SMTP id ds4-20020a0568705b0400b001b00a99b4aemr4324762oab.31.1687785104345;
        Mon, 26 Jun 2023 06:11:44 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y8-20020a4ae708000000b0056360466d3esm321096oou.48.2023.06.26.06.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:11:43 -0700 (PDT)
Message-ID: <b6a3bb29-ea6f-cdec-3f0f-4db51f385ec8@gmail.com>
Date:   Mon, 26 Jun 2023 10:11:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] rust: alloc: Add realloc and alloc_zeroed to the
 GlobalAlloc impl
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>
References: <20230625232528.89306-1-boqun.feng@gmail.com>
 <a79002ec-aa2d-1eec-58be-372c3b2a0efa@gmail.com>
 <CANiq72kVUv4djvhLxz5tRYn-U2kXZMs0N1M=CZxdznnN0jY47Q@mail.gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CANiq72kVUv4djvhLxz5tRYn-U2kXZMs0N1M=CZxdznnN0jY47Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 06:40, Miguel Ojeda wrote:
> On Mon, Jun 26, 2023 at 5:34 AM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
>>
>> I think that this should go above Link and Signed-off-bys, although I'm
>> not sure if maintainers do it when is merged.
> 
> Both styles are used, it is fine either way. Personally, I pick one or
> the other depending on the kind of comment.
> 
> Having said that, there seems to be a missing `From:`, but I can fix
> that on my side if Björn is the intended author.
> 
>> Newbie question, aren't tabs in the commit message verboten?
> 
> I am not aware of such a rule, and there are commits in the kernel
> with tabs, e.g. commit 9828ed3f695a ("module: error out early on
> concurrent load of the same module file").
> 
> In any case, that text doesn't go into the commit message, because it
> is after the `---` line.
> 
> Cheers,
> Miguel

Alrighty, both make sense to me, thanks for the explanations!

-> Martin
