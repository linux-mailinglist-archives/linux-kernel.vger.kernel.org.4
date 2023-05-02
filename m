Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381D26F3BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjEBBFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjEBBFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:05:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE69358C
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 18:05:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24b725d6898so2046739a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 18:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682989518; x=1685581518;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd91ppODkhdQSeDsJCj2eoxzCnM7myNH99JsFWJo740=;
        b=HItlprmpUNSwtLo//rzIWz2tjmKjTcDnmKxKcQlKDhisDLq0nCMbH9DRPNUGW4uHHT
         025gFOKL/6M4GrjjMUeX9ajRuNwkRnRepj8Cx4SEdgOnjou6JkrtennuXfvXT4okgqwO
         I8r7ToBJDfH6kh9olhCly5weDpA+g8va4FMbByJ8CB8gKQcPZquu8Qktkg2Puq24R9jh
         R52kSz9SAoMMoM/+twnyemXvF6MKxiXRMBbx3Xdw1SPLqzdG6AFv6GdDzxpj+Q3yej3R
         8tpqhnORkKwNHo5/lpLelvDMLesEGOj+xxfOOuzIEnCu17lzZei64vDFSMT0PBFMofEe
         eMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989518; x=1685581518;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd91ppODkhdQSeDsJCj2eoxzCnM7myNH99JsFWJo740=;
        b=RZrj2HWWnHpbXg/rnPOorwGtkXLrJXW/cNPIsDYFS+zS7a8tT5dx/hUjiFpO+R1CAB
         6aa8Q1Smy2L1PHCGtHZxoGhsIaZhGfpStz5Pl8O8pfb55PQJcikp0hz8t3HAOIOG4Qio
         bm3nJlTuDk173k5RPM4gSFyHBMv9Yur2kPdsnS2lr3GBY3pEwAFme3g5lJC3tdQZrmYX
         XajGwTP9BY32yO8G5phe2CPdD0IzGIc7F1Lms5//AX7QCtX9u8kStpaRE1w+gN6Q2C4F
         sBm2Rqmw2MvBLRXpP58m+DJnJcF+4LtZM6Oj0mqIe/aHQ2I5BGrxV1tK1JWqYJWKHK4C
         UBXQ==
X-Gm-Message-State: AC+VfDyPxXDwMO/dh6PTwuzdGjRGYRSokgMswImtPXfHsx1e2Nht0ne4
        fNWGdtRa8cxXuNcTW0Fzsu8kxg==
X-Google-Smtp-Source: ACHHUZ7yKG3T46mlxxIAdbjBzW6yOKQOvv0uftti8Dnm8fbxV/qtBXESOiJcvFLpp/x2/ei2/FFRdw==
X-Received: by 2002:a17:90b:358d:b0:24d:fccf:7ba6 with SMTP id mm13-20020a17090b358d00b0024dfccf7ba6mr5349508pjb.43.1682989518048;
        Mon, 01 May 2023 18:05:18 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s23-20020a634517000000b0051f17e4e1b2sm17202045pga.68.2023.05.01.18.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:05:17 -0700 (PDT)
In-Reply-To: <20230427-fence-blurred-c92fb69d4137@wendy>
References: <20230427-fence-blurred-c92fb69d4137@wendy>
Subject: Re: [PATCH v1] dt-bindings: riscv: explicitly mention assumption
 of Zicsr & Zifencei support
Message-Id: <168298679765.11596.12636857720303602067.b4-ty@rivosinc.com>
Date:   Mon, 01 May 2023 17:19:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Apr 2023 11:43:42 +0100, Conor Dooley wrote:
> The dt-binding was defined before the extraction of csr access and
> fence.i into their own extensions, and thus the presence of the I
> base extension implies Zicsr and Zifencei.
> There's no harm in adding them obviously, but for backwards
> compatibility with DTs that existed prior to that extraction, software
> is unable to differentiate between "i" and "i_zicsr_zifencei" without
> any further information.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: riscv: explicitly mention assumption of Zicsr & Zifencei support
      https://git.kernel.org/palmer/c/41ebfc91f785

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

