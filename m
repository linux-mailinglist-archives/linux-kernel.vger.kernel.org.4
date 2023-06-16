Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37170733472
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbjFPPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjFPPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:13:24 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B5C3581;
        Fri, 16 Jun 2023 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686928404;
  x=1718464404;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=oQT8FMsskbrII3ufVQZy2vIcS5ZsD7/FmmoLvitVZ/g=;
  b=ik/excYqoT1mAWYdry0zOKyGCm+hjfEcXBFZjE6leoJhsOQTYHKwZCH+
   xLAaBrS5H/HFgVs4pgcf4LMmc78NMZjrsD31cYESfPiWcQR5eL8n0J980
   3x1yMPzl1vFoI3H5EupOMdmzeZDGnEHVN8AvoBet5dXPhfBKtqq4A5+6C
   8gDzb4Z9DoFGLp2f5OW5OgHyFK+SjiGttpUCbBo2qjUC+ROOeJ10CYKNO
   gBNlh+jsKe0oq2aupKTSmbnLH3LKbRO1VCXqvlqUOqPMR/fC/17I/AhE+
   cvCbrb0IlJXRzmY/ftJ/1gpwy0ic6VmuvM1NtnE+JTdXXU+9sVVhkzdU+
   w==;
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: [PATCH 0/2] Add driver for Murata IRS-D200
Date:   Fri, 16 Jun 2023 17:10:42 +0200
Message-ID: <cover.1686926857.git.waqarh@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murata IRS-D200 is a PIR sensor for human detection. In this series we
add devicetree bindings and an IIO driver with support for triggered
buffer and events. Link to the datasheet should be added to the
devicetree bindings, when that is available.

Waqar Hameed (2):
  dt-bindings: iio: proximity: Add bindings for Murata IRS-D200
  iio: Add driver for Murata IRS-D200

 .../iio/proximity/murata,irsd200.yaml         |   54 +
 drivers/iio/proximity/Kconfig                 |   12 +
 drivers/iio/proximity/Makefile                |    1 +
 drivers/iio/proximity/irsd200.c               | 1051 +++++++++++++++++
 4 files changed, 1118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
 create mode 100644 drivers/iio/proximity/irsd200.c


base-commit: b6dad5178ceaf23f369c3711062ce1f2afc33644
-- 
2.30.2

