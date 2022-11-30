Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E918963D4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiK3LcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiK3Lbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:31:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0163A86A0D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:30:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u27so15446931lfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJ/QyPMvHYitchauxg+J4IBvV0VZtgC9RglXLyAlxPA=;
        b=Q2CN4xiKuwV8Yk/iVEzI07y6vaE//VcWOTuqr4Xntq8gHpyz9PNL36Tf0YMhKoDDZE
         PlWQXZHbaV/joc5NJ9j5VLVF2xw6034GC6y4ppl7CarHCuaTickPZVXWgEUnbrRAhaYS
         cxz/ukOQc94wO6GCH2XRQZomLt+4e4OJ84rfEBAgq6wFQ78MjZUWT58LrbUhJecuNgIA
         /PR548Em6l0gSIf4ErFPcikc0sUl0Nzqa10Wo7EtqrbtgKHJpqJqxgeQ5wUAisx6OIOE
         z0wp8Y8+l4OuAJEBNELr1iW7Sx73ZQ06X7Ai8NvfqGyxfAVmox9ZxizOlCDznyv9elHi
         Q7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ/QyPMvHYitchauxg+J4IBvV0VZtgC9RglXLyAlxPA=;
        b=TMBVVHKZZnK0XbrxplXn7xFeD2lssssKlG41oDyzhybOTPL6+fuFR0Rj0113pe7Hh6
         qX8B7c5Tcp8TCI404whp+lF2p5rClL5IqrZ/vq209IOVstpxcXWjGm7w4P/HE+ftrT98
         cDcIjgmSyuC3JaJ+Qj5EbZ7wk+ZHuSSiN5MTwVL8TQmMJ4kjuPoa4BrafvcMe5Zuh+yN
         JGdPcbIpUlKTzTh+bD9ScvgaBDloiZ3Zldg78+uCizf/+hbMeSuFechp4xz6ravaNl9Y
         3+zO2p/krcDppMNvl8Hv/Dt0M6FWIn/n7UvVP763tBQcYZT+sbcy7Ui4pOu0ciHn5sDe
         xpVw==
X-Gm-Message-State: ANoB5pme8tmiOtJmuqlXmPQrBvJx96EEUZPwneqC5zxWfmGpm1dh9z/w
        FCQaPFdtLe0f/4sbTNAgZfs8Wq4ltjzDZKG35Ek=
X-Google-Smtp-Source: AA0mqf7JfENvuHNjnW2DUEb8QRCashtG496fKpGfEnPYju3hRuId9ZVsavPh7u0U6jT3kj5bHlVh1uYniJunHQxdnck=
X-Received: by 2002:ac2:4838:0:b0:497:c370:470b with SMTP id
 24-20020ac24838000000b00497c370470bmr19675173lft.309.1669807829540; Wed, 30
 Nov 2022 03:30:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:40ca:b0:200:b774:fd43 with HTTP; Wed, 30 Nov 2022
 03:30:28 -0800 (PST)
Reply-To: ms.bbianca@yahoo.com
From:   Ms Blake Bianca <dw2396468@gmail.com>
Date:   Wed, 30 Nov 2022 03:30:28 -0800
Message-ID: <CACri2vTfCDrzV4Bd_ERi-STYFLiY-j=4BxA8p-FcZOyVzKfKPA@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

      I have an offer for you, kindly reply back for more details.

Remain Bless,
Ms Blake Bianca
