Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1D701C5F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjENJEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjENJEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:04:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7161BDA;
        Sun, 14 May 2023 02:04:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ab0c697c2bso107072655ad.1;
        Sun, 14 May 2023 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684055081; x=1686647081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sr7He/pCNojPfEjyfoxTnVv2pnOmIOyhXbpqNpYspU=;
        b=pU95jA9oIE1XSndkuY4s8vJgdRJJfI0HZkVmmBo5BOdwDhCA/RuhEsNJdPjXcHvNOr
         6x3nsKHgsva2nibluFKpYw0ScZ5MClmNtKpWYUTbMylQuMwkQxQAa5MoJFC3uOEhSzS1
         TkmgM8YB/3mNslhO8KqH7LCnRDH8vHy5dQY2AZ8m83IpPd/QvdkED9Cv0SzhvxI5fXPD
         R7NVz3tws8acj78GzdyXRjDKsrEWVoeH8Q4UQY39FfX24WhUE1r6ShA5+0Fr8pn/+AhU
         2my/8FY11x27Hy6RwaQ2SlUfsSqrk3TykCpbB8bbnVCxwK3RQSvRwzu82ptZcttyeCWT
         IpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684055081; x=1686647081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sr7He/pCNojPfEjyfoxTnVv2pnOmIOyhXbpqNpYspU=;
        b=k4EmVmK82FCCJaZKtboIaYcjSXtLMPwOD4HCUmR6kajRDzYNUh93YXF+fSnn0gmn51
         LZ8BZB8ve2jwalf2Wg/9daaACpy75AYTngCKVPUV+Im8VsdCryfnFx2uBQPvnb7iMhiO
         8jq0ud9t4bnEagxihXV6nj8+gECaJWtJWdED/hXZaSrQLo96e7hd7AfOTg4VDO+qMRPo
         3O1FxbSk9DqmhCIU0zD8OLu+xyIeTK90r5cZ4/sEKRc2g9m39Nrh3j8jrUSuVC2LeuQo
         fpFjkHj8fPXz04LGdvgiFSDWvd48tDiw1oAeUwUnmaV63YS/FTm3wb6LzUDhgxwtvvSr
         bETQ==
X-Gm-Message-State: AC+VfDxMgiCSxEn9K7fDXFmOcMWgYEoD9HglJHD7ae1oABKUh/9FcD0h
        5QrW6gEGyA1i41kJYqe6ZkU=
X-Google-Smtp-Source: ACHHUZ7hQdIgm7/AWlnFtJBuPivBY+vCFVmAsf7EHDdFk+J5nlxqit/d6Tr2NaJ3D3VaTaQYaEMRJw==
X-Received: by 2002:a17:902:ec8a:b0:1aa:f3c4:7582 with SMTP id x10-20020a170902ec8a00b001aaf3c47582mr41892841plg.31.1684055081545;
        Sun, 14 May 2023 02:04:41 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709028f8600b001ac5b0a959bsm2786455plo.24.2023.05.14.02.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 02:04:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6E5091061DB; Sun, 14 May 2023 16:04:36 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux RISC-V <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH 0/5] riscv: Fixes for vector extension documentation
Date:   Sun, 14 May 2023 16:04:27 +0700
Message-Id: <20230514090432.78217-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=bagasdotme@gmail.com; h=from:subject; bh=awthxNyEGnmTtC0cZTI98tjXN2G3v5UMQlRNSz4sBY4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkJSyQeZ8QJO847+NKqMcv795Lqp9eM+I+Xr+m9d+jof mGHw2tzO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCR4kuMDJftfgarqTyaaXx0 qlhWZITC5SeH1fk4YpJDy+17Jsn7zGNkeHkhbZLg+51rH3f6fV4Z9+j6bI/jz130dvyWXfRQfnb rSVYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are documentation fixes for vector extension support. The first
two fixes kernel test robot report [1], while the rest is bullet lists
fixup.

[1]: https://lore.kernel.org/linux-doc/202305141409.bEBvlSY4-lkp@intel.com/

Bagas Sanjaya (5):
  Documentation: riscv: vector: Separate SPDX license identifier and
    page title
  Documentation: riscv: vector: Wrap control_argument struct definition
    in code block
  Documentation: riscv: vector: Use bullet lists for prctl list
  Documentation: riscv: vector: Use bullet lists for prctl() return
    values
  Documentation: riscv: vector: Fix bullet list usage on sysctl section

 Documentation/riscv/vector.rst | 66 ++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 31 deletions(-)


base-commit: aab772f330541c3876484bcff439bb39b2784cf7
-- 
An old man doll... just what I always wanted! - Clara

