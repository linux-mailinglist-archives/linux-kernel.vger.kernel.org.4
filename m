Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49915FC8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJLQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJLQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:00:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C920F7E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:00:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h185so8838642pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2lvFXzj1B5AbFhRx0jQ0CX63rE8hZfFVslgge4Qybs=;
        b=o7zR5YOCdpSYtKJk/cFHbC2zAt7QwxSG5H2JsihQkXq2yIMYUJ9KHWNAlAZRQCFS+5
         O3R++Z8N9Q1jBlXTdarjJSH4CzpGC9skg9+iwMqhbILhx5y+M2NWUn2cxezcrIwXHeaF
         +SgzRw/Tuk7x0ZSmZ991tXAXpz3bzVLm9DCfvtnveT+IgtQTzCF55niQDpStbGmB3Gey
         UrMLy+B42UyIKWl1HWl1g1jkMYXRIwpAVOuWjL9w3OWgGcVz2Tz+mYgv8n1U1zxwzxn0
         mw82v7xinaLpon6ig5zi6Eezu/BwX80vy3evLw0dQm7qCfWaF9UXett6WQWJAhTgNwdC
         6kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2lvFXzj1B5AbFhRx0jQ0CX63rE8hZfFVslgge4Qybs=;
        b=D3OtFqFr7+TvxI4PDbcMQ5Y8RqHuKnXdD0hCrb0y5PtUoiYGjTrGCnH9rP798tS/rl
         5iQ2EoiSTy1xHZMRbm429Yq4qBiJIWMcAf6k1W/V4nbLYRLp+qSvIRWxzwZAPjZgRPEr
         Rq06SyrILwj4RjcIjl88tYCgSMwgmbOc92FtIeLy6K2gT9l3aIMO382OnDpKrUamcacL
         87xMmQpmyPP4Goa3SpVmnVe4e64ay6bIhHkkM0Cjf7o3hzrfFb0J78FBNEaepUirWOi6
         uBO7/vJ/wpJwH+H9JwEJGfpjQZ6+3ByyzVXxJZROM91NfNOB1nJD8JyNf47AwIm/Llg8
         1kHQ==
X-Gm-Message-State: ACrzQf1AsPmk06r0q2ipX6NlhwAXkzPm4siqVZujD9mW8lC0roaifTKZ
        P/kpOtpHZLBvf7QDWh4F1rnNzw==
X-Google-Smtp-Source: AMsMyM4L7kfhQ6titzJtV6W57V3d2nORtXiwltbKsZB7DHCP68SPxamj3WMqedvmtOyyzFy67jgm0Q==
X-Received: by 2002:a63:5761:0:b0:43c:5940:9176 with SMTP id h33-20020a635761000000b0043c59409176mr25604652pgm.65.1665590400186;
        Wed, 12 Oct 2022 09:00:00 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090ab70600b0020d39ffe987sm1630094pjr.50.2022.10.12.08.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:59:59 -0700 (PDT)
In-Reply-To: <20220728210715.17214-1-palmer@rivosinc.com>
References: <20220728210715.17214-1-palmer@rivosinc.com>
Subject: Re: [PATCH] doc: RISC-V: Document that misaligned accesses are supported
Message-Id: <166559036448.27925.6190896060696605736.b4-ty@rivosinc.com>
Date:   Wed, 12 Oct 2022 08:59:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
Cc:     linux@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>, corbet@lwn.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 14:07:15 -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The RISC-V ISA manual used to mandate that misaligned accesses were
> supported in user mode, but that requirement was removed in 2018 via
> riscv-isa-manual commit 61cadb9 ("Provide new description of misaligned
> load/store behavior compatible with privileged architecture.").  Since
> the Linux uABI was already frozen at that point it's just been demoted
> to part of the uABI, but that was never written down.
> 
> [...]

Applied, thanks!

[1/1] doc: RISC-V: Document that misaligned accesses are supported
      commit: 06267eb2decaa6baac81bbd882265a8e7782dba4

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
