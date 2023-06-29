Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A31B742E35
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjF2US0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjF2USX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:18:23 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E554212C;
        Thu, 29 Jun 2023 13:18:21 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7948540a736so201926241.1;
        Thu, 29 Jun 2023 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688069900; x=1690661900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUWhvTvfHqgopfY1uSN+qHK2KI5XDnK/yjYuoUEXk2U=;
        b=c62PoVKbgzWOEFkUff8ELJGV2zMwglcbj6FoMzCObDjQW1+iyOknR3B035XLnoaMZn
         //nk+lN6h4P8ladqgPGcQNrUJW+69NyYColAxb5oYJKipb3HGoEKbeCNsvmCM2UwhNwx
         pIBejsOrGskixePDLpKm4h4ssj2oULquaoG1b16kFh1C7EfQr5cE/6DkxlM5cpxbon8U
         zJvnpiIMstFI2x1HLCZFSx4KnWWGbmtwP887Hw3mONd/3BxqgI6HwiwPN1nGVdfzfgwc
         417Cax2KKCnkBjF4iBA9ZM6Uif8RGzgvHtFGyPndywQ4WJLuQ8hnQFb8EpjGPuAT3C2P
         +EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688069900; x=1690661900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUWhvTvfHqgopfY1uSN+qHK2KI5XDnK/yjYuoUEXk2U=;
        b=aCw+POVIwBFLOZJCwD4L3xYlT6cjpqM479uSyQW78kQ3f3N7FaIl5YP9tXANrF0Lca
         QcIG8Qyj6zlV8BGcxtWQlWlbLTq8UpUMgtT8zpGS342zdQlVozaXw4dTNKGgWRk+foB9
         lHKRD59hgHiFbDKktmrMx6A2FtTduw4OOs8aRFty5X+1tsy/sJTIMjSNBAoKXTb/NgRz
         C3VQsdJqvVMmjslDo17UcGT7ssqO39ywhmlbxNPR+k/fwIQ6F9HF0KBr5GfUbpwOOEpP
         0j3VJkkbNMtAetSf5xmOzcaNAgXxvgC/efoi1yizM3bCRw9kMx0CWLLxoJX0RZVEvoHW
         frjQ==
X-Gm-Message-State: ABy/qLbAm3hldSVP6tD63HcsH3Dx3ZFAFZArN0m0VdRDsylmD+T/n0ao
        /e3wnrhFIn3f40YAA4CtQKFuiScNz1E+YQUTtIs=
X-Google-Smtp-Source: APBJJlF2KtirkA/fsOxG+VVCxOYyMAlfWTo0z5/eLCxCwSDN4XvjA6NOIND+fHMuzuo+zt6UMFjmqk4ekPCsi+BydAQ=
X-Received: by 2002:a05:6102:3a42:b0:443:7935:6eb5 with SMTP id
 c2-20020a0561023a4200b0044379356eb5mr810115vsu.15.1688069900058; Thu, 29 Jun
 2023 13:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-6-paweldembicki@gmail.com> <20230625150552.sljrgm6rqodmefq5@skbuf>
In-Reply-To: <20230625150552.sljrgm6rqodmefq5@skbuf>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Thu, 29 Jun 2023 22:18:08 +0200
Message-ID: <CAJN1KkycUbLLWSTACr=xpuxLG7Arn3L0O0+z2VtyovnFx9s5QA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/7] net: dsa: vsc73xx: Add vlan filtering
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
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

