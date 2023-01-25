Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1633C67AFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjAYKjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjAYKj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:39:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C5D21A0D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:39:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fl24so91483wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2k3GRfdwQwoSZfn0KhpRa1fW62kWoYSQlgbY74Cf7bU=;
        b=FOVqUZqrtN8E+Q5DRtjfkrzBkNCleZcZFHW0hRhzW9+TtPoSwfTof6f2Ag8PW7Boh7
         xra7XAhHJzvQC3nDpcaLC6PC9wG4BI6qESpOot/T6BmqfaGm8HFg61ewtRxaFp5QerFE
         H4ucQGGjRmqNrFoWvbR0G36Gx6Aqe5XcysOVuncB+PA/Gl9cUpmexn3mYDgewh7CYeNZ
         u85Q+dDjhEM04R3p5i7T4Y+6i0wifZB+Ug2RFMD6zp7s7No5deUWb1yyVgOaWPh0Mh1e
         tj4XtqECGq0t8ygmcypULyvTikJcB0IVBB225tWhQpuKWFavraNTKhdY3dYM8ZYLmMfb
         TK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2k3GRfdwQwoSZfn0KhpRa1fW62kWoYSQlgbY74Cf7bU=;
        b=GOA5i3ESa7i3KOA+aVVypivj9xWB5XrjgUYKfJTG02ZqVjmCwWiGQfGh8Tvvy2sQuR
         r/GoiXQNzBkUOHUlgwIBb9WvoCIXQNTa2pnPA1/BqQEjV6FlLmu98DNjKKVJbvNV7SH3
         tPJNrtt8YvEibVYjW3sd47pCO2EuAZ41gzb5MbNSs9Rc0vvAf6c+3bBtGZ4Sz0T/L0Fk
         PCNu8VoDXs1z9+Iyb4l18MP0bNY/PiKD+G7vURAGG/iwl47nD+WQJlxFAI3PgOVTkQ93
         Vh1cckwM3Nd7sUC8ViaKk2GeEumQfcWD7lhvPMlLz150wNdqHcqQkx54YeW1tFIKPRNi
         QVMw==
X-Gm-Message-State: AFqh2krEV+5yIODzoyOyq2BUfYKGLPk5bMErteYoRhWFmChp/J7jFCvu
        K5aYWTZuxKaa/WLiQsJar5Qa2g==
X-Google-Smtp-Source: AMrXdXvi91mHEUaswxqklkPAxXst6bIFSak+wTtRWlR+XHNG3kZR3PTkuDFDIGYWSOnl2vaaqcivuQ==
X-Received: by 2002:a05:600c:1c01:b0:3da:fc07:5e80 with SMTP id j1-20020a05600c1c0100b003dafc075e80mr33641244wms.12.1674643164667;
        Wed, 25 Jan 2023 02:39:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003d9780466b0sm1386804wmp.31.2023.01.25.02.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 02:39:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Palmer <daniel@thingy.jp>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: mstar: align UART node name with bindings
Date:   Wed, 25 Jan 2023 11:39:20 +0100
Message-Id: <167464315348.338477.1343014919200110781.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151523.369225-1-krzysztof.kozlowski@linaro.org>
References: <20230123151523.369225-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 16:15:23 +0100, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> 

Applied, thanks!

[1/1] ARM: dts: mstar: align UART node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/5e4505d22f2c3c739bdd063e5348bca3ff34dae2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
