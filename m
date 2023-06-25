Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B340F73D53C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFYXTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFYXSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:18:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192CE44
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:18:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55adfa61199so320596a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687735130; x=1690327130;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMyidyx6c8j5MqA0hxypdhWidgaRdQYvwuhrsrEdDAU=;
        b=r1Kkob3K7eMRLpiJCBwt7BrIxDGHwLTSuYUVmbjdbsOi8X9tHT0HbkkGfxV3slmG8l
         EzwED/43arOsSoKB9nj4ESxua/Hbje/cjt5LMkLfWp46F53MUwdwbUJdyOWoDddl5478
         e727q3+cEBjKr0bUQ6/6hGDj4i9Prr3xElgEnq7TIGwWdwG6bQxv5uIecVqw9X9eBzzg
         7Zn56LTIEJ4brd+tSYnMn0r3au4gw+mPdgZVMN84x0b0bmmzd2MfN8sJNTn0SScdytLc
         LzfofWl5kLWv/pC18bq3c1nnfmK3aJp94VGDjlAYcKH8euJ6CAhdzjTICMV53FZ9OVfh
         KoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687735130; x=1690327130;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMyidyx6c8j5MqA0hxypdhWidgaRdQYvwuhrsrEdDAU=;
        b=XaZmI+fuq5L1ebdQi/m20jpY1fVY1RB2KuQw7U+gT/DNNWt4EZHjvUwt3/UpJsVvpk
         VDcmnVq/IovY3poq9hK/24de22eVOqHrmUiDnpcNoSIn0APZP8sfPAeCUvZ6Z0rNO0TK
         1mTKmL3zspl7G70DeZzVHANj0OrdsQLX0KpVbQ84AeCXGEPgm788uEYLJKwil4MRBJ58
         BXoxS7R1J39LhMKm8Qr9/VLfFyoB7/AmmZ72Kx4kUAmhp49bqLZj6YC2i04HFZ6HDa1c
         p3jc2qhOYUfsxV/nYPMMdyk1wJfXO1AEUmmWvAJM8ogo57lPdur64JI3GCBN7nvazAyl
         ioyg==
X-Gm-Message-State: AC+VfDy02Pp7aOpjYlfI4u8Wm76NQUQGFzXh1sTGQYKIMVbIA4cy97o6
        CfVQztCNanvlVM6Tqee+szotjP/Yc1jDB1WL/Wo=
X-Google-Smtp-Source: ACHHUZ7chlK+14uMjyxEuWPh5cyB+olLpZYJstcYOjERPpCE49wWN2rz8PEjV9wVJ6+bT43Q5ElOog==
X-Received: by 2002:a17:902:da8c:b0:1af:981b:eeff with SMTP id j12-20020a170902da8c00b001af981beeffmr6581208plx.64.1687735130591;
        Sun, 25 Jun 2023 16:18:50 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y6-20020a1709029b8600b001b682336f66sm2873895plp.55.2023.06.25.16.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 16:18:50 -0700 (PDT)
In-Reply-To: <20230615-creamer-emu-ade0fa0bdb68@spud>
References: <20230615-creamer-emu-ade0fa0bdb68@spud>
Subject: Re: [PATCH v2 0/2] dt-bindings: riscv: cpus: switch to
 unevaluatedProperties: false
Message-Id: <168773507362.1389.2217273473354305328.b4-ty@rivosinc.com>
Date:   Sun, 25 Jun 2023 16:17:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jun 2023 23:50:13 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Do the various bits needed to drop the additionalProperties: true that
> we currently have in riscv/cpu.yaml, to permit actually enforcing what
> people put in cpus nodes.
> 
> Changes in v2:
> - drop patches 2 -> 5, they're now standard in dt-schema
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: riscv: cpus: add a ref the common cpu schema
      https://git.kernel.org/palmer/c/3c1b4758a954
[2/2] dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
      https://git.kernel.org/palmer/c/1ffe6ddc5c64

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