niedz., 25 cze 2023 o 17:05 Vladimir Oltean <olteanv@gmail.com> napisa=C5=
=82(a):
>
> On Sun, Jun 25, 2023 at 01:53:41PM +0200, Pawel Dembicki wrote:
> > This patch implement vlan filtering for vsc73xx driver.
> >
> > After vlan filtering start, switch is reconfigured from QinQ to simple
> > vlan aware mode. It's required, because VSC73XX chips haven't support
> > for inner vlan tag filter.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
> > v2:
> >   - no changes done
> >
> >  drivers/net/dsa/vitesse-vsc73xx-core.c | 101 +++++++++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/v=
itesse-vsc73xx-core.c
> > index 457eb7fddf4c..c946464489ab 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> > +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> > @@ -1226,6 +1226,30 @@ static int vsc73xx_port_set_double_vlan_aware(st=
ruct dsa_switch *ds, int port)
> >       return ret;
> >  }
> >
> > +static int
> > +vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
> > +                         bool vlan_filtering, struct netlink_ext_ack *=
extack)
> > +{
> > +     int ret, i;
> > +
> > +     if (vlan_filtering) {
> > +             vsc73xx_port_set_vlan_conf(ds, port, VSC73XX_VLAN_AWARE);
> > +     } else {
> > +             if (port =3D=3D CPU_PORT)
> > +                     vsc73xx_port_set_vlan_conf(ds, port, VSC73XX_DOUB=
LE_VLAN_CPU_AWARE);
> > +             else
> > +                     vsc73xx_port_set_vlan_conf(ds, port, VSC73XX_DOUB=
LE_VLAN_AWARE);
> > +     }
>
> Why do you need ports to be double VLAN aware when vlan_filtering=3D0?
> Isn't VLAN_TCI_IGNORE_ENA sufficient to ignore the 802.1Q header from
> incoming packets, and set up the PVIDs of user ports as egress-tagged on
> the CPU port?
>

Because I want to forward tagged and untagged frames when
vlan_filtering is off.  If I set VSC73XX_DOUBLE_VLAN_AWARE, I can put
all (tagged and untagged) traffic into the outer vlan, called by the
datasheet as "MAN space". In QinQ mode, it is possible to ignore what
goes from a particular port but it is possible to separate traffic
from different ports.

> > +
> > +     for (i =3D 0; i <=3D 3072; i++) {
> > +             ret =3D vsc73xx_port_update_vlan_table(ds, port, i, 0);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> What is the purpose of this?

I want to be sure that the table is cleared when vlan awareness is changed.

>
> > +
> > +     return ret;
> > +}
> > +
> >  static int vsc73xx_vlan_set_untagged(struct dsa_switch *ds, int port, =
u16 vid,
> >                                    bool port_vlan)
> >  {
> > @@ -1304,6 +1328,80 @@ static int vsc73xx_vlan_set_pvid(struct dsa_swit=
ch *ds, int port, u16 vid,
> >       return 0;
> >  }
> >
> > +static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
> > +                              const struct switchdev_obj_port_vlan *vl=
an,
> > +                              struct netlink_ext_ack *extack)
> > +{
> > +     bool untagged =3D vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> > +     bool pvid =3D vlan->flags & BRIDGE_VLAN_INFO_PVID;
> > +     int ret;
> > +
> > +     /* Be sure to deny alterations to the configuration done by tag_8=
021q.
> > +      */
> > +     if (vid_is_dsa_8021q(vlan->vid)) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Range 3072-4095 reserved for dsa_8021=
q operation");
> > +             return -EBUSY;
> > +     }
> > +
> > +     if (untagged && port !=3D CPU_PORT) {
> > +             ret =3D vsc73xx_vlan_set_untagged(ds, port, vlan->vid, tr=
ue);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     if (pvid && port !=3D CPU_PORT) {
>
> Missing logic to change hardware PVID only while VLAN-aware, and to
> restore the tag_8021q PVID when the bridge VLAN awareness gets disabled.
> DSA does not resolve the conflicts on resources between .port_vlan_add()
> and .tag_8021q_vlan_add(), the driver must do that.
>
> > +             ret =3D vsc73xx_vlan_set_pvid(ds, port, vlan->vid, true);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     ret =3D vsc73xx_port_update_vlan_table(ds, port, vlan->vid, 1);
> > +
> > +     return ret;
>
> Style: return vsc73xx_port_update_vlan_table(...)
>
> > +}
> > +
> > +static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
> > +                              const struct switchdev_obj_port_vlan *vl=
an)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u16 vlan_no;
> > +     int ret;
> > +     u32 val;
> > +
> > +     ret =3D
> > +         vsc73xx_port_update_vlan_table(ds, port, vlan->vid, 0);
>
> Style: single line
>
> > +     if (ret)
> > +             return ret;
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val=
);
> > +
> > +     if (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA) {
> > +             vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port,
> > +                          VSC73XX_TXUPDCFG, &val);
> > +             vlan_no =3D (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
> > +                       VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
> > +             if (vlan_no =3D=3D vlan->vid) {
> > +                     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                         VSC73XX_TXUPDCFG,
> > +                                         VSC73XX_TXUPDCFG_TX_UNTAGGED_=
VID_ENA,
> > +                                         0);
> > +                     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                         VSC73XX_TXUPDCFG,
> > +                                         VSC73XX_TXUPDCFG_TX_UNTAGGED_=
VID, 0);
> > +             }
> > +     }
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,=
 &val);
> > +     vlan_no =3D val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
> > +     if (vlan_no && vlan_no =3D=3D vlan->vid) {
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_PORT_VLAN,
> > +                                 VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);
>
> As documented in Documentation/networking/switchdev.rst:
>
> When the bridge has VLAN filtering enabled and a PVID is not configured o=
n the
> ingress port, untagged and 802.1p tagged packets must be dropped. When th=
e bridge
> has VLAN filtering enabled and a PVID exists on the ingress port, untagge=
d and
> priority-tagged packets must be accepted and forwarded according to the
> bridge's port membership of the PVID VLAN. When the bridge has VLAN filte=
ring
> disabled, the presence/lack of a PVID should not influence the packet
> forwarding decision.
>
> Setting the hardware PVID to 0 when the bridge PVID is deleted sounds
> like it accomplishes none of those.
>

My bad. I should just set VSC73XX_CAT_DROP_UNTAGGED_ENA here.

> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static void vsc73xx_update_forwarding_map(struct vsc73xx *vsc)
> >  {
> >       int i;
> > @@ -1524,6 +1622,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops=
 =3D {
> >       .port_change_mtu =3D vsc73xx_change_mtu,
> >       .port_max_mtu =3D vsc73xx_get_max_mtu,
> >       .port_stp_state_set =3D vsc73xx_port_stp_state_set,
> > +     .port_vlan_filtering =3D vsc73xx_port_vlan_filtering,
> > +     .port_vlan_add =3D vsc73xx_port_vlan_add,
> > +     .port_vlan_del =3D vsc73xx_port_vlan_del,
> >       .tag_8021q_vlan_add =3D vsc73xx_tag_8021q_vlan_add,
> >       .tag_8021q_vlan_del =3D vsc73xx_tag_8021q_vlan_del,
> >  };
> > --
> > 2.34.1
> >
>

Thank you for such detailed responses and clarifying for me many issues.

--
Pawel Dembicki
