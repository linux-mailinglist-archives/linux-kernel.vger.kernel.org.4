Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C560E5E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiJZQ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiJZQ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:57:55 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C667A9D508
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:57:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w29so3267950qtv.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nk4FQh9FIRW9ukOBEKqKGc+wpz7Fqj2H4Wc1giFHF/Y=;
        b=KIcVHBayQqeA+p/QvvzkGZ1Sh6lYzDdqlIiaJcGWaKBG8nq2n2lvdLc92K/mYYepAV
         sNKTzm2YLr7tL6sBPBlqNpW+WdHFxxk/x4H3+pDUZds+xXBM3qvkDjeAumb7MHShhH0+
         Bw8Gyh9tVvQq7TNSw+ng/lc4VOlYI7n8m45wCh/Zbqlq/bnLzcMjq5Kh9MpVHEkXbGdt
         hsCpw7wvEYW0pE1H8D3ljQnbUqKQav3A93ItvHcDmOIDZwgMDGFuL5WGAN7ajUIkgoHR
         emzkAgkwkc34lmJrjiFSgrur74z9UDz+bBaHx8VvEC4yY2ReO3RsVGoDnC6l1qWkIYvf
         StLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nk4FQh9FIRW9ukOBEKqKGc+wpz7Fqj2H4Wc1giFHF/Y=;
        b=XYbhpglIBGvwYhfru6fB4DclUCzs5D29dzbBDS3N3XV04v7mlk2YtIStp/eiTouQ/U
         4HQb5T6N87tfj/g/7FUCGRMPWOgRfp6Q6dLJBv7URFFv3KvmbB5PXDI3UbGp3K6kJT+F
         UBjRcX4i/VV+jmAx/FVeOXSyrugi/7psjN8H4AaNXPI9NvtqUIUZHPkPT3KJuTEoFSxx
         k4LiN9nPKxoQjc+kmxRpOIt9jfAAzPTlDQXLG5NzkDjvIiRB8w4HzAEsIGFSaqgU7jp4
         mJrLNbZPw4qAPRD1Vka0CUyQ2fvmg3nvj7UxvoayO+4qbtrA2T1v2LWctmEAxXC/OYgQ
         hPtw==
X-Gm-Message-State: ACrzQf2Q1vojYoL+QldbciDUENZXVUjW7hw0Eu7HFn1QHq87xH9efRDE
        v7x3FtniVPPIFCwbhk+pggIr6g==
X-Google-Smtp-Source: AMsMyM6GAuIHkol+76uJHyE/7/LS/KOkIBLGnhzlv+FJpJns+JSteBtrFePlHGYXFj7jxp/vqYekkg==
X-Received: by 2002:ac8:5c42:0:b0:3a4:ba3a:99d7 with SMTP id j2-20020ac85c42000000b003a4ba3a99d7mr6447673qtj.128.1666803472469;
        Wed, 26 Oct 2022 09:57:52 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a40d500b006ee8874f5fasm4360759qko.53.2022.10.26.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:57:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] ARM: dts: kirkwood: correct indentation
Date:   Wed, 26 Oct 2022 12:57:42 -0400
Message-Id: <166680346261.49767.15441308309372947389.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002092007.68955-1-krzysztof.kozlowski@linaro.org>
References: <20221002092007.68955-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2022 11:20:05 +0200, Krzysztof Kozlowski wrote:
> Do not use spaces for indentation.
> 
> 

Applied, thanks!

[1/1] ARM: dts: kirkwood: correct indentation
      https://git.kernel.org/krzk/linux-dt/c/eab1e9105a93922d62bd5d158fc11d4b59ab0fce

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
