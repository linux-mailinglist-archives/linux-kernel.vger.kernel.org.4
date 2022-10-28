Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA7611D61
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJ1WXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1WX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:23:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA424C115
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:23:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b11so5803728pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96klAYK4L8VEW80FVp8o5wKDkKqz0+lk+6pkw6OjoQg=;
        b=ccsxS6QdpCQpwhqNvcwYJAR1mDDSkq70idXCUyZO2Wir6nUHAmexSdcHETJ3EB5nuE
         ODsLCIR02AIieFRK77tygtI0kSzdDCMT8cSoROH3eoUVB5zpOc/6mdz09qfktv/jjZOW
         FSdSDKxOsCPqHs8n7ruTtKsOfBo2qAs6y9cZ0ECUskSwV+LzJnjqx/898J8B+BKzpwis
         qWhuDvYiCRJNtfHLq5c3ZFHvBc6nUrDNsTfajC/i/xNaUNMKQgiC1rQNYXSjOqyBm6T/
         8RBytLABDk+8GhK0z7i8sYcgZbjaajGs2GUTltzl4dKlXHh+LL5StwnZlsMnerko7X/e
         SRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96klAYK4L8VEW80FVp8o5wKDkKqz0+lk+6pkw6OjoQg=;
        b=Qb3/M+IpnFhSR0PCGDTnsQaKNpCQJhCkWmPTktYvkd+JDZ2U5JryqCONeHvkWZtmP6
         BsPj4dtQ/sgYk0r7USjFB7Ke05kgq4489JWUe2PHelQoYWS+uFgDPqKhJFIBKn3Ed4MS
         2p2WMNqsqyXT5E+1uH4y6Hoq0J8u5KXuKlpyca7YT/5RREOeo/tpR8GOmtwIeDiywCck
         petPIzrXFI4EU4pN4ilUxv0zNxEOeljUBYtN/zvyRhCXwvERIi7XI0vpZCG/BpCQrYiV
         PmrpUWWscaYeImM4WMOkK0WQYAJm6LY5Bj/9LfNkHtYDtp+VRmo35LewQN6zyGbIUM3T
         MMsQ==
X-Gm-Message-State: ACrzQf0JrdbZ36DviGiP2o/cPM3RIsTPEfOkl2ZnRCh1rPU3y9b7E6rE
        9yDLYCV7Ilj90UIo1HmbvXANXw==
X-Google-Smtp-Source: AMsMyM7NCYwLjSbnYw0R0TQbhwQQSDLXFmIgXkUJ8uvNv7e161hQ0A9j/RA9KUs1OZ5GdsA98OYv7A==
X-Received: by 2002:a17:902:e944:b0:179:dee4:f115 with SMTP id b4-20020a170902e94400b00179dee4f115mr1240644pll.141.1666995804162;
        Fri, 28 Oct 2022 15:23:24 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q10-20020a170903204a00b00176e6f553efsm3482022pla.84.2022.10.28.15.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 15:23:23 -0700 (PDT)
In-Reply-To: <20221009134503.18783-1-tjytimi@163.com>
References: <20221009134503.18783-1-tjytimi@163.com>
Subject: Re: [PATCH v3] riscv: support update_mmu_tlb()
Message-Id: <166699579458.30369.3811976740296212930.b4-ty@rivosinc.com>
Date:   Fri, 28 Oct 2022 15:23:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
Cc:     falcon@tinylab.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     guoren@kernel.org, akpm@linux-foundation.org,
        alexandre.ghiti@canonical.com, anup@brainfault.org,
        Jinyu Tang <tjytimi@163.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        tongtiangen@huawei.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, panqinglin2020@iscas.ac.cn,
        maobibo@loongson.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Oct 2022 21:45:03 +0800, Jinyu Tang wrote:
> Add macro definition to support update_mmu_tlb() for riscv,
> this function is from commit:7df676974359 ("mm/memory.c:Update
> local TLB if PTE entry exists").
> 
> update_mmu_tlb() is used when a thread notice that other cpu thread
> has handled the fault and changed the PTE. For MIPS, it's worth to
> do that,this cpu thread will trap in tlb fault again otherwise.
> 
> [...]

Applied, thanks!

[1/1] riscv: support update_mmu_tlb()
      https://git.kernel.org/palmer/c/1b52861f0e04

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
