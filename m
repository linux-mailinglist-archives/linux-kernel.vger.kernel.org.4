Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B796DCCA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDJVOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:14:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9871BF8;
        Mon, 10 Apr 2023 14:14:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f26so9294463ejb.1;
        Mon, 10 Apr 2023 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1681161270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np05l+USw9jQizmzx3dX3IUWv75lT/svJRr6EobyBN4=;
        b=CnS+HX1ztyCTAYIIBFVJEh3pzxH54r5KMaTE82OLyJqMdiz8CPkQN/Jdksiarozx6j
         E08rvBNJBiBnusoWHCShkGKVpPmtDR4MRgM3wF7CXjjeUE44QZRYzbej768Pa1vkueHy
         j1MmAWnxNrSKLT9Y1HtlDZ31Ypp3viVNJRaDredHDs0deakTftdMj53lbDNeZ8kzQcwg
         b5tuGME6JCx4tXsVrLFSX2+0YxC8mks4eA7/cF78QWJ9jcYMM9JxA7rxEREtNHFareRp
         A7IwayHBisdDn309kTEcYCguk0aEam1CLtdp937BC759j/6w2Z1ZE6NM0exbcH3zZluO
         jH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681161270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np05l+USw9jQizmzx3dX3IUWv75lT/svJRr6EobyBN4=;
        b=voOB6hdUnEtlTIc0WsHeCGmKNkpjKolG1/pVjzw0zm4kgSe2gCL14dwJLKNXr22tEA
         bvBsVFaQfov3/qr/e/hec5lk0nETDBQ8h7LrI5F0fULQiyMTPR10nSFhSdYfKjN2v+vo
         ExRawryhxw71bham7HuM14V3pxIFVJw8A0hESRSCY4OGrDb5Y5EF5akHIuCBVTSRKaxV
         z7/naxgUxyj/HntRO/7Kz9jxYTQmfrQvAq6pFWoPYdIucVUF3vnRc6rgChKeEAzVo4jh
         rvyFyTI2j1Ec3+FlKNf1UfbuywuVupyA5lSHtlOMwXPCGvKX8M4cDSnZ1jmYgx1VRLTT
         iX8Q==
X-Gm-Message-State: AAQBX9cUQoCHsENsSO4rjoUirAVU6Heoz78SFxOLASjtelgVkiNHPmTO
        zcwNI/7sgoqjAzt/1p4bhEBBRAfeZTsH2L9SxKk=
X-Google-Smtp-Source: AKy350a4fEr7xVPa9wFsgP6jGB5yZoJoMoyQxdGguA9nMTFfrIYVpvif3OI9rv1CQDmWpwMM8aTInQ0AB9gwUV44xbQ=
X-Received: by 2002:a17:907:970c:b0:8f5:2e0e:6def with SMTP id
 jg12-20020a170907970c00b008f52e0e6defmr4971819ejc.0.1681161270379; Mon, 10
 Apr 2023 14:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-bf20bcb9-790b-4ab9-99e3-0831ef8257f4-1680878185420@3c-app-gmx-bap55>
In-Reply-To: <trinity-bf20bcb9-790b-4ab9-99e3-0831ef8257f4-1680878185420@3c-app-gmx-bap55>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 10 Apr 2023 23:14:19 +0200
Message-ID: <CAFBinCBdmqG+D5Y_CF=pB6paevTDVCQVi-NBq8Z8i8NykhLW_w@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: meson8b: correct uart_B and uart_C clock references
To:     hfdevel@gmx.net
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 4:36=E2=80=AFPM <hfdevel@gmx.net> wrote:
>
> With the current device tree for meson8b, uarts B (e.g. available on pins
> 8/10 on Odroid-C1) and C (pins 3/5 on Odroid-C1) do not work, because the=
y
> are relying on incorrect clocks. Change the references of pclk to the
> correct CLKID, to allow use of the two uarts.
>
> Fixes: 3375aa77135f ("ARM: dts: meson8b: Fix the UART device-tree schema =
validation")
Cc: stable@vger.kernel.org

> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

PS: the author of this change seems to be just your email address, no
name attached.
I'm not sure if Neil can fix this when applying the patch. Generally
the rule is: patch author and signed-off-by line should be equal.

And finally: thanks again for spotting and fixing this!


Best regards,
Martin
