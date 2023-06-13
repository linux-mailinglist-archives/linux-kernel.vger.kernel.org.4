Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A659672E319
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbjFMMdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242305AbjFMMdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:33:00 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7400173C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:32:51 -0700 (PDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 457773F26D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686659570;
        bh=kHrI60HGgHX5jqkZGeWx9fzAxW6E9mR4OgwfiGnOAxQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=qmLkrq+DSESZ4ieYNdgbkikBcIYbiCUCeIT5sJFeC0XRBtrVmCSooYp4UBSJpJgZ8
         /CF0jcxQwZcG5LtvkugQ4bqbzK5WuBR7ny6BahVSgeHXidEAsFxp9yb6U+z5a5l8zj
         ccvaHMQNxHP5V7M6C8cJmWQyIbzsJyOiY0PCpvc6OuPEJmCHLK+rTdfVQUQMaz1xlq
         jOCGe+H+6N1gxElQdyov5ZHSHPpMy53gqbtAn4vRWFuQ6eaDi+pQ1O4z+oHfhZA0Z6
         gMAtlYKLYS+w2CSNUw6cIV6Yh2aQ/fMj1n2ZFY87B7Q1npcWWySw3RwmkyqwudRrnI
         7a0e8hYqEhgJg==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39c872bab70so3365214b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659568; x=1689251568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHrI60HGgHX5jqkZGeWx9fzAxW6E9mR4OgwfiGnOAxQ=;
        b=OuqX5UEMo7bUWbrqo28oySPExbE5RwXGEnIeh4V6jwILmxRrpeS1l1rufrlmYultPn
         C0PC4llsRTsvIjEtuqx6/oCVWso8uljD7LXacIcRS1ZaoIgZaLGjtq35qcc8nA5M3eZo
         3+yqTlHaa6Uzz6oKpc5SLg08bruKUl3qVz9rHugFpS04ueQTjLtR5XbrgiNESp/OpLSV
         WTP0CJCKo6LGaUk5v426mVpyNXSPUokCFq0r2uyVuJSXA/1fJRYUk+mZDMHcV1L41mAb
         8ViMbu80dODdB1OckbI+3z56kC6CQzM1vcYtmH9efkJQwz/TsOrI0gTvR6KS6wd1FzPh
         A7AA==
X-Gm-Message-State: AC+VfDzpSBewuHyhBGcqsAhYnE0gaK0Sdz/WF9UEDzi1IR8vIqXzAGAx
        1n7q2uSy+bTtlbvODIegCtD9YJ2nTL+nOZkqCy/CmklCAzAhxgBM2w2vWSne67LCVKXjjAPvQb5
        He+1ZXahr+C7nTpA2/Puj47TzhVoJa0J0PHAzRzYlZAPsX+9dxQ==
X-Received: by 2002:a54:4808:0:b0:39b:7ba7:bd1e with SMTP id j8-20020a544808000000b0039b7ba7bd1emr6763075oij.11.1686659567823;
        Tue, 13 Jun 2023 05:32:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OQeh1b10s7ZGLTmJ0pP4jyvk53jHubefHpSrwjFFh9fL4c+WcRZ7ueDOIk1giyyKHQPXWpQ==
X-Received: by 2002:a54:4808:0:b0:39b:7ba7:bd1e with SMTP id j8-20020a544808000000b0039b7ba7bd1emr6763057oij.11.1686659567593;
        Tue, 13 Jun 2023 05:32:47 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:ac1a:e505:990c:70e9])
        by smtp.gmail.com with ESMTPSA id z26-20020a056808049a00b0039c532c9ae1sm4838116oid.55.2023.06.13.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:32:47 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, dsahern@gmail.com
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] selftests: net: fcnal-test: check if FIPS mode is enabled
Date:   Tue, 13 Jun 2023 09:32:22 -0300
Message-Id: <20230613123222.631897-5-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613123222.631897-1-magali.lemes@canonical.com>
References: <20230613123222.631897-1-magali.lemes@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some MD5 tests which fail when the kernel is in FIPS mode,
since MD5 is not FIPS compliant. Add a check and only run those tests
if FIPS mode is not enabled.

Fixes: f0bee1ebb5594 ("fcnal-test: Add TCP MD5 tests")
Fixes: 5cad8bce26e01 ("fcnal-test: Add TCP MD5 tests for VRF")
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
No change in v4.
No change in v3.
 
Changes in v2:
 - Add R-b tag.

 tools/testing/selftests/net/fcnal-test.sh | 27 ++++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 21ca91473c09..ee6880ac3e5e 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -92,6 +92,13 @@ NSC_CMD="ip netns exec ${NSC}"
 
 which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
 
+# Check if FIPS mode is enabled
+if [ -f /proc/sys/crypto/fips_enabled ]; then
+	fips_enabled=`cat /proc/sys/crypto/fips_enabled`
+else
+	fips_enabled=0
+fi
+
 ################################################################################
 # utilities
 
@@ -1216,7 +1223,7 @@ ipv4_tcp_novrf()
 	run_cmd nettest -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 1 "No server, device client, local conn"
 
-	ipv4_tcp_md5_novrf
+	[ "$fips_enabled" = "1" ] || ipv4_tcp_md5_novrf
 }
 
 ipv4_tcp_vrf()
@@ -1270,9 +1277,11 @@ ipv4_tcp_vrf()
 	log_test_addr ${a} $? 1 "Global server, local connection"
 
 	# run MD5 tests
-	setup_vrf_dup
-	ipv4_tcp_md5
-	cleanup_vrf_dup
+	if [ "$fips_enabled" = "0" ]; then
+		setup_vrf_dup
+		ipv4_tcp_md5
+		cleanup_vrf_dup
+	fi
 
 	#
 	# enable VRF global server
@@ -2772,7 +2781,7 @@ ipv6_tcp_novrf()
 		log_test_addr ${a} $? 1 "No server, device client, local conn"
 	done
 
-	ipv6_tcp_md5_novrf
+	[ "$fips_enabled" = "1" ] || ipv6_tcp_md5_novrf
 }
 
 ipv6_tcp_vrf()
@@ -2842,9 +2851,11 @@ ipv6_tcp_vrf()
 	log_test_addr ${a} $? 1 "Global server, local connection"
 
 	# run MD5 tests
-	setup_vrf_dup
-	ipv6_tcp_md5
-	cleanup_vrf_dup
+	if [ "$fips_enabled" = "0" ]; then
+		setup_vrf_dup
+		ipv6_tcp_md5
+		cleanup_vrf_dup
+	fi
 
 	#
 	# enable VRF global server
-- 
2.34.1

