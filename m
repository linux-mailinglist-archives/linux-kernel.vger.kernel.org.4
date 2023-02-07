Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F3068CD0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBGDDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjBGDDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:03:08 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531F6166D1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:02:11 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id e22so10454863ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 19:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z9fF9bTJAs7hPku1qwOb0bPsrz0j5pBb+IfpjHYUWA4=;
        b=qOLgDWSfs4FgJTpu9qQ+S43PK+nmS3drAj4Y11r1/1YTp6uDCeKnhT2myFuAE73B7P
         7PodQDMWV0DHRCqegJrGFs4+oNGZTQM4H8d7Rtcx9vrOUww5PTYcCY0wZqzuWZIZwe9r
         QWs84FXy2GKUT2N3gZejNLp1ySCcq3OBCSKdWdQYBNAVybxXN2uqPv6KJ/4LM/7V5BPD
         WN1qADF6v20TK9l2FKt81UFxoOtOwJkFzUaV7jDCFQwBKg5lwG7NTrbo2TbXbmgse7AD
         QH9LPIpchEbBrB/VZi5tlIRwsyJBVrmWOU8P5ZP9slGnggFEWAPla2wJyMB+hNZZ9a7N
         PDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9fF9bTJAs7hPku1qwOb0bPsrz0j5pBb+IfpjHYUWA4=;
        b=ImmJ2IH7X/k1fWJxD87rze1Lo63RBhSjxdPdbu1VpxEyITpVLeisIhuPS/cSL7leY2
         sLkpcEU4IRSgHNmZ69q+hYrH8kOPfUI4XtkGju+bjhiAiaoZNvt14QD8liyfHC4g8OxQ
         1jgkmR79+8fzxYGOqRGdAzy17Y2mk9sgAPqj0UL8o3MpNQtHbW2hiJsoTqekweW9kAoh
         QFSTIdY7VpSzUKSlY1CfLB9MFkmT6ry3YjBEhPcGQgsZX95jn3weOuUB6sQIOF9QPPcP
         DehYf9g55CZrasq2eic0NlmNEmkds4ju4dW1RVzwDPYq+P0MSFg+g/1YxJnUo/6Ivj7h
         ihTA==
X-Gm-Message-State: AO0yUKUfMDR/4CTRovYqECjXh3fW00wiexF4SLkSmt5B1T/Qn26WLjWa
        93f2EekumKN9d7oV5KBqJid3Tc6URGd3Ig==
X-Google-Smtp-Source: AK7set/jd6vI+mTg/L++Qzv4jnB+cDkKrStQf9aN4wMXGPaqpRuyka/syvFkPR13agb9W3jC8l3u2A==
X-Received: by 2002:a17:906:6557:b0:885:d02f:d4ad with SMTP id u23-20020a170906655700b00885d02fd4admr1854114ejn.43.1675738928785;
        Mon, 06 Feb 2023 19:02:08 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090625ce00b008711cab8875sm6159110ejb.216.2023.02.06.19.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:02:08 -0800 (PST)
Date:   Tue, 7 Feb 2023 04:01:44 +0100 (CET)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
To:     linux-kernel@vger.kernel.org
cc:     trivial@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Mark a few scripts as executable
Message-ID: <b0615ab1-f6be-08cb-5736-52625dd11b23@gmail.com>
User-Agent: Alpine 2.26 (LNX 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d161e017b98de5abf7765aa0dab907f22f25c90f Mon Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Tue, 7 Feb 2023 03:55:53 +0100
Subject: [PATCH] Mark a few scripts as executable

The scripts in scripts/ should be marked executable by default, but a
few were not.

Signed-Off-by: Jesper Juhl <jesperjuhl76@gmail.com>

---
  scripts/spdxcheck-test.sh | 0
  scripts/test_fortify.sh   | 0
  2 files changed, 0 insertions(+), 0 deletions(-)
  mode change 100644 => 100755 scripts/spdxcheck-test.sh
  mode change 100644 => 100755 scripts/test_fortify.sh

diff --git a/scripts/spdxcheck-test.sh b/scripts/spdxcheck-test.sh
old mode 100644
new mode 100755
diff --git a/scripts/test_fortify.sh b/scripts/test_fortify.sh
old mode 100644
new mode 100755
-- 
2.39.1

