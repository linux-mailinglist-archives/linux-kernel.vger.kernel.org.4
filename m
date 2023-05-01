Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2656F3A9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjEAWpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEAWpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:45:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2426426BC
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:44:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a9253d4551so23086985ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682981098; x=1685573098;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1WHrGanmnNt8uASWew+y3h1eCxRyqChW0U1S7kwZ5s=;
        b=11detkrEfL5rr1ljYPAAdxq3BuYmAJjReWFXB17Iyeuzhsehxpr9j6ExMoEw6f6mGz
         VnfYQcKNf05/7Zk+HZ+iKZiZS1aJWirivZ2nGhg7AcP7z9GAttcF8f0eb+YtpUusJUQc
         c2Ez3hS9zZcufRdKKJWy0Q0yXIwhqZPiVW5/qXmBiYDFL7qvYGukmDBmthRY4bpJbFTD
         2ZSRA4t/4vaLRO6RMehiAoUQ6BgOKgIfnAPoM5NTHszy2KbgXuLGXqUkJuNldz7w3ouc
         22HEgPCYMVNKvkopEkXVXVhL6VhjO5eU3iI78v62nocZJhZBytcDUuic4Qan25ZITVYj
         UqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981098; x=1685573098;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1WHrGanmnNt8uASWew+y3h1eCxRyqChW0U1S7kwZ5s=;
        b=foGo2HL7T+cW3jHaDsyjBGaU1kSecMEQA2Vb6aLw9lWUV28rypo8tvabJSru9xl2fY
         H3YXuQ4C/bXaOkE6bX2b/6NZdNtbp13Y/TkQsLWYoSBfta9CKDUGAcHfu7bnObMwGdwJ
         bsYGkn3OoxxDxj9PcUVvI6IHgPCZ9+t0c9wnjOgBwrCWbMCMHcq3++UvNZVaHVDQ85/J
         BBTWFnu971BiFc6UKMkp8MQiXytdclWQ8dJyWldHGqbjsRNJnqIyBr93H46YBpWotMMr
         hqmRN1FdZfGI8BTpVUzU7H2Ep1gAfeT8Lfu5cQB3oQRfg/A2V/hyom0IW9wzhUj3kSfZ
         x1WA==
X-Gm-Message-State: AC+VfDw6OVyWg3ZYfJMMqTKnfIW/DX0toJzW33/iic26IZidUaiFOGI9
        8uuQAeEhWqvYB1qbfv11IUs81g==
X-Google-Smtp-Source: ACHHUZ65+5jmJQGg62lzHtAux5EwaHGRV58fHKk5Z4NvG9vBphpWaVTHw+MJ1oesU3gmRXkqOxrFIQ==
X-Received: by 2002:a17:902:db03:b0:1a6:e1ac:ecb8 with SMTP id m3-20020a170902db0300b001a6e1acecb8mr20638813plx.43.1682981098628;
        Mon, 01 May 2023 15:44:58 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090322c200b001aad714400asm4573023plg.229.2023.05.01.15.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:44:58 -0700 (PDT)
In-Reply-To: <20230426100009.685435-1-suagrfillet@gmail.com>
References: <20230426100009.685435-1-suagrfillet@gmail.com>
Subject: Re: [PATCH -fixes V2] riscv: mm: remove redundant parameter of
 create_fdt_early_page_table
Message-Id: <168298107614.32296.13970329837227173007.b4-ty@rivosinc.com>
Date:   Mon, 01 May 2023 15:44:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        alexghiti@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
        anshuman.khandual@arm.com, mick@ics.forth.gr, samuel@sholland.org,
        Song Shuai <suagrfillet@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Apr 2023 18:00:09 +0800, Song Shuai wrote:
> create_fdt_early_page_table() explicitly uses early_pg_dir for
> 32-bit fdt mapping and the pgdir parameter is redundant here.
> So remove it and its caller.
> 
> 

Applied, thanks!

[1/1] riscv: mm: remove redundant parameter of create_fdt_early_page_table
      https://git.kernel.org/palmer/c/e4ef93edd4e0

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

