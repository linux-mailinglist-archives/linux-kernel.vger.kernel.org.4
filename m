Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A665C7C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjACT7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjACT71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:59:27 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8335114097
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:59:24 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id u8so10982501ilg.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zzywysm.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5J4EGBEddxLo8G+FzVVns1o6o8CcH7FdeCRkfOCVPQ=;
        b=FZJz01IvyN5If7qklJzEXMRxUD+IWrKiqM981gedBuGukLcBNdo959ct83OeUVuWc5
         WIfxx+i8BjXXDD3AUwtJpoDGO1doGzRKZrj/OX6q+hbyAkFV+hy65GHDk/ZgnMtqq3DW
         pxKwsfRaJdcLJ5+Fb/1sYpEVoq/Uhqo1Gd/LsgOoes0R9u/y8zWhglfbznUKt4VIJol/
         UcUJ55Rke3EqaBAVO28oFEsPn1K0WZnuuHwbc+5o1LFJvksRLFDTM1f23glujsyf1wiG
         zNoPgrnYnp7aJdKt6PYlo5+sttwJoHshH7PrYrBjgYiUeAk1aOWjzKl7N74qaoBIzlq1
         DSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5J4EGBEddxLo8G+FzVVns1o6o8CcH7FdeCRkfOCVPQ=;
        b=3Z02O9PSFVS+6w8ybe964umFHrWlQ34v78Hdt/dyY/8tbTOlh3mbaP8HSX/WlXD0LI
         B0ZAkqROhfHujPshhef42SBV32rkJzehJRheiO6rOkFgbV0pPgA/L+ROilUqtFoGV4he
         cl72TMSq26LEshVoZ7sg0lxmlFW3UyZgyjKm7aMQvWXdZa8uOfT1cOqCMk6TF3fkjkcQ
         hRb7cGBftGM2MYZCAVailAoyDQ/dD22w7QtN9HPKoSCTo5iFz3a47BDbGMh/5y2Hqcee
         Ww8yYEPtmzF8M7JmIQu5T1038q+q3LAUZhDdCS5mjH+NXodZURqxduh8dPtUTQCDqtVo
         JoCg==
X-Gm-Message-State: AFqh2kqCYv4IoMZVfnpiOPClGCoM68/UWdmyFA7vV9g2AapQAL1k+en0
        r/d5DAl7T0WjBeCXnDVf3gVxxw==
X-Google-Smtp-Source: AMrXdXt1iMsOai3p3P8ogoAM3QO55D/rUwTFhoXbmA0E2ODJ6SHAzdoUtwFXUHhR3ao5y1B+AVI6bw==
X-Received: by 2002:a05:6e02:10d3:b0:30c:5e42:ebcd with SMTP id s19-20020a056e0210d300b0030c5e42ebcdmr1993126ilj.20.1672775963874;
        Tue, 03 Jan 2023 11:59:23 -0800 (PST)
Received: from [10.132.115.14] ([143.244.61.131])
        by smtp.gmail.com with ESMTPSA id o18-20020a056638125200b0039d756fb908sm10259425jas.40.2023.01.03.11.59.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 11:59:23 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 1/2] brcmfmac: Use separate struct to declare firmware
 names for Apple OTP chips
From:   Zzy Wysm <zzy@zzywysm.com>
In-Reply-To: <6b30559d-9bcc-f3b3-d9b2-2406e9a044b7@broadcom.com>
Date:   Tue, 3 Jan 2023 14:59:20 -0500
Cc:     Hector Martin <marcan@marcan.st>,
        Aditya Garg <gargaditya08@live.com>, aspriel@gmail.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        lina@asahilina.net, franky.lin@broadcom.com,
        Orlando Chamberlain <redecorating@protonmail.com>,
        brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CFE1145-8C00-4529-B4A5-E9FA85D95398@zzywysm.com>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
 <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
 <9c5bdb0a-0877-ed16-f09f-164a9dab16d4@marcan.st>
 <18573bd1a38.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3785835b-164b-28d1-6905-85454cabb69d@marcan.st>
 <6b30559d-9bcc-f3b3-d9b2-2406e9a044b7@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 3, 2023, at 8:30 AM, Arend van Spriel =
<arend.vanspriel@broadcom.com> wrote:
>=20
> On 1/3/2023 4:55 AM, Hector Martin wrote:
>> More specifically:
>> - What BCM4355 variants exist in the wild, and what are their PCI =
device
>> IDs and revision IDs?
>=20
> Who knows. The PCI revision ID always equals the chip revision afaik. =
The PCI device IDs should be as below.

If the day ever came where the FCC inquired about a theoretical spurious =
radio emissions issue in such a chipset, and asked Broadcom for a list =
of all affected hardware releases, would the FCC also be told =E2=80=9Cwho=
 knows=E2=80=9D?

I guess the difference is that the FCC has the statutory authority to =
yank Broadcom=E2=80=99s certifications to sell their product, whereas =
Hector is merely improving your driver support for no monetary =
compensation from you.

Maybe the Broadcom drivers should be yanked from Linux if this is what =
passes for Broadcom release engineering.

zzy

