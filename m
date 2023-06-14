Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08B673018E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245575AbjFNOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245551AbjFNOTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:19:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D464E212B;
        Wed, 14 Jun 2023 07:19:18 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56cfce8862aso8801027b3.1;
        Wed, 14 Jun 2023 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686752358; x=1689344358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX5YO1WYul949jFQhaP2hJUbrdTDjTdGLvHcfir61kc=;
        b=i6gIt2eixifwvL/xKy/LTVOmXLGJXu83F20GOpWUc+DfdS9FpLot9sLufvFkUNociJ
         SR52ir+xMVHqmu/T+1dncFHrybZWnFKA3fI2lbYco5HZgQzsLBI6JsLUJi8GfLrjMqtH
         L80OvDo3uxbVTqLBLpyAJdL90rnuu1wHoy1VrfUWG6twpll4h4p2VSno8fC0YhCKIYkb
         Lt4mUX/3VIr9BSFjlGv+PFuI03s0vrPwSKpwFF9RzzOH2UPpHan1BFuAQEN55v95TojU
         TFHcdpLrJxZrFjl4PWPcV4GT9CTcpdGR1T1F25T+gfYDHVCVzR/LnJdg6DGcS+eNPXI9
         3olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752358; x=1689344358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX5YO1WYul949jFQhaP2hJUbrdTDjTdGLvHcfir61kc=;
        b=En3hniD8WzWEqAVa431q/FIlQIpX0kAMf6Rk6khWxRcvNzkHw3HTZmZBK1MLwOboXe
         IGcDpaC1/XtHZ6ng2UYgz34kDy1wQ/opiQpy43T42uS6jjGl3SyCCQZR8lz7hi2Rd7AT
         t7/0CwkptgL5fH5EjjuACCREX0GB/oxUyYVzTwPHs1bgsGMLjAUvxJknyvBOaU2GuNFw
         Pzs/mqUF/lFyBZPN9PiWV/dB1r9L+YXstv53LSC2+yuTtEMXDtoiLJNbMM31kwRay/Av
         JZoAg68PCaoayfOc19GFp4Aho1dW4FOWUHTZrbVS1SHiNvqxUa3KCX6lyEkfREawf1cH
         Vhvw==
X-Gm-Message-State: AC+VfDwnfE1GVQAZDor5Vx7vfPRAUEo0+YTsLZgCEii4pAQzVpX1PCPK
        5OZIdNGyMAJqlvWqwzwUDnlq4aY9SoMgJUc+yOE=
X-Google-Smtp-Source: ACHHUZ4x6WLud45wPegG2Lh8Ea6ssDXfxMlRzpQJzqGV7rINz/e9/iuzIawfj4+fKglV3jau7YuGI9MaoBNqtSycOK4=
X-Received: by 2002:a81:6e8a:0:b0:56d:24c:8896 with SMTP id
 j132-20020a816e8a000000b0056d024c8896mr1866564ywc.7.1686752357816; Wed, 14
 Jun 2023 07:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230524083153.2046084-1-s.hauer@pengutronix.de> <20230614134034.3p3p75a3jophi2eu@mercury.elektranox.org>
In-Reply-To: <20230614134034.3p3p75a3jophi2eu@mercury.elektranox.org>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Wed, 14 Jun 2023 14:19:06 +0000
Message-ID: <CAEwRq=rUUatDp0JePkDPRkx81c9=sO6ZoW+V=g2S7B8_s-R3uA@mail.gmail.com>
Subject: Re: [PATCH v5 00/25] Add perf support to the rockchip-dfi driver
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sascha, Sebastian,

On Wed, Jun 14, 2023 at 1:40=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> On Wed, May 24, 2023 at 10:31:28AM +0200, Sascha Hauer wrote:
> > This is v5 of the series adding perf support to the rockchip DFI driver=
.
> > [...]
> > The RK3588 device tree changes for the DFI were not part of v4. As
> > Vincent Legoll showed interest in testing this series the necessary
> > device tree changes are now part of this series.
>
> I tested the series on RK3588 EVB1. The read/write byts looks
> sensible. Sometimes cycles reads unrealistic values, though:
> [...]
> Otherwise the series is
>
> Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> -- Sebastian

I also tested this new version of the series on a Pine64 QuartzPro64 dev bo=
ard.

I applied the series on top of my local branch, which is based on Collabora=
's
rockchip-3588 plus some QP64 DTS patches, and your V5 patch series.

Looks like this is still working properly:

-bash-5.1# uname -a
Linux qp64 6.4.0-rc1-00140-g658dd2200e2a #24 SMP PREEMPT Wed Jun 14
15:50:34 CEST 2023 aarch64 GNU/Linux

-bash-5.1# zgrep -i _dfi /proc/config.gz
CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI=3Dy

-bash-5.1# perf list | grep rockchip_ddr
  rockchip_ddr/bytes/                                [Kernel PMU event]
  rockchip_ddr/cycles/                               [Kernel PMU event]
  rockchip_ddr/read-bytes/                           [Kernel PMU event]
  rockchip_ddr/read-bytes0/                          [Kernel PMU event]
  rockchip_ddr/read-bytes1/                          [Kernel PMU event]
  rockchip_ddr/read-bytes2/                          [Kernel PMU event]
  rockchip_ddr/read-bytes3/                          [Kernel PMU event]
  rockchip_ddr/write-bytes/                          [Kernel PMU event]
  rockchip_ddr/write-bytes0/                         [Kernel PMU event]
  rockchip_ddr/write-bytes1/                         [Kernel PMU event]
  rockchip_ddr/write-bytes2/                         [Kernel PMU event]
  rockchip_ddr/write-bytes3/                         [Kernel PMU event]

# With no memory load
-bash-5.1# perf stat -a -e
rockchip_ddr/cycles/,rockchip_ddr/read-bytes/,rockchip_ddr/write-bytes/,roc=
kchip_ddr/bytes/
sleep 1

 Performance counter stats for 'system wide':

        1058691047      rockchip_ddr/cycles/
              9.35 MB   rockchip_ddr/read-bytes/
              0.57 MB   rockchip_ddr/write-bytes/
              9.90 MB   rockchip_ddr/bytes/

       1.002616498 seconds time elapsed

# With a hog
-bash-5.1# memtester 4G > /dev/null 2>&1 &
-bash-5.1# perf stat -a -e
rockchip_ddr/cycles/,rockchip_ddr/read-bytes/,rockchip_ddr/write-bytes/,roc=
kchip_ddr/bytes/
sleep 10

 Performance counter stats for 'system wide':

       10561540038      rockchip_ddr/cycles/
          60212.59 MB   rockchip_ddr/read-bytes/
          31313.03 MB   rockchip_ddr/write-bytes/
          91525.60 MB   rockchip_ddr/bytes/

      10.001651886 seconds time elapsed

You can add my T-B, for the whole series:

Tested-by: Vincent Legoll <vincent.legoll@gmail.com>

Or is there something else you want me to test ?

Thanks for your work
Regards

--
Vincent Legoll
