Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A12B611D9E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJ1WsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiJ1Wr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:47:58 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7561E3ECB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:47:57 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g129so6018518pgc.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNWOunf0MeNELm/6hh2SrO7f/AQE69u+QfbjVdty5AM=;
        b=EEpGSKxK9lR6bSHQeO9mpjI5aJ0mo+Tq9xtR5dxdAmPO9pWDjVnq3MZGd3HBstWi89
         G81YmqMpQD6yQWv7F7ajDR4NDx7KA6Iel23+LU300QGRZLpkh8LHT1j31b1ctIB0AzXR
         W4ib7MLukIKMC+QZGnlSX+erxQKN1z0e9QTqXwH4kEz350BEMayq7PocPU1ejopjVjeG
         fqAqO0qM9sV+0Rnn7zy7g+DyMo1wxWqz+H2CDqLf7WZ1cBsSmVWB418/2iXO1nWpNhCm
         c9JOSvK/1J5o3pAH+/Ej2Jx0J13dmvi4CIYsCT8esTVuiZuJDdBhUWIz+EWJ1VwNhtmZ
         ZdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNWOunf0MeNELm/6hh2SrO7f/AQE69u+QfbjVdty5AM=;
        b=QaB1uyjc7w/36M8w0vlR1quhmQRdMn69YXCjwd908GB0EXJdJWn7+nS7V30W0u9CSl
         OpG3YIIy2/m6Imig1Xru0qY1GsJF8HycrPrbg3y7sD7XszYVjiBBuwqHhh06ZvC1UcVU
         JU7pjUlBN0wZeyMSnMAogU06mmh27ylLEtnUUSxs3VUhzLnHjCe73a7M6O6AFvoebqn5
         tJMtaZm6kegPuA1Px+neWm+CyK7gJvfspv+q2AOi0BcLW6S80JYmYDBgqfXs+tCv3OAT
         t5xYa9+rIhOqdG82ue0WVuCp7x4cOXhpsEnbeYfmkW0uKcIG6rXaNi0ReFTvl5zSv4+p
         0ubw==
X-Gm-Message-State: ACrzQf0jmq6j/tMmrcC1Cok9QV66Je7I6UGWjgQpnfDM0Xhlx1O6pcQl
        huh5IoFLIMIUnOEzioLpjf2lP9P2xi/BbA==
X-Google-Smtp-Source: AMsMyM6QWOjW3DUtSzW+KukyxrKtOPnGEwYsIahI+/leRyvtuw78aUBGwwYao1GqCUc6at4+NEb0tQ==
X-Received: by 2002:a63:ea48:0:b0:43c:69c4:68d4 with SMTP id l8-20020a63ea48000000b0043c69c468d4mr1629243pgk.416.1666997277123;
        Fri, 28 Oct 2022 15:47:57 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902bd9600b00186b6bb2f48sm3523938pls.129.2022.10.28.15.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 15:47:56 -0700 (PDT)
In-Reply-To: <20221012110928.352910-1-emil.renner.berthing@canonical.com>
References: <20221012110928.352910-1-emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v1] riscv: dts: sifive unleashed: Add PWM controlled LEDs
Message-Id: <166699694891.354.8818111630458399949.b4-ty@rivosinc.com>
Date:   Fri, 28 Oct 2022 15:42:28 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bin Meng <bin.meng@windriver.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 13:09:28 +0200, Emil Renner Berthing wrote:
> This adds the 4 PWM controlled green LEDs to the HiFive Unleashed device
> tree. The schematic doesn't specify any special function for the LEDs,
> so they're added here without any default triggers and named d1, d2, d3
> and d4 just like in the schematic.
> 
> 

Applied, thanks!

[1/1] riscv: dts: sifive unleashed: Add PWM controlled LEDs
      https://git.kernel.org/palmer/c/8bc8824d3019

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
