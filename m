Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC273022C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbjFNOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244077AbjFNOqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:46:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8751BF9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:46:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-66682bd799fso107169b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1686753973; x=1689345973;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xLm4Mt5usYBeFNGXXmpqchycUZ5e+7+/NNA+W+5oEQ=;
        b=49iHWlJatBGNeViZG4mboIj2qlTs9VZj7DyRbWCL5LnSGfp0Aj9+hY19D9+3VSdN2A
         4DUUUQw2ZX3Iu/lhnh0TIf+ALlJv32JBuqtHHXpaF4MZHgbMzdWrJ4E/iAXSvrs6DR4x
         WjBZkcNF/zZR8TvhJI/X+/CtLQG2SJcqLeJd0wo39xNGTXPRy75+XrsHyzAITyGzQ4JX
         +f3zge/XiqE7uy4uUhvnfRrNCN88i57Zkxhb4UWaubvTsHakcfOmoREoQnWXJap/vNgA
         sGQStSQcBPdLAWKNuc6KThB24G7LWQIAgO0zLMX+qxQDilaQTzibXRnyokOSJRxrQ5Q5
         QbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686753973; x=1689345973;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xLm4Mt5usYBeFNGXXmpqchycUZ5e+7+/NNA+W+5oEQ=;
        b=Yy8e6voRulMtOftMj12YCryQniDGxFPYXEIGgUFMvtTB7l2n3w+BnEbYYOXkXi2Wxg
         MrEcZTApsAIqwe7PPuuW+t0iXJiBuWoxSCOxabeIt0EAFuQM1qUCYVz842d+RXXBHlCR
         ClhOjbYg6/n2qXau6xaXEckrYqsullBReBXCybmolkvngtsyT8iQirVJLXdSNchQ1+O9
         o3RHKscUenb+zSAplixjxV95VSWRoFAs0lIVgMBcSgPhWaV3emIIdp1xapHAy04QrJYs
         HmKGAtXT46Ug5NbhA3VQS/sc8YpejyjVpVDoOVYfGjv7r80UUPEbE9Qdzcsg9+s8toU2
         Ooug==
X-Gm-Message-State: AC+VfDy4Gbg+xxfgLwou7TWxs12pbEHy5vgT5wiBzpflx7PC2HP+75Rr
        LDl9ev1x4zuQAebeGy/xLet2tQ==
X-Google-Smtp-Source: ACHHUZ6LNRJOcGwpGUMflzElhsfo6fxzDZwXU7iTG2/LQOEYbmKryQ15aqEgj1/fDj7dn2k+yD7lDg==
X-Received: by 2002:a05:6a20:7484:b0:100:b715:8ab2 with SMTP id p4-20020a056a20748400b00100b7158ab2mr1854527pzd.46.1686753973511;
        Wed, 14 Jun 2023 07:46:13 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id y10-20020a63180a000000b0052c3f0ae381sm1423428pgl.78.2023.06.14.07.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:46:12 -0700 (PDT)
Date:   Wed, 14 Jun 2023 07:46:12 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Jun 2023 07:46:10 PDT (-0700)
Subject:     Re: [PATCH] dt-bindings: riscv: cpus: drop unneeded quotes
In-Reply-To: <20230609-discourse-lapped-5217cc4d7ede@wendy>
CC:     krzysztof.kozlowski@linaro.org, Conor Dooley <conor@kernel.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Message-ID: <mhng-c1f5c918-1b72-4a2b-91c0-eea05dab14b7@palmer-ri-x1c9>
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

On Fri, 09 Jun 2023 07:21:17 PDT (-0700), Conor Dooley wrote:
> On Fri, Jun 09, 2023 at 04:07:06PM +0200, Krzysztof Kozlowski wrote:
>> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
>> checking for this can be enabled in yamllint.
>> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Did you want me to pick this up in the RISC-V tree, or is it aimed 
somewhere else?

>
> Thanks,
> Conor.
