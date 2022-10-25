Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0816460D595
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiJYUd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiJYUdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:33:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284DAC3BF;
        Tue, 25 Oct 2022 13:33:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fy4so15813489ejc.5;
        Tue, 25 Oct 2022 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5y5N+tuS7DlthYuEPypRk3pQGfy0Smme3GIXM4h1WE=;
        b=JRyJjxpk4z3Gbl1gd19JgiK3zOtEBNvjSqXeda4YX8f8PBPaEjL0QsAGsmL3AbCI2k
         Sslxdfkywvl9NEAC+vdOXwmBv/qY8g6cKwn0ijmJ8iCYOow/nXJwk3QtxmcIFkp32By+
         poZipGbt3EjJYlAUe3mwYPIaMBQLJmMSbWQTygjIcsH+IklwY2q2TccNBpR/k4HWEUPs
         kMOvxhTvR6aviEf8hslcTAbk3JGmSL23v+B3Hou4FaxFSbkin8dhTarRq14yic2zH6RH
         y8ueT0UZzxakjdFiv+dp2dCKcluENYpmOT/+bSMCH1wSbbS2OoDV9lLxT1Meb73XXibT
         ZC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5y5N+tuS7DlthYuEPypRk3pQGfy0Smme3GIXM4h1WE=;
        b=PcXxlDfrkC9mx51xEcNGth3E88irJ8Un1XTTdbcahquSObKL8LfrKg11UbMB2M4ZId
         C44LHFRfDg0EwzMVs8gJodMwowBU8B2O3knGpTFFO4cph64whKE8U8Yh7PmCjrvdC9QK
         sxIOhb4Uu4dU0YRYTryTPUJhSIs0IQK1E8CLJl48Pn92JQVrfG1cesbiXhGhMjSAxTBC
         9bDn7rUNvbb+vXdi1qZnVaMFxQjzgdS1r1hhXMmcwC1W3jAVOqR3kUdjeOqbujK0xfb/
         C82RVm2y1sBBS5wEeY1VOfNMrTQnBMxlixiRoC0hpV2aOd9dK3mVQQScv8hVhc9XP2HK
         3IMQ==
X-Gm-Message-State: ACrzQf1xD6JTpWIVd1K9C6fcOv+4OwmpxXqVWEmuaCGwBdWBKwiXaqO5
        L0I5MLs3efIqvfj2X82bxigW/uwDhDhnmJ3wJbCxrBUp
X-Google-Smtp-Source: AMsMyM6x0/9ya1/Z1YZG50P7yFVQMxNRJ80Pcg/kcbudNGPlQ3cMBeWYHq7i/e/TcBezYgpsHxs8hJ0I+ba3NQLPs0c=
X-Received: by 2002:a2e:834b:0:b0:26d:e1f8:1453 with SMTP id
 l11-20020a2e834b000000b0026de1f81453mr13637954ljh.65.1666729991356; Tue, 25
 Oct 2022 13:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-1-Igor.Skalkin@opensynergy.com> <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
 <CABBYNZKc7Y8JJ-J9+yUvnDTeVwYuqmzEZYpvfzvN0ctKGyj-Ow@mail.gmail.com> <a0ea56ee-8cf4-c1ef-de15-1bbdb0340da6@opensynergy.com>
In-Reply-To: <a0ea56ee-8cf4-c1ef-de15-1bbdb0340da6@opensynergy.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 Oct 2022 13:32:59 -0700
Message-ID: <CABBYNZJPasDqHKp+1mDY4myU9oLfREcW4gt1eGhst1wyU0Y4ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] virtio_bt: Fix alignment in configuration struct
To:     Igor Skalkin <igor.skalkin@opensynergy.com>
Cc:     virtualization@lists.linux-foundation.org, mst@redhat.com,
        marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Tue, Oct 25, 2022 at 1:17 PM Igor Skalkin
