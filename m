Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E06F30D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjEAMZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjEAMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:25:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC61BB
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:25:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f00d3f98deso22274224e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682943910; x=1685535910;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uBgAWRhKxk6UEmdv5jE39t1viFb+AQUZD51sjKWSdNg=;
        b=bKBAY7S+nLpXAksEeOFSTU5JckI+tpvAmFb79i4FpCXb/nfW0RtA6VPxu9wWpr2wav
         QKwPsFDsrU/ErtG6DOvlkkKCz0HxMHav54WV+Da9KcXKu0DEMQQlgZGfW8+IJSVUzeWI
         3bHa21ek2I0VTdpQOQP+Fjew/LaHGj5kqj3p15f/xwkp8+irpHWdONDqdeLEeXbu8ZFn
         0cGUa7LO+q4wsN0Hs5mQQlF43KHAxyidAOthM4yAd55qrXNg6f1Ux0ol7gPFZvnMnHPp
         YGp+Bx2NfcYhZaXqDJloXnvwa8vxjKyi21n8eWFPJdgrcOtTYn+D4c+RBNCxHXLae0f1
         LcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682943910; x=1685535910;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBgAWRhKxk6UEmdv5jE39t1viFb+AQUZD51sjKWSdNg=;
        b=JLY+s1u6nNmu9rZaZdMz/QIVvPaWq7ZbD+N9NYTyzMALXS8vHLEzIkxLPf7GeS8xXs
         KbwqABsQvhPP1FIIv2nzllO4ZrEnG4F/xtM8qUG26jwlH0u6aNCcSyuIgkD50GgIs+ex
         vcVB/9ryZtMe7/JMjC26NdAbYo2iE7HICHZDFQuVjHcREbus9QEajaBsXFE8DVdd78YR
         I787SiXM6BWmTOoDGZYtr9yOkzspEm3+3fbXnS4Xi7vwiD28OT2WWPX/tT402DT1hRCF
         ac9ML2P8408VQ+odUVBToxRd/TVMFi4UUCphgHDNhLRgvr7jrNoZQJZlhpdo3KiWla4s
         pFpg==
X-Gm-Message-State: AC+VfDyLpj1r5sXC1ovytt6q+shrnzdCBQhWMu5daF5cYh92ogqJ8wuL
        auNnUaJxswMOZjTKlQKmOh9aiLcz3oWfIHcUy5VUMozotdQoeg==
X-Google-Smtp-Source: ACHHUZ4WXqxiu2jyeRBMkvT2Icw3Ws5/gKr6U7LbrztNpxJEnCldkNKpNTqCTdy0jtpao9hWls3zxwpgMZJYirNkjNM=
X-Received: by 2002:a05:651c:31c:b0:2a9:133e:dadb with SMTP id
 a28-20020a05651c031c00b002a9133edadbmr4983415ljp.1.1682943909555; Mon, 01 May
 2023 05:25:09 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?SXN0dsOhbiBWw6FyYWRp?= <varadiista.1@gmail.com>
Date:   Mon, 1 May 2023 14:25:00 +0200
Message-ID: <CACUCvsBNhL96Leo8w5fj3mwNNXJmr_k3Op26ctj5c6dkfTmUUg@mail.gmail.com>
Subject: [PATCH] ACP6x audio: Add board quirk for ASUSTeK COMPUTER INC. M3402RA
To:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Kernel Developers,

I hope this email finds you well. I am writing to submit a patch for
the ACP6x audio driver in the Linux kernel that adds a board quirk for
the ASUSTeK COMPUTER INC. M3402RA.

After experiencing issues with this board on my Linux system, I
researched the issue and found that adding the following code snippet
to the file sound/soc/amd/yc/acp6x-mach.c should resolve the issue:

{
    .driver_data =3D &acp6x_card,
    .matches =3D {
        DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
        DMI_MATCH(DMI_PRODUCT_NAME, "M3402RA")
    }
}

As someone with no experience with the Linux kernel, I am submitting
this patch in the hopes that it will be beneficial to a larger number
of users. I have tested this patch on my own system and can confirm
that it resolves the issue.

Please let me know if you have any questions or require any additional
information.

Thank you for your hard work and dedication to improving the Linux kernel.

Best regards,
Steve V=C3=A1radi
