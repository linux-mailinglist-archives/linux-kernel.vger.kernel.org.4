Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89C71619E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjE3NXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjE3NXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:23:21 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43A411B;
        Tue, 30 May 2023 06:23:14 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-19edebe85adso3897242fac.2;
        Tue, 30 May 2023 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685452994; x=1688044994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMNSQewRslTTM3ryH1hSW9tsjlBjJbSYLIcYAPdfTm8=;
        b=Ngm/jZ0C5Q+NbA+yGe/TmaSY8mt/WOmGrqzXtYoxvTUU8NZfrDFO1HwI5IJQdbHqhn
         lowU4zLein+etGYsdpQWXsifP9hlwMeeiXGXNsZPi8ovnJnuWGrl9ijUEFHorVUdJRR5
         h5uwfkdwJwNHKYMQCM+SpHKySNsDNYUTC8Q0N91QuO9nKOrQlOmSk1kGXWzVX2H2/zOW
         Mlpb8jnAIU2omz2E5NZKtYPDuAg8DbznalgJHV7ZHSMpLSJKXe1ccuhDZdcWrN1oD6nv
         Yv7viv/NWEsYhqqm+NMlDD0xFZBhnuNBXieb1kf+PmsFhzKmdpU1zrOdJQxl4xjcPuzq
         9X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452994; x=1688044994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMNSQewRslTTM3ryH1hSW9tsjlBjJbSYLIcYAPdfTm8=;
        b=BJfKp2Mwe35KmW7JPjrOTcwBaOQFvoEJv++bIXfDp/L5tr5+wl1xuPxWmT0s+RRNjh
         q/XXWZycJ2POkV8HJCIsNIbXBv95COqyVqGxANwq0H3dWdiXl+33gFAHKsfCRs6QMZW0
         +SNIUt3k/YnbV3xWjrmxCFbxeR/56loelE1hW/X2LlqSNX/rltQqi/txGmQKKiuf92hg
         8DF0XF8jqoypUXqbfrg9M+eqKOmB+JawhZj9B5QpTD/ZeegM+uTpVzoSTF9ehINA/CKk
         o6/neWkyMDm0wnvZJYjFOGj634R5QCW2AlmOXNe35YZ8bJI0FF/LaSlXUEVTpS+3u0we
         oURQ==
X-Gm-Message-State: AC+VfDxg8X/kxFGEkPcB3U+c+SPr0f22JypN2sSVSH1DdKkB3Cdw0Ank
        6DWJ97YgyRkL76XLP0du5uE=
X-Google-Smtp-Source: ACHHUZ5fJ5/CZJU+0D+6o27bvrgi4iHhxfbFd9EVzO8mHxFNv8cO6H+JuweFU8OBq7zmgNQqBVYwmA==
X-Received: by 2002:a05:6870:3c11:b0:19f:9dc5:c0b with SMTP id gk17-20020a0568703c1100b0019f9dc50c0bmr705762oab.12.1685452993776;
        Tue, 30 May 2023 06:23:13 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id g7-20020a056870214700b0019edd086f33sm5692768oae.41.2023.05.30.06.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:23:13 -0700 (PDT)
Message-ID: <08508ddf-fda7-0a19-a8ce-b65c0e9a7903@gmail.com>
Date:   Tue, 30 May 2023 10:23:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 6/7] rust: workqueue: add safe API to workqueue
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>,
        Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
References: <b54801cd-1afb-2190-3b8a-4a095d04fdff@gmail.com>
 <20230523110709.4077557-1-aliceryhl@google.com> <875y8ab7y0.fsf@metaspace.dk>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <875y8ab7y0.fsf@metaspace.dk>
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

On 5/30/23 04:19, Andreas Hindborg wrote:> I prefer the first one, but both look OK to me. Is one more idiomatic
> than the other, or is it just a matter of personal preference?

Pedantic Clippy will deny a boolean match and I prefer if-else over it
because the latter it's explicitly purposed for boolean control flow.
