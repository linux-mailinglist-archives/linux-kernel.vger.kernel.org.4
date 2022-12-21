Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61B0653039
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiLUL1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUL1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:27:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB9610AF;
        Wed, 21 Dec 2022 03:27:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B8B61780;
        Wed, 21 Dec 2022 11:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DF7C433EF;
        Wed, 21 Dec 2022 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671622021;
        bh=HjepBz/ZEos8NkTBb7ACzSazfzqLFQPZOb05O/86Zrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scyy5swg3nESqilvvNzTnP6mtzjucrmyOP7nocPJdLz5SxMWNXxPzEJ1Z9RvzmMjM
         A94VhQOUiNK0mxhxxMpC52VFc6mdezCBLS8/yiEoTRfcPOz5QpYFLQqzg7et1t9TpR
         ePMt2q+1reRNYB+bqb6kjTOIP5LoO4XcUIlx2LVGrar8XUsbnllqlLDxMIc9xTGNMQ
         nUYC2o6WAS6u3zlyE7i7rUj8aQ4GxUzAOhwvd+jiLHaKNY6lTJDBt4LnKpGsigByid
         RLt0RwbntRH/IEUIKbwGp6iEggtG5N9C8n99gDYMuXju5zVPWS493XLBDDH94gE/Qh
         THj4oclsUzdHw==
Date:   Wed, 21 Dec 2022 12:26:58 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [6.2][regression] after commit
 cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
Message-ID: <Y6LtgojZfDqNKoE3@lore-desk>
References: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
 <678adc67-9e46-3eef-f274-c951b121570f@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2s7EVZ7K4gA7xtJY"
Content-Disposition: inline
In-Reply-To: <678adc67-9e46-3eef-f274-c951b121570f@nbd.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2s7EVZ7K4gA7xtJY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 21.12.22 02:10, Mikhail Gavrilov wrote:
> > Hi,
> > The kernel 6.2 preparation cycle has begun.
> > And after the kernel was updated on my laptop, the wifi stopped working.
> >=20
> > Bisecting blames this commit:
> > cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae is the first bad commit
> > commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
> > Author: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date:   Sat Nov 12 16:40:35 2022 +0100
> >=20
> >      wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf
> >=20
> >      Introduce the capability to configure RX WED in mt76_dma_{add,get}=
_buf
> >      utility routines.
> >=20
> >      Tested-by: Daniel Golle <daniel@makrotopia.org>
> >      Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
> >      Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> >      Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >      Signed-off-by: Felix Fietkau <nbd@nbd.name>
> >=20
> >   drivers/net/wireless/mediatek/mt76/dma.c  | 125 ++++++++++++++++++++-=
---------
> >   drivers/net/wireless/mediatek/mt76/mt76.h |   2 +
> >   2 files changed, 88 insertions(+), 39 deletions(-)
> >=20
> > Unfortunately, I can't be sure that revert this commit will fix the
> > problem. Because after the revert, compile of kernel failing with
> > follow error:
> > drivers/net/wireless/mediatek/mt76/mt7915/dma.c: In function =E2=80=98m=
t7915_dma_init=E2=80=99:
> > drivers/net/wireless/mediatek/mt76/mt7915/dma.c:489:33: error:
> > implicit declaration of function =E2=80=98MT_WED_Q_RX=E2=80=99; did you=
 mean
> > =E2=80=98MT_WED_Q_TX=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >    489 |                                 MT_WED_Q_RX(MT7915_RXQ_BAND0);
> >        |                                 ^~~~~~~~~~~
> >        |                                 MT_WED_Q_TX
> > cc1: some warnings being treated as errors
> >    CC [M]  drivers/net/ethernet/intel/igb/e1000_phy.o
> > make[7]: *** [scripts/Makefile.build:252:
> > drivers/net/wireless/mediatek/mt76/mt7915/dma.o] Error 1
> > make[7]: *** Waiting for unfinished jobs....
> I'm pretty sure that commit is unrelated to this issue. However, while
> looking at the code I found a bug that would explain your issue.
>=20
> Please try this patch:
> ---
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -422,15 +422,15 @@ void mt7921_roc_timer(struct timer_list *timer)
>  static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *v=
if)
>  {
> -	int err;
> -
> -	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> -		return 0;
> +	int err =3D 0;
>  	del_timer_sync(&phy->roc_timer);
>  	cancel_work_sync(&phy->roc_work);
> -	err =3D mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
> -	clear_bit(MT76_STATE_ROC, &phy->mt76->state);
> +
> +	mt7921_mutex_acquire(phy->dev);
> +	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> +		err =3D mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
> +	mt7921_mutex_release(phy->dev);
>  	return err;
>  }
> @@ -487,13 +487,8 @@ static int mt7921_cancel_remain_on_channel(struct ie=
ee80211_hw *hw,
>  {
>  	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
>  	struct mt7921_phy *phy =3D mt7921_hw_phy(hw);
> -	int err;
> -	mt7921_mutex_acquire(phy->dev);
> -	err =3D mt7921_abort_roc(phy, mvif);
> -	mt7921_mutex_release(phy->dev);
> -
> -	return err;
> +	return mt7921_abort_roc(phy, mvif);
>  }
>  static int mt7921_set_channel(struct mt7921_phy *phy)
> @@ -1778,11 +1773,8 @@ static void mt7921_mgd_complete_tx(struct ieee8021=
1_hw *hw,
>  				   struct ieee80211_prep_tx_info *info)
>  {
>  	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> -	struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> -	mt7921_mutex_acquire(dev);
>  	mt7921_abort_roc(mvif->phy, mvif);
> -	mt7921_mutex_release(dev);
>  }
>  const struct ieee80211_ops mt7921_ops =3D {
>=20

I guess we have a similar issue for 7663 too:


diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net=
/wireless/mediatek/mt76/mt7615/main.c
index ab4c1b4478aa..0405a31fcfd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1175,16 +1175,14 @@ static int mt7615_cancel_remain_on_channel(struct i=
eee80211_hw *hw,
 					   struct ieee80211_vif *vif)
 {
 	struct mt7615_phy *phy =3D mt7615_hw_phy(hw);
-	int err;
-
-	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		return 0;
+	int err =3D 0;
=20
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
=20
 	mt7615_mutex_acquire(phy->dev);
-	err =3D mt7615_mcu_set_roc(phy, vif, NULL, 0);
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		err =3D mt7615_mcu_set_roc(phy, vif, NULL, 0);
 	mt7615_mutex_release(phy->dev);
=20
 	return err;

--2s7EVZ7K4gA7xtJY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY6LtgQAKCRA6cBh0uS2t
rDjhAP0YBC01r+T8HOIfmVYfb9LbKF3odR1hy6xL2+CPIQXUbgD/W4TBBswa0Vi6
WxFH3z8MOr+lOev59YNkKE7L/yRo5gg=
=p1NZ
-----END PGP SIGNATURE-----

--2s7EVZ7K4gA7xtJY--
