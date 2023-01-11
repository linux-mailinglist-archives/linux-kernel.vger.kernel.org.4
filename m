Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D5966577D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjAKJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbjAKJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:28:51 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26761003;
        Wed, 11 Jan 2023 01:28:39 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id tz12so35295695ejc.9;
        Wed, 11 Jan 2023 01:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ygIVHVHC7ext0UN1C5LJ2TwQHCTMxtld2JzO7RrKTU4=;
        b=jTpyx9hnJIoy78iTB6SIoWRbX4qrzQ1fuOViFzx0w8CI9A2WBNuaaAw9BJDaMxvW1V
         UKxyT9rVcCPCXHcIF6lN4Vnd0ZFuHO5/Na0eUcj0eyiYoZSO3e5v6d33qzOSrk+QcPsL
         hwt9Bz3jgllgJqtq8QrsGcF13f0WWYtGZKOKk2TypBlQlsQMFgUTvg7WU7Yrz4odFGYP
         2xHPX4ZkA8u9rs3PMWdKr5sj+nzMCLHzYI+W+mWPkytuWs/7fPYqCxMFENSnJX06e/v7
         WWtZdomU5vIXn9UjaX00UuJi2+O0Z4Ge1SaEjEDJEuYrki/PWihxk962vCXY9UTKTm7m
         o3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygIVHVHC7ext0UN1C5LJ2TwQHCTMxtld2JzO7RrKTU4=;
        b=p5UO+HnNLpD86wwnK6p3V02rclyK939UD5xY/PjgXEtVLugrfe1sQlel9vVeHlMByo
         m7xfJvQNxOZXHtS9DCuRri6vGv2vgWczAmZZQhMDSEf13wfB6Hro/iFbwf7RzQnxNtEs
         rA9VXz81ciT1wRcHqq/8jX/vytvkhE/VXLwOdQHca1rsdKxWiIKYWNyW1u/2ECtJ7k7b
         We48/juT47I216SZj2Tk8A+j6waQwfQha/X1uc7joFWA6F2TXKiDGyHKf7Dbbm7Ik8vZ
         aKalDRNXbF04aOxWdgzW7ZiFLL5pxfuatNHrAcy3rOGXCHPQq0SAm85DayAbSrYeDFy1
         +47g==
X-Gm-Message-State: AFqh2koJvBP7hjI3qAX67hq6j3lkOc2uu22pRkhn3uuU/49ftMpQCJg/
        EDSljF/21WfDVRRhuoeMMMh5WZ847Sg=
X-Google-Smtp-Source: AMrXdXs4hf7WiPmjqQae5kzx61lOUZYsBW4synif4lYB7hFc6zelE1Qtu8JacKsT5n1coC7Of1L6PQ==
X-Received: by 2002:a17:907:c70c:b0:7c0:a247:2f3c with SMTP id ty12-20020a170907c70c00b007c0a2472f3cmr65431025ejc.1.1673429319503;
        Wed, 11 Jan 2023 01:28:39 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906308e00b0084d3acda5fasm4473970ejv.189.2023.01.11.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:28:39 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: adjust SAMSUNG SOC CLOCK DRIVERS after s3c24xx support removal
Date:   Wed, 11 Jan 2023 10:28:28 +0100
Message-Id: <20230111092828.958-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230111092828.958-1-lukas.bulwahn@gmail.com>
References: <20230111092828.958-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a4946a153cb9 ("ARM: s3c: remove all s3c24xx support") removes all
files that match the file pattern 'include/dt-bindings/clock/s3c*.h'.

Hence,  ./scripts/get_maintainer.pl --self-test=patterns complains about a
obsolete file pattern in SAMSUNG SOC CLOCK DRIVERS, as it does not match
any file in the repository after the commit above.

Remove this obsolete file entry in SAMSUNG SOC CLOCK DRIVERS.

Fixes: a4946a153cb9 ("ARM: s3c: remove all s3c24xx support")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e400f564b0f9..b0a0711090cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18377,7 +18377,6 @@ F:	Documentation/devicetree/bindings/clock/samsung,*.yaml
 F:	Documentation/devicetree/bindings/clock/samsung,s3c*
 F:	drivers/clk/samsung/
 F:	include/dt-bindings/clock/exynos*.h
-F:	include/dt-bindings/clock/s3c*.h
 F:	include/dt-bindings/clock/s5p*.h
 F:	include/dt-bindings/clock/samsung,*.h
 F:	include/linux/clk/samsung.h
-- 
2.17.1

