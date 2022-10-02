Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2B95F20AB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 02:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJBADF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 20:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJBADD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:03:03 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416881D32A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 17:03:02 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-131fd187e35so5718327fac.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 17:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RNX/xzGFLHjZiDwwYFnW8x0Zq94rir3TYawEnHUU6nU=;
        b=nBFAJvuw+Tw7nyoNVW0S2KaWYbCxBczm/dFLbOL9Bkff1ziFkWPBL929TG1RLalzDd
         PJbQkkwni6Bv6WVBP4+YK03YmlrSucn/LNnu2Sx2XKTgWhslBo9oD1SasSR8BT0T/I/l
         z4/XQnS7ytwhbtLJL4wLfXCS3ZLmDHmpufDgRe2MAQJIn7mbSsyqUlmBXl94PyiAKRsw
         S/A/uL5iYBaqyAXSMnTxQsRO5yaPbHxFxsR8rUQYAh369Mef/pC2Fan3zakDf/pK9yRY
         s/pnlku1VjHt+U5tlMXTkTKem6r2VO8Cx8RHLp+hm7esjmS/Hln3DZaa7k7Y9ZXrgRIB
         b9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RNX/xzGFLHjZiDwwYFnW8x0Zq94rir3TYawEnHUU6nU=;
        b=i7Js4U4depPZNEQFRrq6JoCwapQmz/e4uDXB1xAmEYz+gRWSy13S3VSCF3OwDnIqdM
         g8JiL/8bwP6/kaErRHMjR9O/MS5/OBeGLmKkiEyJpKVwBDdvNjQIDWCwaWekUKfvOW+X
         piZ64ukbL5664IJrPGkvkBSdVOnN4+/NvQldGgFv9oCifpa0ZZZtLDycjXTL7DEHpbmd
         2IujqTgXSazp35qKWC/d+GJ6XGl/Vd4rQ0m/bAoOF2FiD8Ba9a8P3R9d1CSH0jPqLuwE
         C8Q/eHHogK06Fe4S5nlFsxlwnZ6c0A/70l3HHZWUGc2SUP9IVGOjiC4dySIYy0Sl1/OG
         h+5A==
X-Gm-Message-State: ACrzQf1gtUjP6ZTBoYfuOxEH5uPtVChe7kPa3HWHFcgxchrp+YBgt6fi
        9vP1zjyQla2B3KOcVF9kpODwQwv1JHgjFA==
X-Google-Smtp-Source: AMsMyM5jASZeKDyW8k9//WE3J+OEV+IybjOLmse3/EX3VznqfbL+njlA0e85uIjaOj23s4h3UeIigw==
X-Received: by 2002:a05:6870:14ce:b0:127:6a7b:ada with SMTP id l14-20020a05687014ce00b001276a7b0adamr2175395oab.10.1664668981531;
        Sat, 01 Oct 2022 17:03:01 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t26-20020a056870601a00b001324ea027c1sm268217oaa.40.2022.10.01.17.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 17:03:01 -0700 (PDT)
Date:   Sat, 1 Oct 2022 20:02:58 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Julien Panis <jpanis@baylibre.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [char-misc:char-misc-next 12/23]
 drivers/counter/ti-ecap-capture.c:380:8: sparse: sparse: symbol
 'ecap_cnt_pol_array' was not declared. Should it be static?
Message-ID: <YzjVModUmh/HM+ET@fedora>
References: <202210020619.NQbyomII-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Id/g7WW2rBF+mQFs"
Content-Disposition: inline
In-Reply-To: <202210020619.NQbyomII-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Id/g7WW2rBF+mQFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2022 at 07:04:27AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.=
git char-misc-next
> head:   7cd04013fbf3e6dcb67ca6b59aa813269a2ad9ce
> commit: 4e2f42aa00b67605938173a61d07a44fe13bad68 [12/23] counter: ti-ecap=
-capture: capture driver support for ECAP
> config: parisc-randconfig-s041-20221002
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-mis=
c.git/commit/?id=3D4e2f42aa00b67605938173a61d07a44fe13bad68
>         git remote add char-misc https://git.kernel.org/pub/scm/linux/ker=
nel/git/gregkh/char-misc.git
>         git fetch --no-tags char-misc char-misc-next
>         git checkout 4e2f42aa00b67605938173a61d07a44fe13bad68
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=3Dbuild_dir ARCH=
=3Dparisc SHELL=3D/bin/bash drivers/counter/
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> sparse warnings: (new ones prefixed by >>)
> >> drivers/counter/ti-ecap-capture.c:380:8: sparse: sparse: symbol 'ecap_=
cnt_pol_array' was not declared. Should it be static?
>=20
> vim +/ecap_cnt_pol_array +380 drivers/counter/ti-ecap-capture.c
>=20
>    379=09
>  > 380	static DEFINE_COUNTER_ARRAY_POLARITY(ecap_cnt_pol_array, ecap_cnt_=
pol_avail, ECAP_NB_CEVT);
>    381=09
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

The first argument to the DEFINE_COUNTER_ARRAY_POLARITY() macro is a
token serving as the symbol name in the definition of a new
struct counter_array structure. However, this macro actually expands to
two statements:

    #define DEFINE_COUNTER_ARRAY_POLARITY(_name, _enums, _length) \
            DEFINE_COUNTER_AVAILABLE(_name##_available, _enums); \
            struct counter_array _name =3D { \
                    .type =3D COUNTER_COMP_SIGNAL_POLARITY, \
                    .avail =3D &(_name##_available), \
                    .length =3D (_length), \
            }

Because of this, the "static" on line 380 only applies to the first
statement. It might be best to take the DEFINE_COUNTER_AVAILABLE() line
out and leave DEFINE_COUNTER_ARRAY_POLARITY() as a simple structure
definition to avoid issues like this.

I'll submit a fix tomorrow to do such.

Thanks,

William Breathitt Gray

--Id/g7WW2rBF+mQFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYzjVMgAKCRC1SFbKvhIj
KxkfAQDcYDK+oryupOntI6fkUQ8IiAdEQYdVlwC05lDnKmjEAQD/Rx8reid2LUDe
eWkM+BWx93ltsFAJOCkvCQVNnMIcSA4=
=qLyF
-----END PGP SIGNATURE-----

--Id/g7WW2rBF+mQFs--
