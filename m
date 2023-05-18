Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B50707D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjERJyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjERJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:53:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D40E10E9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:53:58 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51f6461af24so1179250a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684403637; x=1686995637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToOy6SsrGe7zKTu/1dnhsnfvtx8a3k0NpeaGTGEdvcw=;
        b=NfO8PSfflrsk+m3I1FVbwFU5zMNr3p4Z+siTZn+5tQNdR2qqI5GAVSfonYNkeWP9uO
         TCKOk/YNF7papCUlqmmZnyl3ih/swtbQxNnylyDvxM8nk1C593dC9/LExvL+B8RjmB63
         2Rhi1ePmYw62JIfTh6yZNirMw5ZZkONUhlTHAG4H8s61LCo9jylLPsjpbxfRguLCP42h
         y7CiDSrm38WK5Gadf5i/CN5FANz+vxv4Wtdl0FPURj617bOMXm0OtfMkjdgAu+YrG6/G
         z+fCU+Ho8MM4yxv19xi97+paDg6d17MCXpUiclFqEN1I8hOvndcOPKSdCrjHPtT9DQXz
         TN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684403637; x=1686995637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToOy6SsrGe7zKTu/1dnhsnfvtx8a3k0NpeaGTGEdvcw=;
        b=LCa7JXb35JfEhztbRevMJc/yq2SIChSuy/Nu3iQsk4SBdv2LdG75c3swN7ClQhjf60
         SqhlP7V+W5/t1XSVNi6Y9cCil30GiO8mstXVoEMeeDhMWKKqg0WKD70KjxKHOY8MIJ4J
         U3wGa8E5xRyNIudNt4j7GRSLMAdphkChCfPV0z5tZzpKrrT2Gc0Nm9C39QoFpxnuXhWQ
         /F9qEDpaB+LNO0d1Jl3ShPwN/gkj0mzhi/g9RZmw6zuzRqqy1OlxnElcwkSU0u6aeeeD
         Yf7NJk9PzzOGB9aV0uaObB1Qe96fT9Lt8a6i+skdmzD1fHANB4fbqngUfVl3GfGm1jim
         cIJg==
X-Gm-Message-State: AC+VfDy4eWaFDnuKVQPVcHH6G6EvuGvtPloxEdvO+eCRWl03FLCESyhE
        R6NRGnh6kPYgm4p7HLRNuzwmEA==
X-Google-Smtp-Source: ACHHUZ67kxU3de0WUF+4JciTkr/dX619CKjiOJxgCBiKnXnKL0LGhFvAk3UEiqDl+nRVs/mcY5VA0Q==
X-Received: by 2002:a17:902:f7c6:b0:1ae:5d55:3bc3 with SMTP id h6-20020a170902f7c600b001ae5d553bc3mr1928476plw.48.1684403637276;
        Thu, 18 May 2023 02:53:57 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.115])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902e31400b001ae5d21f760sm981151plc.146.2023.05.18.02.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 02:53:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] MAINTAINERS: Remove myself as a Arm CoreSight reviewer
Date:   Thu, 18 May 2023 17:53:45 +0800
Message-Id: <20230518095345.1755105-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't done any meaningful work for a long while on Arm CoreSight and
it's unlikely I'll be able to do related work in the future.

Remove myself from the Arm CoreSight "Reviewers" list.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..342b8a3e19e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2102,7 +2102,6 @@ N:	digicolor
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Suzuki K Poulose <suzuki.poulose@arm.com>
 R:	Mike Leach <mike.leach@linaro.org>
-R:	Leo Yan <leo.yan@linaro.org>
 L:	coresight@lists.linaro.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.39.2

