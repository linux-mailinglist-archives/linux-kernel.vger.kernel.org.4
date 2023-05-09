Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBFC6FCFA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjEIUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEIUjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:39:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC857A0;
        Tue,  9 May 2023 13:39:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so4201966f8f.1;
        Tue, 09 May 2023 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683664745; x=1686256745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzT2Qg7+gnTohAZR8U03MVTx3xSlsm1ApgjWGg/yeYo=;
        b=qEHme8UZ/79GsnJuDa+hJvF24q+bvoWHIe4OGGF/RwMW9NPnWhSgdEkLCrisNYrwSK
         l0uJTJinPPdpbhtmVhQjVmkw0PgCHRt9PN5HaJP3t2IAOAWBnXik99eannCuCrzVuROK
         8Us4Uc06vcWW0A+COknpeEnuXt0+VB+wYNKKbiHYfh2aKDXuhf+2be7QJm4pdSSCBi/3
         Wg1xP3tnF+tSHc4lrcgnjol8eIFkc5Q9Px/NCuyO3gwlsyLSL8E6LuDw4aQ4rG9nvF3I
         zvLIQyTIFhjV1trdennbTuLHVnl4SnT7m1E3OCf1ZdgUNW95ivsJj59u4rM6hVcpVGS/
         WyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683664745; x=1686256745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzT2Qg7+gnTohAZR8U03MVTx3xSlsm1ApgjWGg/yeYo=;
        b=jDGcDmSy6w5Jf7uH9mapaX95M4ixKxl1bH9TZkkHX39lsNip963WPXEZAXSC7SK/Mg
         2/tiAiUggjEP6CXNp171qV3pKVKBpGzil5/rH/GzzvStPZK2DyBajC4SBTeDxgf27+hA
         AOfHjQkJ0QmEF78fTjwJ8cd6XSKKdFmXD89XR2QAB7tA2fZnkfLE99Z631z9trh61kj8
         aeyibMfoE+4msQyrFDXc+354KalOo7lIr/WTsur3Ik7ilEsO9tU5f5YlEtGwvwNQaM7X
         aYiCyvS5W6zz1C/OL1NB4+WmObsuS8BawdzOAuH4Jzvi0x4X1Y890XjjW3/s4uVPwfwL
         o1zQ==
X-Gm-Message-State: AC+VfDyv0wY5oGFunjCSNHyPoqESfFJW98+isbrKx7weJkUaARcK1JbK
        8iMnoelXGajWpdCs1gDKh062h0cEB/hsWnOP
X-Google-Smtp-Source: ACHHUZ4f1RVMO5EGx6nj8UpK4sD07mMfYHSd70dWGenO9CfbdCN4EaaokO8sbgvaIfU3Sig06Q+S3Q==
X-Received: by 2002:adf:e48b:0:b0:2fb:7099:6070 with SMTP id i11-20020adfe48b000000b002fb70996070mr11889088wrm.47.1683664745349;
        Tue, 09 May 2023 13:39:05 -0700 (PDT)
Received: from [192.168.0.19] ([2.222.93.88])
        by smtp.gmail.com with ESMTPSA id a14-20020a5d53ce000000b0030732d6e104sm15234707wrw.105.2023.05.09.13.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:39:04 -0700 (PDT)
Message-ID: <e1fd41eb-71e9-f8d9-2607-363c88fd9ab3@gmail.com>
Date:   Tue, 9 May 2023 21:39:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] rust: lock: Reflow long documentation line
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     alice@ryhl.io, alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
References: <7f464c01-d4ec-d632-fa40-0c3f18c2ffca@ryhl.io>
 <20230507162739.17392-1-ben.gooding.dev@gmail.com>
 <CANiq72=0bbXtRpfYp+CT5tfwcsDi_A6_WV-23Bw44nD+Bbk9uA@mail.gmail.com>
From:   Ben Gooding <ben.gooding.dev@gmail.com>
In-Reply-To: <CANiq72=0bbXtRpfYp+CT5tfwcsDi_A6_WV-23Bw44nD+Bbk9uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Antivirus: AVG (VPS 230509-4, 9/5/2023), Outbound message
X-Antivirus-Status: Clean
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On 08/05/2023 21:37, Miguel Ojeda wrote:
> Hi Ben,
>
> On Sun, May 7, 2023 at 6:27 PM Ben Gooding <ben.gooding.dev@gmail.com> wrote:
>> Suggested-by: Alice Ryhl <alice@ryhl.io>
>> Signed-off-by: Ben Gooding <ben.gooding.dev@gmail.com>
> Thanks for the patch! Several notes:
>
>    - Missing commit message -- in general, please check your patches
> with `scripts/checkpatch.pl` and please read
> https://docs.kernel.org/process/submitting-patches.html.
>
>    - This patch goes on top of the previous one you sent but, in the
> kernel workflow, what you are expected to do is send a v2 of your
> patch series instead. You can use `-v2` in `git format-patch` for
> that.
>
>    - This patch is not just reflowing as the title implies, but it also
> changes the style of the link -- is there a reason for that? If yes,
> this should be explained.
>
> Cheers,
> Miguel

Thank you very much for your feedback, this is really helpful as I'm 
learning the process.

I've submitted a proper v2 of my patch based on your feedback which is 
hopefully much more like what you would expect - please let me know.

Many thanks,

Ben

