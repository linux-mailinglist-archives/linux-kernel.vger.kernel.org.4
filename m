Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2D7248B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbjFFQOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjFFQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB691995;
        Tue,  6 Jun 2023 09:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD70F63078;
        Tue,  6 Jun 2023 16:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1499C433EF;
        Tue,  6 Jun 2023 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686068022;
        bh=QwM7DUTQAmP5CKDLGISPOe3AvYarrqjMTLKruYcs9PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJy6gvAh/zvD96T9SPZvmnhkT7brSRIfmeZMKpeEhfunsDeST1CcgNsaiBZlPEHyD
         4fMeCfNwFvFtE8GFIa8WqMLkAjyePqldvpEvky9b05OEThINNaqTYkk+0XJSmLsibE
         PHBFvv5Lm9EmRsvvwre9VXrBbi53IBFiVlHZ+KOjWVEM5bR67tkFlUzF1ICmaROFqz
         PDzIuK2bEkQzgkFgosobbvI3iTSYzKAZyyzOWcUUegdVnMrqhzi83tyXADxRnxsAod
         sCMH5SdA7/5cKBZb2QOsy1ZjhFbLhePF6n9HAPDtRoS5s5BgyvF7fxhzHzKMtN7Aal
         ZmwHP1ZDVO2Qg==
Date:   Tue, 6 Jun 2023 18:13:36 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/mediatek/mt76/mt76x02_util.c:475
 mt76x02_set_key() warn: variable dereferenced before check 'key' (see line
 415)
Message-ID: <ZH9bMMyN/UMPBTq1@lore-desk>
References: <2f121202-5846-44a9-8b83-e2ba1fa671d0@kadam.mountain>
 <87mt1ciu5o.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p6BjL3/uPCwCbsuy"
