Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A526BDF9D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCQD3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCQD3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:29:15 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536696043F;
        Thu, 16 Mar 2023 20:29:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id n2so4418398qtp.0;
        Thu, 16 Mar 2023 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679023753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6CV8jZsYZ2UdjlBBX4uRe49UAt4qUKHV31McFDU6yLg=;
        b=aRKdTq+mbJiQCUWWNi+grNsxTP/+77aC8OvU9AHkX9qpfLem0iH7adSvgaMYYsohET
         vUPNVEDQl2nd47n1Qn34kXGc08FOXiKm9BC99+bJnnZIMMRz2bkBK4lXP30CXo1pPB/Q
         CGQ4G1x/T35BAc27b1m+0EW7lLzgD0YtwchNo5CuXhTUhrT3pzyBheaCM5CxBuyhRTGp
         6Rlyw4mt3BRyfyXStumrcaQlANQldE86gvoVtKmst3dE2+F4FNjqarCJhIzoBbhVaV9V
         vujOBK0gTKgYJYxKDTpUTSuLLyFCPUc8VyqdQNFX8nadnje3R5ohwYI9JB8ey7uSUb3a
         cLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679023753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CV8jZsYZ2UdjlBBX4uRe49UAt4qUKHV31McFDU6yLg=;
        b=02liDWFu9yIV5JH/XDV6abXTU2V8mh7nUuBgQytWHH3cM3pACHLIugqOIV5GvsSMsn
         h9+ceHBfGlhINSKFvnr0GvoSsvKVTkD7e/ER80iEnhsvHUHwyQDv6fjeNeecD5yuaot2
         3qUuSQ8PBRgzyc1yv27WX+miavGGLjOv9R+IZIOMz91JY80vCE5qAmf3w3MQIoLunDuO
         ZnjWVv0C+vFMUzwHRx0YfCAaCYbABqQB8lTim0drEGTAs3r0O2LBpoFPc52W51Ehkm2D
         ammmFi+7oX+H8BRCkcjLeDiMxFycLwwg6S7ZzZ+/2/Cq+ftd271FclmqHN9L4T3lw34T
         a3DQ==
X-Gm-Message-State: AO0yUKUP7+2JCaSq4YFlxn3oVSreV9UjgNV2Ubs/2OI/ola2KF0V6Dac
        PcIIwNH0SlAmm7lfYBEXMaM=
X-Google-Smtp-Source: AK7set9ayLl6DVP3+gZKMmP4yPrSNIWqBDDEkVNbzDa1pgYCZxX/fmmvQgmc0uxngHYUIqR+HgvxaA==
X-Received: by 2002:a05:622a:1792:b0:3c0:3d68:540c with SMTP id s18-20020a05622a179200b003c03d68540cmr9074044qtk.65.1679023753528;
        Thu, 16 Mar 2023 20:29:13 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f66-20020a37d245000000b00745f3200f54sm818826qkj.112.2023.03.16.20.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:29:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9F20327C0054;
        Thu, 16 Mar 2023 23:29:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 16 Mar 2023 23:29:12 -0400
X-ME-Sender: <xms:h94TZJeP6PQoptmF6R4rQRBbAxGKgzqJl4arpRjyCzJa-TEcam5Mbg>
    <xme:h94TZHPpMNFJuj0KpfjzhRVYG7yzowzzrxmbxInVbz-ArjMmDMtw3bsxLTWlXN7-G
    Idd_aG2g873uyRQyw>
X-ME-Received: <xmr:h94TZCgQ9eoJhV70wwIzgMu3L4OtFkoE_XEQlfK26tE1vZD3CtYhdxJ8NII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefuddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgteffhfehjeegtdduieffudetfeehgfegudejudfhieefgfeigfevueduledu
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:h94TZC89nxDeNCHeZtbWXW3bb0rs-liPqoS0uwcEGsQnLBC3KlQvWQ>
    <xmx:h94TZFsLXYrzeBq0xwtdBP1cg2vSbY3FRcHw0rT2xrDM65w0uvEfdQ>
    <xmx:h94TZBE0nGSOMur527BJCi0-a6KlZnJo3WmQhSfX7dNGS3u_TdzqZA>
    <xmx:iN4TZLIHSu2YwXSnUZewic4xlp_BjbeeCAWoblxsnjz0joVniM_tnw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 23:29:11 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add myself to RCU entry
Date:   Thu, 16 Mar 2023 20:29:05 -0700
Message-Id: <20230317032905.10837-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Just to be clear, the "M:" tag before my name is short of "Minions" ;-)

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..370d2970b193 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17638,6 +17638,7 @@ M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
 M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
 M:	Josh Triplett <josh@joshtriplett.org>
+M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
-- 
2.39.2

