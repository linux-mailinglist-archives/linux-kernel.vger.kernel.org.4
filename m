Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16A6732292
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjFOWOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbjFOWOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:14:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969D8BA;
        Thu, 15 Jun 2023 15:14:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9741caaf9d4so334206466b.0;
        Thu, 15 Jun 2023 15:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686867250; x=1689459250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38f3zMiD2iJLYkWKmro5ZH5L9YJl3p+FlUUNQWER8tI=;
        b=qi7+rM589uiI8RO0fZvte5ptItF5GUV26VlUnfmPeefjBHPJwODjrd6Y4+2Vbg1Fin
         rjkmdFUBf45J4FRZACWcLVq4T0OByfURRPBaPM3ey9kONaIjummSbKpleg5gS6EfzM1o
         u7kXt5E/wqQUoZHMfy28LceQV006JWs0Kvcp4wVV+W9c+1/wB1H/o0wetzlRSy/aO6VS
         gZcJpJ/otWogRDnyIk5BIaRlsvOABZsvmLIzXO7bnBGPH8/TB5bpguzTn+e/rlWZsKwt
         luvftRK547DkoAxEccbez+8JZR73DI0kp8Gre+apgcN1o4y5GEO1FsN4eVqXbM8cAEMD
         J6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686867250; x=1689459250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38f3zMiD2iJLYkWKmro5ZH5L9YJl3p+FlUUNQWER8tI=;
        b=TmrwMeLiX6FlrkzXs4/huqoZmCdam+sE7jK/H2LWkzQ6bnL+k7JfUgfVgE5nU4fXbJ
         Of0Kh/fTEkz3zbbjvv+INP2vQd3abcJhH1IkmKXHRpbrHWwyD5AhzVUfGoBgpshHZ4WM
         Da4A8gL01sOFQTJ50NTBSrbx1BL6Nz5Bty7hWEFSIeKLIDDELV1O/Fz+InbusOIKjhUH
         E82Xd4UIqgEuI21yFVy+7DDylUlhKNwZhMik3u7HTGLVuwG5gFDZC4NkZGJ9236dDsjA
         TptLBVHCncdQCNYd3UMpcARVJI52e35GY5BvYCu+IblSimml9ARnAxbUA7es6UDEWrbw
         0JUA==
X-Gm-Message-State: AC+VfDzH9wTU7A85Z9HHi+TpHg84cxqn/Pvv8g2By+qMcruzXFjNdaUo
        nT5ioxtGn+fuhmCiq3W5UwThu8Fqsz4Ajwz6gDI=
X-Google-Smtp-Source: ACHHUZ6DXHkFqzYuv6gmwEeYzxVonBfQJzMjslZlAaPmBnJHUG6Dk8ufUQERFFsNvjfkW/Sf67e9fYs86Nss2YmI5fA=
X-Received: by 2002:a17:907:a41e:b0:97a:e496:c121 with SMTP id
 sg30-20020a170907a41e00b0097ae496c121mr228921ejc.69.1686867249862; Thu, 15
 Jun 2023 15:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230615142044.1357257-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230615142044.1357257-1-heinrich.schuchardt@canonical.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 16 Jun 2023 00:13:59 +0200
Message-ID: <CAFBinCAEFvmxnBDJPSs+mGqAraGUDFkCB3SjRTEyC9waA3P8JQ@mail.gmail.com>
Subject: Re: [RFC 1/1] wifi: rtw88: Add support for the SDIO based RTL8723DS chipset
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
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

Hello Heinrich,

On Thu, Jun 15, 2023 at 4:21=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
[...]
> On my Lichee RV Dock board this patch is enough to make The RTL8723DS
> work. But unfortunately after running some time the driver crashes.
> My impression is that the crash is not specific to my patch but must
> be hidden in one of the existing functions it is invoking.
>
> This seems to be related to not checking pkt_stat->pkt_len.
>
> My kernel was built against v6.4-rc6.
As Larry has mentioned: support for the RTL8723DS chipset is in
wireless-next.git
You can find the whole series here: [0]

It seems you're missing at least "wifi: rtw88: sdio: Check the HISR
RX_REQUEST bit in rtw_sdio_rx_isr()" [1]
That patch should fix the exact issue that you described.


Best regards,
Martin


[0] https://lore.kernel.org/linux-wireless/20230522202425.1827005-1-martin.=
blumenstingl@googlemail.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.=
git/commit/?id=3De967229ead0e6c5047a1cfd5a0db58ceb930800b
