Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01287602244
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiJRDL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiJRDJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623DF9AFD7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:07:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n7so12596118plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=glZFDN3AHMX7S3G0PMTlaeT9BFw4J8xiraTo5Hd9nbE=;
        b=mF0cQfuRXpGo2kCvszI69LFhd8M85WRTSL9PiOLxXLninjAI4t0yoRYlkrLX3Jx+WB
         kD6RS8LzDWcTOI2LCtu7SO/qFazY+hQ6s0I7x8675VutHMT/TDi9uo2HK6KXvzw08t9V
         6ongr7McCUV99+kQPxG16SkQ/1grINwo4pe+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glZFDN3AHMX7S3G0PMTlaeT9BFw4J8xiraTo5Hd9nbE=;
        b=haxhxCpjExBbwDhbGaqcvP+5wR2Dw+9mGYW1ieEdfe9k+469bwtzvu07yKoVM/3AyK
         dGN6LC13Sl8/bc5w4aM934cGWC7UZi+9OeiWAmYqOBocx/m8QS9FJl6kR7kVes0BQDFL
         /kjcx8qV3ZehW3UCF7tkBXkHVckvnLKFF2arvgc7Sp70GWnEdh/tHNcZEJUose/RF95A
         LnPT9W2NBt0PbXsuN+jE87uLz6iE54XnNBRpojkJQNBF87fnOf0g7Hv1zhysrPIA8KeY
         aLyfDIEyYqIjElpS/3J9nDDI9mmyGS4PYNhxT9brtcVx7lb7RbuPh4QJd3S2YfofhIqg
         XNzg==
X-Gm-Message-State: ACrzQf1Ia45BoPViYshwpdvBT+jDVTml0eJz6FHHAY8O94j1QYVwx6HV
        Ql6n1hAla1++ZYajyw2WsCbbcA==
X-Google-Smtp-Source: AMsMyM5nAaJygI9OUltDMlB7UpLcmWT2XCkim5Gt4Fln009SoeD+wO4R3Ff/mb+1stNUq8Mt0iGAUA==
X-Received: by 2002:a17:902:eb86:b0:17f:f884:a62b with SMTP id q6-20020a170902eb8600b0017ff884a62bmr843423plg.153.1666062438830;
        Mon, 17 Oct 2022 20:07:18 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:58b4:95a3:4654:2a9f])
        by smtp.gmail.com with ESMTPSA id mn7-20020a17090b188700b00205f013f275sm10423991pjb.22.2022.10.17.20.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 20:07:18 -0700 (PDT)
Date:   Tue, 18 Oct 2022 12:07:14 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv3 6/8] zram: Add recompression algorithm choice to Kconfig
Message-ID: <Y04YYtJUZPq13fLg@google.com>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
 <20221009090720.1040633-7-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009090720.1040633-7-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make (secondary) recompression algorithm selectable just like
we do it for the (primary) default one.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 3e00656a6f8a..076a76cd1664 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -93,3 +93,43 @@ config ZRAM_MULTI_COMP
 
 	SIZE (in bytes) parameter sets the object size watermark: idle
 	objects that are of a smaller size will not get recompressed.
+
+choice
+	prompt "Default zram recompression algorithm"
+	default ZRAM_DEF_RECOMP_ZSTD
+	depends on ZRAM && ZRAM_MULTI_COMP
+
+config ZRAM_DEF_RECOMP_LZORLE
+	bool "lzo-rle"
+	depends on CRYPTO_LZO
+
+config ZRAM_DEF_RECOMP_ZSTD
+	bool "zstd"
+	depends on CRYPTO_ZSTD
+
+config ZRAM_DEF_RECOMP_LZ4
+	bool "lz4"
+	depends on CRYPTO_LZ4
+
+config ZRAM_DEF_RECOMP_LZO
+	bool "lzo"
+	depends on CRYPTO_LZO
+
+config ZRAM_DEF_RECOMP_LZ4HC
+	bool "lz4hc"
+	depends on CRYPTO_LZ4HC
+
+config ZRAM_DEF_RECOMP_842
+	bool "842"
+	depends on CRYPTO_842
+
+endchoice
+
+config ZRAM_DEF_RECOMP
+	string
+	default "lzo-rle" if ZRAM_DEF_RECOMP_LZORLE
+	default "zstd" if ZRAM_DEF_RECOMP_ZSTD
+	default "lz4" if ZRAM_DEF_RECOMP_LZ4
+	default "lzo" if ZRAM_DEF_RECOMP_LZO
+	default "lz4hc" if ZRAM_DEF_RECOMP_LZ4HC
+	default "842" if ZRAM_DEF_RECOMP_842
-- 
2.38.0.413.g74048e4d9e-goog

