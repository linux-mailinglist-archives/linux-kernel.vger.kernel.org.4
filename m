Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B729D6AF712
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCGU7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCGU7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:59:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171759E65C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:59:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so13099364pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 12:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678222775;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6atF6I2q0Ii8LJH3Gz8PsiaDUZKWNvxsL7EGNgfsZ8=;
        b=17PlGSKbkKuIupnjF7zLginu7kJrESk+P/cZNJX3rRw0zF5jTVklMTT4oR5QGRJVM7
         td0ySlYq+69ZpSgNbAzR6FlBEXGLj2Nis9SADR+8/t3oWYFVdd1c8s8Eyy+n25AsiJOt
         CiC+MRleb+/J3bbZRtBB3/bmGXFd/un/5H3hKP1sq+a2g1SiQrHa54iR/iizzfYy75st
         ZSCa1KDT9CGoTh5cv/Lswq88zQ3lR9cBRvLTJhT5+JJq/gsHU8khfZp8LLNGcTMCMeQl
         g0KFdVBvW8oyUCRSU+kvddY3z0TLf28jI0RrkaJcNvizuIkpYAEfriNVf7GtZNbClPEv
         WPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222775;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6atF6I2q0Ii8LJH3Gz8PsiaDUZKWNvxsL7EGNgfsZ8=;
        b=2f680yUD8r0e2t/2vZJZoM61/MOaBrAAmaV43RVN4b9COukeepDiJ7MX1PNE5bxZKH
         VQBzTqjVyIO3j57nUJq7imR7hucQ3XhKhYQrG+RslUX4xS0yDr/OPaj4Z0GWuxsboWBD
         s0gUR/iwpLtUXvuahGK5t5Upxyl/8MUlRVIIPX56wiIje1ELGkToiVAjq1D1pjGRr59k
         FM7v8PeZ9COlJRSK02HlIX13Jc+NdDqRrhdjtzG+yzFTojuyeRvGEoZM7SfHWVQHsvIM
         iGw6nAb6MHOqrLOeBgbhW0kk4gJbXS5zazlef1rOcePyWXCCBCVXA408ePxTxYHbNIjQ
         CGvA==
X-Gm-Message-State: AO0yUKXqpPEL2LXsV4W+yduIi84tswh464jiYce9DBSWcd0C6gZtpX17
        ZT/s/JEWV7R2eBGfamQc+E+RqA==
X-Google-Smtp-Source: AK7set8gIjw0BxRnruPT5teFvlmXm/ZFQq6QpH299KEvyKIMUvG5/5R6imaZgBOnNpMXCYoLV8qPeA==
X-Received: by 2002:a17:902:c94e:b0:19a:ae30:3a42 with SMTP id i14-20020a170902c94e00b0019aae303a42mr17281637pla.21.1678222775335;
        Tue, 07 Mar 2023 12:59:35 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id ke15-20020a170903340f00b0019aaba5c90bsm8828902plb.84.2023.03.07.12.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 12:59:34 -0800 (PST)
Date:   Tue, 07 Mar 2023 12:59:34 -0800 (PST)
X-Google-Original-Date: Tue, 07 Mar 2023 12:58:37 PST (-0800)
Subject:     Re: [PATCH 1/4] dts: add riscv include prefix link
In-Reply-To: <20230106010155.26868-2-andre.przywara@arm.com>
CC:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        uwu@icenowy.me, szemzo.andras@gmail.com, fabien.poussin@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        frowand.list@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     andre.przywara@arm.com
Message-ID: <mhng-6efe8a4c-7234-4324-8861-b4f1ff028ec2@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023 17:01:52 PST (-0800), andre.przywara@arm.com wrote:
> The Allwinner D1/D1s SoCs (with a RISC-V core) use an (almost?) identical
> die as their R528/T113-s siblings with ARM Cortex-A7 cores.
>
> To allow sharing the basic SoC .dtsi files across those two
> architectures as well, introduce a symlink to the RISC-V DT directory.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  scripts/dtc/include-prefixes/riscv | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 120000 scripts/dtc/include-prefixes/riscv
>
> diff --git a/scripts/dtc/include-prefixes/riscv b/scripts/dtc/include-prefixes/riscv
> new file mode 120000
> index 0000000000000..2025094189380
> --- /dev/null
> +++ b/scripts/dtc/include-prefixes/riscv
> @@ -0,0 +1 @@
> +../../../arch/riscv/boot/dts
> \ No newline at end of file

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
