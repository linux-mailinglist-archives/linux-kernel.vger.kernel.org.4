Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8DB5FBB63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJKTgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKTgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:36:46 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3E7814E9;
        Tue, 11 Oct 2022 12:36:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s10so18140912ljp.5;
        Tue, 11 Oct 2022 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2I8otcqoVQjYNYDGvUGwP30DEIINxDXT7uwZdeQKk4=;
        b=G0YZBqSE4a25/7HFxTyY8WwaSIiyWXVquLoPlSW1ihrLHtaugKwH2KKJe52cuc65qX
         cWXSLB0Z7+WBc5HXK9bmf0iIu5QhYschPBpxuVctJVGaLtGONk3y3GYx0kiLNFhe6SMc
         nO9NkMlEqqLnU9rI3MHwXNDbnf2ckgvdkOo8XaoNNFilWfxNhvL8dOYkHqfA0woVF+wS
         DbfWJQzdpHQV9XKG1rx3sMExPF0dUOAMsgzmknNLXG3+rpv2D8GUL4PADNkrMeRHSdxF
         0v8dz6d6gUVNOo2EbQGHFT2cvy5CAoORdS8oyPvU+8eLiOojqeFNubdtL98GQ4QCGr4g
         b27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2I8otcqoVQjYNYDGvUGwP30DEIINxDXT7uwZdeQKk4=;
        b=3GNXKmALqUNS68H4q3894kGLwuCorVAhqBPiDcjMux76S8TU5EvM+ltIQQAboqC1+M
         s+7D27guuASFs9p/zEeUvd+q3r3gDSHy1+6H2c4TmiWkDdZ0ZVwAa+Cpuo8eSiC1tsuj
         LJqLSAX02PxSLhT4xf1KTUY2YwmtpD9Zu0ZXcED2aSKo1kNP2r1US0QdlBOrrRyzB9M8
         pzn3QmsFVPZR3rirbXPLaN2NhCRqyMBU+CFcXoI1tetni2w9ybEyIrAitmdEvMbXv5VG
         VinAtc40bimKtzik2hTCEKy8Lb0FN5ySInVuEPYewh99aAwRV8Lb0rPe33hUVM2doZRB
         l+/g==
X-Gm-Message-State: ACrzQf2GNi2F1ShY/sNh6j/sbwHu77caTj5LPoqYGYFEks1mnsOjRO7e
        fUnXFJ81bsCYLskAGEMfu5t+YwmjTf9cAQHgk80=
X-Google-Smtp-Source: AMsMyM5b7urvgo9/FMLZjMUFRHPKwO378LHKodF07M2AdfyYAEK8otuHL0M+ndeDz/CFje5d3dtAItLadbKKDUHiYzA=
X-Received: by 2002:a2e:9d81:0:b0:266:a1d7:74b4 with SMTP id
 c1-20020a2e9d81000000b00266a1d774b4mr9013743ljj.423.1665517003260; Tue, 11
 Oct 2022 12:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org> <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20221007090223-mutt-send-email-mst@kernel.org> <CABBYNZKfLOxrTAVLRSH+hOwaB5RYkGdjbtfabufUcgR3oy897A@mail.gmail.com>
 <d41ec1d3-e262-3be6-17f2-a9495c55b868@opensynergy.com>
In-Reply-To: <d41ec1d3-e262-3be6-17f2-a9495c55b868@opensynergy.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 Oct 2022 12:36:31 -0700
Message-ID: <CABBYNZKH2njHBdHWjxQhoiUbVPR-bYAFYJHFYO28YhLayrAVoQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
To:     Igor Skalkin <igor.skalkin@opensynergy.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, mgo@opensynergy.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Tue, Oct 11, 2022 at 5:23 AM Igor Skalkin
<igor.skalkin@opensynergy.com> wrote:
>
> Hi Luiz,
>
> Current version of this patch is wrong [q]changing uapi like this can't
> be done, will break userspace[/q], next version is in process, will be
> sent in few days.

Thanks for the update, I will wait for the next version then.

