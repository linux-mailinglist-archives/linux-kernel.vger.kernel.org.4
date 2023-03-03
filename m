Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FDE6A8DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCCAHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCCAHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:07:38 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E8F58493;
        Thu,  2 Mar 2023 16:07:37 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bh20so570356oib.9;
        Thu, 02 Mar 2023 16:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677802057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ook5Ec9qfFVjwleUXj/LqDwssTSlYFmJKpBefHfpo38=;
        b=GpkWlWwxGnbF1UiRrzzPA8PYfWq2Gvug/QEwfDNE95HaMrLGmvhWoGfn4+L8LH245n
         yPCEhcEZoLHGlk+K8qscLb+lhB7Tgd+uiw3sXeb01vJ99JxTTR6CbqkJi3bF0TJ6kBx1
         XhTvB0LCofq6bAHoYKOFDwEPsklr65TObJKdFpn/IwYJGXrKmpeoyatQ6O1yJhWQAhbn
         9Bn0u9Xi4JTbosst6trYJeg0o68Uj/kbmnVtMpfvg1M6nBP2wy8Qc2h2SLPBIpExveIY
         ndWUBqcDCSeF4kvYWc2YbdX4w8dmLGOnZJyyqZy+6Pr0Vp5gWKOj/4TBVjuEiI/qzbvC
         vr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677802057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ook5Ec9qfFVjwleUXj/LqDwssTSlYFmJKpBefHfpo38=;
        b=1r5SqHb3NIV1b42hZWxR7bwZhOUBt0DUZ6ouIOLqJpo2uzk7eHpO1H58HpQ9Zl/Q9E
         JHjUcUrQXPSaPssocXtA3RBzDmgkzeu6qQvPTC4wqWp4exKuf4b50wi/dGN7ftnUcjoq
         0qjFNQSWMqct6BSZTmHI2YXJdlV8p8AXgRWLGWn3sP8D2IQkcBmXOrDp+h0u3ROWCcpr
         VctdCTYXT+Fmadh9fOoaqhdubOq8ovi+y2zmxKeUG7wDnbLpTk5OdFfb3D51iaqgYgRW
         MSf/jh5nvHWafFLo2gTPPPJe5dUfCI7NzYWPwl5JHhuNto0OFDe7+xhnFt0FVm6yfl/t
         +vmQ==
X-Gm-Message-State: AO0yUKXZgZcphkn5jpuI73ysTN7UsWdaFef5VaUg+MlAxGanO+XFDWGf
        EGqpS8TWHICShaK5l6qD4uY=
X-Google-Smtp-Source: AK7set9EW2DKpCm4ea/1PhXxoDawI1xVRRIW889jClCCAKllx++mjYNbCzJqfW87Ft9RQlNWV3qdug==
X-Received: by 2002:a54:4783:0:b0:37f:8682:937b with SMTP id o3-20020a544783000000b0037f8682937bmr5734187oic.13.1677802056863;
        Thu, 02 Mar 2023 16:07:36 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id i67-20020acaea46000000b00383e0c1f6cdsm276360oih.27.2023.03.02.16.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 16:07:36 -0800 (PST)
Message-ID: <f7c32e01-3205-0d57-2223-58ca7b3e731f@gmail.com>
Date:   Thu, 2 Mar 2023 21:07:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] rust: bindgen: Add `alt_instr` as opaque type
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Derek Barbosa <debarbos@redhat.com>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZACvxNOuuyifQ9Nx@kernel.org>
 <37578649-c696-f3b5-a216-196e210929e5@gmail.com>
 <CANiq72=nvg3cU61zRYXxLUKvEib1qezRHGZSC=7sGah8aDH-dw@mail.gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CANiq72=nvg3cU61zRYXxLUKvEib1qezRHGZSC=7sGah8aDH-dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/23 18:02, Miguel Ojeda wrote:
> On Thu, Mar 2, 2023 at 3:59 PM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
>>
>> Still, we have to be careful if these kind of things appear in
>> the future.
> 
> Not entirely sure what you mean -- do you mean if some Rust
> abstractions used its fields? But if we were in that case, it would
> not compile, so we would notice. Or what do you mean?
> 

I've meant a general case with any abstraction, but that would be
noticed right away.

>> And I notice that You haven't mentioned the version of Bindgen that
>> You've used, including its linked libclang too. Otherwise I think this
>> could be accepted.
> 
> I could reproduce this with the expected versions. Since, for now,
> those are the only ones supported and the build system emits a warning
> otherwise, I think it is fair to assume those versions were used
> unless otherwise stated.
> 
> Cheers,
> Miguel

Sounds fair.
