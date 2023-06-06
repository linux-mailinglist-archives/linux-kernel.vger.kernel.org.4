Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CBF724A62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbjFFRga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237895AbjFFRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:36:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC0410F0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:36:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso9359649a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686072959; x=1688664959;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gdp4S+eQxFiKfHwPNqSR2VRP1nv6P0cgdm1YgiXygNM=;
        b=qv3VIrKhNKnucoSAPFfAY4WLFvoX/zmB8m5YAtYgIqiMEARlXzH0vymd3w5taAOkq+
         DJOjFLm+pejV48XapvBeVsWRTXiYjrqWgTA7cKIvZF/A5mEihzkmT76NUh7lYiaCMi44
         3Y2CK1C1R3wInwkt9549rDlm5Wzw0AKCA42jnPrldNTtCI+e6iAfYfWBQE6Hla2+ri06
         mN/98oyNQJxaHGVlN8ajpAacok/RfWzk5XRElQaGw/r2RXpvVPBC9PWWxU9kSh9PkpZe
         r5Td6BNj2F79nF1Q/rzA3A6PQlYKCLUT+nWB9zFdIaamnrGh5QMIbYDNKQDgIaZ12VCx
         H63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686072959; x=1688664959;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gdp4S+eQxFiKfHwPNqSR2VRP1nv6P0cgdm1YgiXygNM=;
        b=KmCtPodmT8mn2CFhOBriJ2Z1IwkMZ/vwZnr7Y+KKTGhva809Z6YPPH0RKDNR6rdaX0
         8WcsCftPlY2zKUjQ4NhaIAz5ldGMjOedMiwzzB+rOo0rhn95iXVJxE91I/wH+TNmsG5r
         DpUOf/7vUl8O5dmnZ32k43sqyCD0jMYaSTYEzFF8Mw6dL4xdQG+6i0MvyhXIoTybiWVZ
         AM+aas/SEcziisLQV8RygLNl5TzzMnfLj3fTrbEDqCrR1oOoCt7v2APlCMf8TbC/xZRO
         EUXgL4KDZk13zr3sIH9iwQqsKbAEYsnN+ChOihy1IRy+cPX4I/cKkAJuI5tRLHA6DV6h
         9OAQ==
X-Gm-Message-State: AC+VfDwuq0fvMLSa1V0A3+Hth+0DRl1KRQAwSDdPShr9fdAk4yQ3Owm3
        8MDXPdQO7eCiqtMkWkCdPItmOk8qila/GY0lxlpKNg==
X-Google-Smtp-Source: ACHHUZ7vstHVKqnFMMNz3kMOqA1kekutTy0W0KKYUfBfFo6ZAN1i4100uVJ9oGNA1xTiupBy8ntWSw==
X-Received: by 2002:a17:907:1606:b0:973:ff4d:d01e with SMTP id hb6-20020a170907160600b00973ff4dd01emr4238978ejc.31.1686072958732;
        Tue, 06 Jun 2023 10:35:58 -0700 (PDT)
Received: from google.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id rl15-20020a170907216f00b00974638e4a98sm5685962ejb.24.2023.06.06.10.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:35:58 -0700 (PDT)
Date:   Tue, 6 Jun 2023 17:35:53 +0000
From:   =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, ptosi@google.com
Subject: [PATCH] scripts/mksysmap: Fix badly escaped '$'
Message-ID: <20230606173553.v7lckyxrcsotanm5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The backslash characters escaping '$' in the command to sed (intended to
prevent it from interpreting '$' as "end-of-line") are currently being
consumed by the Shell (where they mean that sh should not evaluate what
follows '$' as a variable name). This means that

    sed -e "/ \$/d"

executes the script

    / $/d

instead of the intended

    / \$/d

So escape twice in mksysmap any '$' that actually needs to reach sed
escaped so that the backslash survives the Shell.

Fixes: c4802044a0a7 ("scripts/mksysmap: use sed with in-line comments")
Fixes: 320e7c9d4494 ("scripts/kallsyms: move compiler-generated symbol patterns to mksysmap")
Signed-off-by: Pierre-Clément Tosi <ptosi@google.com>
---
 scripts/mksysmap | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index cb3b1fff3eee..ec3338526102 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -32,7 +32,7 @@ ${NM} -n ${1} | sed >${2} -e "
 #  (do not forget a space before each pattern)
 
 # local symbols for ARM, MIPS, etc.
-/ \$/d
+/ \\$/d
 
 # local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
 / \.L/d
@@ -41,7 +41,7 @@ ${NM} -n ${1} | sed >${2} -e "
 / __efistub_/d
 
 # arm64 local symbols in non-VHE KVM namespace
-/ __kvm_nvhe_\$/d
+/ __kvm_nvhe_\\$/d
 / __kvm_nvhe_\.L/d
 
 # arm64 lld
-- 
2.41.0.rc0.172.g3f132b7071-goog


-- 
Pierre
