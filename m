Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1382F7308CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjFNTvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjFNTve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:51:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA2E1B2;
        Wed, 14 Jun 2023 12:51:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-54fd171cedcso593303a12.3;
        Wed, 14 Jun 2023 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686772293; x=1689364293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md9lJKmlQJvh1OZaUzX4DgJIrqm76TL4au4CTghcG/E=;
        b=V9thkchiKXb6KvcRpmH/5tE9tuUGZmrVmTfS7pyVleoqsTeSmhRR9IvR8QY1biyoPp
         U6YrtENufunf28NM775x4KZRl6ucdZDoAnzir4SoqIPQ5Nmo9EBxgxoeAJ+1R/NK0v+a
         vOwGkkeHoPP6liCkXMt23SYxJTvokHgy0wrZjYChsit6Q019r0jGZl/BCgg7vVgcP6lQ
         JqqyFDqfGs0ITwi5atzwRNShjy4YoybKD/k3w//ENXiFJENvXT+oBUq5QrX497nejLyD
         QksrO3itaCMlV6msn2LA6oCa7xLMYc8Rxx0gkyR+OV0SJIBO2shoPD4wcAgva43SLzjs
         bYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686772293; x=1689364293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md9lJKmlQJvh1OZaUzX4DgJIrqm76TL4au4CTghcG/E=;
        b=gKVSo6a86cgMG8XZyajvVNUF6mRzNneHhL/iOS/Y3g+fydrqxuq7pDmwWTUz+TZPYY
         2jD1FDHLpUdPIlkIHDkx/Srw/NrBnjlKtp+6SpnOudnfxG0ebWIyZn4IsSU5xw4gBNkY
         fD/NzSv6/sl8ozbJPa4H5jTRswjMy8kFyk4YqKzx1Mrlw7I0KpfBIo4nzriA0R4Bjv1h
         P97Fmws2UgpASyn92uk1/0lF+zB/9zIYWo24g6xm1jtzQYsLJmV4s4EQFtsXSAu1euO3
         2HW2cC4JZ6eh/LDTjixFs/8ft4qBpVvoP1vOC3hk3RvJX7j+sfGzQQk0Ed9rdoMltnq/
         CQnw==
X-Gm-Message-State: AC+VfDy2HkDNerwitGGaVVf4tWqWNNlXKpiqHjJPQcw5W9t9ylRVfyj4
        0Z7+dRst0qhpgc0Y9u3XYWMdbFqnezuLhyGEe2g=
X-Google-Smtp-Source: ACHHUZ4VBmluG6ODSEiZ+YZ6cKjQzEkNwgG2Jx/k+1Wq+rcowseSsrI8mlOimnJNxswGpbk4W/FFajCTW8uIUS7z47c=
X-Received: by 2002:a17:90b:4b8f:b0:256:2fd4:e238 with SMTP id
 lr15-20020a17090b4b8f00b002562fd4e238mr2401011pjb.38.1686772292745; Wed, 14
 Jun 2023 12:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230614134034.3p3p75a3jophi2eu@mercury.elektranox.org> <20230614152721.eep5ip726ump2kpe@mercury.elektranox.org>
In-Reply-To: <20230614152721.eep5ip726ump2kpe@mercury.elektranox.org>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Wed, 14 Jun 2023 19:51:21 +0000
Message-ID: <CAEwRq=qufx6Y6JCD3pzA31y7mfXUxFeMLtwthE_N7rYY7k9+-A@mail.gmail.com>
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

Hi,

On Wed, Jun 14, 2023 at 3:27=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> On Wed, Jun 14, 2023 at 03:40:34PM +0200, Sebastian Reichel wrote:
> > I tested the series on RK3588 EVB1. The read/write byts looks
> > sensible. Sometimes cycles reads unrealistic values, though:
> >
> > 18446744070475110400      rockchip_ddr/cycles/
>
> I have seen this going off a few times with and without memory
> pressure. If it's way off, it always seems to follow the same
> pattern: The upper 32 bits are 0xffffffff instead of 0x00000000
> with the lower 32 bits containing sensible data.

How often is that happening ?

I have been running this in a loop with varying sleep duration for
the last few hours without hitting it, with and without memtester.

REPEATS=3D1000
MAX_DURATION=3D100

OUT=3D"/tmp/perf-dfi-rk3588-${REPEATS}x${MAX_DURATION}s.txt"
echo -n > $OUT

for i in $(seq $REPEATS) ; do
  DURATION=3D$(shuf -i "0-${MAX_DURATION}" -n 1)
  echo -n "${DURATION} : " >> $OUT
  perf stat -a -e rockchip_ddr/cycles/ sleep $DURATION 2>&1 | awk
'/rockchip_ddr/ {printf("%X\n", int($1))}' >> $OUT
done

BTW, it's on a musl-libc arm64 void linux userspace.

--=20
Vincent Legoll
