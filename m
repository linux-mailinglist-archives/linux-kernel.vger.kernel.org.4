Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70F274173F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjF1ReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjF1Rd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:33:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB4F210A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:33:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so3542617e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687973636; x=1690565636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu8Gi2wSnoTXkOMcCin+xgkyW4SfsZOtfaMQ9m+MZ5U=;
        b=ctXSjsQSzaufeY9GTPqn+avzhgMNvjo9PgbMSWr3gC1OzFmKrqHpkfW/Hh4/BxaRHj
         oatlyGdfBX5is3/rXAkRtPpuVaBjnbVAWHtGueEalCtd0kiWVV+nHvycDQA6ttsaegMd
         3lcR9743n2mULg7SZFP8WAzgB7VrDSJyHfySHd5R6/1eVpsEDvWiJ7WrXlv0a9KSs29x
         WETDEpY2W0csY2Kc8h8MS0M9gIM0+saldCRjt5f4n2ePrtvwjqb9Q37Q+s3b2t5w550r
         rE7oMwUkLRYM2F7ETOGVj7LBn7mLZofgXEPOlaZgFM5DxnuqH6dXXJk0pzK8+aL2GhCR
         7xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973636; x=1690565636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu8Gi2wSnoTXkOMcCin+xgkyW4SfsZOtfaMQ9m+MZ5U=;
        b=jsgTD4p/1mBRc8M+QSkIzmX9sRestu9G5Eip494OCNtHqDctlmZsnHS7QV98iGSLqe
         jJIekSaGRhFLpCHvjHIte4J4JJ+I+1WoSEogC5GW1HUBo4sxKfMyQ7ghkkLM7cMBh7rp
         lxEwn2tVTueXTRw2XcVyupraV50rcY26M2E7G83gUeDOXrNwZlV0SUDfV0GNfift+IR9
         ln3nsqec8aK2DGFawZOOmLBsfDxitWZpiEK5acFAw8KbdRaOBU2NFpuCHWDgKQ4iKAjN
         5igsLxhZUazLsrDQdcHwKHbJBnmn2DhLiUzGX2OwJDZz6ITD+iTewjYG8hnkC/Ty1CpP
         HSAg==
X-Gm-Message-State: AC+VfDxSoKU7BxPgdJ8/+yZYVI80x8Yw5QRrIvR4FmeDYaRS+qvAZrKq
        xFczOFIRHRLK4qiCVTWBeeurjNFBN8DEGr8n/8H7PQ==
X-Google-Smtp-Source: ACHHUZ7/LXypQ2b7zt5BdRodKsoDzSYUcdIaTGpou0UZUfpPyxiEPFkUIurdLsWJ+cccDbdbnTpgIrlMLbBaiJoTBCY=
X-Received: by 2002:a19:7710:0:b0:4f8:6800:86f6 with SMTP id
 s16-20020a197710000000b004f8680086f6mr16992828lfc.49.1687973636628; Wed, 28
 Jun 2023 10:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230626-provable-angrily-81760e8c3cc6@wendy> <20230626-sensuous-clothing-124f7ae0aedf@wendy>
In-Reply-To: <20230626-sensuous-clothing-124f7ae0aedf@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 28 Jun 2023 10:33:20 -0700
Message-ID: <CALs-HstDV3PjBk_8WDecwuvVK9rno1CKFzT1+8ohoUXE7X0GwA@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] RISC-V: add single letter extensions to riscv_isa_ext
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 4:21=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> So that riscv_fill_hwcap() can use riscv_isa_ext to probe for single
> letter extensions, add them to it. riscv_isa_ext_data grows a new
> member, signifying whether an extension is multi-letter & thus requiring
> special handling.
> As a result, what gets spat out in /proc/cpuinfo will become borked, as
> single letter extensions will be printed as part of the base extensions
> and while printing from riscv_isa_arr. Take the opportunity to unify the
> printing of the isa string, using the new member of riscv_isa_ext_data
> in the process.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/hwcap.h |  1 +
>  arch/riscv/kernel/cpu.c        | 36 ++++++----------------
>  arch/riscv/kernel/cpufeature.c | 56 +++++++++++++++++++++-------------
>  3 files changed, 46 insertions(+), 47 deletions(-)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index a35bee219dd7..6ad896dc4342 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -77,6 +77,7 @@ unsigned long riscv_get_elf_hwcap(void);
>  struct riscv_isa_ext_data {
>         const unsigned int id;
>         const char *name;
> +       const bool multi_letter;

Instead of defining a new member, could we just infer this by making a
macro like #define MULTI_LETTER(name) (name[0] && name[1])?
