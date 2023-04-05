Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282626D7E9C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbjDEOFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbjDEOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:04:44 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6B876B4;
        Wed,  5 Apr 2023 07:02:08 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 7cba445b858272b9; Wed, 5 Apr 2023 16:01:34 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CB79D1B4EA6F;
        Wed,  5 Apr 2023 16:01:33 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 00/32] ACPICA: ACPICA 20230331
Date:   Wed, 05 Apr 2023 15:29:49 +0200
Message-ID: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptefgiedtfeeuheegtdfhleeltdeuledugfehfeekkeekudffgeegtdeufeekvdeunecuffhomhgrihhnpegrtghpihgtrgdrohhrghenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=0.5 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series of patches is a set of ACPICA 20230331 changes described at
https://acpica.org/sites/acpica/files/changes_64.txt ported to Linux.

It contains the following material:

Bob Moore (2):
      ACPICA: Update all copyrights/signons to 2023
      ACPICA: Update version to 20230331

Hesham Almatary (1):
      ACPICA: Add support for Arm's MPAM ACPI table version 2

Huacai Chen (1):
      ACPICA: Add support for 64 bit loong_arch compilation

Jeremi Piotrowski (1):
      ACPICA: Add support for ASPT table in disassembler

Jessica Clarke (1):
      ACPICA: Headers: Delete bogus node_array array of pointers from AEST table

Kees Cook (10):
      ACPICA: struct acpi_resource_vendor: Replace 1-element array with flexible array
      ACPICA: actbl1: Replace 1-element arrays with flexible arrays
      ACPICA: actbl2: Replace 1-element arrays with flexible arrays
      ACPICA: struct acpi_nfit_interleave: Replace 1-element array with flexible array
      ACPICA: Introduce ACPI_FLEX_ARRAY
      ACPICA: struct acpi_resource_dma: Replace 1-element array with flexible array
      ACPICA: acpi_pci_routing_table: Replace fixed-size array with flex array member
      ACPICA: acpi_dmar_andd: Replace 1-element array with flexible array
      ACPICA: acpi_madt_oem_data: Fix flexible array member definition
      ACPICA: acpi_resource_irq: Replace 1-element arrays with flexible array

Najumon (1):
      ACPICA: add os specific support for Zephyr RTOS

Niyas Sait (1):
      ACPICA: add support for ClockInput resource (v6.5)

Pedro Falcato (1):
      ACPICA: acpisrc: Add missing tables to astable

Sunil V L (2):
      ACPICA: MADT: Add RISC-V INTC interrupt controller
      ACPICA: Add structure definitions for RISC-V RHCT

Tamir Duberstein (8):
      ACPICA: Avoid undefined behavior: load of misaligned address
      ACPICA: Avoid undefined behavior: applying zero offset to null pointer
      ACPICA: Avoid undefined behavior: member access within null pointer
      ACPICA: Avoid undefined behavior: member access within misaligned address
      ACPICA: Avoid undefined behavior: member access within misaligned address
      ACPICA: Avoid undefined behavior: member access within misaligned address
      ACPICA: Avoid undefined behavior: member access within misaligned address
      ACPICA: Avoid undefined behavior: load of misaligned address

Xiongfeng Wang (2):
      ACPICA: ACPI 6.5: MADT: add support for trace buffer extension in GICC
      ACPICA: Add missing macro ACPI_FUNCTION_TRACE() for acpi_ns_repair_HID()

void0red (1):
      ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects

Thanks!



