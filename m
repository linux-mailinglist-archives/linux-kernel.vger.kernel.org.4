Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E3737234
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjFTRAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjFTRAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:00:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEDF91
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:00:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e97fcc60so2115465b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687280415; x=1689872415;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QK+YTzQYirL13Os91ZaovYkQTYBm+sE9lgoxCY58ads=;
        b=jlbqn+apNr6F9PTo3mvJqssWrFtPJbIQl9jmkvBjaCv9yVtDiI0KAvHeyRetatf6vV
         F+khgMF6VN4e7go0v9Rtx9aDZ8O6DceoA5SrZdgOyto5gru93jWY/9dzVKCuGy6EFGz6
         Hgnv4uOAd4a8Ze8Wq4NUEUp1XC4b2bjpYvw1WkCx2rFASy/Y5Q6oj/DSOT8gCjpatXs6
         epH1VMaY+wyzrhZGJCjre15E2JhTddDERTAT0clo9GOJDKG8x4S7JQ18KXtn/UTupic/
         C/2ele7/LGT+iv/Kv3dEo3GOVGkU7mD7q4ICs5fYO/zNkTQOdHNZBCNIDbM5R9XXIHKD
         L93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280415; x=1689872415;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK+YTzQYirL13Os91ZaovYkQTYBm+sE9lgoxCY58ads=;
        b=JcPPNt75bd9QMxrkd0eSxmriBMV5PqEhJgd4cKN1fiVZNipVwjepVpcQavMyeFU1u9
         bFcThmvQKAvxtUuaxmR3CPcYwvgln4J7sdxJZhSdmfD6+qBezmtLsJRnM2R4A1jV+mdT
         unO6MCAHCjw8tgC++G0wmYB3Oe392JSCaQVi8wuZ+I8bG76Oj5HW3mYNJmJu1QaXoYDQ
         W5/deoko5AlPgDZhxy04CDp0Dew0fFBobC6oP/dbCxtb2tNumm1LpXgs1ce8DmGUp7xC
         OVXJon8X7zYU8kQ75RJFi2y/8z/dmL4ncslYmj2j7TyX/KL5beVIvADaPs7IxlvMcmE8
         cSYQ==
X-Gm-Message-State: AC+VfDxpSjyaZKiqHS8wZvKUMHkMBlCl76XkA25RY7c4coozj6R52SjM
        T0z2Sj9GB4A7iGMbKEVpdzUJQw==
X-Google-Smtp-Source: ACHHUZ5YTS2ZtJb6TMHkwov/SWafsEKbx/kSL9Eef8V1L8C+MUfF8AMHNWCY+1vck4/7YVBsS7pDWw==
X-Received: by 2002:a05:6a21:9983:b0:121:bf66:a715 with SMTP id ve3-20020a056a21998300b00121bf66a715mr4753743pzb.45.1687280415224;
        Tue, 20 Jun 2023 10:00:15 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q25-20020a62ae19000000b00666e17004a4sm557666pff.58.2023.06.20.10.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:00:14 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:00:14 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Jun 2023 09:59:33 PDT (-0700)
Subject:     Re: [PATCH v2 0/2] dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
In-Reply-To: <20230615-creamer-emu-ade0fa0bdb68@spud>
CC:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-9b234a44-e770-48a9-8a7b-d71a9ed671e7@palmer-ri-x1c9a>
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

On Thu, 15 Jun 2023 15:50:13 PDT (-0700), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Do the various bits needed to drop the additionalProperties: true that
> we currently have in riscv/cpu.yaml, to permit actually enforcing what
> people put in cpus nodes.
>
> Changes in v2:
> - drop patches 2 -> 5, they're now standard in dt-schema
>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: linux-riscv@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
>
> Conor Dooley (2):
>   dt-bindings: riscv: cpus: add a ref the common cpu schema
>   dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
>
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

LMK if you wanted me to pick these up?
