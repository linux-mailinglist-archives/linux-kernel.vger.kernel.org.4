Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D282460E5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiJZQ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiJZQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:57:53 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E4795E69
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:57:51 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m6so11030010qkm.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYncI9iq1pDXu9ob3vX3woC79Xi+GcEdWFaiHxAv4cs=;
        b=vjNd97uE6/lUxlklcedmQU5BK0kwqnrglytRWk/Mt0bakrpewIs8SuNh7nyx0F8XJu
         WmfaLc3jjLEgW8kp682wv1/N2ZbOsHEjgXbRZ+P2aOV58FAmq3Duz+ySDldO/eFhL+jw
         0+bgads4K/z1I/QFWnnpMzO6w1Fpu/0RjtelDnWjdLx2cyJpG2+uCD5r5c/pdo/t2WTA
         Bpr6dGGQnRDw6FwOWl+KUiErf7OPqmpX+e0kdALO8YSEMl5O2AfVY6qxHMpky8w2+jnP
         KqBetI4aH0Q441fwsdb4N/dG+mMuOYlAr75ACwjsC6KHVkZNNL6H1JJ1OoZfUSVPHN0c
         CbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYncI9iq1pDXu9ob3vX3woC79Xi+GcEdWFaiHxAv4cs=;
        b=bSVP33dP3ftgyg7HslLANxnALf88qkdYNx9Tmf2Hw+ZerJVd3a4mF1HgfRDU5aMQvD
         LerX8/ern/b06fm0np0JgJ7zjZt1DVWC41M39GPGlkBOOa/q8Z1blxxeKN5FVmn6nQyL
         Ka2NjVWaJrsYMqAIlO0yjl6BvowcQUu39/3AoABuuP4Qd6eXzOUDblsMXtrj7+T4qA2b
         M7to02hYh5V2jtoot0/1NcmZkKmf9Qk8FWr2APnHvo4pKJyNRFm4JG6I8uBqbAZNS8Us
         RPxEJi6zMC7ClNMyDuYaPEJkFWReSa7TnIVIhWyqeh50w+JMnVwGbq+HLL408LsZ/rOV
         tZ/A==
X-Gm-Message-State: ACrzQf2vB6IyVWk1cJdZ72kGAPQxOH7z83Uu6J2HBsgZWPT7zZU4dwHO
        g189LNLBF9EmaV5ktzy2Kx5vAQ==
X-Google-Smtp-Source: AMsMyM68uIT4uI/nLKrAReT2Gg8+sF1erjHZI4opwTnws2cuUsk5iOrGknrwZBZXk/BpXIiATitubA==
X-Received: by 2002:a05:620a:24c3:b0:6ee:d4bb:e5b0 with SMTP id m3-20020a05620a24c300b006eed4bbe5b0mr31286865qkn.471.1666803471057;
        Wed, 26 Oct 2022 09:57:51 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a40d500b006ee8874f5fasm4360759qko.53.2022.10.26.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:57:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] ARM: dts: armada: correct indentation
Date:   Wed, 26 Oct 2022 12:57:41 -0400
Message-Id: <166680346261.49767.17898258491384283819.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002092008.69003-1-krzysztof.kozlowski@linaro.org>
References: <20221002092008.69003-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 2 Oct 2022 11:20:08 +0200, Krzysztof Kozlowski wrote:
> Do not use spaces for indentation.
> 
> 

Applied, thanks!

[1/1] ARM: dts: armada: correct indentation
      https://git.kernel.org/krzk/linux-dt/c/a7569f7d21e7a8b4196600672e25039fb58bf322

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
