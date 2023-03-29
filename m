Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687136CF1FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjC2SQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjC2SQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:16:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E5649D5;
        Wed, 29 Mar 2023 11:16:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r40-20020a05683044a800b006a14270bc7eso5339623otv.6;
        Wed, 29 Mar 2023 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680113795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=somFh1uhW0pZ9Km2n8zQjRO2r+wUA8O/Rj4+D8ShWV0=;
        b=HIhTQSyU7RjD/NNa0Sgd3HMaFspLoot1hSfelzXW3lLXeb+gghjEUS9R7gtM+cx+C0
         cPMUc4+8CAR8JrrtRkh4v2Czk5DS3a9qdb8spGAhvqBrQULEPgAQ0gWTnExC1/+nybxt
         snjL11AAbXxFxf5Z1RsIO8FLmnQYcyXQr5wib8KJDiLbZJGZDvATIl9CbmGlP4q6vFtL
         aoBD8Ubz8NGFMYsNJAhGnvpKFR/E43cuCMbSGJCyXJxkIrMA8EIYVxj5vx/S+52GEPaG
         yDtR+kS+9CiGeD1lxudgIcaiTZS6Y2XLh+VWyWnik3jHjwFJeKmQ3ZsxPGLdclICqsq7
         ckUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=somFh1uhW0pZ9Km2n8zQjRO2r+wUA8O/Rj4+D8ShWV0=;
        b=RIKdCSctl7nOYcRMZeb4vHVvQAY6TCuIbnto36oBKQn5AAwkQHEPQk2gJq62smksAe
         3CzZu5Wp2a6rZwrJ74YsYF8k6iMryJ9ma87jj1GP4fLIKIfNXg7LVS8GuP6g03ji/TXN
         FvB6eooCjbOMfxrp2tnkpAPtNX0S82psfE+TuITbR4rZTUI5Owe7DDWvB1CeIi+klWD3
         iV4EGt6wt4Yu4Nuo1JdNaH3FSRQ62wp+rmPDR3YTYqA+ACLaB+5cp7QzsRH8sVcqNX6J
         h77zzSWST5f70v/XsHG8c9wejfI9iDKHOwCTGjX0WszggId5TMO2x/6CnFv7Po4zElBx
         8mhg==
X-Gm-Message-State: AAQBX9dTdRjmQiNYDE5SOagQm4AH2jPIsF4FMc3PYiwwjYwji6lsdL9I
        GZRL+47oFSVS3DXOlfCs0v0=
X-Google-Smtp-Source: AK7set9t1ky4C84DCB0Oa9W5iSm8eMk1sho1/wGcP0jut+StvjNl5/Wwed9jFJUtSLvjILKMX92JiQ==
X-Received: by 2002:a9d:7e96:0:b0:69d:d4f4:733d with SMTP id m22-20020a9d7e96000000b0069dd4f4733dmr9367901otp.4.1680113795235;
        Wed, 29 Mar 2023 11:16:35 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id a12-20020a056830008c00b006a11de6cd02sm5663072oto.34.2023.03.29.11.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 11:16:34 -0700 (PDT)
Message-ID: <2a10a97f-70ba-5216-a527-067deda6a94e@gmail.com>
Date:   Wed, 29 Mar 2023 15:16:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/6] rust: error: Rename to_kernel_errno() ->
 to_errno()
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
 <20230224-rust-error-v2-1-3900319812da@asahilina.net>
 <0849f870-2d95-8c3a-c7dc-2b18dcee4c65@gmail.com>
 <CANiq72ko9tY4dsK9Srte2oYQp8G=PMyLDTOR33-yNTVXmfyzeA@mail.gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CANiq72ko9tY4dsK9Srte2oYQp8G=PMyLDTOR33-yNTVXmfyzeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 12:04, Miguel Ojeda wrote:
> On Wed, Mar 29, 2023 at 4:47 PM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
>>
>> Reviewed-by: Martin Rodriguez Reboredo
> 
> These (in the different patches) are supposed to have
> <yakoyoku@gmail.com> email when I take them, right? (no need to resend
> them)
> 
> Cheers,
> Miguel

Ah, yes, they were supposed to have my email with it. I wasn't that
livened up when I sent them.

Thanks
-> Martin
