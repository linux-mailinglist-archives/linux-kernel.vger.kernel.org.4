Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06306D1443
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCaAoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCaAoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:44:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60B710273
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:43:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d13so18925013pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680223430;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Nh6wghJCLi6iSQ6tglI4Yg3G0qoglbH/jnqGu6JlHc=;
        b=snNtgbMxeWRQo9Fxv680K34bFazQibQcKc6zD+jN6Su4WV8xg80W/1CT/fsZV1xnPu
         kBKLJI5u3Rjdp4+lUZEazvuVJsAOz4zQb9QF8XsDtTLY9qfGIxrEvdEs0kHwLKl/9IVj
         jOT0g9y75Msc5pqyOhVIX4PeCuYE7hiGWj68dL++WEWmTVS3BPCOvyG7JRSl8iJySI10
         oPxyHDv0m02A4Zm9FXl1AEmJFmA2KLYbgo4k5u+79OS8mwWm2NVUuz1TWy1D3tkZJZhp
         bVwVaDm/hVsRhaoJRwWhFwPescSU5YAQkNMs0g2vDRfPJ+hjEmaF/pSS0HOjXQTNLIr3
         9iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680223430;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Nh6wghJCLi6iSQ6tglI4Yg3G0qoglbH/jnqGu6JlHc=;
        b=bYePtIs0Wace46BJHPsBVsowUPyrXVH9AbOI1Q9LTNbM93V023Pl2TIqUSfvNUz2Ix
         +HzUYHZNBRHx4zNfRkNBUEqxlQYdzYk3ju3D0O6vxTnsTTR+xbre1Q3eFUgpFTFrJBS6
         hOvCkDChE9iXoKutHka2K9zAwuHVp/Wvt3sbKnCqQMIl3vPZH7LIea8tqR5a9xwjTmTF
         wYR3Bh0QXdBvbZ8sFQp+5fvFML3g4/u9DRuRCNGr6GenHbTZKjwElVwiMDQs3DjNRo5Q
         stfPBTQpHQAikpt9CqiacIIVjAk3P/5h8RWOowx2EVOD7aWndF7sNrZeohyp4dW6swT2
         L8dw==
X-Gm-Message-State: AAQBX9fBAoiH0YHaxdnxctGuPShKpkQl43Bq1K+8muRbaaaW7JaTDXLw
        2IyxWoQbjIus6eph4E9YcWOFuA==
X-Google-Smtp-Source: AKy350ZpyU/dWJs87ZyCBxyHo1HqiAqZRtM7Q5eHJAFeRkSFooc0RQeeZi6psfEZf3OOkH+IY+dYJg==
X-Received: by 2002:a17:90b:38c5:b0:23d:3f32:1cd5 with SMTP id nn5-20020a17090b38c500b0023d3f321cd5mr26786258pjb.26.1680223430326;
        Thu, 30 Mar 2023 17:43:50 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b00192fe452e17sm299404plb.162.2023.03.30.17.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 17:43:49 -0700 (PDT)
In-Reply-To: <20230324121240.3594777-1-conor.dooley@microchip.com>
References: <20230324121240.3594777-1-conor.dooley@microchip.com>
Subject: Re: [PATCH v1] RISC-V: convert new selectors of RISCV_ALTERNATIVE
 to dependencies
Message-Id: <168022341598.16896.1867829754046036531.b4-ty@rivosinc.com>
Date:   Thu, 30 Mar 2023 17:43:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Conor Dooley <conor@kernel.org>, ajones@ventanamicro.com,
        Jason@zx2c4.com, apatel@ventanamicro.com, heiko.stuebner@vrull.eu,
        jszhang@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Mar 2023 12:12:41 +0000, Conor Dooley wrote:
> for-next contains two additional extensions that select
> RISCV_ALTERNATIVE. RISCV_ALTERNATIVE no longer needs to be selected by
> individual config options as it is now selected for !XIP_KERNEL builds
> by the top level RISCV option.
> These extensions rely on the alternative framework, so convert the
> "select"s to "depends on"s instead.
> 
> [...]

Applied, thanks!

[1/1] RISC-V: convert new selectors of RISCV_ALTERNATIVE to dependencies
      https://git.kernel.org/palmer/c/d34a6b715a23

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

