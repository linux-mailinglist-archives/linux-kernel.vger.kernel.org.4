Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BC5FD423
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJMFPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJMFPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:15:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42560DBE74
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:15:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cl1so882067pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jjzSbquCGIpZBdOT7nOgHDr2hdlUw8WRIsF1vsL4Nk=;
        b=UKqxWkfM/aMOqDYiA3dhhALbROWYdi3V8SUNyNVkCs0PTqmV52wr8cxoold1Ip2j70
         njd8Rq9HVQ1M6N4IJJj3lh1ZGnFJekZ0LqTJYq6odww9cAWdgqs8aNs1BwLvtH2jD68a
         UFjMmiUXXyDntoXChizYt9EfaT+oVLKmOQrS4H/IxbGj4yu6QhHnDV4Tb0tbIhMOZBGq
         +XB4Gw4YMwWBqMDS7PeTnlVTsqil42mhqHIDek3b4/uJC8SDS2x1yRWenHwmrpyxl482
         6tnDZ8GmiKAI6/wm4fXhUTwSXyfg6J6T+cS8eWTeM7dAmkh9ScweSoudEiHi21BFahja
         MTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jjzSbquCGIpZBdOT7nOgHDr2hdlUw8WRIsF1vsL4Nk=;
        b=wkXd8TsidFhDNkVlouGsagH/6vgJDRAJFtZiODPl6FzXFSlcgHN1KsOufmOW96rCuw
         cnW3ketsA8iGFAlyoasELsV75iec8zFcRL/ElZpOIL7s+toW5Z7TWBwIdf+Z6FtEVzAG
         wbqC6wRijGYIhKZEz1iAk4tFYVWqUOpRo/C4J63gcaOiJHuPXvZSR4mMYt8qL+LmH9M3
         sctbJOh8sq6MbZOeIMuQRM3erjERlMZDnVagsib3aj7fPxzZSTCBN1N7YogQ5oJK/KAV
         fKPFJkivWDlgWmj5PiFm7j2WKihT2sc9v3QbIh4C2/Rce4qw462qnW1FJ7USFMVgYA3k
         SQ/g==
X-Gm-Message-State: ACrzQf2GZ+nj1vgb5igqpKOhCWxodm6Q/Gk7ZtFAtfHzKoagh67uLaP8
        ELdZMK1xUu7Zz54RwnH5yyM9bw==
X-Google-Smtp-Source: AMsMyM7n13PJvUAYFtfq5Tw2ZISk2AiYMgqsFCw4SHVk4/QZn3nYBJI6UNk4g+wo3EqfDTnMhqMd4w==
X-Received: by 2002:a17:902:ef51:b0:180:7922:ce40 with SMTP id e17-20020a170902ef5100b001807922ce40mr28773522plx.8.1665638149701;
        Wed, 12 Oct 2022 22:15:49 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 24-20020a631558000000b0045feab454f6sm8632449pgv.51.2022.10.12.22.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 22:15:49 -0700 (PDT)
In-Reply-To: <20220823183319.3314940-1-mail@conchuod.ie>
References: <20220823183319.3314940-1-mail@conchuod.ie>
Subject: Re: (subset) [PATCH v4 0/4] Fix dt-validate issues on qemu dtbdumps due to dt-bindings
Message-Id: <166563815015.20405.16941289599227550003.b4-ty@rivosinc.com>
Date:   Wed, 12 Oct 2022 22:15:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-2a85d
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Sagar Kadam <sagar.kadam@sifive.com>, qemu-riscv@nongnu.org,
        devicetree@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <mail@conchuod.ie>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 19:33:16 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The device trees produced automatically for the virt and spike machines
> fail dt-validate on several grounds. Some of these need to be fixed in
> the linux kernel's dt-bindings, but others are caused by bugs in QEMU.
> 
> Patches been sent that fix the QEMU issues [0], but a couple of them
> need to be fixed in the kernel's dt-bindings. The first patches add
> compatibles for "riscv,{clint,plic}0" which are present in drivers and
> the auto generated QEMU dtbs. The final patch should be ignored for all
> serious purposes unless you want to wash your eyes out afterwards, but
> JIC the versioned extensions ever come up, it's there.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: timer: sifive,clint: add legacy riscv compatible
      https://git.kernel.org/palmer/c/826249942679
[2/4] dt-bindings: interrupt-controller: sifive,plic: add legacy riscv compatible
      https://git.kernel.org/palmer/c/6e965c9bd738
[3/4] dt-bindings: riscv: add new riscv,isa strings for emulators
      https://git.kernel.org/palmer/c/299824e68bd0

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