> Best regards,
> Igor
> On 10/7/22 21:33, Luiz Augusto von Dentz wrote:
> > Hi Michael,
> >
> > On Fri, Oct 7, 2022 at 6:03 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> >>
> >> On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> >>> On 8/8/22 01:00, Michael S. Tsirkin wrote:
> >>>
> >>>      On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> >>>
> >>>          According to specification [1], "For the device-specific con=
figuration
> >>>          space, the driver MUST use 8 bit wide accesses for 8 bit wid=
e fields,
> >>>          16 bit wide and aligned accesses for 16 bit wide fields and =
32 bit wide
> >>>          and aligned accesses for 32 and 64 bit wide fields.".
> >>>
> >>>          Current version of the configuration structure:
> >>>
> >>>              struct virtio_bt_config {
> >>>                  __u8  type;
> >>>                  __u16 vendor;
> >>>                  __u16 msft_opcode;
> >>>              } __attribute__((packed));
> >>>
> >>>          has both 16bit fields non-aligned.
> >>>
> >>>          This commit fixes it.
> >>>
> >>>          [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/=
v1/query?url=3Dhttps%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1=
%2fvirtio%2dv1.1.pdf&umid=3Db1110db2-819d-4f27-b35e-18ac23ce0ab4&auth=3D53c=
7c7de28b92dfd96e93d9dd61a23e634d2fbec-2c53002097633a932e7d67b899e6bf6999cdc=
899
> >>>
> >>>          Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> >>>
> >>>      This is all true enough, but the problem is
> >>>      1. changing uapi like this can't be done, will break userspace
> >>>      2. the driver has more issues and no one seems to want to
> >>>         maintain it.
> >>>      I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
> >>>      to merge it for this release.
> >>>
> >>> This is very sad. We already use this driver in our projects.
> >>
> >> Ping. If we still have no maintainer I'm marking it broken, users
> >> should at least be warned.
> >
> > Please resend.
> >
> >>
> >>> Our virtio bluetooth device has two backends - HCI_USER socket backen=
d for one
> >>> platform and uart backend for the other, and works well (after applyi=
ng your
> >>> "[PATCH] Bluetooth: virtio_bt: fix device remove") patch, so this "de=
vice
> >>> removal" problem can probably be considered solved .
> >>> We could help with the rest of the problems you listed that can be so=
lved
> >>> (specification, QEMU support).
> >>> And the only problem that is difficult to solve (because of the need =
to change
> >>> UAPI header files) is just this one with unaligned configuration fiel=
ds.
> >>> At the moment, it does not reproduce, because without VIRTIO_BT_F_VND=
_HCI
> >>> (Indicates vendor command support) feature negotiated, the driver doe=
s not
> >>> read the non-aligned configuration fields.
> >>>
> >>> So, what would you advise us to do? Continuing to use the "marked bro=
ken"
> >>> driver, start writing a specification for a new from scratch, better =
one?
> >>> Or is there any way to bring this one back to life?
> >>>
> >>>
> >>>
> >>>          ---
> >>>           include/uapi/linux/virtio_bt.h | 2 +-
> >>>           1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>>          diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/l=
inux/virtio_bt.h
> >>>          index a7bd48daa9a9..adc03709cc4f 100644
> >>>          --- a/include/uapi/linux/virtio_bt.h
> >>>          +++ b/include/uapi/linux/virtio_bt.h
> >>>          @@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
> >>>           };
> >>>
> >>>           struct virtio_bt_config {
> >>>          -       __u8  type;
> >>>                  __u16 vendor;
> >>>                  __u16 msft_opcode;
> >>>          +       __u8  type;
> >>>           } __attribute__((packed));
> >>>
> >>>           #endif /* _UAPI_LINUX_VIRTIO_BT_H */
> >>>          --
> >>>          2.34.1
> >>>
> >>> --
> >>>
> >>> Best regards,
> >>>
> >>> Igor Skalkin
> >>> Software Engineer
> >>>
> >>> OpenSynergy GmbH
> >>> Rotherstr. 20, 10245 Berlin
> >>>
> >>> igor.skalkin@opensynergy.com
> >>> www.opensynergy.com
> >>>
> >>> registered: Amtsgericht Charlottenburg, HRB 108616B
> >>> General Management: Rolf Morich, Stefaan Sonck Thiebaut
> >>>
> >>>
> >>> Please mind our privacy notice pursuant to Art. 13 GDPR. // Unsere Hi=
nweise zum
> >>> Datenschutz gem. Art. 13 DSGVO finden Sie hier.
> >>
> >
> >
>
> Please mind our privacy notice<https://www.opensynergy.com/datenschutzerk=
laerung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-=
general-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unse=
re Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www=
.opensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaef=
tspartner-gem-art-13-dsgvo/>



--=20
Luiz Augusto von Dentz
