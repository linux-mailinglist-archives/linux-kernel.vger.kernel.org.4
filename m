Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95467EDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjA0TKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjA0TKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:10:09 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21687BE4E;
        Fri, 27 Jan 2023 11:10:07 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id q10so4526548qvt.10;
        Fri, 27 Jan 2023 11:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GSPIv+YqWdBZ4Ekp+ls2qyg5+evBT3aLSAigsT+W2bo=;
        b=q2e55E8gLMbbkccPn6JzZN4GEJyjdCHjScWW4jlkhEzZFF2WaghJGaHQeo7D+b1zvb
         28HB1B/zHGh0VsYRGx8jdo5moKtdAIBSHxTKLGooGdV3xcR1tUmzSlpUP0ey1gUqjN3A
         MbM4IfgDsJgbzFUvsvCxfFrJqyMajMTaAta3oFTky0Y/zdMSjpmZJz7LZmixS6Vn5zTz
         b3JdzD3UE7YjB99So/GfTckevQ6WbDPLh05ssc5QNRHS2lRNv9sww6TN+EU+ePJ7t6Zo
         hiwT3hSsY1cMy7oWxgF0/yp76J/jhIoWuF7FbQ2dworHxWMUg/iPaRAzIvp8BA/u60zD
         g9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSPIv+YqWdBZ4Ekp+ls2qyg5+evBT3aLSAigsT+W2bo=;
        b=K2LjNJbudqDpqPwX5DjL3hTIfvKq+GYATLqr7LOJUtfMVCogP+HhYyzSJ73IGCg5wL
         4Kx7s1kfkxjbrn/Qetkj0WDiBlq6XHKgqBDihuvPDH3VMyH3PtQsCAtS5qSnDPyn2cZN
         LMrL9UZXkFQ1krWkWBTuo4DRkDrzuZ3vQHdrrsAXhX6ddqQ9lYi7HRLZQoTKFi1/ZIwL
         lAXGjhALZHmMG7dmzzf/vU8dNPMwa/J2y9W5UyGjpcsOyJBPyGn9glu9TTMWUINmhBKw
         u/4FsnYaIe++UavWHoWnY6gXmm1HZLndsf3Zu1HADHkXhxEIZKNiZF8w8evMXtQBKw1g
         V2yA==
X-Gm-Message-State: AO0yUKUT1GhS0ocMie2KT8oX5s1YNoaKC8z0r95FKNg94NZuXADwydCS
        ujLwzcvXxQVEqJl4AgrVCzc=
X-Google-Smtp-Source: AK7set8nPB+Gn1du31KZgmxgwcBAH6FrxEuFT79qYMyqShGE2pPhvigqvUHCzA6bHwyJvUvIYzgs1w==
X-Received: by 2002:ad4:5b87:0:b0:537:64fc:eb43 with SMTP id 7-20020ad45b87000000b0053764fceb43mr28166288qvp.7.1674846606828;
        Fri, 27 Jan 2023 11:10:06 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id b23-20020a05620a127700b00704c6263924sm3362881qkl.13.2023.01.27.11.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:10:06 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id EB62227C0054;
        Fri, 27 Jan 2023 14:10:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 27 Jan 2023 14:10:05 -0500
X-ME-Sender: <xms:jSHUY0E3i0J3OUbieJRT_exCwA7DmmPNTZEY9b8dZonb52KtcXxTOw>
    <xme:jSHUY9UIzf74y4vbKvtZW7fCYdqSXrjvjssBwuX7mnlIVJ73ixPBz8EUTMX9sZA9l
    llnjoLxQ3zNfbN3UA>
X-ME-Received: <xmr:jSHUY-J4-ITIAYCRbHESGMkDgEeeaGVnCN2pn27wi81wh4qblm2wzXgddh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeelfeegvddutdetudeivdetfeegtdegffdvlefhueelhfehveetjeefteeu
    gfefgeenucffohhmrghinhepiihulhhiphgthhgrthdrtghomhdpghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgv
X-ME-Proxy: <xmx:jSHUY2HwoYuB28qZfcUesrhh9HqexonIKxrOzEDup58jSWyhhqqTmA>
    <xmx:jSHUY6VDmuUQoQHA0vCvSnZ1TxWuFpozXaDAMFY9tjtEPkizXUEeyA>
    <xmx:jSHUY5Ond06l5ItzknTyWvpBGGDesUJv2cwsurLNYgCCYIC7DjJCwQ>
    <xmx:jSHUY8LuqBAKMZZ7zdoHsDKvvmFVTbvDzhVspklQwFg1tZ3GaMrcvA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jan 2023 14:10:05 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rust: MAINTAINERS: Add the zulip link
Date:   Fri, 27 Jan 2023 11:09:13 -0800
Message-Id: <20230127190917.3369037-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd..30161207f365 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18219,6 +18219,7 @@ R:	Boqun Feng <boqun.feng@gmail.com>
 R:	Gary Guo <gary@garyguo.net>
 R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
 L:	rust-for-linux@vger.kernel.org
+C:	zulip://rust-for-linux.zulipchat.com
 S:	Supported
 W:	https://github.com/Rust-for-Linux/linux
 B:	https://github.com/Rust-for-Linux/linux/issues
-- 
2.38.1

