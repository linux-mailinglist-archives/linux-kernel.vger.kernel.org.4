Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFF9705EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjEQE2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEQE2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:28:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E841BE3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:28:31 -0700 (PDT)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3821F3F4D8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684297709;
        bh=KBpfMGXFAKUC2kcFXYgmGlqf/+Ln1ijfI1krE7exXtI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dXeCS8HdQ1Mep1Zkhxu4SEHey5ySggR2Bt7l1v7yYcX2YLIeaf/Bdderesk24+U+N
         bpHxmgSbpNCOdcvjkcjMKimSCHxIun2Cb6Y4OFZzwhVq8CKL59Rsm0ABgbBgtpYRcn
         0KOHRYKRpCY8e+oQp+cFEz9DyyyhjkHlqtF19Cvho03cO5xTrlP25J36HWdjai2pvY
         9xBVuIsmbSLY4rnichW0o9KzXdjDk20yd1uCEy7Fldmgfj4wFKI5IR5rUN6q2o4TnU
         DVozZ0bNqKFqpvdpVNAUh6LEmJ2CXIbUncYd0DNtsVEOvWTGl5f/N8xYSjYaD6qBXS
         7CFoDv9wj2O2w==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-52855ba7539so171950a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684297708; x=1686889708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBpfMGXFAKUC2kcFXYgmGlqf/+Ln1ijfI1krE7exXtI=;
        b=kchenC0bnWcKcQr5OMBViznOieJlBPk7KVOpeIzEnRm3+x4Gaf4lUNKLZcsRI/9wNU
         Y56IOFul8f3DGbF9aw0HP2NkrFMkMF5wLzxmjGubMJcRUDufo8ZQ05fjROjUhlvTyBoE
         N8H88KhgggKuMUAffZom1XxSaolSxQLp7AkZbSZNMQu+Ry8MH5onntr5yzaJq3Sn1oLf
         HlV6UZVKgHaBOZzqDAQ3LyMnfKJtY+yHljgkj4Ws7C+cAhilR0n/bo02OTWLl7WEZe9X
         6nWd8AtsRTc0bwPzQ4XFFLBpNKYr1fmzsOZmsPV+a9YfQur/q7tBYQvRokbQhljxaw2x
         abuQ==
X-Gm-Message-State: AC+VfDxC25+2UsjUa78ZDbVWjWheKOI+dJ6Xk575OMP4jNWYGn+RuRHi
        UQaObvE7Wif1U/yAO/x6twXE1pj+EERmEUvnPcWYoRA1j7psZNmk+M30xLYMj3WuaGx4kZAnJRy
        Am7SWFM/E3EIeXADdS7oIKwuwLOlN8FJvDlccf7x97pBQIGclss+IcUeqFQ==
X-Received: by 2002:a05:6a21:78a0:b0:100:5082:611d with SMTP id bf32-20020a056a2178a000b001005082611dmr42889332pzc.32.1684297707764;
        Tue, 16 May 2023 21:28:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jauJJgzn0NahJYNuK4adOWvhtRhNxmWcFWppdTKAFqALS+hCZVtqdFpLGQnZ41PvugHRjHrY1TDbErkoB4eM=
X-Received: by 2002:a05:6a21:78a0:b0:100:5082:611d with SMTP id
 bf32-20020a056a2178a000b001005082611dmr42889319pzc.32.1684297707499; Tue, 16
 May 2023 21:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230516080327.359825-1-kai.heng.feng@canonical.com> <ZGNeG1O1yS229nPO@nimitz>
In-Reply-To: <ZGNeG1O1yS229nPO@nimitz>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 17 May 2023 12:28:16 +0800
Message-ID: <CAAd53p44LFmZowFjRFaNV3fFUbMp2zxJksnCTR-MyhNJYfTeJw@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: t7xx: Ensure init is completed before system sleep
To:     Piotr Raczynski <piotr.raczynski@intel.com>
Cc:     chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 6:42=E2=80=AFPM Piotr Raczynski
<piotr.raczynski@intel.com> wrote:
>
> On Tue, May 16, 2023 at 04:03:27PM +0800, Kai-Heng Feng wrote:
> > When the system attempts to sleep while mtk_t7xx is not ready, the driv=
er
> > cannot put the device to sleep:
> > [   12.472918] mtk_t7xx 0000:57:00.0: [PM] Exiting suspend, modem in in=
valid state
> > [   12.472936] mtk_t7xx 0000:57:00.0: PM: pci_pm_suspend(): t7xx_pci_pm=
_suspend+0x0/0x20 [mtk_t7xx] returns -14
> > [   12.473678] mtk_t7xx 0000:57:00.0: PM: dpm_run_callback(): pci_pm_su=
spend+0x0/0x1b0 returns -14
> > [   12.473711] mtk_t7xx 0000:57:00.0: PM: failed to suspend async: erro=
r -14
> > [   12.764776] PM: Some devices failed to suspend, or early wake event =
detected
> >
> > Mediatek confirmed the device can take a rather long time to complete
> > its initialization, so wait for up to 20 seconds until init is done.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Does it fix any issue? Anyway target tree would help here I guess.

It fixes "PM: failed to suspend async: error -14" mentioned in the
commit message.

>
> [...]
>
> > +static int t7xx_pci_pm_prepare(struct device *dev)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(dev);
> > +     struct t7xx_pci_dev *t7xx_dev;
> > +
> > +     t7xx_dev =3D pci_get_drvdata(pdev);
> > +     if (!wait_for_completion_timeout(&t7xx_dev->init_done, 20 * HZ))
>
> #define T7XX_INIT_TIMEOUT or something similar wouldn't do any harm here.

Sure, will do in next revision.

>
> > +             dev_warn(dev, "Not ready for system sleep.\n");
> > +
> > +     return 0;
>
> So in case of a timeout you still return 0, is that OK?

You are right, error code should be returned instead.

Kai-Heng

>
> [...]
> Thanks, Piotr.
