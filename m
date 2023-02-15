Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757C0697EED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjBOO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBOO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:57:44 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4752885B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:57:17 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d8so19264215plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+Mbl0g6rewAZqcNNK0K4K6/jg8bNiR+3LrvTe5CXU0=;
        b=R7NKnKseIJblxJGMzPtGV9aTTUQtppTr8LzibxegG+d0lm9BmuOA2OF+BTHeQvqrCe
         5ZNl88t4L823SCvY2yyUs+oAURFnCGq5umOB4sI4z07myF1sal+sU7wxQW+zLtfSYlbk
         MCHMlAAkUGO6h4EW5USkjmIKYSfNPt2SIoyEwPRH5wmYLdkfrAjwCPgZuFZ+KgZzB1j5
         7vsjNve5YkUwuItC+eZ3S95C0XSqxGP0SarpoT7v1eHKaGs+/okzbyNR5SZwBeMkZe+u
         MxsbgOWh34KIUQC/7lZhkDZDDO0+Zr95MB38bIJwXeT1qZOzEsP6Pn9GoywCjHMos9xo
         bwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+Mbl0g6rewAZqcNNK0K4K6/jg8bNiR+3LrvTe5CXU0=;
        b=WX4eTy4JMBSNUNCEkNzSnaYmjSPbDOlF5rxFBOwTCZq3XzAYSu4Q7giZHdtXXvcZ4w
         KKuyGz7qTrXIn1gbLLzkQVurSmZMO5CSUE4OExnjzVbcx5xmMIqFWLFxQMa4Y2SrVvPz
         e9/ozOk2/oADZdOVytOKH3uWu7yAAvM+RMw04B+Ur7lg+oY1beT5B1ra7QCk29FP6fZ6
         0AEfY0/q8HqmQ12mdHUTUgz9Qg00vNbxS4oGglb+O6jRfopq9ClERWciVQrQpbno5HP1
         w3XxQR7F5tcCS27Ot+FfskBKdbmY9XhVGxJzljyEebA5NnJm6kQ+Zj8OeC4jlGQTuil4
         3SdQ==
X-Gm-Message-State: AO0yUKUMtAmqSVS+TxytKBYfw0C9Q+gmTlvuSEz6eFdQt093V+YVlNkM
        6Bih10ev2FL4/y7nBq4ToZ2mng==
X-Google-Smtp-Source: AK7set+C2IE8RdyZmZIecSJN1ZBeTM0z7D1/QOI9JCjcCUrwDOjXDtQA8SEK7NrNq7HN69Y0dpnGXQ==
X-Received: by 2002:a17:902:e847:b0:19a:84db:76ed with SMTP id t7-20020a170902e84700b0019a84db76edmr3262322plg.15.1676473036641;
        Wed, 15 Feb 2023 06:57:16 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090302d100b00198e346c35dsm12318576plk.9.2023.02.15.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:57:14 -0800 (PST)
In-Reply-To: <20230212021534.59121-1-samuel@sholland.org>
References: <20230212021534.59121-1-samuel@sholland.org>
Subject: Re: [PATCH 0/2] riscv: Fix alternatives issues on for-next
Message-Id: <167647301913.19800.7426585067377523860.b4-ty@rivosinc.com>
Date:   Wed, 15 Feb 2023 06:56:59 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Christoph Muellner <christoph.muellner@vrull.eu>,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Jisheng Zhang <jszhang@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2023 20:15:31 -0600, Samuel Holland wrote:
> Several people have reported that D1 fails to boot on linux-next.
> Patch 1 fixes a bug where early alternative patching used the wrong
> address. Patch 2 fixes a separate issue where the Zbb alternatives
> are incorrectly applied based on the 'C' extension instead of Zbb.
> 
> 
> Samuel Holland (2):
>   riscv: Fix early alternative patching
>   riscv: Fix Zbb alternative IDs
> 
> [...]

Applied, thanks!

[1/2] riscv: Fix early alternative patching
      https://git.kernel.org/palmer/c/bfd6fc5d8014
[2/2] riscv: Fix Zbb alternative IDs
      https://git.kernel.org/palmer/c/d5a7fab7859d

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
