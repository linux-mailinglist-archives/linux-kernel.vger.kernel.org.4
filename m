Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955CB69BBB1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 20:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBRT4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 14:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBRT4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 14:56:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52E912F28;
        Sat, 18 Feb 2023 11:56:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v4so1105775wrw.13;
        Sat, 18 Feb 2023 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pQjuBZrFRe+74KRwh27+bKz/8Tg+GaGpJcQvuBfoHbI=;
        b=BCdKo6Oj/bi7MNxf+s2RU605Lmn+aQ+ahaAsMzFREv/9yPTnHiaeaUovQ4ZSDyeDfR
         9cOb51mHK0gY+bfrmdcCA2apNhB9eYN9l71FuHAMTN5krnhngvVyhFpAfIRN/nVv4SP+
         5qG4GpvdioF/1jic1ayEKJXdnAANHh1kAhw7FQ7xyNXNP78/sVQTevgpjE4lj1rDWP41
         k9KA7HVBXu4v01CEwMjtI5OVRyr3EIAo9QmZT5dSTN2OIWRpLXR1MaYgXlTwv2TvItp+
         bdH7QQRFf4taIde3F9ACS+nIKcsSWDNbmzfPO+8k2q4X0AowHYkY/sO7GN6uZVx+aE0C
         YzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQjuBZrFRe+74KRwh27+bKz/8Tg+GaGpJcQvuBfoHbI=;
        b=IaR/LhZ0uf3P4CIar8aCVPGl7x3NVBzxbTibNIZvVX8BG8bHdfMlGMLhW9Clvs5rt9
         yfwwHGTpKdIo/dXWdlMOIW5KJ6PDy14qY2fszKofGAxnY+3Cc3CSUku3w2U209N0AYPa
         K+E8KhiLvsoiEKL3RqFkBASvLlH5cxr5wii7hQR/tOBo83yMxy0uaZlXq5EjYl9M8zfR
         zHMsOfCqV5HhFGJWf4B/fsrhNlxVrE8xhylLXv43Jze0e0TU2bgl1ak0c4TiBbBx/dVz
         LpD501G56WccnmHrvi8E2VbCYHplMfYunO37D7g3iW6OaXm2qffbUvSK32WrhHtLpvdH
         LLTA==
X-Gm-Message-State: AO0yUKXl30SxOYl6DGCX7vkx99TnvNqcjmoU0OK5WEm90xh5oJIbEai2
        jZkvoe41iZ7pfoKuV8Mk5sHQ1VKgQ1Qog8exbMeiD0/Pkxk=
X-Google-Smtp-Source: AK7set/l/hR/n23DPN26/fKiCoXrFJYtYMoT+Md0gNV6ygNQomH5ZpQWeGEur3+P79bZfYVjk6ST01a/qMosLLDJsXU=
X-Received: by 2002:a5d:6dcc:0:b0:2c6:e7b6:dc30 with SMTP id
 d12-20020a5d6dcc000000b002c6e7b6dc30mr109892wrz.9.1676750210966; Sat, 18 Feb
 2023 11:56:50 -0800 (PST)
MIME-Version: 1.0
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Sat, 18 Feb 2023 21:56:39 +0200
Message-ID: <CAGi-RULY-9eS7JUA7bW_tJ0JjA_hJTjvOyGyj7_7aVtRk2BaFg@mail.gmail.com>
Subject: amba pl011 non amba/sbsa driver
To:     linux@armlinux.org.uk, Greg KH <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Baruch Siach <baruch@tkos.co.il>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
Our upcoming SOC is using pl011 ip, but we have a different NOC than
AMBA and we don't want to use the SBSA, as it provides limited
functionality in the UART.

My question is should we develop a new driver or add more
functionality to the current driver.
The pl011 driver is a bit messy, and the functionality we actually
need is actually supported in the current driver, but I can't
differentiate my HW using AMBA id.

If a change will be more suitable in the driver, my plan is to add
support for an oe_device_id table  along with an amba_device_id table
for generic amba pl011 drivers.
Does this make sense ?

Thanks,
Ramon.
