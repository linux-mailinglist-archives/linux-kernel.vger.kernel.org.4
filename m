Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699A86C0207
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCSNZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCSNZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:25:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191051CBD1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:25:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w9so37244653edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679232348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZHVKRyqUkVQgHIPcnrjM4VftHtoW1MPmlfE9Rq46vI=;
        b=mNQgmGbT+HVA15+DOSJlLUEnpBIvOyX+j5cvdZStAMH3VF92O9PT06RNqnKRcLovaL
         P30ex7z0Rp9MyvhsrqrkReKNRvyDU8AwDnEANAvLUiQ6kvbh9Uru5Up9soTO/7BSyub8
         Sd58TAIV1/wEw/MjVS5H4ulLp8ToU4GBHkw/APoVrk4OPB9rBU1ml8FlRR1IicVjvqnU
         TIVfbOmEHMt2YTG0rr16Qxh3pVdfbKIs0nVC4oMTf0MSbp0tnoRKdErZji/f+qQ2jf0u
         WXpQJjZ/5ob5O6P+f2bPFt6qcqoEEpnPUkHalWUkXthEOEMawcOA2WqTCGknztflUuhD
         /FJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679232348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZHVKRyqUkVQgHIPcnrjM4VftHtoW1MPmlfE9Rq46vI=;
        b=jMF081tzjkuXyB9nKzffWa6XAQ9/8DMQILniOwql68zNLhuyP8dsuTm4nlliwGLk3T
         Z9RRrsULZu0QGv0xkhb6wMaCplPXCC2grrwI8kUgHBwpkK1i21znR68I9EhBGbrCpcJh
         XIzTS7n6iwDcO+DN5R0pu9XrzmyIyb9kqstB5AE4PYGlyWvC1FaxxgUJBsn5KAMF1BMP
         LlWoNkWMVbiym/pBK5iug5UTvdV0wUF9YQ68pVr177/YSg9KSYFPESU3cygTnte6X3yc
         qNnn0lnOVy2DjgITWBkXGdFyARNZuYLYuQRtJ0hQ+mTRJP+4Haw8G1YiPL2OJlgJ6Ms1
         7p2g==
X-Gm-Message-State: AO0yUKWvYsjDhp243JCRv2dcSpxh0973cQa4ttOpV9svjlqaBmx0MTvH
        9D/iHuVPu6z1zGUE459cfIM=
X-Google-Smtp-Source: AK7set/2uQPzlmU1OHFq9zDhnY7GnvreG7DHR7u3GAV4giydFft8V9GEoMXX+yqrcLSXhEr6GQVUyw==
X-Received: by 2002:a17:906:2e91:b0:931:7c20:f75a with SMTP id o17-20020a1709062e9100b009317c20f75amr5049951eji.53.1679232348497;
        Sun, 19 Mar 2023 06:25:48 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id by22-20020a170906a2d600b008cecb8f374asm3235200ejb.0.2023.03.19.06.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 06:25:48 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, vireshk@kernel.org, johan@kernel.org,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH RESEND] staging: greybus: remove unnecessary blank line
Date:   Sun, 19 Mar 2023 15:24:51 +0200
Message-Id: <20230319132452.151877-2-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank line before struct as reported
by checkpatch:

" CHECK: Please don't use multiple blank lines "

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/greybus/greybus_authentication.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/greybus_authentication.h b/drivers/staging/greybus/greybus_authentication.h
index 7edc7295b7ab..48b4a9794d3c 100644
--- a/drivers/staging/greybus/greybus_authentication.h
+++ b/drivers/staging/greybus/greybus_authentication.h
@@ -41,7 +41,6 @@
 #define CAP_AUTH_RESULT_CR_NO_KEY	0x03
 #define CAP_AUTH_RESULT_CR_SIG_FAIL	0x04
 
-
 /* IOCTL support */
 struct cap_ioc_get_endpoint_uid {
 	__u8			uid[8];
-- 
2.34.1

