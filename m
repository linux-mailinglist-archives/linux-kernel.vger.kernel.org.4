Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2B5709B52
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjESP2l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 May 2023 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjESP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:28:38 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9471A6;
        Fri, 19 May 2023 08:28:37 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso85276266b.0;
        Fri, 19 May 2023 08:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684510116; x=1687102116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LpLEsVi8gedKYCkeDSQbqSIWZm0Ti0kQFvwl5FvWwk=;
        b=d/24Mjw/fQsATZJVi3uRAl38SACulya6D2uRmwyWyMMjV1jg9ZK0rkvGGVVRD0+JDX
         ijAZawIdpD+moVx16zVQGvWJ8GoUDwKEtHAH5SZ2dLD1yK28PLwsQLqfkQ+NcVa+RdOP
         0cQg208bF2bPD4ErYGUdtllS9AMB9JW82UqBFIbYvn766J81sx9z+Cu6YWT8EgQ9je5g
         SQTIgpYgkcBvfRdg90OVq3sT9a51nwV/F3qn4yB9ms07OZR3vMPk8kQP7ep02MXc8+ek
         yY5j+n34QrgUpMUWyqIi/J3h0eDPYKkSt2QKXDk8yguO98tGTPDiyLp2mGb+BPWOi1OR
         u4fQ==
X-Gm-Message-State: AC+VfDyCUrxX48WRy1eSvEkxjFZXo25FRz6N9Fo40Y6n5vWxgW4Dsi/v
        IjSk2GSLhyyyKsQ4YmzI1L4H3VNmo2snYurGhc8UEABhohM=
X-Google-Smtp-Source: ACHHUZ7js2vhL7jMHv3mcBklVxXc8VsE+E3d9LIxIlCW1ZDAa8TcDoPdpSK/rrCd1cxya08jVrh2rd2CIe0wjzwdrug=
X-Received: by 2002:a17:906:74dd:b0:929:b101:937d with SMTP id
 z29-20020a17090674dd00b00929b101937dmr2623077ejl.1.1684510115560; Fri, 19 May
 2023 08:28:35 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 May 2023 17:28:24 +0200
Message-ID: <CAJZ5v0g9RmqJm=bpc9SQryYo4r+9Ctj7_aXQcfFRWTS3=xs6qw@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.4-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.4-rc3

with top-most commit 71a485624c4cbb144169852d7bb8ca8c0667d7a3

 ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P

on top of commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6

 Linux 6.4-rc2

to receive an ACPI fix for 6.4-rc3.

This adds an ACPI IRQ override quirk for LG UltraPC 17U70P so as to
make the internal keyboard work on that machine (Rubén Gómez).

Thanks!


---------------

Rubén Gómez (1):
      ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P

---------------

 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)
