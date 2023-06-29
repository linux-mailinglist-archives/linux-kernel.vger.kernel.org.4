Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138C4742F46
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjF2VIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjF2VIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED2A2D4C;
        Thu, 29 Jun 2023 14:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 699EB61640;
        Thu, 29 Jun 2023 21:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC82BC433CC;
        Thu, 29 Jun 2023 21:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688072889;
        bh=QVWWSgeIDy9G1T0y1s1CguF1zCjfXWdS83lM64yH870=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R0CzxeqamLxMSeOUudK9QLDYHXutU4k1i7YAU/+nbdoHGbbXXiPe7urw9sDNEJLAL
         aVDE8AZM6wPuRaqrkBRJQ+Vsp7VabCX8CRCZyCzpLv0sGygnHpMeEzcuGK9nBIb98U
         Wj3wtfiP8Or1RUoId9/E1N7KZdRJTK/S+EsW7yEiRpxUebQt52CKB3gnG9nY9/9Fo5
         OE9oWn+jsh5oWgUc3BBhvjBbt72tozVDtgMUSHcEabrlow+kZqmeyfQ2/OJFpl9UTk
         OeytmAd7bSVCpIXGYlID5yu9Gs8H4hh+ifQbjlMMRuDi4DLp9IO3GdvQOI7Qcl/6xJ
         TTi8z1bczuBiw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f13c41c957so333166e87.1;
        Thu, 29 Jun 2023 14:08:09 -0700 (PDT)
X-Gm-Message-State: ABy/qLaBOQEWDC8tMtpRYqtr8gNqtB1MmeW0zNSOh5SLjWwyBsNbSmpl
        vx86PpG3za5NJjDdfxTRcFMUHyuoPf+1syur/Ps=
X-Google-Smtp-Source: APBJJlFiLvq/00pxW1fSfw8POZDWzgKpN6sQ94B0C73Uomase4zWNPqdpHugOi5T3I9U3e3RhH+sUGWixwBHEGJceUE=
X-Received: by 2002:a05:651c:c97:b0:2b6:b9ee:a7b1 with SMTP id
 bz23-20020a05651c0c9700b002b6b9eea7b1mr708635ljb.5.1688072887642; Thu, 29 Jun
 2023 14:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <1c40a12b51ccd6ee2ee002276f5b1ba92c377100.1687990098.git.objelf@gmail.com>
 <20b61d77-7397-e3ba-3215-232f49eb8c07@molgen.mpg.de>
In-Reply-To: <20b61d77-7397-e3ba-3215-232f49eb8c07@molgen.mpg.de>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 29 Jun 2023 14:07:55 -0700
X-Gmail-Original-Message-ID: <CAGp9LzqbqAGe0AXN2zH-PViOtu0TcygE265S61QfLxczoHgm3Q@mail.gmail.com>
Message-ID: <CAGp9LzqbqAGe0AXN2zH-PViOtu0TcygE265S61QfLxczoHgm3Q@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btmtk: add printing firmware information
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Chris Lu <chris.lu@mediatek.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, jenhao.yang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        mmandlik@google.com, abhishekpandit@chromium.org,
        mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Paul,

Thanks! I will update the patch with your suggestions.

thanks!
Sean

On Wed, Jun 28, 2023 at 3:44=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Sean, dear Chris,
>
>
> Thank you for your patch.
>
> Am 29.06.23 um 00:20 schrieb sean.wang@mediatek.com:
> > From: Chris Lu <chris.lu@mediatek.com>
> >
> > Add printing firmware information part when driver loading firmware tha=
t
> > user can get mediatek bluetooth information.
>
> Maybe use the commit message summary/title below:
>
> Bluetooth: btmtk: Log hw/sw version and fw build time
>
> Maybe also paste one log message example to the commit message.
>
> > Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> > ---
> > v3: resend again with the latest tree
> > ---
> >   drivers/bluetooth/btmtk.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > index 9482401d97fa..8490d59502a5 100644
> > --- a/drivers/bluetooth/btmtk.c
> > +++ b/drivers/bluetooth/btmtk.c
> > @@ -57,6 +57,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, c=
onst char *fwname,
> >                             wmt_cmd_sync_func_t wmt_cmd_sync)
> >   {
> >       struct btmtk_hci_wmt_params wmt_params;
> > +     struct btmtk_patch_header *hdr;
> >       struct btmtk_global_desc *globaldesc =3D NULL;
> >       struct btmtk_section_map *sectionmap;
> >       const struct firmware *fw;
> > @@ -75,9 +76,13 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, =
const char *fwname,
> >
> >       fw_ptr =3D fw->data;
> >       fw_bin_ptr =3D fw_ptr;
> > +     hdr =3D (struct btmtk_patch_header *)fw_ptr;
> >       globaldesc =3D (struct btmtk_global_desc *)(fw_ptr + MTK_FW_ROM_P=
ATCH_HEADER_SIZE);
> >       section_num =3D le32_to_cpu(globaldesc->section_num);
> >
> > +     bt_dev_info(hdev, "HW/SW Version: 0x%04x%04x, Build Time: %s",
>
> Why not print 0x%04x/0x%04x, that means with a slash?
>
> > +                 le16_to_cpu(hdr->hwver), le16_to_cpu(hdr->swver), hdr=
->datetime);
> > +
> >       for (i =3D 0; i < section_num; i++) {
> >               first_block =3D 1;
> >               fw_ptr =3D fw_bin_ptr;
>
>
> Kind regards,
>
> Paul
