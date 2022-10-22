Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7ED608DE6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJVPNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJVPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:13:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150D8136421;
        Sat, 22 Oct 2022 08:13:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bu30so9138600wrb.8;
        Sat, 22 Oct 2022 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hsAXJnvDhdGEYHdFVs6ZsPQJBxXOr6Vkrm8tN3jfKA=;
        b=Tc+9bReccTVcBJtXvSY5mXWo22AMO3N8kNZU9IGYfInuNngCZLGFa+77IyML9bvQap
         8EbYh6StnB4lQNlNFkXwboIWTGEYJUN+XRd37H4mZvzm8mNjHfhZAP3dzx68H+Ruhtoh
         To5rioRaL08Mf1VEWMRF6CVw7fHwiJ2VtK8qmnY1wBiYD1vwDaKkvXPULo3j+Bpum0CD
         /GTmhyScpq+yLip7FgWN+TuGHItcdRtIK55JQLBMS1F7x0yHw6eJDQKlqdduUMq6QQq8
         ru1ny0Sc/pKdkCXhm6PF7A35Z5CgqbnKBHNbIT3Z8P4dvfVb2wc4K73IeK7N1NhoUFDq
         uR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hsAXJnvDhdGEYHdFVs6ZsPQJBxXOr6Vkrm8tN3jfKA=;
        b=22fN4QZtYoLxPlZ3ofXD8lLhyT+fjmLbIYjqQl6SRlBI6rwkx/QiApawJ6t8Jc9ScS
         P4hX3lCeKtoBB5dFm+0DX97GT8xXop93OUCaWbmGrKd8kFehfqtZprYdrD3tswD7zW06
         4Oqe1dLMAbQ7pM1KLPkEgTV4c3T5Mlq24jF33oiNP2q7adUGSzT0zcuHe8dNWa3ej7ma
         Jjew0+oYwWgXnuyXQRupAknvSD3euRRFav425MK1a1dzsP2VZds6/vKgo3f5bQqsc41n
         zcdfgQYRrYb0q/G0PqZdBKOnicCY/jACqJxqBiVtav4lPgWGD9Ilty/JwvyAY4ZLDJH+
         1ylg==
X-Gm-Message-State: ACrzQf2V4otrOJtgMO5cs3Mk1DJzt46m7k4fw4sus2b4bVX7f4Hw+Ouc
        8zeTQCzpdUt+b2hy9SoWalZfzCU/v+RA8w==
X-Google-Smtp-Source: AMsMyM4qRLdYWNzPMwjl8hrKdsHi/Oaq15mHY7N4nVs1JJZEkRpfPIotfOL1ELU3HhrVpOqcLmT/lw==
X-Received: by 2002:adf:e5c3:0:b0:236:5092:7cfc with SMTP id a3-20020adfe5c3000000b0023650927cfcmr6507269wrn.285.1666451579537;
        Sat, 22 Oct 2022 08:12:59 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-18-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.18.133])
        by smtp.gmail.com with ESMTPSA id u11-20020adff88b000000b0022e2eaa2bdcsm21310581wrp.98.2022.10.22.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 08:12:59 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 0/2] serial: 8250/ingenic: Add support for the JZ4750
Date:   Sat, 22 Oct 2022 18:12:22 +0300
Message-Id: <20221022151224.4000238-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JZ4750 and JZ4755 have an extra clock divisor in CGU called CPCCR.ECS.
It needs to be handled properly in the early console driver.

V1 diff:
 - splitted into separate patchset
 - code refactored to avoid peek in CGU register
 - Krzysztof's ack picked

Siarhei Volkau (2):
  dt-bindings: serial: ingenic: Add support for the JZ4750/55 SoCs
  serial: 8250/ingenic: Add support for the JZ4750/JZ4755

 .../bindings/serial/ingenic,uart.yaml         |  4 ++
 drivers/tty/serial/8250/8250_ingenic.c        | 50 ++++++++++++++++---
 2 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.36.1

