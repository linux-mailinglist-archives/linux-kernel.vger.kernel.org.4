Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAEB6B8BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCNHWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCNHWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:22:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E6C5D762;
        Tue, 14 Mar 2023 00:22:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so6443321edd.5;
        Tue, 14 Mar 2023 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678778522;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9krYtYgrFfB+EZxwYgYFLH4M2qRAdQv9i48TyNn/Zvw=;
        b=kJZ480KiLGQMVSncOnZGVRRx4P0N7HZDE5tLslc8GyW3aA7WqL3XWUTKlXJ+hJOarg
         lOwW+YKeXPziRZZOYmtFTnQACP8mW49W/o7JddTQ1kGS6bDHRI5lWnrFvUxEHW1f9Ed1
         +TwWFNcQQEo5VwIlH6DD4/S0b8GsYP45529MACcObqbIDjyc86kGBdSxpSCQ1GZHVOfY
         VvzSvDxfcXqL/FCyvISuyWRWI0/28jqkpSQyrP8N3161bhOSCH3RGhX1s2EsMv/+m5DN
         M3WMJtbpQyDtwE0VOU01sTF9xqIIPxFtkARdZ581774I2NtRORQMkG/dci42SXs5oDMG
         80QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678778522;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9krYtYgrFfB+EZxwYgYFLH4M2qRAdQv9i48TyNn/Zvw=;
        b=ZF5R3nuUKY900HpuwF4v/jIMLa7MV0jQ9fu+Yg+w+teBRrYKs0bQAHvk5MlXvicc4Q
         xtzYy4qZhAIV+iZ9DOsQrlmanVKubEWvYs1xjke8w9RbYY+bcHem02umxkpHRikmurN1
         GRRpicI94kRXniD6PUPH5HdwyvV4OArrfJ0D3GHYZPFPdisExWtr3+BpiBXKLHrjgKAd
         0rZXKZa1Y+IzusYi2JnaK5F6e6vpglYQz7Ui2JEqDSOceXp0uqiCdWzQi8Ko+il57vEl
         xUt98GpGsNK7WmeMuFyLqdoC75tvrLqSkvVIqcOGvkIIllon0O4S82LtgmE+bQwg7m5t
         5XtQ==
X-Gm-Message-State: AO0yUKXiiQhn1P5r4oSGwlEKjHMSu8GG0/bgSDjUOJouQU7SOoD4vTC+
        17yojUd9l50RKIKY+OaxM1mk3fH3ad9lIJvjfEU=
X-Google-Smtp-Source: AK7set8w7RHwJaqXqkb0zNbF2TQM1bbv1FN1z99erE9S9U8EuBbiRbq6QJAK5jLQk8p6wLGQEkDGieMxhqcQw/ObnTk=
X-Received: by 2002:a17:907:e91:b0:924:32b2:e3d1 with SMTP id
 ho17-20020a1709070e9100b0092432b2e3d1mr747785ejc.3.1678778521709; Tue, 14 Mar
 2023 00:22:01 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 14 Mar 2023 08:21:50 +0100
Message-ID: <CAKXUXMwwQuwssyzBrOXHOz__YRpa1Rjgqmwn5rRFjDVLBbabPA@mail.gmail.com>
Subject: Question about the dependency on the config SOC_FSL in CPM_QMC
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mark Brown <broonie@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
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

Dear Herve,

In your patch below, you added the config CPM_QMC which depends on the
non-existing config SOC_FSL:

https://lore.kernel.org/r/20230217145645.1768659-7-herve.codina@bootlin.com

Up to my knowledge, the config SOC_FSL never existed in the mainline
tree. Is this dependency really required or can the expression simply
be reduced to COMPILE_TEST and we drop the dependency to SOC_FSL?

Note: This patch has now shown up in linux-next with commit
3178d58e0b97. Currently, it would not be possible to compile test this
driver, as the dependency on SOC_FSL is never met.


Best regards,

Lukas
