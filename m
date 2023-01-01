Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244AE65AAEF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 19:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjAASKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 13:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjAASKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 13:10:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E720A2702
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 10:10:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so22199033wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 10:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+gJLslUfByh2rYJWcIA9do6hLYKAffEB3P1PALwn3c=;
        b=Hs94l5lz8Zpjb5cjrLXmVRpQ5DDgSko2nb1TF75/WozZv0OWQETL9q4ZhcutBb7i1X
         MGYh1G0A3lxNeFpryVmmy4XmhUn3sj0W8N8x591vRUfxdoBCyHiSD57SWVU5CjNHHCXt
         OqrewOx+plPSxlSACcQy9AENeOi+YLFS9XcSYYh7oU2XrKUBR58i05xSzZewVOz0nQbM
         ADsnQnIzYfsPn39FsFYATPtXNfrbpoXfxwggNCXvd+8+zYJRCV9KltNzYFJcJCPbD1q9
         maG8eF0uaCSADaDapX7Qyd9BUCdz6a8ZkuJHF0qOIPL3Jqw76Z/wEf+tCWbhcTmJ3eHa
         86VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+gJLslUfByh2rYJWcIA9do6hLYKAffEB3P1PALwn3c=;
        b=metMkFH1lNmgngFnRoJqx1aEvpsqDISC9PEawT/IOBAHT2oS3OXuujCuBPcZ7OpYJf
         dapGJM3JTvj8NmVd2zCspFkUfD+s566QEINBxDq5+iizg3E0fzbLWL6bHDVHNjSSINEC
         jeHrG2jM5oZrwWBwhaxqMKdHJtlOiftUj1FO0DvdJ4qgljFKbc1JjgbGXwqNDIX/iP2I
         5IivRr0JZTI2kIiU4WeVcCdKRz9X9krs7AKaD2XP56H5JbwonT48SkfPwh7lPQMlMtEW
         aMFE++xqZcm/+cA5h4E7SvCXOzrEl2hsy5tm5nvpF09iVdOwspHFl6/+PG9Wm7jzXkRL
         WPnA==
X-Gm-Message-State: AFqh2kpF1jyr3AzsMdoqItdWoUAfqWAAgqitgLgtUXZhfo9HOUc8qoZy
        G/UBjDOEdT8e5t7k4UHZ/8OYeTQkPPw=
X-Google-Smtp-Source: AMrXdXu03TW9KRg7/3HjeNn7x+SuCzT0WZA6pgRoN/xRQC0OT00XxTxQc6r3wymdqpz9dA0xSViQ7Q==
X-Received: by 2002:a05:600c:3d91:b0:3d9:103d:9078 with SMTP id bi17-20020a05600c3d9100b003d9103d9078mr25909718wmb.22.1672596608407;
        Sun, 01 Jan 2023 10:10:08 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id u9-20020a05600c19c900b003d9876aa04asm29180561wmq.41.2023.01.01.10.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 10:10:07 -0800 (PST)
Date:   Sun, 1 Jan 2023 19:10:05 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     linux@dominikbrodowski.net, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: pcmcia: ti: regression cannot get IRQ
Message-ID: <Y7HMfUTjuWC+Zudk@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I was trying to boot again my old compaq armada 7400 laptop and the network card is unusable.

Last known working kernel is 4.16.18.
First known bad kernel is 4.17.19

The interesting log is:
[    3.503348] yenta_cardbus 0000:00:0c.0: ISA IRQ mask 0x0698, PCI irq 0
[    3.503442] yenta_cardbus 0000:00:0c.0: Socket status: 30000006
[    3.505250] yenta_cardbus 0000:00:0c.1: CardBus bridge found [0e11:b048]
[    3.505370] yenta_cardbus 0000:00:0c.1: adjusting diagnostic: 60 -> 00
[    3.505457] yenta_cardbus 0000:00:0c.1: Using INTVAL to route CSC interrupts to PCI
[    3.505554] yenta_cardbus 0000:00:0c.1: Routing CardBus interrupts to ISA
[    3.505556] yenta_cardbus 0000:00:0c.1: TI: mfunc 0x00000000, devctl 0x64
[    3.505556] yenta_cardbus 0000:00:0c.1: TI: no PCI interrupts. Fish. Please report.
[    3.505556] yenta_cardbus 0000:00:0c.1: no PCI IRQ, CardBus support disabled for this socket.
[    3.505556] yenta_cardbus 0000:00:0c.1: check your BIOS CardBus, BIOS IRQ or ACPI settings.
[    3.632323] yenta_cardbus 0000:00:0c.1: ISA IRQ mask 0x0698, PCI irq 0
[    3.632416] yenta_cardbus 0000:00:0c.1: Socket status: 30000020

Full 4.16.18 log is availlable at: http://kernel.montjoie.ovh/zoo/armada/dmesg-4.16.18.txt
Since 4.17 (and 4.18) is stuck sarting init, I have log for 5.0.29
Full 5.0.29 log is availlable at: http://kernel.montjoie.ovh/zoo/armada/dmesg-5.0.21.txt

Regards
