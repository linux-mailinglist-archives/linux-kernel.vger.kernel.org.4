Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED662F04E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbiKRI7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241108AbiKRI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:59:10 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138E31F9E4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:59:08 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g12so7193955lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NxaxFzNcdUjxkj1wWujP1qQSv4aJuIfgBun8CKSTJE=;
        b=fodFDbDC7l3QXUmu+TtEhItk9oGb8HZO6P/pYgALSsOz2fU9/VEUs1aiKtqfwys8PW
         J52ynGcqhLcuwvoFWcuXOJpueSb3cmg2rN13TSPib4jhMSvQZyRy3zscCMQU+2yUIKbP
         cF36ydCIzwZLKZvthtrwXbYHNjYV3ENhGTLEobkCZIxwQExD4HvTYiwuw9sriiT2MuFt
         LFIeIiGnAKxaK2TcWQQXB8sl9r/aGB7Zj39G1uDnRpsANlznM/EPS8rojavbxLKAwZ3K
         ql3ZuO97yUH0lImxFD7ryOVU3c3MrvojeFLXk6PA0VBBlz4M3Sjvl8QwP+YfNTE+eb3t
         Wxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NxaxFzNcdUjxkj1wWujP1qQSv4aJuIfgBun8CKSTJE=;
        b=WgxCQGboxnhfHUAqzfxUn6BM5WEDcznT7iZwCgFo6As9o6eO/CEuS4EkbhnEcAw9J1
         z4/8BkUaZs53DWday0rLfb/P5Gpt3seKyTChJ3Hyvv6RG3VQ3l8kRtPsj8yV27kXFG9L
         C7GWfUDTx7qwxyoX6hJsiIIXdi5CUgSkutlgm+lykibFkHdmAYcc0hurlUU+HxTnHAuq
         4IrUsjPi+NCydhAVORdY/QAditoMLjFbg+265VsOkqIZZr2QkKduXqqSaBiUF3m6eurF
         VnR4F0ICISnCKeIotafdyh7/iEo9zE7tPWaGLEBNkIaqXlc8eVeksZ7rHmPISDLLsnRD
         YqCw==
X-Gm-Message-State: ANoB5pmFJXPj+EirUZavvXS+//uSYHFH1D9z9vC1GxlOfNFaXBxqUYi3
        M0Y7AzdERCwY35gqbFqB9z6zOw==
X-Google-Smtp-Source: AA0mqf4ivMqG6AZhYndYtFw8VJ+Cx81bOUtgxOBSWZgbRaNrff5pJPmHvaixGx0HPFwOs5lSIQiEeg==
X-Received: by 2002:ac2:4e0e:0:b0:4b1:7c15:e920 with SMTP id e14-20020ac24e0e000000b004b17c15e920mr2439006lfr.453.1668761946381;
        Fri, 18 Nov 2022 00:59:06 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b0049478cc4eb9sm575398lfo.230.2022.11.18.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:59:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: lpc32xx: trim addresses to 8 digits
Date:   Fri, 18 Nov 2022 09:59:01 +0100
Message-Id: <166876193952.14422.18159441573911160164.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115105049.95313-1-krzysztof.kozlowski@linaro.org>
References: <20221115105049.95313-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 15 Nov 2022 11:50:49 +0100, Krzysztof Kozlowski wrote:
> Hex numbers in addresses and sizes should be rather eight digits, not
> nine.  Drop leading zeros.  No functional change (same DTB).
> 
> 

Applied, thanks!

[1/1] ARM: dts: lpc32xx: trim addresses to 8 digits
      https://git.kernel.org/krzk/linux-dt/c/a63ae7db698a58ba9450b24742394c0f16b2899e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
