Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E075E6739
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiIVPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiIVPf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:35:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F93CD4A9E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:35:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j16so15344594lfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=akYYafNOuWhsG6Uk19XZx6qfSJseAlSpwqtkBF7c3Uk=;
        b=bG3jqbJBSs+Zy4pehkaom0r8y9QQG+SPrzfgyNRzJZ3MifqY3GiProheY0ofCXGVDD
         V+9lr2CClDAB514409u9Pcc/cIcKH0lYkRqOduh8UVS35q2YWeVSfkxyQNdh3VgsvlZr
         CCyyUReVJ7ZsX09wYGgKdoEQylvEAhHry/ZXPZiMTf/b9cT+XHFNzTOOLvRZ+vrDEbpL
         rSAkvBwmZUuRyhmNJWZiamDEHaJrs6fMAnlA+GYzOCpI808YvoV2ONoWwMuzNs1RUQhK
         ZwCWi9Su5Wqr7AbWDYlYJ3rQIehGw4GRZ6r6oFAe9ox5Pl7crlXRmT6s7bq0HoYLERL9
         Sz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=akYYafNOuWhsG6Uk19XZx6qfSJseAlSpwqtkBF7c3Uk=;
        b=twWiILi/83n2KCjOPfQL7CirKYUNfFA2pvleAYvKmt9HZh6lmbYyhjuf/uoKx1tB4Q
         X/xFvfeSSQUetTPLwQWLqpmdFKFndoE1cRqxijUnApCKpcTaMDImd9tPM+YyXI3fUSbZ
         dxQ5wfyKC+uI+leCFiqEtaWxT4rPs3SgzLenQ3rquj37KPbdYye9Vr+FIKp9THJnq/Il
         StoG5e5Cn9WmfspXk+1+xjzIqmOxzr+OyQqzbRiYA14FUasg/cM2ddlhrgsemNhsxSt2
         pThrj8DxFaYjoaMpl3X29NDC5tGDIsTNiKo1yPO1x53IHR4BdTtSEhJ9KL6r+90ErD6y
         TThQ==
X-Gm-Message-State: ACrzQf2dMPpD0R5EhLTdVtfYbRwpjkPY+2TwyB3vov8cANlqygEaqsfv
        h9BzSKL6o0e/6oBs74sriZo=
X-Google-Smtp-Source: AMsMyM6Dqp3iJt9pKiV6yPIHyzWEcsdL4uMylG+LucaV60NBjxt5mrJnMR5fuAFkSMaaJyjZI+jFKQ==
X-Received: by 2002:a05:6512:1055:b0:49a:de51:5458 with SMTP id c21-20020a056512105500b0049ade515458mr1420898lfb.585.1663860921607;
        Thu, 22 Sep 2022 08:35:21 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004886508ca5csm992969lfc.68.2022.09.22.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:35:19 -0700 (PDT)
Date:   Thu, 22 Sep 2022 17:41:25 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [jic23-iio:testing 58/58] drivers/iio/adc/mcp3911.c:274:6:
 warning: variable 'tmp0' set but not used
Message-ID: <YyyCJX374uWYrPTN@gmail.com>
References: <202209220845.GmS9zryR-lkp@intel.com>
 <20220922115925.00004ec9@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rIiIuRTFM5K9HQs3"
