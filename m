Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF760FFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiJ0SA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiJ0R75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:57 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F181781C4;
        Thu, 27 Oct 2022 10:59:23 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id f8a35747ecaca7a6; Thu, 27 Oct 2022 19:59:21 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8B54466D83D;
        Thu, 27 Oct 2022 19:59:20 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 00/11] ACPICA: Upstream changes since ACPICA 20220331
Date:   Thu, 27 Oct 2022 19:45:39 +0200
Message-ID: <4756726.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.45
X-CLIENT-HOSTNAME: 213.134.169.45
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepheeggfdtteethfduveegfeevteduiefgteefueekuefhieegffevteektdfhveeunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeiledrgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledrgeehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series of patches represents upstream ACPICA changes committed since the
20220331 release, as available from https://github.com/acpica/acpica, except
for the patches that have been applied to the Linux kernel already and one
commit that was reverted from the upstream ACPICA.

It contains the following material:

Alison Schofield (1):
      ACPICA: Add CXL 3.0 structures (CXIMS & RDPAS) to the CEDT table

Bob Moore (3):
      ACPICA: Add a couple of new UUIDs to the known UUID list
      ACPICA: Improve warning message for "invalid ACPI name".
      ACPICA: Finish support for the CDAT table

Huacai Chen (2):
      ACPICA: MADT: Add loong_arch-specific APICs support
      ACPICA: Events: Support fixed pcie wake event

Kuppuswamy Sathyanarayanan (1):
      ACPICA: iASL: Add CCEL table to both compiler/disassembler

Robin Murphy (1):
      ACPICA: IORT: Update for revision E.e

Sudeep Holla (1):
      ACPICA: Add support for FFH Opregion special context data

Vit Kabele (2):
      ACPICA: Check that EBDA pointer is in valid memory
      ACPICA: Do not touch VGA memory when EBDA < 1ki_b

Thanks!



