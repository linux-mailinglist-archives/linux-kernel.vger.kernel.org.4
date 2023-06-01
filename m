Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB171F6C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjFAXn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFAXnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:43:23 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAC3194;
        Thu,  1 Jun 2023 16:43:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af290cf9b7so20720011fa.3;
        Thu, 01 Jun 2023 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685662996; x=1688254996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXUXOYsaWNhycHkJnu9BK+q/+zGaOZqzGstpDVdACzg=;
        b=cjETJogGjC0Ea/C68hFQWO7SMxFflQI8WdPfkDtjI01C2g9pxxRQ45VFKkRHo5msMI
         CQIluQdOf+pvGhnM9Cr/qygxe+sb0YklRXF2nijUf89QWlHKHSMPsfCe6C7ehdmBH4Ml
         PU8R7+seAbeTq1MrdIBlQmGZN2BWy2BMWnzvY5Gqs3f+BpnG75fbIWqSa4PxqHJnItN0
         zr4bBQB6DE1WrPGyI0K08fKEkhlgyZWpugxiHdmKbB+f9fqfEaKywRd/1lWSLxI2y1ur
         U0dd/ms9vRJBn6FhrT8oCUUAYxWfhfrUiKNCT60Ev7KaNB6DROvFAcMjGzTwQZJbF4Oi
         kVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685662996; x=1688254996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXUXOYsaWNhycHkJnu9BK+q/+zGaOZqzGstpDVdACzg=;
        b=WX21wbGY154yC3fsDWNFv366ojo4bV318ccdWjIx2MXRpiarbAuoZgmyJLiTU25+uL
         AHSDQf2kqdbyN5asvCXd6D80RXlIqGlai5WGPQik1mPh7zT1uCojoXV2vosB1BOClnx/
         M6ASRmzI52q/1Qp1fBZ3V03XkO3WAg1h2GxhZlpQ97dmT3RNQvwo474aTGy46P/bToFq
         +7Yh6DJCcrG8nDJtRELu2zObvtJLlQabkHpqYkJgRn+HIlOqbaE6G7IkRZkV0OI0tLhL
         lGM9RMQRZSsu4espNKiCge2yiCcJfAqWyOFtDI7A4iQg4RjoYeMWx8xUGEX00DBw9c+l
         67BQ==
X-Gm-Message-State: AC+VfDzpBVwnsx08EMBAfVQyHcxLMu3l6DEeaDosUkyuiTpQbjH8tO3A
        LxeQYMJmbt6jEuCEkAhWX4Wk48jM7BSkEpxEMq6pi3u+
X-Google-Smtp-Source: ACHHUZ6rX/fOmNECTeIRnG0+fMgapBsPtceuxzRgFoaKjJx9SOqCSp0+6aVBwWlMd7yzgpOZSiGUhbIhVynmv2q5PR4=
X-Received: by 2002:a2e:9b04:0:b0:2af:1c0a:20e1 with SMTP id
 u4-20020a2e9b04000000b002af1c0a20e1mr492380lji.52.1685662996198; Thu, 01 Jun
 2023 16:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230531090424.3187-1-johan+linaro@kernel.org>
 <CGME20230601220156eucas1p21caabcf02509fce7eb26f973704980f9@eucas1p2.samsung.com>
 <20230531090424.3187-3-johan+linaro@kernel.org> <ecef83c8-497f-4011-607b-a63c24764867@samsung.com>
In-Reply-To: <ecef83c8-497f-4011-607b-a63c24764867@samsung.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 1 Jun 2023 16:43:04 -0700
Message-ID: <CABBYNZKv94T=BpJBmE-+bWV8Jj=HW_ZEBD_LLX_wQOTFnQi=3w@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Johan,

On Thu, Jun 1, 2023 at 3:01=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 31.05.2023 11:04, Johan Hovold wrote:
> > Devices that lack persistent storage for the device address can indicat=
e
> > this by setting the HCI_QUIRK_INVALID_BDADDR which causes the controlle=
r
> > to be marked as unconfigured until user space has set a valid address.
> >
> > The related HCI_QUIRK_USE_BDADDR_PROPERTY was later added to similarly
> > indicate that the device lacks a valid address but that one may be
> > specified in the devicetree.
> >
> > As is clear from commit 7a0e5b15ca45 ("Bluetooth: Add quirk for reading
> > BD_ADDR from fwnode property") that added and documented this quirk and
> > commits like de79a9df1692 ("Bluetooth: btqcomsmd: use
> > HCI_QUIRK_USE_BDADDR_PROPERTY"), the device address of controllers with
> > this flag should be treated as invalid until user space has had a chanc=
e
> > to configure the controller in case the devicetree property is missing.
> >
> > As it does not make sense to allow controllers with invalid addresses,
> > restore the original semantics, which also makes sure that the
> > implementation is consistent (e.g. get_missing_options() indicates that
> > the address must be set) and matches the documentation (including
> > comments in the code, such as, "In case any of them is set, the
> > controller has to start up as unconfigured.").
> >
> > Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD addr=
ess missing in dts")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>
> This patch has been recently merged to linux-next as commit 6ac517d8cf8b
> ("Bluetooth: fix use-bdaddr-property quirk"). Unfortunately it breaks
> bluetooth operation on my Raspberry Pi 3b+, 4b+ and Khadas VIM3 based
> test systems.
>
> Before this patch on Raspberry Pi 4b+:
>
> root@target:~# dmesg | grep hci0
> [   14.459292] Bluetooth: hci0: BCM: chip id 107
> [   14.464283] Bluetooth: hci0: BCM: features 0x2f
> [   14.470632] Bluetooth: hci0: BCM4345C0
> [   14.474483] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
> [   14.487275] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
> [   15.347542] Bluetooth: hci0: BCM: features 0x2f
> [   15.354588] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+-0159
> [   15.361076] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0290
> root@target:~# hcitool dev
> Devices:
>          hci0    DC:A6:32:12:38:D1
> root@target:~#
> root@target:~# hcitool scan
> Scanning ...
>          88:57:1D:AB:19:B2    Samsung Family Hub
> root@target:~# hcitool | head -n1
> hcitool - HCI Tool ver 5.50
> root@target:~#
>
>
> After this patch:
>
> root@target:~# dmesg | grep hci0
> [   13.979860] Bluetooth: hci0: BCM: chip id 107
> [   13.984969] Bluetooth: hci0: BCM: features 0x2f
> [   13.991444] Bluetooth: hci0: BCM4345C0
> [   13.995300] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
> [   14.005131] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
> [   14.839465] Bluetooth: hci0: BCM: features 0x2f
> [   14.846047] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+-0159
> [   14.859859] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0290
> root@target:~# hcitool dev
> Devices:
> root@target:~# hcitool scan
> Device is not available: No such device
> root@target:~# hcitool | head -n1
> hcitool - HCI Tool ver 5.50
> root@target:~#
>
> Reverting $subject on top of linux-next fixes this 'issue'.
>
> Let me know if you need more information about my test systems or to
> make some other tests.

Can you give it a look, looks like different manufacturers have
different expectations, anyway we should probably figure out a way to
get these controllers working otherwise we will need to revert.

--=20
Luiz Augusto von Dentz
