Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ABD725461
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjFGGgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjFGGf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:35:56 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C762699;
        Tue,  6 Jun 2023 23:35:04 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19f454bd2c8so7732371fac.3;
        Tue, 06 Jun 2023 23:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686119698; x=1688711698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A+z7wlEdRYbHtO/dJJM54F9I60knJM0fwL0Pnl9OAY=;
        b=CeBxyTw4/DL2b53rqIdeqOOwXvqJymfF8VJR9+4UcxpQFiyo+OwIMesotQRktUL9Rq
         u5L3QTBiHepyPJlpGrL6cpCvR+c6cEzdJ9TI8Dth7G8GXQLDoiOEW4g7d36caUwBN8Pu
         aGrvbWL2o/OfQ4KUGxa14WLqLBwaluW1sN6mQDTe6DGFZ6q3QNT/jXkgBmxH+7BgvvmR
         m8ejb2V/SoD+kBtizSYQiqZ9dtpCOXJUsLlxZ5RMrNusNoP7eN4Ve/v43YFJPMkPCmqt
         ACvjdOU29Y/YVVtTHiVOeyYyDrfxKFfcal1NCU1nYhLeT7Vdlu8D3udsxR3foPjveeaH
         Rd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686119698; x=1688711698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A+z7wlEdRYbHtO/dJJM54F9I60knJM0fwL0Pnl9OAY=;
        b=fiikxvt1IiYEVQ5wjnEa7Pb+rE4a42wYpUmvQ3RR4/AhTVdEylOuOpP1ueP1dB1585
         5zRBpaOsnTLmiDaLerwTapcS7tTzYwkIj5E2fOntSS7UR8RSW0H4jY17qsQS99hr+PZ4
         jRGup6/V7J0FDTm8PVNdDL5psFNcznO1g/MYbK9GoBKfwJP1ATcNAmnb3UF60QxBhm46
         2r/57xFByX20+CVvFYcmAsmeJl+vh36R8vgvt5yt/0ITcgRoRraMGtG1mClmn7GYHYJ6
         2k1aG2GOvWDZ72i9uTkBJ6XSeYKAdYjWzpu1Leh2tEPwUzDY/9P5fUTkEOEen8B1ttNU
         zgLw==
X-Gm-Message-State: AC+VfDz3z0w3yD2NhKsn7oUlK8xuYtVIb4Uiq1v+2xNtOVbCPmuNN3Bo
        YLnCrOQX2bkw08BYpFH0u8xJMVviZVgK7zD7YOsZv12P
X-Google-Smtp-Source: ACHHUZ7QAMpiZYDHkdOXvZF5AcH1Av2L/av0UOiVWQKHozt0OEDoW4IMlurqAbfQqumtyxdobjJfLVit+WESRKIIMUo=
X-Received: by 2002:a05:6870:c690:b0:19f:55f7:310e with SMTP id
 cv16-20020a056870c69000b0019f55f7310emr5928554oab.13.1686119698271; Tue, 06
 Jun 2023 23:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230606211600.1601694-1-liviu@dudau.co.uk> <20230606211600.1601694-3-liviu@dudau.co.uk>
In-Reply-To: <20230606211600.1601694-3-liviu@dudau.co.uk>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 7 Jun 2023 08:34:46 +0200
Message-ID: <CAMhs-H-b-RmxSKsXpFjRby4XLTx3S0_M-dV-fffHueRSmebLRw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mips: dts: ralink: Add support for TP-Link HC220
 G5 v1 board
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

On Tue, Jun 6, 2023 at 11:16=E2=80=AFPM Liviu Dudau <liviu@dudau.co.uk> wro=
te:
>
> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
> a MT7603 2.4GHz WiFi and a MT7613 5GHz WiFi chips integrated on the board=
,
> connected to the main SoC over PCIe.
>
> The device uses NMBM over NAND, which is not currently supported in the
> mainline, so NAND node is skipped in this revision.
>
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> ---
>  arch/mips/boot/dts/ralink/Makefile            |  3 +-
>  .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 84 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 1 deletion(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
     Sergio Paracuellos
