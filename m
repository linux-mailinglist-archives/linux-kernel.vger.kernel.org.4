Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E437360E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjFTA5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjFTA5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:57:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD74186
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:57:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25edd0df667so1567312a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687222638; x=1689814638;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDwfEXS4UcUdADaX0jFk9MFHU4b/peplLYhaMJzY/3k=;
        b=roMX73tvFgCVlgpykNlqo/y0zB4mYwpeb6Vaov04zBRhEKiRbA6/FwYdCzk055waiz
         jXqy+uvxHUurHNX7wRZfYpxPgaqkoxvtM2gci1yPnsLSu+nBJkyh8LsG98Tfz9u8GpPW
         Ta4mE7ZVeuHK+iDGQvrrGjtEA9C7MOSU8xe19xbamfYj+nUYegkCEEyrbFAhHGJykJz4
         l6bsQw57L171vqYnIJ3R24++06JC8hmkyOPKa076mAjb2dHkZqc7BOALkcDYYGvZ+dre
         rRr0xf/9vmudE2r/6qKysWazoiQYOTsot81cF/S3h/sBhfFHvKFlbr8BXv0BlKajkJYm
         Hmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687222638; x=1689814638;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDwfEXS4UcUdADaX0jFk9MFHU4b/peplLYhaMJzY/3k=;
        b=JuYqFttTqMEtE7OoVvP9A/Lp6+++T7Bytv4DbjrLkhPGIEWlKGoagWFNCKUdxxVbWN
         WnLr7HSmYpS/GLynnUDrbyq5LExLOEuCmGSx6CQVWwTwKONqWw6jpTYfYzemJZK0ibxm
         CgGbvgt/JbeFodvlcahlYAqcmaCZ/EZwodoeSZOTHIc/sGwJA/NbiKIzw5LnKdnVaqTZ
         av0Ik/FcXf0ye0riTfh7EfClIg0Fu7qYhACGTfCkSq+KqmcXRyjrpej1fVhKtyKGR7gm
         ZTYaUH1ZVQrYgbPPbdHP/xO3UDg6bCwVDzrV2BfIUDG3CLcDmfC/Ith2BWbufUxbnwvC
         n1lA==
X-Gm-Message-State: AC+VfDzyhD9+6B39OpHD66H+5eQUSp7/akPjaaURQZaFBqfexXzt9NVF
        UG+3zGn0uT30EWCGAbmV9VyWqw==
X-Google-Smtp-Source: ACHHUZ7pft8MC7PJnrHEptg4LtQUB5qkzY1Vi6cRzbAcwsmpU4J/46TzpnS7b0dcw7vTjjnyI16M6A==
X-Received: by 2002:a17:90b:3686:b0:25e:8076:dd04 with SMTP id mj6-20020a17090b368600b0025e8076dd04mr21024368pjb.6.1687222638621;
        Mon, 19 Jun 2023 17:57:18 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id z20-20020a63e554000000b0053b92b26412sm264064pgj.14.2023.06.19.17.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:57:18 -0700 (PDT)
In-Reply-To: <20230607112417.782085-1-sunilvl@ventanamicro.com>
References: <20230607112417.782085-1-sunilvl@ventanamicro.com>
Subject: Re: [PATCH v2 -next 0/2] RISC-V ACPI: Assorted fixes
Message-Id: <168721242546.30028.5666286839056939512.b4-ty@rivosinc.com>
Date:   Mon, 19 Jun 2023 15:07:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sunil V L <sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Jun 2023 16:54:15 +0530, Sunil V L wrote:
> This series fixes couple of issues required to complete the previously
> merged basic ACPI support series.
> 
> 1) Kernel test bot has found a new warning using the sparse tool. Though
> I believe this warning exists for other architectures also,
> I don't see an issue fixing this for RISC-V.
> 
> [...]

Applied, thanks!

[1/2] RISC-V: ACPI : Fix for usage of pointers in different address space
      https://git.kernel.org/palmer/c/3b426d4b5b14
[2/2] RISC-V/perf: Use standard interface to get INTC domain
      https://git.kernel.org/palmer/c/ca7473cb8312

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

