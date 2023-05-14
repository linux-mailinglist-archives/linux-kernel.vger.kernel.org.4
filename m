Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11004701E28
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjENPdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENPdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:33:20 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BF244AE;
        Sun, 14 May 2023 08:32:54 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53063897412so4474696a12.0;
        Sun, 14 May 2023 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684078346; x=1686670346;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odfI42LfjFjYiGmwpoXU0rW2oYspEJ1vTnNK/Z96H8c=;
        b=OnVJnmY6QHxGZqUdS0J3SREG4B4wqa4mOHwWZf0Cd2ILURG9dy2xYYah2nmv74PlK8
         b10o554L4nfXz06SWtlIIVhNQLmW2dwnDsiBwcjVppTsVA59wUMH6ReeZ066yRtPEtHy
         nsSUMzA/Q8fI1bOpl8l7AxUX5E6J9hqY2N5m0u/TzzjfLznBegcyKVrB9u13PUuSbUkV
         sdBX7NTRZUmj4uy5nE8luQUooFhx+shX1O2f6QvioimTQrqAOVZ/V/Nmgr5jL7E8VvGr
         QrCIdgUaMmDRVkmvHtLesSUyVKdbssBXUxukxnZ9punOcGEiVPiraAFLB1mWLK5J7eWo
         CdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684078346; x=1686670346;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odfI42LfjFjYiGmwpoXU0rW2oYspEJ1vTnNK/Z96H8c=;
        b=Q4YpDC00GAxKM38uYP62VqrpO0406vmKxluvzh/v4mszS69FQX9HQCQwzJDBzLrXAa
         SaJfyg9Kfg156Q61kDGiBUyWsz3Fxi5dI5tamTHfBJQcdVYNjD3m7wtKwcbSaPDPS3ym
         NzS9I2uS7ynzCpSRoqo5fQxVBQXsPlgqHfnRPJ9/cj8BEO1dyU91fYXYZL9SmsvOWAlR
         EYcOWzN8s3uwdjXIYPqpiWKjl+YtIKys1KcmV4Bq5R/pmy+MECUT4zMGLuBgdE1jOTTN
         BMVoJQQjyA3S/L63U65W4gCrblS4ZgpGD07mo0cw3SeyFFm347syBbhk7cq15/oAFXtW
         oj6w==
X-Gm-Message-State: AC+VfDzCP43/p2UrRw3+cPu3ZD1ngVTpsvQklCDKFUHHPbZZlHuxVKu8
        sTa5lee1dqqSQQsCvUFGVw==
X-Google-Smtp-Source: ACHHUZ4n2HyH6Ze3g1I+wxRZZDTQyiZB6i+vO6JhaJQwzmorCJl0hsvRi9t7bHVxgYAMXsZjv2SAuA==
X-Received: by 2002:a05:6a21:32a2:b0:ff:6120:e9b9 with SMTP id yt34-20020a056a2132a200b000ff6120e9b9mr37183414pzb.39.1684078345683;
        Sun, 14 May 2023 08:32:25 -0700 (PDT)
Received: from smtpclient.apple ([110.226.25.172])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b0063b7b811ce8sm10135030pfo.205.2023.05.14.08.32.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 May 2023 08:32:25 -0700 (PDT)
From:   Swapnil Raicha <raicha21swapnil@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v1 1/4] drm/panel: simple: Add AUO G101EVN010 panel
 support
Message-Id: <4B9C9FF7-F338-4449-8841-BCC3D423EB76@gmail.com>
Date:   Sun, 14 May 2023 21:02:02 +0530
Cc:     airlied@linux.ie, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, thierry.reding@gmail.com
To:     alex.gonzalez@digi.com
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_B,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

I am currently working on STM32MP1 based custom board and using the =
auo,g101evn010 panel.

The panel comes up but the colours are not as expected.
One observation is that when I pull down the notification bar on the =
Android Screen on the panel, due to the overlay of the notification, the =
colours in the background seems to be perfect then.

Not getting where to look at for this issue.
Seems to me an issue related to DRM.

Can you please suggest a solution for the same.

Waiting for a reply.

Regards,
Swapnil Raicha.=
