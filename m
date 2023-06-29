Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA71742AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjF2Qdr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 12:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjF2Qdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:33:45 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698BA30EC;
        Thu, 29 Jun 2023 09:33:43 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-56ff9cc91b4so8633227b3.0;
        Thu, 29 Jun 2023 09:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056422; x=1690648422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxwLFy9k5SNI8Gdm+Tnj9m12doV32P23RU600L8QjFM=;
        b=gVznQFVknbOmCARjquBMr1OT8KRbF3We6ulGs2cNxw9OXyWZX+5FKs+Zxv3Ub2g+ma
         bcC85fsWSk0LRs8MsO3L14u8XtipkU8DCKCmJeiPRys3fcEq7TgKinQEHKTxi8Qh/F4O
         vm/0nykSctWTlbCze73VxO9nXcgVW2fyouE8iUX8nxFIB1S78xrrAziKSv4PeWfTIKVO
         396/gpFmiCFxGTs0aSSeOCYfMh5Qs26N9sBhRvf+4Q5+wyNveLI7JZVR1cgtlDs8H2Dc
         E0MWz8DzhhLtHAsI6PolGQamHHhRlBauxk3ZQrrmBFe1ky5xXVJHHjMs9ao9mwCfMklE
         IHRg==
X-Gm-Message-State: AC+VfDwo9N1GEF6CC4qL9jxkmDk4Vypa5ZIAG+g7OYVpAsf7wl2B3uQJ
        5F2SR4trcMTR1bf1xBAynSKC3PinJvUQZu1q
X-Google-Smtp-Source: ACHHUZ5iyGmPuvQukcLpT2LzCpG3w8iqjWw+QfhU7G7jklt/n3IM5gQnPQhXemCRw8Wk7zNBapCtKQ==
X-Received: by 2002:a81:6cd7:0:b0:56d:9e9:c2a1 with SMTP id h206-20020a816cd7000000b0056d09e9c2a1mr44903395ywc.16.1688056422260;
        Thu, 29 Jun 2023 09:33:42 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id q130-20020a817588000000b0057725aeb4afsm399314ywc.84.2023.06.29.09.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 09:33:41 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bd77424c886so809508276.0;
        Thu, 29 Jun 2023 09:33:40 -0700 (PDT)
X-Received: by 2002:a25:3252:0:b0:c1a:bff5:377d with SMTP id
 y79-20020a253252000000b00c1abff5377dmr299680yby.64.1688056420537; Thu, 29 Jun
 2023 09:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626-viewless-marrow-17838c2172f6@wendy> <676db602-54d8-d6b0-274f-365e65a2102c@amlogic.com>
 <20230627-unsure-uniformly-079cad2c26e6@wendy> <061bb829-fb75-d154-0c15-9f0f982fec41@amlogic.com>
In-Reply-To: <061bb829-fb75-d154-0c15-9f0f982fec41@amlogic.com>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Thu, 29 Jun 2023 17:33:29 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+0Kf3zFyUtkCEkm7K8zXwaovxQmo1DWFwy8y25GQ2wqXg@mail.gmail.com>
Message-ID: <CAJX_Q+0Kf3zFyUtkCEkm7K8zXwaovxQmo1DWFwy8y25GQ2wqXg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Baisc devicetree support for Amlogic T7
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 8:52 AM Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>
>
> On 2023/6/27 15:23, Conor Dooley wrote:
>
>
>  > [ EXTERNAL EMAIL ]
>  >
>  > On Tue, Jun 27, 2023 at 02:13:34PM +0800, Xianwei Zhao wrote:
>  >> Hi Conor,
>  >>      Thanks for you reply.
>  >> On 2023/6/26 18:02, Conor Dooley wrote:
>  >>
>  >>
>  >>> [ EXTERNAL EMAIL ]
>  >>>
>  >>> Hey,
>  >>>
>  >>> On Mon, Jun 26, 2023 at 05:52:21PM +0800, Xianwei Zhao wrote:
>  >>>> T7 is an advanced application processor designed for smart display.
>  >>>>
>  >>>> Add the new T7 SoC/board device tree bindings.
>  >>>>
>  >>>> Add basic support for the T7 based Amlogic AN400 board, which
>  >>>> describesthe following components: CPU, GIC, IRQ, Timer, UART. It's
>  >>>> capable of booting up into the serial console.
>  >>>
>  >>> Lucas has already sent patches for the T7 SoC & is at v5:
>  >>> https://lore.kernel.org/linux-devicetree/20230623081242.109131-1-
>  >>> tanure@linux.com/
>  >>> There's been a bit of discussion there, and there serial stuff in
>  >>> particular is different in his series (it doesn't use always-on for
>  >>> examples).
>  >>> Could you please go and take a look at his series?
>  >>>
>  >>> Cheers,
>  >>> Conor.
>  >>>
>  >> AN400 is the reference board designed by Amlogic, which is different
>  >> from Khadas VIM4.
>  >
>  > Yet you share the same dtsi, which he has got through several
>  > iterations of before you arrived.
>  >
> Hi Lucas,
> Are you going to continue with the dtsi part?
>
>  >> And T7 serial is the same as S4, so I follow S4 serial.
>  >
>  > Yeah, no. SoC specific compatible please.
>  >
>  >
>  > _______________________________________________
>  > linux-amlogic mailing list
>  > linux-amlogic@lists.infradead.org
>  > http://lists.infradead.org/mailman/listinfo/linux-amlogic

Hi Xianwei,

I am doing the basics for Amlogic T7 A311D2, but the next step ( sd
card or emmc, something to boot on) would be more difficult for me
than you.
After the first series for Vim4 gets merged, I will start to work on
how to get sd cards working.
But if you already have that working for the AN400 board, please send
it. And I will look at that work and use it for Vim4.

Or, if you don't have it ready and want to share it with me, we can
work together on these A311D2 patches.
You test on AN400, and I test on Vim4.

Thanks
Lucas
