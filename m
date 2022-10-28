Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AD5611D63
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJ1WXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJ1WX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:23:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA82E24E393
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:23:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j7so2156198pjn.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Ihcw8NxFdUArfYGoYPQQdxW1/H3YB3VcR84XFdSGYw=;
        b=qkUdA/p6Q+cT+8qbm8kiLgu1x0YNjH2FbQwsJNCU/3V9tcobjtro71CSmddyIPYZX6
         WOZqnfgUhhOrytqaJt9vv3HUx7O9tFANNfKCRymPc4g9slE2WjBb2B8slG58lAepI3cs
         GLmZtln4A6EKXTQMy15TsD2yJRUd4/fl5R9DcsnxwUmruYwYUsHF3bnz2KdeEbrk2aAt
         x58BOTPidIbZvqmYVLOOVPMd/HSU9qktmEYSFZfD687C9FizvVUXcS2aKY3ULTaOJMTt
         G3hspNTEafiQsVXYU5Cp6fe6OXnowU08tTf+2MNkxhIg4r2HsEFqmmuq5r9HD7nk+hRs
         ntGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ihcw8NxFdUArfYGoYPQQdxW1/H3YB3VcR84XFdSGYw=;
        b=JGw3bu+qsOTVHKEtGHb9cRFbLmclpFL7VttkOk5I+iwqOJao6mKftJ3GriKIAxavkJ
         JcE9Io4KPDFIE2YkSI7iNjnuFDYPxzTME7dYsA2jb8zinpq3fmkPICmBjfH4CgkoufFI
         EV9pK2QXvUdZ9VK8hI6CTTkdHkuEZ2BLdSIrf2hbZ9gtnrM/Pp0c9erfDUP8aFhkh41g
         2ID5enh3G8BA8+WwS1ynDeGHLq/QRLFlgm/mucC0/nunuQMvSQ+DuUhwseBmV0QfJjN2
         BlM0C2ENRlV6N7ljuEUpc8vL9guzxjFSzczILXBTMCuzlW7mWDoPqzAA7v0N8W3Rzn9T
         i7Tg==
X-Gm-Message-State: ACrzQf1mThjbVaFhZzeJU1a5HFoyxJno3LG6xRmzKUix489qGq5J1QOo
        ArjNSfFf7fdlSwdCegGBP7yXRQ==
X-Google-Smtp-Source: AMsMyM5FkW8lXL0j94ViobvJHEOvz1kLRmJFT1+V9+Q2wyOOwmHy+AcAQB7vEC9Iy2KxwNKEI0ahRA==
X-Received: by 2002:a17:90a:dc10:b0:213:90f3:27c9 with SMTP id i16-20020a17090adc1000b0021390f327c9mr1517757pjv.240.1666995805267;
        Fri, 28 Oct 2022 15:23:25 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d16-20020a170903231000b00186b04776b0sm2537002plh.118.2022.10.28.15.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 15:23:24 -0700 (PDT)
In-Reply-To: <20221010182848.GA28029@watet-ms7b87>
References: <20221010182848.GA28029@watet-ms7b87>
Subject: Re: [PATCH v2] riscv: fix styling in ucontext header
Message-Id: <166699579461.30369.17737854094128986667.b4-ty@rivosinc.com>
Date:   Fri, 28 Oct 2022 15:23:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Cleo John <waterdev@galaxycrow.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 20:28:48 +0200, Cleo John wrote:
> Change the two comments in ucontext.h by getting them up to
> the coding style proposed by torvalds.
> 
> 

Applied, thanks!

[1/1] riscv: fix styling in ucontext header
      https://git.kernel.org/palmer/c/3558927fc2b2

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
