Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2345BA2B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIOW1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOW1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:27:07 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4620FF78;
        Thu, 15 Sep 2022 15:27:06 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-349c4310cf7so72437617b3.3;
        Thu, 15 Sep 2022 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NlxdPlGDclSVG1dP8Ered5Aj96QYeQaYTMEQCcdsZZE=;
        b=ZHooVNorr46gDUSPq+/8edA6CX+1L8cGMDsChOOIi+v5mWr+mXwPOJysExYYJyNIAj
         WDD6IGqhajlPhJzUNhUPqKUIh0e1HQrdguD0ExiX+mSjAfqXvjGawh/ReIqeMpi5uDu0
         LfbRrMJNU/yU1CnAtTZKV0TQDb6rI1jGSxrUTDBEtx9hXvmeaDuiOM/lDI/5Rr9G+i8L
         85rTrdHDFti1kMCT8+q3KblPSnapUTLL+RQ9OiBdJD04JAWp+xcGB3YaMsHwtUYybb/1
         7JnYZUDFho4xwf0xHe6kV4C3Cp+sb3uHf8a+SX1xK43K+yDmW4lIJarFW0Tq6bqoAs0a
         HRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NlxdPlGDclSVG1dP8Ered5Aj96QYeQaYTMEQCcdsZZE=;
        b=p+O9K+fAYkIrOQ3EAH0RWz+O5XLfH1Oej6FVAW+AA8ty5hHc3T+k2D25OkWvj0RY6M
         HMKrld3qsyad/LK9eQCMuwbm/j6ucWfroR2A1sU+PVFaWaO0Ru7QN1jhWYp/dfSVIax5
         cxfQqXsRXSVAKgGLs3xGdvwpitQbSIWM11UFXk8tPnL+YF0g4iEidtdaj7mo138MxSkM
         IR6KS8ktNTnJMITu1uXC7xeog1aeBe9eB08AVZyGFFbHGMlOHxmHSwZbiWnDzZt4fLFJ
         iBcpJ2pNoh3CSq4YPy6QDfDWmcdHA9Nhv/p+YT7tyGEE5lhBaLIbiH8/YQjjbErXXegl
         klDQ==
X-Gm-Message-State: ACrzQf1N0IxwzMoiPaotI4nBs3NBL6mxTNvrlxFwAHZ4VTbeaflBIpa1
        YBBdZHkvtwDzmIlNPN4u8ktfWCFqbCsTOqzowFQ=
X-Google-Smtp-Source: AMsMyM4Yp7PBzBgpfRaS3bO7iKYy5Jlc/0xzHj4cPfpCIpsQ9PGNNJjX8oCqARs+4zAsE6SlnC/8A+XAHEdYFUNOoiE=
X-Received: by 2002:a81:4ac6:0:b0:344:ef13:7c8b with SMTP id
 x189-20020a814ac6000000b00344ef137c8bmr1905559ywa.24.1663280825519; Thu, 15
 Sep 2022 15:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <3693a3a1-5a2a-4cc5-fb55-f6ad9a4b3f72@microchip.com>
In-Reply-To: <3693a3a1-5a2a-4cc5-fb55-f6ad9a4b3f72@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 15 Sep 2022 23:26:37 +0100
Message-ID: <CA+V-a8u87tqhC69qGD2zq_gT9jc_cSWd+NRn_u0bPTdmmk+j4A@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] riscv: boot: dts: r9a07g043: Add placeholder nodes
To:     Conor.Dooley@microchip.com
Cc:     geert+renesas@glider.be, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, heiko@sntech.de,
        atishp@rivosinc.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
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

Hi Conor,

Thank you for the review.

On Thu, Sep 15, 2022 at 10:36 PM <Conor.Dooley@microchip.com> wrote:
>
> On 15/09/2022 19:15, Prabhakar wrote:
> > riscv: boot: dts: r9a07g043: Add placeholder nodes
>
> nit: s/boot//
>
Will fix that.

> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add empty placeholder nodes to RZ/Five (R9A07G043) SoC DTSI.
>
> Can you explain why do you need placeholder nodes for this and
> cannot just directly include the other dtsis?
>
Since the RZ/G2UL SoC is ARM64 where it has a GIC and on RZ/Five SoC
we have PLIC for interrupts. Also the interrupt numbering for RZ/Five
SoC differs from RZ/G2UL SoC hence we are not directly using the
RZ/G2UL SoC DTSI [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi?h=v6.0-rc5

For the RZ/Five SMARC EVK I am re-using the below files [1] (SoM) and
[2] (Carrier board) as the RZ/Five SMARC EVK is pin compatible.  Since
I am re-using these when trying to compile the RZ/Five DTB I get
compilation errors since the nodes dont exist (and there is no way
currently we can delete the node reference when the actual node itself
isn't present) hence these place holders.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi?h=v6.0-rc5
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi?h=v6.0-rc5

Cheers,
Prabhakar
