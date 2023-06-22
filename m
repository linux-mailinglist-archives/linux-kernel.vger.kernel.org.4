Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82973A91A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjFVTnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjFVTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:43:21 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E624F1FED
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:43:14 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39ca120c103so4990353b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687462994; x=1690054994;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T11uxBhIjGWzq3ibADFPBxygIm6nnj3hVsi3PNKGSA=;
        b=xo1/ZwUQaNDkC4rDA90YGndxKNvE0D28jIdXnxVPwuvLsh34JQk/FeE5HsUcSbQC3f
         3WCHDoFRWiV1D229OnTV/wcoeRyigg8efklJh0pkajVzuEcSff3qf9yWkbWcFonOBrCV
         OJM2AQ9VfHH1rVjVNO7MFICuRP1ee3yZpppZweUpiVx2ru21r3+tl0J6Lx/lHrbaeTI2
         7L+DClFsnYxO0/fD2aMargKtjMqSJV9R0hn0l/kJI4quI4qt7hW0OmmT+wcI/nReY5MJ
         22EizoFPM2b1r+jyIYyfPrkiiXo/PfQGmoLVy1oEqB3K9eT9GCMk1nPLCFA6+xn1dMxW
         gkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687462994; x=1690054994;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T11uxBhIjGWzq3ibADFPBxygIm6nnj3hVsi3PNKGSA=;
        b=LEcrj7OX2cOXhQPS43RMR1d7MHK8fs2AIwa+pwLjRoMDfO4ly0XaAllifXhRXzDO+T
         mRbjNXF34Nn9+hTSHtBfK1bFz3kC4juGriQ96fyX+kCbGBrLUdXj7vTPLt88Jz02GgoP
         qxVxV7r1emiKPuZCV5etQXv4qr+cBo/La8Ga1OWkf6Uv8+wmVE56+C345mcz9osCqRzN
         pQ81/ZSBmdmp9DAd3KyRVi9amDTU61mauv+MoSZ/Bjq/FLaTcxwDx352t3ZPnbAEfGBz
         2uOBdhC/u9OqeuM0G6VBMwU4tfZk35mPpSTK+GhTE65OiJ6LDAwpdSPNYYd38oq4IavC
         VpHw==
X-Gm-Message-State: AC+VfDzaEK6n4CPYRvlN8h/TfsDFhy4k02UhT+/LK0tCC0+g4sTJswzE
        9rCXVzO48TsXRKIJPIY33QQNXQ==
X-Google-Smtp-Source: ACHHUZ5WaibaXi8GDeiG3MswMLiamw5o+dUTYjXfQhHtuaUX2w3ZX/M/khKv/POfy1MNBzVRFwyCaw==
X-Received: by 2002:a05:6808:20f:b0:3a0:5596:efe8 with SMTP id l15-20020a056808020f00b003a05596efe8mr4046410oie.54.1687462994158;
        Thu, 22 Jun 2023 12:43:14 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q23-20020a635057000000b0054fd1723554sm5075167pgl.21.2023.06.22.12.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:43:13 -0700 (PDT)
Date:   Thu, 22 Jun 2023 12:43:13 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Jun 2023 12:42:32 PDT (-0700)
Subject:     Re: [PATCH v2] dt-bindings: riscv: deprecate riscv,isa
In-Reply-To: <20230622-stipend-flashily-97917469f39b@spud>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        ajones@ventanamicro.com, apatel@ventanamicro.com,
        atishp@atishpatra.org, jrtc27@jrtc27.com, rick@andestech.com,
        ycliang@andestech.com, oleksii.kurochko@gmail.com,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-9e03f021-961d-44f3-81c1-9c09abd3662b@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 11:59:32 PDT (-0700), Conor Dooley wrote:
> On Thu, Jun 22, 2023 at 11:25:35AM -0700, Palmer Dabbelt wrote:
>
>> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> 
>> I'm not wed to any particular encoding for the properties, IMO that's more
>> of a decision for the DT folks.  IMO the important bit is to just get away
>> from ISA strings and move towards some tightly-specified properties that
>> indicate how the HW actually behaves.
>
> I'm going to resubmit with Rob's list of strings. I'll keep your tags,
> since the spirit of the patch will be the same, with enforced meanings
> for each extension.

Works for me, thanks.

>
> Cheers,
> Conor.
