Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB52655B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 20:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiLXTfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 14:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXTfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 14:35:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639BA1027
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 11:35:19 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so2892070wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ky886qI0KpdBKyE/WAUrm/GFEgYZKI1+GOfJ2wMECcs=;
        b=LRZnk/oi23sQR/8gfE/GtN/wJGk4v5Wg7k36EUtSnicjLgA4KfaoyPmfY3w2wgw+oH
         xiCrHaoR5JUlD1jP6Kp+UlSz/WwnDeGDK5/u9ANWhD2yr8glmfgb3KbHpniWBzyp/fU8
         yFs/miSdAaxFxMlxuVFDRXltjKwcuLOJihxYGTjBlNfss9mZFs4Pt/7FlQQVfGi0Kanq
         hGPnU8KPsHHVd4x/bp+hEpAMkqZ2Ve/Q6GPAC4pTgi6b/GRxMZXThGsyAQniiVmLPz4y
         syfGqoGCKzGYzyCIEhZFnxvemfFhK2Z4cWYkTloZVVAd83wOIvkZ/jkRzAcKNP+q6Oke
         TDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ky886qI0KpdBKyE/WAUrm/GFEgYZKI1+GOfJ2wMECcs=;
        b=kwVRe8R6hfpwPe4ofEYktzE7YZRaQ1PYIejxR6QI2Vzc46f5nWXj/3fpWBmkDQJrJY
         nK5B5klX5HenieQ9vRYTx7AWtn0kwA3pasmKfXg+blpKhot8rtgHUpd4gs1dohV8NFoD
         WWa+4yZhiG/56geAHvWE8a/bXBkAynvymCYxBz+WV2ofEppOjhfXnffVca87oa0Yfnms
         RjCz314uzGtShe1BRUPqx3gw+oSjCE9m+fM9Y9tWMs9IMbT1eJDxnxSB/WveiSYZM02z
         NUVt6cQN14IMkPDkyvPcHZ0Thcpn6KuwSPbKbzPeWXyGx24sqwkVIX9+egI1TYxRV9Xi
         iLxA==
X-Gm-Message-State: AFqh2koGgiRu87sARvEIwar7NCitSq1rHSn+D6NDS20nE9hF3EkIM+Ut
        Ul3FOjCbAZLdSGT5AsIZGCY=
X-Google-Smtp-Source: AMrXdXujq4BGdP1SjZekBBvgaWCx3y0upzetrzDYePmc/4xnToTCrlF6jAUX7ebgQUYzBYYmeKVXAQ==
X-Received: by 2002:a05:600c:a51:b0:3d2:3376:6f38 with SMTP id c17-20020a05600c0a5100b003d233766f38mr9951862wmq.20.1671910518013;
        Sat, 24 Dec 2022 11:35:18 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c4f0700b003d96c811d6dsm7196255wmq.30.2022.12.24.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 11:35:17 -0800 (PST)
Date:   Sat, 24 Dec 2022 22:35:14 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Nick Terrell <terrelln@fb.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: lib/zstd/compress/huf_compress.c:460 HUF_getIndex() warn: the
 'RANK_POSITION_LOG_BUCKETS_BEGIN' macro might need parens
Message-ID: <202212241900.qp4rtcCs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72a85e2b0a1e1e6fb4ee51ae902730212b2de25c
commit: 2aa14b1ab2c41a4fe41efae80d58bb77da91f19f zstd: import usptream v1.5.2
config: parisc-randconfig-m041-20221219
compiler: hppa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
lib/zstd/compress/huf_compress.c:460 HUF_getIndex() warn: the 'RANK_POSITION_LOG_BUCKETS_BEGIN' macro might need parens
lib/zstd/compress/huf_compress.c:460 HUF_getIndex() warn: the 'RANK_POSITION_LOG_BUCKETS_BEGIN' macro might need parens
lib/zstd/decompress/zstd_decompress_internal.h:206 ZSTD_DCtx_get_bmi2() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_block.c:894 ZSTD_execSequenceEnd() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_block.c:942 ZSTD_execSequenceEndSplitLitBuffer() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_block.c:1009 ZSTD_execSequence() warn: inconsistent indenting

vim +/RANK_POSITION_LOG_BUCKETS_BEGIN +460 lib/zstd/compress/huf_compress.c

2aa14b1ab2c41a Nick Terrell 2022-10-17  457  static U32 HUF_getIndex(U32 const count) {
2aa14b1ab2c41a Nick Terrell 2022-10-17  458      return (count < RANK_POSITION_DISTINCT_COUNT_CUTOFF)
2aa14b1ab2c41a Nick Terrell 2022-10-17  459          ? count
2aa14b1ab2c41a Nick Terrell 2022-10-17 @460          : BIT_highbit32(count) + RANK_POSITION_LOG_BUCKETS_BEGIN;

This define looks like:

#define RANK_POSITION_LOG_BUCKETS_BEGIN (RANK_POSITION_TABLE_SIZE - 1) - RANK_POSITION_MAX_COUNT_LOG - 1 /* == 158 */

So it's a macro expansion issue but harmless.

2aa14b1ab2c41a Nick Terrell 2022-10-17  461  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

