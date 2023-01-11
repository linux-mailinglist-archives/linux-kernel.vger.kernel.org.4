Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15120665DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjAKOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjAKObj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:31:39 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D9A1EECD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:29:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o13so12570747pjg.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/OTdQMwfQhFTnQWgBxUmTi+nldVOlVLSts2ym041evY=;
        b=PKcsdansjEeRaAcKkeijLdmarAq+gEtId5/DH9kZvmyxoY9DfXvZpx6c998ZzBnWqb
         0dU2rWct8gxtKsac3vuLCV3oJZzZQ4SmsxAhcG4hMwzVghKZuqouC0j8H8hLsPYT5MNz
         5/4SUhZNfE0WwPTClrfcqgb9yf+hcQ86m3vBRn0vLxsRKdSoeYCMRrtcB8YGmEBGWGy3
         zRZBCltCnzc1XQTZST+I8q5Tq83PPy1E+021/VkLlaYOxqUXvYISJHBHwomgdRXeChLg
         mfzo31RiFubhR3iJR8ZfYol5ozgrV1Fg8XAMx7LJOM93E9XJxfsnQwk+TuKOH5uAqmb+
         aqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OTdQMwfQhFTnQWgBxUmTi+nldVOlVLSts2ym041evY=;
        b=B0GeJ1SOBA/mQHIgsLxpBvfwYy/87PGtk/HsDc9Y9JSzybLvNqs/uWq3tiK59PPORF
         /4IbIRX79jOCH7qSKx6/QRyFHumIIhlrTDbmsyIw29HMf+xqE2G6VN1OAbSJK7S4pXNA
         1Y1VsCT0Bw6lewuYHPN8tkZak1CsgBjHh6YSgLq3QaKvDDKFdyZghGXE7kmgerYU4zOA
         aker9Y7mpDrScDq9ZdeeKVUSU7E3wP15br6uYCugaMFi6P9RBiynX/5jeg0UKKsR4Z++
         bkGTVycrTa4fkQYfH7796FbsloxGkF17My4+Ma1huRkYY0pt+wBShOCaWTDK3NGCR4tM
         oxlQ==
X-Gm-Message-State: AFqh2kr9nLmuAnsVbmeJGRg0jmodW2Jiws4Eq9qe8JQTXx3yBkI6nQqD
        V2SHUPu1HTGvLiToIVO+iPymIBqE4V0vtV0V
X-Google-Smtp-Source: AMrXdXv4lUXYYUnixs5G7gSJtKvpyido8l7w37g1c75g2lmWF5dnYZlj0sRiTRwzxjybyOqx7KcHkg==
X-Received: by 2002:a17:903:11cf:b0:192:9550:339a with SMTP id q15-20020a17090311cf00b001929550339amr70723935plh.52.1673447359882;
        Wed, 11 Jan 2023 06:29:19 -0800 (PST)
Received: from localhost.localdomain ([124.123.169.48])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001928c9d772bsm9559805plk.206.2023.01.11.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 06:29:19 -0800 (PST)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkft-triage@lists.linaro.org
Cc:     skhan@linuxfoundation.org, broonie@kernel.org, will@kernel.org,
        anders.roxell@linaro.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] selftests/arm64: bump timeout to 15 minutes
Date:   Wed, 11 Jan 2023 19:59:12 +0530
Message-Id: <20230111142912.81606-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKFT CI found that with the latest mainline kernel (6.1) on
some QEMU emulators and FVP, the following tests will take
longer than the kselftest framework default timeout (45 seconds) to
run and thus got terminated with TIMEOUT error:
* fp-stress - took about 11m30s
* sve-ptrace - took about 8m50s
* check_gcr_el1_cswitch - took about 6m
* check_user_mem - took about 3m
* syscall-abi - took about 5m

Current test timeouts:
not ok 29 selftests: arm64: sve-ptrace # TIMEOUT 45 seconds
not ok 36 selftests: arm64: check_gcr_el1_cswitch # TIMEOUT 45 seconds
not ok 41 selftests: arm64: check_user_mem # TIMEOUT 45 seconds
not ok 46 selftests: arm64: syscall-abi # TIMEOUT 45 seconds

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/arm64/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/arm64/settings

diff --git a/tools/testing/selftests/arm64/settings b/tools/testing/selftests/arm64/settings
new file mode 100644
index 000000000000..8959a5dd8ace
--- /dev/null
+++ b/tools/testing/selftests/arm64/settings
@@ -0,0 +1 @@
+timeout=900
\ No newline at end of file
-- 
2.30.2

