Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DEA5F6C89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJFRL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiJFRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:11:54 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527FBA7ABA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:11:52 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id nl8-20020a17090b384800b00205f930565cso1373537pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gIRTEOV760XmyIZ/Qi7fwmuzWwZOXMhh2dv+gAx8YTQ=;
        b=hKrqnN77SIF0aoCHhjnc01Xfz+qA6XLrRWcZhg0cRFbr5kbWjrZKjUUdodyeCKSgyg
         titUyrnc9EVwraqc6/H04PeiwVTsLAWkofdan0t4tlf3ZEXyeVLZjrEsFUrAg2g5FDdb
         g/Sy9uuSHFmowKhfmBDnbktYZqgcSFb/ryLKl97TbgWq5eXQgE8VMXx41XG3vP73ATOd
         hRbjAxM2l5bu9nomRHaKH007naphm+U2EWtAQDuAD5pUmPmE1IuSDL5eiEfbAqvGTjbT
         sX1mFo8711e1VgtzFgvGXxVvemZjXWetxvFYCLOh31mxw/8f/Eq17VAAeHKEqBBe0LDU
         muaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIRTEOV760XmyIZ/Qi7fwmuzWwZOXMhh2dv+gAx8YTQ=;
        b=bvJp/9ZLqNnvpowu9iYcXH8KSu7EE2QPUN5Nflp5wqLWrHKP1l3zYKIo0cZ84aksvX
         j3gFgOwb+rlpIlzsRjS2WM6iqNsPALw2OL+fsI3rXZn8WwYG1qmtn61Yu31O6qVqMuut
         lxMJbtFnQppPj1VJe9YWeK6knAVst3H+wVpaU1svzL0fzAnhU0Q56jvk8gw1jdVWbqJA
         aCMWqAX6QsFhLmEhmrhmBEiwQZJtFiCrkJc+czUH0+ukK0tuQW5JNXYGbqfEeFg/xpxL
         ptJB/M7+6u4UA2oLydAAHch9v9FczVKYuWHNY0O4OhBC/C9+L80QUZKuY5zP4Nz64QgY
         TlUA==
X-Gm-Message-State: ACrzQf0X1AE6oVn/dTN5VUifDcQCoeNo85q5KBSx4gH3fDtMj/Uvjl/Y
        f8HlvRm3yG6Wj0f914EUJfYUQNYrgDpT
X-Google-Smtp-Source: AMsMyM7pA4CBYBz9VUO/SHmDpNSich9Ia0/sJqXHITGbOjZvJdyv9F0xpY0akV2fVfUNIJxMT0DSG2qBpbgk
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:902:db0a:b0:178:32b9:6f51 with SMTP id
 m10-20020a170902db0a00b0017832b96f51mr405091plx.145.1665076311692; Thu, 06
 Oct 2022 10:11:51 -0700 (PDT)
Date:   Thu,  6 Oct 2022 10:11:29 -0700
In-Reply-To: <20221006171133.372359-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221006171133.372359-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006171133.372359-2-vipinsh@google.com>
Subject: [PATCH v4 1/4] KVM: selftests: Add missing break between 'e' and 'g'
 option in dirty_log_perf_test
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing -e option (Run VCPUs while dirty logging is being disabled) in
dirty_log_perf_test also unintentionally enables -g (Do not enable
KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2). Add break between two swtich case
logic.

Fixes: cfe12e64b065 ("KVM: selftests: Add an option to run vCPUs while disabling dirty logging")
Signed-off-by: Vipin Sharma <vipinsh@google.com>

---
 tools/testing/selftests/kvm/dirty_log_perf_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index f99e39a672d3..56e08da3a87f 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -411,6 +411,7 @@ int main(int argc, char *argv[])
 		case 'e':
 			/* 'e' is for evil. */
 			run_vcpus_while_disabling_dirty_logging = true;
+			break;
 		case 'g':
 			dirty_log_manual_caps = 0;
 			break;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

