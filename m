Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E576662CBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiKPVA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiKPVAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:00:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA06D140B8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:58:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d9so27281554wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qu3xB7BDAsHZerZW0pGAagjp7CtoVgai761hm4h5lQU=;
        b=HYOVnUD070fQWF2aKYfWB3JjVVaD7Vs3JfonohHVtmsMLKc4qCLTrViB2qzoxxsUjR
         653EQMyPLBHu+U3bCLA4O3lWKXkICAs1JWUOUyFWguLMhs2IdOWSLGPCr3jWo2qq8q6o
         5JuAUOa6i9yAyGdpCtoDfp8fHpUPVrNJyiHMByOVw06Edm6PpM3B5S4lr8WI/iBzfaMp
         owugKuC3NYANOB9ZwlZF6y9rb7h9OEv+GG8HFT4V/ZD4Afht58Q02NSUnq9nJ6HEkv7B
         5GkVB4KNEE3WT7oGHgep48R4Wck/oTcJldF5QBAJEZzHdRKpVBF1m3uog7p8P++Fii0T
         Q7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qu3xB7BDAsHZerZW0pGAagjp7CtoVgai761hm4h5lQU=;
        b=1F7yBcrnfbZn7GelPClnuElIuPMQxOHhN7y07S7Tt0hRaZKEVALzU0ix6D7B1s8o77
         +R6HY4IS9gzOHZ27oGpjqxY5J+7vik0LlAfMiGHBaEGPhhH28PtZGPCSuPWRf17gaAHY
         dHZ8pRoPKxnMYLqN2WOIXUVjHgQikW9aJ95cM0hOQ2sfpsZM0PhMMuyn3EmDHMh8QdAQ
         u/rU78g+WVjMqkpEij69wdmfh8wIxaoN99MZBpby0R5YVzD5wYSlp8UIDVjBIbgzYBZ+
         gfZ5/ro20w9vlvIXC+/ip5GB1L+BVgB6Eei2dJQXKeUqieywLsA8V2XwtqNmyXOAoJ3r
         2PUg==
X-Gm-Message-State: ANoB5pmk1dCtUgEr9RN/DfYhMsDeCKPzjWcqVRVNRlpMyqAoNQwduBqC
        6PMxTGyPuIt6HNAluhuAW37YXXfMm0oTbtEA
X-Google-Smtp-Source: AA0mqf5t7rRf8oY52dDS7Sgt4Sm9x7fC18yOZBlUIPzBUqsvzyfPLtQIzKAcPuKAL5u/SPrREazO1g==
X-Received: by 2002:adf:a113:0:b0:236:6f6f:8dd9 with SMTP id o19-20020adfa113000000b002366f6f8dd9mr15441103wro.675.1668632308297;
        Wed, 16 Nov 2022 12:58:28 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdd4b000000b002302dc43d77sm15886098wrm.115.2022.11.16.12.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:58:27 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v11 0/2] mfd: max597x: Add support for max597x
Date:   Wed, 16 Nov 2022 21:58:20 +0100
Message-Id: <20221116205822.1128275-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max597x is multifunction device with hot swap controller, fault
protection & upto four indication leds.

max5978 has single hot swap controller whereas max5970 has two hot swap
controllers.

Changes in V11:
- Update description in DT
- Remove newline at end of file.
Changes in V10:
- Cleanup unused properties
- removed superfluous comments
- Update description for regulators property
- Fix typo
- Update 4 spaces indentation in example
Changes in V9:
- Update properties description
- update required property
Change in V8:
- Set additionalproperties to false
Change in V7:
- Update id
- Remove empty line
Changes in V6:
- Update missing vendor prefix
- Update indentation in example
Changes in V5:
- Fix dt schema error
Changes in V4:
- Add NULL entry for of_device_id
- Memory allocation check
Changes in V3:
- Address code review comment
Changes in V2:
- Update depends in Kconfig.

Marcello Sylvester Bauer (1):
  dt-bindings: mfd: Add MAX5970 and MAX5978

Patrick Rudolph (1):
  mfd: max597x: Add support for MAX5970 and MAX5978

 .../bindings/mfd/maxim,max5970.yaml           | 151 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max597x.c                         |  93 +++++++++++
 include/linux/mfd/max597x.h                   | 101 ++++++++++++
 5 files changed, 358 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 include/linux/mfd/max597x.h


base-commit: 27fea302952d8c90cafbdbee96bafeca03544401
-- 
2.37.3