Content-Disposition: inline
In-Reply-To: <87mt1ciu5o.fsf@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p6BjL3/uPCwCbsuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Adding linux-wireless, top posting so that the whole report is included.
>=20
> Dan Carpenter <dan.carpenter@linaro.org> writes:
>=20
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   f8dba31b0a826e691949cd4fdfa5c30defaac8c5
> > commit: e6db67fa871dee37d22701daba806bfcd4d9df49 wifi: mt76: ignore
> > key disable commands
> > config: riscv-randconfig-m031-20230605
> > (https://download.01.org/0day-ci/archive/20230606/202306060332.WbIToDHL=
-lkp@intel.com/config)
> > compiler: riscv64-linux-gcc (GCC) 12.3.0
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202306060332.WbIToDHL-lkp@intel.com/
> >
> > smatch warnings:
> > drivers/net/wireless/mediatek/mt76/mt76x02_util.c:475
> > mt76x02_set_key() warn: variable dereferenced before check 'key' (see
> > line 415)
> >
> > vim +/key +475 drivers/net/wireless/mediatek/mt76/mt76x02_util.c
> >
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 407 int
> > mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 408 struct ieee80211_vif
> > *vif, struct ieee80211_sta *sta,
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 409 struct
> > ieee80211_key_conf *key)
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  410  {
> > d87cf75f111183 Lorenzo Bianconi 2018-10-07 411 struct mt76x02_dev *dev
> > =3D hw->priv;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 412 struct mt76x02_vif
> > *mvif =3D (struct mt76x02_vif *)vif->drv_priv;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  413  	struct mt76x02_sta *=
msta;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  414  	struct mt76_wcid *wc=
id;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 @415  	int idx =3D key->key=
idx;
> >
> > "key" is dereferenced here

I think I have already fixed it here:

https://patchwork.kernel.org/project/linux-wireless/patch/d560f1a16c9024b6e=
4029bd0baf53384f4552f5a.1683020788.git.lorenzo@kernel.org/

Regards,
Lorenzo

> >
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  416  	int ret;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  417 =20
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 418 /* fall back to sw
> > encryption for unsupported ciphers */
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  419  	switch (key->cipher)=
 {
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  420  	case WLAN_CIPHER_SUI=
TE_WEP40:
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  421  	case WLAN_CIPHER_SUI=
TE_WEP104:
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  422  	case WLAN_CIPHER_SUI=
TE_TKIP:
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  423  	case WLAN_CIPHER_SUI=
TE_CCMP:
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  424  		break;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  425  	default:
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  426  		return -EOPNOTSUPP;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  427  	}
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  428 =20
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  429  	/*
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 430 * The hardware does
> > not support per-STA RX GTK, fall back
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  431  	 * to software mode =
for these.
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  432  	 */
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 433 if ((vif->type =3D=3D
> > NL80211_IFTYPE_ADHOC ||
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 434 vif->type =3D=3D
> > NL80211_IFTYPE_MESH_POINT) &&
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 435 (key->cipher =3D=3D
> > WLAN_CIPHER_SUITE_TKIP ||
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 436 key->cipher =3D=3D
> > WLAN_CIPHER_SUITE_CCMP) &&
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 437 !(key->flags &
> > IEEE80211_KEY_FLAG_PAIRWISE))
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  438  		return -EOPNOTSUPP;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  439 =20
> > b98558e2529986 Stanislaw Gruszka 2019-03-19  440  	/*
> > b98558e2529986 Stanislaw Gruszka 2019-03-19 441 * In USB AP mode,
> > broadcast/multicast frames are setup in beacon
> > b98558e2529986 Stanislaw Gruszka 2019-03-19 442 * data registers and
> > sent via HW beacons engine, they require to
> > b98558e2529986 Stanislaw Gruszka 2019-03-19  443  	 * be already encryp=
ted.
> > b98558e2529986 Stanislaw Gruszka 2019-03-19  444  	 */
> > 61c51a74a4e586 Lorenzo Bianconi  2019-10-29  445  	if (mt76_is_usb(&dev=
->mt76) &&
> > b98558e2529986 Stanislaw Gruszka 2019-03-19 446 vif->type =3D=3D
> > NL80211_IFTYPE_AP &&
> > b98558e2529986 Stanislaw Gruszka 2019-03-19 447 !(key->flags &
> > IEEE80211_KEY_FLAG_PAIRWISE))
> > b98558e2529986 Stanislaw Gruszka 2019-03-19  448  		return -EOPNOTSUPP;
> > b98558e2529986 Stanislaw Gruszka 2019-03-19  449 =20
> > 4b36cc6b390f18 David Bauer 2021-02-07 450 /* MT76x0 GTK offloading
> > does not work with more than one VIF */
> > 4b36cc6b390f18 David Bauer 2021-02-07 451 if (is_mt76x0(dev) &&
> > !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
> > 4b36cc6b390f18 David Bauer       2021-02-07  452  		return -EOPNOTSUPP;
> > 4b36cc6b390f18 David Bauer       2021-02-07  453 =20
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 454 msta =3D sta ? (struct
> > mt76x02_sta *)sta->drv_priv : NULL;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 455 wcid =3D msta ?
> > &msta->wcid : &mvif->group_wcid;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  456 =20
> > e6db67fa871dee Felix Fietkau     2023-03-30  457  	if (cmd !=3D SET_KEY=
) {
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 458 if (idx =3D=3D
> > wcid->hw_key_idx) {
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 459 wcid->hw_key_idx =3D -1;
> > f2f6a47b504b8f Felix Fietkau 2019-01-25 460 wcid->sw_iv =3D false;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  461  		}
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  462 =20
> > e6db67fa871dee Felix Fietkau     2023-03-30  463  		return 0;
> > e6db67fa871dee Felix Fietkau     2023-03-30  464  	}
> > e6db67fa871dee Felix Fietkau     2023-03-30  465 =20
> > e6db67fa871dee Felix Fietkau     2023-03-30  466  	key->hw_key_idx =3D =
wcid->idx;
> > e6db67fa871dee Felix Fietkau     2023-03-30  467  	wcid->hw_key_idx =3D=
 idx;
> > e6db67fa871dee Felix Fietkau 2023-03-30 468 if (key->flags &
> > IEEE80211_KEY_FLAG_RX_MGMT) {
> > e6db67fa871dee Felix Fietkau 2023-03-30 469 key->flags |=3D
> > IEEE80211_KEY_FLAG_SW_MGMT_TX;
> > e6db67fa871dee Felix Fietkau     2023-03-30  470  		wcid->sw_iv =3D tru=
e;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  471  	}
> > d87cf75f111183 Lorenzo Bianconi 2018-10-07 472
> > mt76_wcid_key_setup(&dev->mt76, wcid, key);
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  473 =20
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  474  	if (!msta) {
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 @475 if (key ||
> > wcid->hw_key_idx =3D=3D idx) {
> >
> > This NULL check is too late.
> >
> > 8d66af49a3db9a Lorenzo Bianconi 2018-10-07 476 ret =3D
> > mt76x02_mac_wcid_set_key(dev, wcid->idx, key);
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  477  			if (ret)
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04 478 return ret;
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  479  		}
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  480 =20
> > 8d66af49a3db9a Lorenzo Bianconi 2018-10-07 481 return
> > mt76x02_mac_shared_key_setup(dev, mvif->idx, idx, key);
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  482  	}
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  483 =20
> > 8d66af49a3db9a Lorenzo Bianconi 2018-10-07 484 return
> > mt76x02_mac_wcid_set_key(dev, msta->wcid.idx, key);
> > 60c26859e863c1 Stanislaw Gruszka 2018-09-04  485  }
>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--p6BjL3/uPCwCbsuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZH9bMAAKCRA6cBh0uS2t
rN4LAQDNL8BEsPgt6S7+dsLWJDD11V9cJztRbP8Tqks8IYLJigD+KVOZQuZZHTQB
XRpFvLs0ahWuT/EK3WJqArXr2tovgwc=
=cLR/
-----END PGP SIGNATURE-----

--p6BjL3/uPCwCbsuy--
