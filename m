Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984CF709CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjESQtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjESQsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:48:47 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80DCB6;
        Fri, 19 May 2023 09:48:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 883383200979;
        Fri, 19 May 2023 12:48:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 19 May 2023 12:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684514897; x=
        1684601297; bh=ER5O497djZCDIkmyCNXXy/HSN/ue8KW99etXc+TOCfI=; b=a
        EWNFzt2I7sbRhFmICxYITPUfPLgKFg7zscKjDun7r6vn2ffLLBkT/Bg/YW/3LGNa
        ATAKsFUtkj/s2dUzQzSms//c8Sce9kSk8xEGdXfAP44yZaP8jO0s3fw8s7KexIka
        U1BKOiIrtAND2UcnYcvxxll19Ol1NkESkDlxwAhnosXZS068EBHNhBYFaiAc2fYg
        3+5czIvsQ8AXdavWQ72RXrLGJWjwV3cfk8ved0ShuxfssaCEgNaw+KZiYFBiUMdW
        Nigur28z5UKeTCDe5z6oLlY5Gxcp7dpaAJbUnpFBNXjda2DtS7KBNRcg+yMdJKfv
        iiBkjB/BZiIlmaQ/fTWDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684514897; x=
        1684601297; bh=ER5O497djZCDIkmyCNXXy/HSN/ue8KW99etXc+TOCfI=; b=g
        JNcNTpiHwKMfVE2Gbv5a+qt4PNnq0StVViX5qFTV3FNezsQvLSeipYPs5hmy9m0W
        pIKQge7rrqmYHG8w3AydIGj6K++zz53963VadSt6S83HmqAdyDkYou8mL6OeRIoO
        FJ6uO47rZgBXkLKe1jxKZzpJEZNT2iN22t1o8ddQm9bsABI8KvDAjnQZMNqJhVaP
        URtZLcQwFTNdIpanqOMaj7ai8mK4M0O/eGZdwFbqAZlOZ7pAlxPMFlX9H0zfA48d
        qnWJZ/oL/aoLtRfylLQf8fo9P7oCqU33tRk0BCv1mYwqxL93kW5rul+uo7eDmuvF
        OwY/PqMzP9f0uua0nZg8A==
X-ME-Sender: <xms:UahnZHymM_8hV8c6u8s4bBD2c8Jmh7Assa8Wjr6BOqSMrcbNOz3ZaQ>
    <xme:UahnZPRm11q1Lv34n0eZD_gKrjlwJfHp-oC3fXOKrHnam-g6GbERNyQ6zKEdFxv1c
    m1JIR6CvYzyfztypXI>
X-ME-Received: <xmr:UahnZBVmhqyibydQZ8gfRspc6A7svc8VkxhCX9cEXPADbnhwYlzRSik4fREn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvue
    dvvdegkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:UahnZBjBL8uvcLlyk3rraRsDwS_Zkzj3vrBYayfYuDOMHlAlWObY-w>
    <xmx:UahnZJCLNHmRfcSnFFgueTCqZwmA65nEMQddAtGItrTLRBHui-8b6w>
    <xmx:UahnZKJoadrMiIRDudRusIfzG3VhcuelFk6xPN45y_J5oSCYHW7FFw>
    <xmx:UahnZMN6D5v31iUr-jujB8UeJPQ696CFBZbin7vI6Cx37f9qW1StTg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 12:48:16 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] MIPS: Select ARCH_SUPPORTS_ATOMIC_RMW when possible
Date:   Fri, 19 May 2023 17:47:53 +0100
Message-Id: <20230519164753.72065-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230519164753.72065-1-jiaxun.yang@flygoat.com>
References: <20230519164753.72065-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select ARCH_SUPPORTS_ATOMIC_RMW when we are certain that our CPU
have LLSC support.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 85728e4703bd..5f52bdecb4c9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -21,6 +21,7 @@ config MIPS
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_SUPPORTS_ATOMIC_RMW if CPU_HAS_LLSC
 	select ARCH_SUPPORTS_HUGETLBFS if CPU_SUPPORTS_HUGEPAGES
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
-- 
2.39.2 (Apple Git-143)

