Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C84641E4B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 18:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiLDRzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 12:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiLDRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 12:55:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B624B140CD;
        Sun,  4 Dec 2022 09:55:24 -0800 (PST)
Received: from zn.tnic (p200300ea9733e799329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e799:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 48F111EC05BC;
        Sun,  4 Dec 2022 18:55:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670176523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=4GSyFVHhppU56Viv573uhRazx4FATMW7mWUL/C9pPYU=;
        b=b4jTngj2KET5iUQohbUIKDGV+/8VSqgsyfP6o9gOIQtiurZSniJ0UiVvAf7vcABPOOc2Vb
        AfovbXAwxKgKJ3LUESLlcNqeyG9ebMOuhLGV65myitVF+Hc8ZgnxpMGw5Li/iGaDsgsk22
        wuR0gaXpoVzrGC2IleRLahCvyE14EsM=
Date:   Sun, 4 Dec 2022 18:55:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: CONFIG_SENSORS_OCC_P8_I2C
Message-ID: <Y4zfBRahZJ0QM758@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

make oldconfig asks me here on a x86 machine about this below and it
looks like this should depend on some P8 config item so that it doesn't
show on other architectures.

Right?

Thx.

CONFIG_SENSORS_OCC_P8_I2C:

This option enables support for monitoring sensors provided by the
On-Chip Controller (OCC) on a POWER8 processor. However, this driver
can only run on a baseboard management controller (BMC) connected to
the P8, not the POWER processor itself. Communications with the OCC are
established through I2C bus.

This driver can also be built as a module. If so, the module will be
called occ-p8-hwmon.

Symbol: SENSORS_OCC_P8_I2C [=n]
Type  : tristate
Defined at drivers/hwmon/occ/Kconfig:6
  Prompt: POWER8 OCC through I2C
  Depends on: HWMON [=y] && I2C [=y]
  Location:
    -> Device Drivers
      -> Hardware Monitoring support (HWMON [=y])
        -> POWER8 OCC through I2C (SENSORS_OCC_P8_I2C [=n])
Selects: SENSORS_OCC [=n]

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
