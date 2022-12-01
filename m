Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF30763F816
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiLATV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiLATVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:21:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F7B71EE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:21:53 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6206265pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4Gc9gN2otXkm8m4oox2qCrf5ekLmPGu19VnxyN13J8=;
        b=SwT6lk9yHqGS7ky29RXrRN8zcJ5CXFPRqx/GX4tTizpwqqlWwm1V74YvwYVdVv2ykZ
         e1RJx86pTwR+dPAYl8rF0+Hi9uVJs6zyHl2bR2RlSx8Jrw24pfvo13f6veiXcHvj3QJc
         Xv81/cHQxq3f8dLf3YfRAMfHHLv6uTDpoqFWIH2PXJZAMFD0fL5vvCDwQD8tDx5ZeZMh
         reCbklqNrpf7aH2tbl0MBkXx/St4C84QhVSnIOvL+ASXbKgI+YFcA9Eo31KzU6QUuPZz
         Gk1eRPxzlVaDz/SwfWpqJjqoJm470tmvI8akRxjk3kc5sef9HhyMNNT4chR6vUpltDoG
         nDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4Gc9gN2otXkm8m4oox2qCrf5ekLmPGu19VnxyN13J8=;
        b=X6OWkBMmmvC6rPabFehLyDIT7uzQH8RuQq7KlJlYt2A3+Cg50FonRm/sSaqhvLLV0B
         mlwlCbBzHrOhdKcTr8j32sTGPo/W+FnG1Ls2FmOUvwnH/MnZH2ho424nvnJenYGGJSs3
         UC2vJj4BzcaCd0Z2YTlpicm9BSGQeB8d7o7iqB9B1PM6RGfwOnoZkukdPa5VRiKOh1Ce
         Usbs4JAAJZyf11lne/hbkaMYEwtdUwJ1LHoNPHL8YIu4+4twNhI+r7j2S/jchge8udMM
         GQfvPcYvV3NBWBOlvcJtPRzxNmpy2jcRYiV7a1EZIjioBCQ+aWSrUZ78JIwRGbeHKFmq
         ojSQ==
X-Gm-Message-State: ANoB5pm7jnLZuAj0ZBiDfEJxCPf4aq/94KdeJEl8M8zH2ZRB/5LOpX0n
        2CFqF8ZejnnJXhx+DWf1+jB3ag==
X-Google-Smtp-Source: AA0mqf6YSgYKqisC65u2t1o8VgQbEtHbJDHD+4u2Q56HcmLYNyxLyceIQa1JS6cTUzwYSXW6klAy2w==
X-Received: by 2002:a17:902:f2c5:b0:189:1cc3:802a with SMTP id h5-20020a170902f2c500b001891cc3802amr50026912plc.56.1669922512296;
        Thu, 01 Dec 2022 11:21:52 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3980290pll.200.2022.12.01.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:21:51 -0800 (PST)
Date:   Thu, 01 Dec 2022 11:21:51 -0800 (PST)
X-Google-Original-Date: Thu, 01 Dec 2022 11:21:37 PST (-0800)
Subject:     Re: [PATCH] Documentation: riscv: note that counter access is part of the uABI
In-Reply-To: <20221201135110.3855965-1-conor.dooley@microchip.com>
CC:     corbet@lwn.net, Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Message-ID: <mhng-72f383f6-a85f-4587-9fa6-f85fb9f27ec8@palmer-ri-x1c9a>
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

On Thu, 01 Dec 2022 05:51:10 PST (-0800), Conor Dooley wrote:
> Commit 5a5294fbe020 ("RISC-V: Re-enable counter access from userspace")
> fixed userspace access to CYCLE, TIME & INSTRET counters and left a nice
> comment in-place about why they must not be restricted. Since we now
> have a uABI doc in RISC-V land, add a section documenting it.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Based on an, as yet, unsent v2 of my other uABI changes. I don't expect
> it to be applicable, just getting a patch into patchwork while I don't
> forget about this.
> ---
>  Documentation/riscv/uabi.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
> index 8d2651e42fda..638ddce56700 100644
> --- a/Documentation/riscv/uabi.rst
> +++ b/Documentation/riscv/uabi.rst
> @@ -3,6 +3,13 @@
>  RISC-V Linux User ABI
>  =====================
>
> +Counter access
> +--------------
> +
> +Access to the CYCLE, TIME and INSTRET counters, now controlled by the SBI PMU
> +extension, were part of the ISA when the uABI was frozen & so remain accessible
> +from userspace.
> +
>  ISA string ordering in /proc/cpuinfo
>  ------------------------------------
>
>
> base-commit: 13ee7ef407cfcf63f4f047460ac5bb6ba5a3447d
> prerequisite-patch-id: d17a9ffb6fcf99eb683728da98cd50e18cd28fe8
> prerequisite-patch-id: 0df4127e3f4a0c02a235fea00bcb69cd94fabb38
> prerequisite-patch-id: 171724b870ba212b714ebbded480269accd83733

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I think I merged the last one of these, but if the doc folks pick it up 
that's fine with me.  Otherwise I'll take it when it comes back around, 
so folks have time to take a look.
