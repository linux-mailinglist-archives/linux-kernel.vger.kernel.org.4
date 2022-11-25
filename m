Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653996387E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiKYKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKYKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:52:01 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B1D4908C;
        Fri, 25 Nov 2022 02:52:01 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ho10so9494621ejc.1;
        Fri, 25 Nov 2022 02:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fud1H9vvbIEqPXGteAFL1sMqIMKt+68zGcESyvCiI/M=;
        b=iBGeECdnnmjRGSrtK0BG888XfLpJQoy37P8qu0dK7MXCjPnIEVTd7KlEaOOSvkLRGN
         kFAaGPSHQug6sGbcYfqe0RJlwQMt3+XcQHCTdvcTKLA/krmvCR5CQYNH2jEiUzMDttZH
         JRDa1FaNIFANQI2mKG8lQbj6WNNJgHQyX8vvNJ9StxqDlcia5LinZ0ax51Vw5mTH+cD5
         N5S3sCT/lLtmN5pNfg+N4OXVHuwphgqY8skM/fI+mwfro4xc+5mcul91Ux8bL8AuKsz3
         YngXDKZPjbxqF9hn917Cj7hZjz4lsUFQ61yXo21qKcPZamBy+dPRtpGATkbDoqDXjXRB
         miwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fud1H9vvbIEqPXGteAFL1sMqIMKt+68zGcESyvCiI/M=;
        b=Qq2Zu5R2nYymbG9g8Ryp+LwrXJkS3G9AHMcBwff7YbCc+Daxb9hlH4m6NBFdhPaqsb
         GFkU1g5B4vvGn4qpd0F5q3oMZj4/wkzOB0Q1bxIDF9J0bF3WyiwjLLzXaOva/CxEb5j5
         ti4SbnwUCIElgKvmUZ8MoZ3O/YWX2j98WvPL8dIgJUrP8M6BQlYb/mSRK9uIXwHR4PBp
         Ez1zaeawTbT1xuBdjqS/4cMOj82gFysZVIjvyHsap45OJ4yiokYJHpYNeVykHebm75c7
         fWn0HMVyUgWJnbOL5NsFAAxr3Lw/Nodg/jaS/zl8C2eUM2u3eeFc4j33R1ybm2llrsHU
         RAIw==
X-Gm-Message-State: ANoB5pn6qvqmk4SSym5QGoXIwN4AUsytsXJGO+rpXoTFLc1TW6xzEUIA
        w+wvPUl6Mhokv4+XR17Wl/ULqRkYRyxEcSXvxNI=
X-Google-Smtp-Source: AA0mqf4jnZPyve2IIDg4v48Q9ACVWtHs2u+FvXIyh1nLI+gqZesKRIEyJ8mKN5TZUc79ySLQawRJMPh6FXYTrmAjLvg=
X-Received: by 2002:a17:906:ccd0:b0:7ad:db82:d073 with SMTP id
 ot16-20020a170906ccd000b007addb82d073mr19858052ejb.480.1669373519614; Fri, 25
 Nov 2022 02:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWbunjdFo5YfQ2t4DSDm-LX8WhvLkzAogGrOg7HY4_uPw@mail.gmail.com>
In-Reply-To: <CAMuHMdWbunjdFo5YfQ2t4DSDm-LX8WhvLkzAogGrOg7HY4_uPw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Nov 2022 10:51:33 +0000
Message-ID: <CA+V-a8to-Wr2x8qbxnktTzXrWjTGvtCqwXT27A8EmHTTG7Lbkg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] AX45MP: Add support to non-coherent DMA
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Nov 25, 2022 at 9:04 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Nov 24, 2022 at 6:24 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > Due to the above approach custom SBI calls have been implemented. The
> > above implementation is in preparation for adding support for Renesas
> > RZ/Five SoC which uses the AX45MP core. As with the above approach the
> > kernel image might not be generic so that it can be used on other
>
> might be generic?
>
Oops I missed updating this part of the cover letter. Indeed it should
be generic now.

Cheers,
Prabhakar