<igor.skalkin@opensynergy.com> wrote:
>
> Hi Luiz Augusto,
>
> On 10/24/22 22:54, Luiz Augusto von Dentz wrote:
> > Hi Igor,
> >
> > On Mon, Oct 24, 2022 at 6:41 AM Igor Skalkin
> > <Igor.Skalkin@opensynergy.com> wrote:
> >>
> >> The current version of the configuration structure has unaligned
> >> 16-bit fields, but according to the specification [1], access to
> >> the configuration space must be aligned.
> >>
> >> Add a second, aligned  version of the configuration structure
> >> and a new feature bit indicating that this version is being used.
> >>
> >> [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?u=
rl=3Dhttps%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%=
2dv1.1.pdf&umid=3Ddb3482bc-5b84-4bde-bbb0-41d837955a7a&auth=3D53c7c7de28b92=
dfd96e93d9dd61a23e634d2fbec-d27a9d4c2c971f9ecc5d00d40d5cd9b45c4b5f63
> >>
> >> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> >> ---
> >>  drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
> >>  include/uapi/linux/virtio_bt.h |  8 ++++++++
> >>  2 files changed, 21 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_=
bt.c
> >> index 67c21263f9e0..35f8041722c8 100644
> >> --- a/drivers/bluetooth/virtio_bt.c
> >> +++ b/drivers/bluetooth/virtio_bt.c
> >> @@ -306,7 +306,12 @@ static int virtbt_probe(struct virtio_device *vde=
v)
> >>         if (virtio_has_feature(vdev, VIRTIO_BT_F_VND_HCI)) {
> >>                 __u16 vendor;
> >>
> >> -               virtio_cread(vdev, struct virtio_bt_config, vendor, &v=
endor);
> >> +               if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
> >> +                       virtio_cread(vdev, struct virtio_bt_config_v2,
> >> +                                    vendor, &vendor);
> >> +               else
> >> +                       virtio_cread(vdev, struct virtio_bt_config,
> >> +                                    vendor, &vendor);
> >>
> >>                 switch (vendor) {
> >>                 case VIRTIO_BT_CONFIG_VENDOR_ZEPHYR:
> >> @@ -339,8 +344,12 @@ static int virtbt_probe(struct virtio_device *vde=
v)
> >>         if (virtio_has_feature(vdev, VIRTIO_BT_F_MSFT_EXT)) {
> >>                 __u16 msft_opcode;
> >>
> >> -               virtio_cread(vdev, struct virtio_bt_config,
> >> -                            msft_opcode, &msft_opcode);
> >> +               if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
> >> +                       virtio_cread(vdev, struct virtio_bt_config_v2,
> >> +                                    msft_opcode, &msft_opcode);
> >> +               else
> >> +                       virtio_cread(vdev, struct virtio_bt_config,
> >> +                                    msft_opcode, &msft_opcode);
> >>
> >>                 hci_set_msft_opcode(hdev, msft_opcode);
> >>         }
> >> @@ -387,6 +396,7 @@ static const unsigned int virtbt_features[] =3D {
> >>         VIRTIO_BT_F_VND_HCI,
> >>         VIRTIO_BT_F_MSFT_EXT,
> >>         VIRTIO_BT_F_AOSP_EXT,
> >> +       VIRTIO_BT_F_CONFIG_V2,
> >>  };
> >
> > So this introduces a new flag which must be checked when attempting to
> > config, right? But is this backward compatible? What happens if for
> > some reason the userspace doesn't use the new struct are we able to
> > detect that?
>
> Yes, it's backwards compatible.
>
> [q]Each virtio device offers all the features it understands. During
> device initialization, the driver reads this and tells the device the
> subset that it accepts. The only way to renegotiate is to reset the devic=
e.
> This allows for forwards and backwards compatibility: if the device is
> enhanced with a new feature bit, older drivers will not write that
> feature bit back to the device. Similarly, if a driver is enhanced with
> a feature that the device doesn=E2=80=99t support, it see the new feature=
 is not
> offered.[/q]
>
> So, in our case:
>
> old device - new driver:
> The device does not offer VIRTIO_BT_F_CONFIG_V2 feature and uses the old
> configuration structure.
> The driver also uses the old configuration structure because
> VIRTIO_BT_F_CONFIG_V2 bit was not negotiated.
>
> new device - old driver:
> The device offers this bit, the driver reads it but cannot support it,
> so it does not write this bit back to the device during feature negotiati=
on.
> The device verifies that this bit is not negotiated and continues to use
> the old configuration structure.
>
>
> I tested this patch, it
> a) works fine with a new device that supports VIRTIO_BT_F_CONFIG_V2.
> b) uses the old configuration structure when working with an old device.
>    Our device does not offer the VIRTIO_BT_F_VND_HCI feature bit, so the
> driver does not tries to read unaligned "vendor" and "msft_opcode"
> fields and everything is fine.
> But, if the VIRTIO_BT_F_VND_HCI feature is set for the device for test
> purposes, our middle layer asserts unaligned accesses to the
> configuration space.

Great, thanks for the explanation.

> P.S. But, as Michael S. Tsirkin rightly stated, [q]Will a spec patch be
> forthcoming?[/q], this patch requires a specification update.
> I could not find any virtio_bt specification, do you have one?
> That would be great. Otherwise, would you mind if I try to write some
> initial draft?

Yep, I don't think we have one so feel free to start one, also while
at it we could perhaps attempt to write a tester for it so we can test
it using our CI, assuming virtio works with virtual devices created by
vhci driver.

> >>  static struct virtio_driver virtbt_driver =3D {
> >> diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virti=
o_bt.h
> >> index a7bd48daa9a9..af798f4c9680 100644
> >> --- a/include/uapi/linux/virtio_bt.h
> >> +++ b/include/uapi/linux/virtio_bt.h
> >> @@ -9,6 +9,7 @@
> >>  #define VIRTIO_BT_F_VND_HCI    0       /* Indicates vendor command su=
pport */
> >>  #define VIRTIO_BT_F_MSFT_EXT   1       /* Indicates MSFT vendor suppo=
rt */
> >>  #define VIRTIO_BT_F_AOSP_EXT   2       /* Indicates AOSP vendor suppo=
rt */
> >> +#define VIRTIO_BT_F_CONFIG_V2  3       /* Use second version configur=
ation */
> >>
> >>  enum virtio_bt_config_type {
> >>         VIRTIO_BT_CONFIG_TYPE_PRIMARY   =3D 0,
> >> @@ -28,4 +29,11 @@ struct virtio_bt_config {
> >>         __u16 msft_opcode;
> >>  } __attribute__((packed));
> >>
> >> +struct virtio_bt_config_v2 {
> >> +       __u8  type;
> >> +       __u8  alignment;
> >> +       __u16 vendor;
> >> +       __u16 msft_opcode;
> >> +};
> >> +
> >>  #endif /* _UAPI_LINUX_VIRTIO_BT_H */
> >> --
> >> 2.37.2
>


--=20
Luiz Augusto von Dentz
