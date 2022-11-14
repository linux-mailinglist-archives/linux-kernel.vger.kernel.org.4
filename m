Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73779628A93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiKNUe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiKNUer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:34:47 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C286611472
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:34:45 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CD57C41303
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 20:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668458081;
        bh=WC+NC/bp8exDJsewvJ8oxWxlDpF4ig1RrOTupSn7stI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=jxGeKlxvLdEHg7Dg++tG4aqTrfDd3u1ROUa1+lfNshAk4UTKZz764dyTUl9Wk/L/U
         ffJ38lUJ7ErCRrB+vPTvNAEaXu2erOB+QJ5Q8qvLxLV+SPjOH12Fm+kvKoiiDW1nme
         TtcQanYUtkhuguliwQm/ySkhcSaldqodwJyxUuC+2/Us7G/oaee855TZsPe6zq+0ZV
         KBs1h1SQ1XxZKuzRhP9UH9mjjGY4t37gAwjAH62Y9WQc0MPshF7TrHvJykGOvbYdW3
         HlncUTenS+K6lhbPEDQrYYSlI91ey6Pw+EhZm1eSDREVdvS6Yd2aOOn5LTaRHamoeF
         zIR3jceM+UGqw==
Received: by mail-ed1-f69.google.com with SMTP id t4-20020a056402524400b004620845ba7bso8790453edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WC+NC/bp8exDJsewvJ8oxWxlDpF4ig1RrOTupSn7stI=;
        b=oAi3NlhZRkhYoD2VHYJdGGQZ5Cfr29ezlx3OC66Feybp5txDQcfhjaio2XEe/Vxsbv
         JDlFzVKrHkFV1Ri+IoF3mQWMYvu7DeI7PQ91nr+6mUut5gia0gN+3rCTuRfwGQkvbe5y
         jCbFNvb4rv3v+maKRjPmczqi8dfxdMbnC9EJBbLCqhjXtatWt++PzYrn/lFXDty8GFZQ
         QT/706dTuCTN8X3TLdoa2bFduitWSr8uzQ2yXAGg4mN9lKv3c4wuIj4Btf6PngiPgUEV
         Xosorqy/6NcIAL5nWZ5+mUH086U66o0E7btYZaHKVuH9m4qX3j6nALyxPx07uHBKSGQH
         Tcuw==
X-Gm-Message-State: ANoB5pnqF20qk7MDDgrA9j4v8RIct3ZNV04gihp03D0OZ9A/mwnM1rMP
        UiR0Qr3r9RAObAO9NClqX4gqHhgX720hQK/bw9lxbgmmEJh1F3/5KPB9hmuu/Vs6b6953rEU1jM
        gbEAfiA2H35vvLbfgFopT5LLVHSPTYIlMtAQuiCZcRg==
X-Received: by 2002:a17:906:388c:b0:7aa:97c7:2c04 with SMTP id q12-20020a170906388c00b007aa97c72c04mr11621713ejd.191.1668458078754;
        Mon, 14 Nov 2022 12:34:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5s/a1Lng3ilCkg3POCMwx76l0spcBD3eOI0wAt+YffElcdeD9WJFZ0nls6iE/3xfYz1CCwNg==
X-Received: by 2002:a17:906:388c:b0:7aa:97c7:2c04 with SMTP id q12-20020a170906388c00b007aa97c72c04mr11621699ejd.191.1668458078551;
        Mon, 14 Nov 2022 12:34:38 -0800 (PST)
Received: from localhost.localdomain (host-87-10-120-177.retail.telecomitalia.it. [87.10.120.177])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709063fcf00b007ae32daf4b9sm4572587ejj.106.2022.11.14.12.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:34:38 -0800 (PST)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Coleman Dietsch <dietschc@csp.edu>,
        Lina Wang <lina.wang@mediatek.com>,
        Kamal Mostafa <kamal@canonical.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests net: additional fix for kselftest net build error
Date:   Mon, 14 Nov 2022 21:34:31 +0100
Message-Id: <20221114203431.302655-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to make sure that bpf_helpers.h is properly generated when
building the net kselftest, otherwise we get this build error:

 $ make -C tools/testing/selftests/net
 ...
 bpf/nat6to4.c:43:10: fatal error: 'bpf/bpf_helpers.h' file not found
          ^~~~~~~~~~~~~~~~~~~
 1 error generated.

Fix by adding a make dependency on tools/lib/bpf/bpf_helper_defs.h.

Moreover, re-add the include that was initially added by commit
cf67838c4422 ("selftests net: fix bpf build error"), otherwise we won't
be able to properly include bpf_helpers.h.

Fixes: 7b92aa9e6135 ("selftests net: fix kselftest net fatal error")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/net/bpf/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/bpf/Makefile b/tools/testing/selftests/net/bpf/Makefile
index 8ccaf8732eb2..cc6579e154eb 100644
--- a/tools/testing/selftests/net/bpf/Makefile
+++ b/tools/testing/selftests/net/bpf/Makefile
@@ -2,11 +2,15 @@
 
 CLANG ?= clang
 CCINCLUDE += -I../../bpf
+CCINCLUDE += -I../../../lib
 CCINCLUDE += -I../../../../lib
 CCINCLUDE += -I../../../../../usr/include/
 
+bpf_helper_defs.h:
+	@make OUTPUT=./ -C $(OUTPUT)/../../../../tools/lib/bpf bpf_helper_defs.h
+
 TEST_CUSTOM_PROGS = $(OUTPUT)/bpf/nat6to4.o
-all: $(TEST_CUSTOM_PROGS)
+all: bpf_helper_defs.h $(TEST_CUSTOM_PROGS)
 
 $(OUTPUT)/%.o: %.c
 	$(CLANG) -O2 -target bpf -c $< $(CCINCLUDE) -o $@
-- 
2.37.2

