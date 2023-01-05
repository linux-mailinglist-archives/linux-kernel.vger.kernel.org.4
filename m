Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF565E4D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjAEEqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjAEEps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:45:48 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CD342612
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 20:45:27 -0800 (PST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0EE08418E7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672893925;
        bh=sAARquCdiyoGI6YM6qFupFsPlCgGT8dmLud7FeaIzHw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hzhZi3dj1dNNaKeMZ/aEGIPvxsDYOUF8lRyE3hYJ+MdCgveSfssM8wzU71j2FejqN
         PJqgrzQRrZR5+ilOv7raUWFRhVpM/fjzoVypQEcevUfX1+nZ9oajAWHHDTl2mPq1c3
         3Kvfjp183EgRzq59Wvjpox08KQDcCUM3SpcK4FaRxMgf+9kX/SBrkxCgl8rb6yOj1c
         JCSAsiPYoaofDQ3/pC7bRpDjKIM2cXyEyAEmDToQIhNGYW/na8iQnf+vwYuOvR4HXw
         RCCquRQr7sh0NBP+pIoH1j6LnprZzgvky3d9FHYhoY+ufC+7d8nxfWlvz+TQXuE9vK
         85wCmCrPHx1/Q==
Received: by mail-yb1-f198.google.com with SMTP id n190-20020a25dac7000000b007447d7a25e4so35243779ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 20:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAARquCdiyoGI6YM6qFupFsPlCgGT8dmLud7FeaIzHw=;
        b=VsDVhsFpykg7Fl6qWKgqDTWLmEInIu9YQXKeT76npUR6yykp/oBoYi8zarcBnhiTXI
         LAHGAZP4U7HCiDRSRQgLCN2uhJVRdV4snWs2c3+dFnpBBhRsuI3axmm/Z++8gBRNo87m
         LM+g4xqBPG9GLuXT4RR4dA6yvePxcST/i8OSE4PtZgQ99fK5FX1ZfSgq9fBwTXd0yJOi
         iwh9m83L1zyaVtn0fhfBI2k/EfwRwcr+3xlGbSVhfnHfOli4CUqeUYT7gxS1M04xmIeT
         Otj7IwxtCLzf7ZFDnG0dnhgVySScxVGkznDgSa6J+YLtonqtLnt5OF6o/z70TqpQv+PJ
         reMw==
X-Gm-Message-State: AFqh2kpx3c/eux/JDR5UPI1n9VBG3UObikMGUJcwzWg+UsY1tJF07y3K
        hQsHOsIx8JrA/SW//ER30m+YXjWOsLaMPE8C5ZE5lzRXcbYF/WN593op4gxDvK+M2OoRbfBeqkf
        MYsSELDuFo3xL6nOkPBu6z+zBiY+6xbhMwAhyykOBTM3rAzkmeMvawIrSeg==
X-Received: by 2002:a25:7653:0:b0:6f9:13cc:de91 with SMTP id r80-20020a257653000000b006f913ccde91mr5835486ybc.328.1672893923302;
        Wed, 04 Jan 2023 20:45:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu0OSyLVt9ZvRyS7eU+hux8B4Yqs+UPDqmmVhk6DbIfN6oRf0pMQcay2ov2kLL0a/e61PTMgzfkTS9z2pFkBDg=
X-Received: by 2002:a25:7653:0:b0:6f9:13cc:de91 with SMTP id
 r80-20020a257653000000b006f913ccde91mr5835477ybc.328.1672893923027; Wed, 04
 Jan 2023 20:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20230105044154.8242-1-jeremy.szu@canonical.com>
In-Reply-To: <20230105044154.8242-1-jeremy.szu@canonical.com>
From:   Jeremy Szu <jeremy.szu@canonical.com>
Date:   Thu, 5 Jan 2023 12:44:49 +0800
Message-ID: <CAKzWQkwJ==-BS2wB-21RWaX5vbaphsOjEC5SFq3oNpV7b_JjNg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs don't work for a
 HP platform
To:     tiwai@suse.com
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Tim Crawford <tcrawford@system76.com>,
        Meng Tang <tangmeng@uniontech.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        =?UTF-8?Q?Kacper_Michaj=C5=82ow?= <kasper93@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides this, it has the problem described in
https://lore.kernel.org/all/20220719144753.252231-1-kai.heng.feng@canonical.com/
but the solution could seperate with this quirk.

On Thu, Jan 5, 2023 at 12:42 PM Jeremy Szu <jeremy.szu@canonical.com> wrote:
>
> There is a HP platform uses ALC236 codec which using GPIO2 to control
> mute LED and GPIO1 to control micmute LED.
> Thus, add a quirk to make them work.
>
> Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index eda4914b8aeb..8362eb4642d8 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9409,6 +9409,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>         SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>         SND_PCI_QUIRK(0x103c, 0x8b5d, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>         SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> +       SND_PCI_QUIRK(0x103c, 0x8bf0, "HP", ALC236_FIXUP_HP_GPIO_LED),
>         SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
>         SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
>         SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
> --
> 2.38.1
>


-- 
Sincerely,
Jeremy Su
