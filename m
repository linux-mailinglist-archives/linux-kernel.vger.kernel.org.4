Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77D06A50EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjB1CLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjB1CLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:11:51 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437430C0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:11:50 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 30D4E320093F;
        Mon, 27 Feb 2023 21:11:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 27 Feb 2023 21:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1677550308; x=1677636708; bh=09rEogSw39
        BE6hJVqc4+1JRjsOZEx+0NN5c8zuhIPcQ=; b=LM23vRz1WmVYUs9Xj/r0cQ2JBO
        2u+Z0gBLwpjIE6ED0eFLW2g3QTOjRg/qGesYMWoN/cJpGRRPGHUxSs+sf0iJ4CyW
        8MAHkusNcmG7UM3otih3E/zasjMJnPNKKofNkGvd3dvCzg909pjEigNnaROZeakr
        tR42eebl3eAw8bvXaX+rg7r/+QaE0XSgpXAUy7uV0WZWJAEye7zmvGA1Kl3WA9MT
        T3eNiD6YuM08BZU9EQ4ta3xJSTsKAGh1a6e+1oXwVqytT3xprOcV/BCKtmhAZRrc
        ROHIcKVlwCzP905hTj8djVShKrtMdscWluKwVXTt/DUY9TXtWn61F6bN2YMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677550308; x=1677636708; bh=09rEogSw39BE6
        hJVqc4+1JRjsOZEx+0NN5c8zuhIPcQ=; b=AM/bVi1dsh6EEuwHMgfIIY+mqh8K3
        L42nic894o6GZJ5gOrTMSHHicTp7QrWmc3If8QIB+LcDDd9sUTBvCFJDakyDi7LB
        +Ux93VmyUpic4QUbjTE5pWBVxd1o2j7qMr5HAfJRD7XCIbQkvgBW1YgYAhx6Az+9
        NZV/pIeGRiEylWQmOGYqx+lZ+4/6ftQfasLdrk3itvrZHDEwMLhrGQfkyAOJadFK
        QhsDJOpVDHK2/5V5aBd/d+xHfkwEqqXCCEPv6ke+gmmM7ngJ7igTjyYPoDFjVdai
        u64khV7qdVRArBjLS5zdbiGrt9bOGASd+7pjKMhfHpJA0aPxhz0ku/nqA==
X-ME-Sender: <xms:5GL9Y_FlBYxKqNC5Vyb7-ydCSDJ8NXomJFnlv7MQTEER16K3MG6cmw>
    <xme:5GL9Y8UJBbiCHdnVmngRryLoCoM74ofMwmnHUX3nJhpc3wNPITSfo2X6DKqNSUNLB
    BaEO_S37DWcjvgYWvc>
X-ME-Received: <xmr:5GL9YxJ_6K_qWQSP9JimFlHaE0svPffFexHJqsWjmY3LhyNAXahXDZkR6k6JD0SSkXF3bh4WXJGt1ZZMw8JhSOveE4n3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeluddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehvuggr
    rdhioheqnecuggftrfgrthhtvghrnhephfejveduudevvefhfeevfeekjeegtddtteetud
    ekvefgudeikeegjeejgffftdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvsehvuggrrd
    hioh
X-ME-Proxy: <xmx:5GL9Y9Gyo83XhI4C40Aa9FI98yUKxsxutahalknbUAkvm7viAISgqg>
    <xmx:5GL9Y1WtSvSW2BWCib-dQvy95t7ZjXpy13-ImP5z6LisvuKSEux7iA>
    <xmx:5GL9Y4PHyByqlEgkd1ZucPNqe2NB-YKeQckvOdIdlO6xtOtX3-InGA>
    <xmx:5GL9YygwXHSGtX13KXLm5RZVdVfciSDy9N5GJD86IG4Gbhmbcj-PIQ>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 21:11:48 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, thomas@t-8ch.de, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v7 0/4] tools/nolibc: Adding stdint.h, more integer types and tests
Date:   Mon, 27 Feb 2023 21:11:32 -0500
Message-Id: <20230228021136.13472-1-v@vda.io>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 7 of the patch to add stdint.h to nolibc. Previous
versions of this patch are available here:

* v6: https://lore.kernel.org/all/20230223010025.11092-1-v@vda.io/
* v5: https://lore.kernel.org/all/20230220202010.37475-1-v@vda.io/
* v4: https://lore.kernel.org/all/20230209024044.13127-1-v@vda.io/
* v3: https://lore.kernel.org/all/20230206013248.471664-1-v@vda.io/
* v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
* v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/

This version integrates the Reviewd-By Thomas Weißschuh. It also moves
the whole block of tests from syscall tests to stdlib tests.

Vincent.

Vincent Dagonneau (4):
  tools/nolibc: Adding stdint.h
  tools/nolibc: Adding integer types and integer limit macros
  tools/nolibc: Enlarging column width of tests
  tools/nolibc: Adds tests for the integer limits in stdint.h

 tools/include/nolibc/Makefile                |   4 +-
 tools/include/nolibc/std.h                   |  15 +-
 tools/include/nolibc/stdint.h                |  84 +++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 139 ++++++++++++-------
 4 files changed, 177 insertions(+), 65 deletions(-)
 create mode 100644 tools/include/nolibc/stdint.h

-- 
2.39.1