Content-Disposition: inline
In-Reply-To: <20220922115925.00004ec9@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rIiIuRTFM5K9HQs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2022 at 11:59:25AM +0100, Jonathan Cameron wrote:
> On Thu, 22 Sep 2022 08:50:17 +0800
> kernel test robot <lkp@intel.com> wrote:
>=20
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git t=
esting
> > head:   d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
> > commit: d4e1a549566b9ea8b96e80f0cdcbe99714ac256e [58/58] iio: adc: mcp3=
911: add support to set PGA
> > config: x86_64-randconfig-a012
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f2=
8c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git=
/commit/?id=3Dd4e1a549566b9ea8b96e80f0cdcbe99714ac256e
> >         git remote add jic23-iio https://git.kernel.org/pub/scm/linux/k=
ernel/git/jic23/iio.git
> >         git fetch --no-tags jic23-iio testing
> >         git checkout d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash drivers/iio/adc/
> >=20
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> >=20
> > All warnings (new ones prefixed by >>):
> >=20
> > >> drivers/iio/adc/mcp3911.c:274:6: warning: variable 'tmp0' set but no=
t used [-Wunused-but-set-variable] =20
> >            int tmp0, tmp1;
> >                ^
> >    1 warning generated.
> >=20
> >=20
> > vim +/tmp0 +274 drivers/iio/adc/mcp3911.c
> >=20
> >    268=09
> >    269	static int mcp3911_calc_scale_table(struct mcp3911 *adc)
> >    270	{
> >    271		u32 ref =3D MCP3911_INT_VREF_MV;
> >    272		u32 div;
> >    273		int ret;
> >  > 274		int tmp0, tmp1; =20
> >    275		s64 tmp2;
> >    276=09
> >    277		if (adc->vref) {
> >    278			ret =3D regulator_get_voltage(adc->vref);
> >    279			if (ret < 0) {
> >    280				dev_err(&adc->spi->dev,
> >    281					"failed to get vref voltage: %d\n",
> >    282				       ret);
> >    283				return ret;
> >    284			}
> >    285=09
> >    286			ref =3D ret / 1000;
> >    287		}
> >    288=09
> >    289		/*
> >    290		 * For 24-bit Conversion
> >    291		 * Raw =3D ((Voltage)/(Vref) * 2^23 * Gain * 1.5
> >    292		 * Voltage =3D Raw * (Vref)/(2^23 * Gain * 1.5)
> >    293		 *
> >    294		 * ref =3D Reference voltage
> >    295		 * div =3D (2^23 * 1.5 * gain) =3D 12582912 * gain
> >    296		 */
> >    297		for (int i =3D 0; i < MCP3911_NUM_SCALES; i++) {
> >    298			div =3D 12582912 * BIT(i);
> >    299			tmp2 =3D div_s64((s64)ref * 1000000000LL, div);
> >    300			tmp1 =3D div;
> >    301			tmp0 =3D (int)div_s64_rem(tmp2, 1000000000, &tmp1);
>=20
> Marcus,=20
> I'm guessing the intent here is just to get the remainder. =20
> Hence fix is probably just to drop tmp0?
>=20
> If you confirm that I'll tweak the commit to do that.
>=20
> Jonathan


Hum, Yes. I actually think we can drop div, tmp0, tmp1 and tmp2.
I think they are remnats for when I did the calculation differently.

Do you want me to update the patchset?

 static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 {
        u32 ref =3D MCP3911_INT_VREF_MV;
-       u32 div;
        int ret;
-       int tmp0, tmp1;
-       s64 tmp2;


=2E...



        for (int i =3D 0; i < MCP3911_NUM_SCALES; i++) {
-               div =3D 12582912 * BIT(i);
-               tmp2 =3D div_s64((s64)ref * 1000000000LL, div);
-               tmp1 =3D div;
-               tmp0 =3D (int)div_s64_rem(tmp2, 1000000000, &tmp1);
-
                mcp3911_scale_table[i][0] =3D 0;
-               mcp3911_scale_table[i][1] =3D tmp1;
+               mcp3911_scale_table[i][1] =3D 12582912 * BIT(i);
        }


/Marcus

>=20
>=20
> >    302=09
> >    303			mcp3911_scale_table[i][0] =3D 0;
> >    304			mcp3911_scale_table[i][1] =3D tmp1;
> >    305		}
> >    306=09
> >    307		return 0;
> >    308	}
> >    309=09
> >=20
>=20

--rIiIuRTFM5K9HQs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmMsgiAACgkQiIBOb1ld
UjLtjQ//TcKaFqSzCHllxcmrVvwl0n2nhcJ9M3R8iU+6B0EMRxYltiay5y4sSEZ8
ZPBI73jV+I3G0+X7/NoYARBEUpKSx4v1CvZTbaCswnMkWx3KX+9qaZChdHUdRl0t
EGsi+SZVfi37GkqLeC+QdsWoctbQHsS9YdGor1k3foCEGfE29ShzKmn5PoQfOqjy
FPwsU6HnIvP//jmRpKkbkaE9L0YE9C8pF1n/u0nDu5I3k+xCN+ka1lqG2+7fusuX
78IWuEH9g2684JyaMt7AO/yDPhrMPRO6IGS2PxNYiWB9qhKFmBs3vUgEMZeGaz3O
/84ljkfsqOtem1FTiguei2J7w/PzT+NpYETFG/t8PGpgVulTPkfusldE4KdbMViC
mroKe+qQRYLtF+WLTeva8FHUk7rUmA6AWyD4O1q6Lf/nwe/DMfbevPXTByiiEeep
8RvHZuiPjqgs20iL2a+N1bE2ZpgsTK4s6/wLIFWjGEgKEHCpzvploGYcxlBejeGJ
41FcJICerUxOI4BToaOVnErhGV/dSeEg3kGH7It6geglE1eokvZo91c1nHbCwoEI
kIy34emeKF4PRyDVGVKk7NzrX0C1XZOiwc+n8VwdvOtneqVQyU4KrqiHKZ7sS7+q
5Kph9GfjZ71Xaa9yHHHgR7OF63PEmridtCswv+JTWhjSV7Hg9s0=
=xQ2z
-----END PGP SIGNATURE-----

--rIiIuRTFM5K9HQs3--
