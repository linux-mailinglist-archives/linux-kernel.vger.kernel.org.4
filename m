Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B65E6C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiIVT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiIVTz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:55:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9273195AE7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:55:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u18so16417536lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xIPmujiyfWOajBJjBvgxKpjBtB45GgxFhMLGKXXMv8c=;
        b=ltfdWf65dwpZLGG8ThMq+jdLgqvJdSowvT+mlXGI3G6MEqQch/I/r90ti2743IU4kd
         qmarAkEahCduHlz00QlQjcwKbyGjJWNlgOKZ+PoDtbnY0cDunikVJNz5sNfF/+KytXtp
         AU4B+XbZVAE2qWWf0NAtE1K780ooN2MtnPFZFhmxCg6g3CcTuYUkqApdrewX+b4bT41D
         xW1PB4j0z4Y4vAs5m8MEmGM7KqfDgV15GXtNQNu5N+QEXIAu13IZIlsgsOP+0KWbBlVW
         gpstIYxmNdV0CqXLgHAyvGzue/HQoExCm3gZmWNR2RBb3Ms80k48nPZfgc/bXv4aouwm
         A+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xIPmujiyfWOajBJjBvgxKpjBtB45GgxFhMLGKXXMv8c=;
        b=shv00wj4qisJLyjSiBlkA2bz8wALLdKwv5ehde6FKxtKsRS8yA7qSvmmzkLHx3svWW
         48qy/ZVRxz8r8ipvLKARoa1Du9DDrDMXiBnyTtJWYIcDAD8CDpzHHPbi8DzOm4k0IPrR
         h/+h9ax12bBpJaXkDI98C+G1h56Frst42WItniHgtgMsFqw22NC6qnck7znwBpFUhFg6
         No7/LRD5Vq5fWgFR1J2Oj5woYhUq3HlIMl149T/lQYJ9x42JPKgfLdipFNPCNwuIh+aH
         GUyKp/YSszEgmpsX5xyPTLrGwVQ2xxqawn6iG4N72eNWSF+v6RD7ofw+CK5QybUcUkDU
         FVJA==
X-Gm-Message-State: ACrzQf06flP4Ego7dhUJ/4KYWjHKSYQSRvqMUwVE5hmvkpSHbOw2n3bu
        EhzCREO4ZsRcDOurOF8L6RulCIzso2d00g==
X-Google-Smtp-Source: AMsMyM5+J1LnuXaYj4dCuhVDmlbLEtQBfPA/XoqcT7tSpbnJlBpNwD2Ce58qJvoW4OlXJ2LNgjccog==
X-Received: by 2002:ac2:4a61:0:b0:497:ae0c:4f66 with SMTP id q1-20020ac24a61000000b00497ae0c4f66mr1786866lfp.660.1663876552908;
        Thu, 22 Sep 2022 12:55:52 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id y18-20020a197512000000b004946aef1814sm1082016lfe.137.2022.09.22.12.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:55:51 -0700 (PDT)
Date:   Thu, 22 Sep 2022 22:01:57 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [jic23-iio:testing 58/58] drivers/iio/adc/mcp3911.c:274:6:
 warning: variable 'tmp0' set but not used
Message-ID: <Yyy/NXG61IjpHvxU@gmail.com>
References: <202209220845.GmS9zryR-lkp@intel.com>
 <20220922115925.00004ec9@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cabgzS1QBwGhtYbU"
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


--cabgzS1QBwGhtYbU
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

Yes, the intention was to keep the remainder.
When I looked at the code a second time, tmp2 will have the
same value as the reminder as the division does not make sense.

So tmp1 and tmp0 is removed in the v7 patch.

/Marcus=20

>=20
> If you confirm that I'll tweak the commit to do that.
>=20
> Jonathan
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

--cabgzS1QBwGhtYbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmMsvzAACgkQiIBOb1ld
UjIhMg//fY1JE1gXpqqZMVu6OH/FV2bbm3KH1KSSqrBNURwXLpuoeXn76VW54KL+
oXE8/+XV70w3asz6zJW6Jg2JIi4B8MPloc5b1CA+LQgUjjvgNd7xsNd0XjkOMcQJ
UECmIT3PabdCJM5WMaJnASjh3ULilgmFc3gho7eJ3Q4ZpUIg8hMqc9rD3I5BH9EH
c0qkR+mfjSKVlnxMKUsayPF39UDRvMOM8wqCNaca7V9+9IjmndV6NhiGtw36KIj6
4ZeynNmL1+t3AaJHYWCunSjMRje2AMk9NNwd3/hkGTOcfBaKKoR9medSVH0FJtKB
rLPiT7IgKGmJRifAoHGX97JuSI/MmzyGdVM7HC3NSMe66IIllcCKdLejJtYERM6A
y6TrtugmRtZhfGLQ7o8cBowS4XkP/GVdeXODFOg+xKK8msUqojPcuVX+LSkAz7Yu
vseyvLSdHnNFC8eVZJv8vW+KIpv1GPAcTe6IgrvR/WPNVSBCDafwyFvGlA8ujSTb
xsnMCH0WPW3uDIC42otbT6tignprcCYMu2hISp22gXYZ8miDacAPu0Jw+6JsZme+
8nLjMIllpL3MYyfE5zLHmSKLXjQKzF2/mSg6wa/VOD0SlTXJf7W6diVW4mxSBs7Q
pvFP2Hw0pIKsM9KVGP4tbqL9XmAuaWvi1ZPAnYSmJHwMgcv94ac=
=u9Lw
-----END PGP SIGNATURE-----

--cabgzS1QBwGhtYbU--
