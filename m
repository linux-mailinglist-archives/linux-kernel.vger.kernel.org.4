Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C1865715C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiL1AD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiL1ADy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:03:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4745E5593;
        Tue, 27 Dec 2022 16:03:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E70FFB81211;
        Wed, 28 Dec 2022 00:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E5CC433EF;
        Wed, 28 Dec 2022 00:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672185830;
        bh=MQbih2jbIEW/jJUbyRpVyIdJTyGdXQtXDMaw+tQ/Hf8=;
        h=From:To:Cc:Subject:Date:From;
        b=u7FYZKV+YsqKvFBDe8HzubR9FBcyvRTIhcenog870EfS72mvXJaskwFZT2hc0O3uC
         XHCfQO+tfL0qD4eWuR7UU8MYTFcYZ9DBBNArYXHOp9zjPU8njkyX8Z6FrZLR+Yi4gX
         32d9ivNn32o0XXIB9rsQ+C0U1l9JqKD3VawZHJ0S1KDrD+e3g8+CAOFloJwTjQxahi
         jq3wIyLZ/C5V2+ygmk68wQpLZcZTv7OydjtKh5HPkCiI5/hsxhxk4yShbVGqg1Rpsf
         luCE/oitl6lF+NHanNu64Hwzt8srg3/dgA0S2f9YL0TA0hyoOjnizHohQno97KZIj9
         rHZW9QQnGLJcQ==
From:   Conor Dooley <conor@kernel.org>
To:     corbet@lwn.net
Cc:     Conor Dooley <conor.dooley@microchip.com>, broonie@kernel.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] Documentation: process: Document suitability of Proton Mail for kernel development
Date:   Wed, 28 Dec 2022 00:03:31 +0000
Message-Id: <20221228000330.3971104-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=conor.dooley@microchip.com; h=from:subject; bh=eniW2kbAbZifJ5f8/X496o8vI0+UsoIVdT7XOxxhr/g=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMmr2y/orbfZ7aOV6lagv6d0E8O2VzNUmQoufMoyLpsk9PWf /6TFHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIifWMDC9yJxd8e91z6Vq8zMMDSr fP35azlPzioTDh0R0jcUWh8C+MDP3ervGnfHqKL0z9JMP7NHFCwLaAgFXJQic7ZHt2X3jAzwsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Proton Mail automatically picks up PGP keys for those with kernel.org
accounts (and other domains!) which provide WKD for their users & uses
them to encrypt emails, including patches.

Document the behaviour & Proton Mail's unsuitability for kernel
development.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/process/email-clients.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index fc2c46f3f82d..c448f2814b84 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -350,3 +350,18 @@ although tab2space problem can be solved with external editor.
 
 Another problem is that Gmail will base64-encode any message that has a
 non-ASCII character. That includes things like European names.
+
+Proton Mail
+***********
+
+Proton Mail has a "feature" where it looks up keys using Web Key Directory
+(WKD) and encrypts mail to any email recipients for which it finds a key.
+Kernel.org publishes the WKD for all developers who have kernel.org accounts.
+As a result, emails sent using Proton Mail to kernel.org addresses will be
+encrypted.
+Unfortunately, Proton Mail does not provide a mechanism to disable the
+automatic encryption, viewing it as a privacy feature.
+This affects mail sent from their web GUI, from other mail clients using their
+mail "bridge", as well as patches sent using ``git send-email``.
+Unless a way to disable this "feature" is introduced, Proton Mail is unsuited
+to kernel development.
-- 
2.38.1

