Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3C56513D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiLSU0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLSU02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:26:28 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E3D6599
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:26:27 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id jr11so9284332qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pv+knuoy6rQGJ4nkw2RIVOI1g4kg4HSoXIdBvTVdUsg=;
        b=4KIdEX//Q/s1+TRlcOWpqP9wRcDT3CJHE7BNpENgDxkFbNShRUXth1vTD8t9BiEIVf
         T+UeJoRizo5/6E2fjF/l3MbtLvHULM+ptwpmfUx3JZ33qAIaCxeLt/GQf1jrs+e6ch1O
         XseuDxfThr2VTXsMhl8hM1uZORrX9HYDz6BHfrQ+SXP2Y7f2WWxhnjsnE1aZScQF5yhh
         EA811FsMLd5x+O3LHZ2Z/Ut9staXb6lOHHuQV2Cond9Jomnf/HZ6MmFcx/czPDiB3g0U
         VoldIPZ2JowHAe1RdWRxIc9R37oqGUyrTGXKGx5mHKyMbEoTQEahioWd4dYPBUAfsBuD
         yegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pv+knuoy6rQGJ4nkw2RIVOI1g4kg4HSoXIdBvTVdUsg=;
        b=Ll+M1FyGuq4ZCCqOiDJx6lElS7ZFazisUjmkN7M/VaOhFHzRTM3cABBJueKxn9Q/Ab
         j5/k2ApeIdgWqAFmOCIRMGzINVUFEdmiHN5FPDeE/mLKILWj63VeYq9s4AcMnNpUmAjc
         hiQhg+VxKVFJhzEaqS7VKtY6NYLl/szpJAOVvqEvmmpcfQesyLDWOR0yBCjkXnqdtHCE
         T2NYmzrZW0jv3rySTKh0XwQBPIoUJQh3cVEnEyODCnuhdwX16AMPxHyBJev8+bhOpcgY
         Nx3MLhalwdXafL7s5shgaZVeNWr6Z3bIrSYHLQuYju65CeWlEn41vZ5IluzpG2VmPznE
         EF5A==
X-Gm-Message-State: AFqh2krUgGmiyL3PZasCc4FYNNUIux6tNejNCuIGWFzkw0Jo3GNY32Os
        kF0droWBDFAucZ3zQJX7Cfuxcg==
X-Google-Smtp-Source: AMrXdXv1lX1cqoWU/S9Fo51CaSPiJCmcQfkgc7SygWM5W40U0s2u+sybYiNZvqnPcOBRXsg73XiWMw==
X-Received: by 2002:ac8:74a:0:b0:3a5:7a7c:25ba with SMTP id k10-20020ac8074a000000b003a57a7c25bamr14734810qth.38.1671481586152;
        Mon, 19 Dec 2022 12:26:26 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id bs33-20020a05620a472100b006fbdeecad51sm7677704qkb.48.2022.12.19.12.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:26:25 -0800 (PST)
Message-ID: <855ceb2c7c00d123389931a7bf4b845b636768de.camel@ndufresne.ca>
Subject: Re: [PATCH v1 2/9] media: verisilicon: Add AV1 decoder mode and
 controls
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     kernel test robot <lkp@intel.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Date:   Mon, 19 Dec 2022 15:26:24 -0500
In-Reply-To: <202212200257.l7xJlHCi-lkp@intel.com>
References: <20221219155616.848690-3-benjamin.gaignard@collabora.com>
         <202212200257.l7xJlHCi-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 20 d=C3=A9cembre 2022 =C3=A0 02:25 +0800, kernel test robot a =C3=
=A9crit=C2=A0:
> Hi Benjamin,
>=20
> I love your patch! Yet something to improve:

This is expected as kernel next does not pull the uAPI v3 for this CODEC. T=
he
patchset is RFC I believe, we will have to send a non-rfc one before this t=
est
can pass.

>=20
> [auto build test ERROR on media-tree/master]
> [also build test ERROR on rockchip/for-next linus/master v6.1 next-202212=
19]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/=
AV1-stateless-decoder-for-RK3588/20221220-000013
> base:   git://linuxtv.org/media_tree.git master
> patch link:    https://lore.kernel.org/r/20221219155616.848690-3-benjamin=
.gaignard%40collabora.com
> patch subject: [PATCH v1 2/9] media: verisilicon: Add AV1 decoder mode an=
d controls
> config: m68k-allmodconfig
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/d60040964a6a110a1=
d3a9af3794c27e25a24182d
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Benjamin-Gaignard/AV1-stateless-=
decoder-for-RK3588/20221220-000013
>         git checkout d60040964a6a110a1d3a9af3794c27e25a24182d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dm68k olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dm68k SHELL=3D/bin/bash drivers/media/
>=20
> If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
> > > drivers/media/platform/verisilicon/hantro_drv.c:504:31: error: 'V4L2_=
CID_STATELESS_AV1_FRAME' undeclared here (not in a function); did you mean =
'V4L2_CID_STATELESS_VP9_FRAME'?
>      504 |                         .id =3D V4L2_CID_STATELESS_AV1_FRAME,
>          |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                               V4L2_CID_STATELESS_VP9_FRAME
> > > drivers/media/platform/verisilicon/hantro_drv.c:509:31: error: 'V4L2_=
CID_STATELESS_AV1_TILE_GROUP_ENTRY' undeclared here (not in a function)
>      509 |                         .id =3D V4L2_CID_STATELESS_AV1_TILE_GR=
OUP_ENTRY,
>          |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> > > drivers/media/platform/verisilicon/hantro_drv.c:510:35: error: 'V4L2_=
AV1_MAX_TILE_COUNT' undeclared here (not in a function)
>      510 |                         .dims =3D { V4L2_AV1_MAX_TILE_COUNT },
>          |                                   ^~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/media/platform/verisilicon/hantro_drv.c:515:31: error: 'V4L2_=
CID_STATELESS_AV1_SEQUENCE' undeclared here (not in a function); did you me=
an 'V4L2_CID_STATELESS_MPEG2_SEQUENCE'?
>      515 |                         .id =3D V4L2_CID_STATELESS_AV1_SEQUENC=
E,
>          |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                               V4L2_CID_STATELESS_MPEG2_SEQUENC=
E
> > > drivers/media/platform/verisilicon/hantro_drv.c:520:31: error: 'V4L2_=
CID_STATELESS_AV1_FILM_GRAIN' undeclared here (not in a function); did you =
mean 'V4L2_CID_STATELESS_VP9_FRAME'?
>      520 |                         .id =3D V4L2_CID_STATELESS_AV1_FILM_GR=
AIN,
>          |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>          |                               V4L2_CID_STATELESS_VP9_FRAME
>=20
>=20
> vim +504 drivers/media/platform/verisilicon/hantro_drv.c
>=20
>    338=09
>    339	#define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 |=
 \
>    340						 V4L2_JPEG_ACTIVE_MARKER_COM | \
>    341						 V4L2_JPEG_ACTIVE_MARKER_DQT | \
>    342						 V4L2_JPEG_ACTIVE_MARKER_DHT)
>    343=09
>    344	static const struct hantro_ctrl controls[] =3D {
>    345		{
>    346			.codec =3D HANTRO_JPEG_ENCODER,
>    347			.cfg =3D {
>    348				.id =3D V4L2_CID_JPEG_COMPRESSION_QUALITY,
>    349				.min =3D 5,
>    350				.max =3D 100,
>    351				.step =3D 1,
>    352				.def =3D 50,
>    353				.ops =3D &hantro_jpeg_ctrl_ops,
>    354			},
>    355		}, {
>    356			.codec =3D HANTRO_JPEG_ENCODER,
>    357			.cfg =3D {
>    358				.id =3D V4L2_CID_JPEG_ACTIVE_MARKER,
>    359				.max =3D HANTRO_JPEG_ACTIVE_MARKERS,
>    360				.def =3D HANTRO_JPEG_ACTIVE_MARKERS,
>    361				/*
>    362				 * Changing the set of active markers/segments also
>    363				 * messes up the alignment of the JPEG header, which
>    364				 * is needed to allow the hardware to write directly
>    365				 * to the output buffer. Implementing this introduces
>    366				 * a lot of complexity for little gain, as the markers
>    367				 * enabled is already the minimum required set.
>    368				 */
>    369				.flags =3D V4L2_CTRL_FLAG_READ_ONLY,
>    370			},
>    371		}, {
>    372			.codec =3D HANTRO_MPEG2_DECODER,
>    373			.cfg =3D {
>    374				.id =3D V4L2_CID_STATELESS_MPEG2_SEQUENCE,
>    375			},
>    376		}, {
>    377			.codec =3D HANTRO_MPEG2_DECODER,
>    378			.cfg =3D {
>    379				.id =3D V4L2_CID_STATELESS_MPEG2_PICTURE,
>    380			},
>    381		}, {
>    382			.codec =3D HANTRO_MPEG2_DECODER,
>    383			.cfg =3D {
>    384				.id =3D V4L2_CID_STATELESS_MPEG2_QUANTISATION,
>    385			},
>    386		}, {
>    387			.codec =3D HANTRO_VP8_DECODER,
>    388			.cfg =3D {
>    389				.id =3D V4L2_CID_STATELESS_VP8_FRAME,
>    390			},
>    391		}, {
>    392			.codec =3D HANTRO_H264_DECODER,
>    393			.cfg =3D {
>    394				.id =3D V4L2_CID_STATELESS_H264_DECODE_PARAMS,
>    395			},
>    396		}, {
>    397			.codec =3D HANTRO_H264_DECODER,
>    398			.cfg =3D {
>    399				.id =3D V4L2_CID_STATELESS_H264_SPS,
>    400				.ops =3D &hantro_ctrl_ops,
>    401			},
>    402		}, {
>    403			.codec =3D HANTRO_H264_DECODER,
>    404			.cfg =3D {
>    405				.id =3D V4L2_CID_STATELESS_H264_PPS,
>    406			},
>    407		}, {
>    408			.codec =3D HANTRO_H264_DECODER,
>    409			.cfg =3D {
>    410				.id =3D V4L2_CID_STATELESS_H264_SCALING_MATRIX,
>    411			},
>    412		}, {
>    413			.codec =3D HANTRO_H264_DECODER,
>    414			.cfg =3D {
>    415				.id =3D V4L2_CID_STATELESS_H264_DECODE_MODE,
>    416				.min =3D V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
>    417				.def =3D V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
>    418				.max =3D V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
>    419			},
>    420		}, {
>    421			.codec =3D HANTRO_H264_DECODER,
>    422			.cfg =3D {
>    423				.id =3D V4L2_CID_STATELESS_H264_START_CODE,
>    424				.min =3D V4L2_STATELESS_H264_START_CODE_ANNEX_B,
>    425				.def =3D V4L2_STATELESS_H264_START_CODE_ANNEX_B,
>    426				.max =3D V4L2_STATELESS_H264_START_CODE_ANNEX_B,
>    427			},
>    428		}, {
>    429			.codec =3D HANTRO_H264_DECODER,
>    430			.cfg =3D {
>    431				.id =3D V4L2_CID_MPEG_VIDEO_H264_PROFILE,
>    432				.min =3D V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
>    433				.max =3D V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
>    434				.menu_skip_mask =3D
>    435				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
>    436				.def =3D V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
>    437			}
>    438		}, {
>    439			.codec =3D HANTRO_HEVC_DECODER,
>    440			.cfg =3D {
>    441				.id =3D V4L2_CID_STATELESS_HEVC_DECODE_MODE,
>    442				.min =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
>    443				.max =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
>    444				.def =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
>    445			},
>    446		}, {
>    447			.codec =3D HANTRO_HEVC_DECODER,
>    448			.cfg =3D {
>    449				.id =3D V4L2_CID_STATELESS_HEVC_START_CODE,
>    450				.min =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
>    451				.max =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
>    452				.def =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
>    453			},
>    454		}, {
>    455			.codec =3D HANTRO_HEVC_DECODER,
>    456			.cfg =3D {
>    457				.id =3D V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
>    458				.min =3D V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
>    459				.max =3D V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
>    460				.def =3D V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
>    461			},
>    462		}, {
>    463			.codec =3D HANTRO_HEVC_DECODER,
>    464			.cfg =3D {
>    465				.id =3D V4L2_CID_MPEG_VIDEO_HEVC_LEVEL,
>    466				.min =3D V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
>    467				.max =3D V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1,
>    468			},
>    469		}, {
>    470			.codec =3D HANTRO_HEVC_DECODER,
>    471			.cfg =3D {
>    472				.id =3D V4L2_CID_STATELESS_HEVC_SPS,
>    473				.ops =3D &hantro_ctrl_ops,
>    474			},
>    475		}, {
>    476			.codec =3D HANTRO_HEVC_DECODER,
>    477			.cfg =3D {
>    478				.id =3D V4L2_CID_STATELESS_HEVC_PPS,
>    479			},
>    480		}, {
>    481			.codec =3D HANTRO_HEVC_DECODER,
>    482			.cfg =3D {
>    483				.id =3D V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
>    484			},
>    485		}, {
>    486			.codec =3D HANTRO_HEVC_DECODER,
>    487			.cfg =3D {
>    488				.id =3D V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
>    489			},
>    490		}, {
>    491			.codec =3D HANTRO_VP9_DECODER,
>    492			.cfg =3D {
>    493				.id =3D V4L2_CID_STATELESS_VP9_FRAME,
>    494				.ops =3D &hantro_vp9_ctrl_ops,
>    495			},
>    496		}, {
>    497			.codec =3D HANTRO_VP9_DECODER,
>    498			.cfg =3D {
>    499				.id =3D V4L2_CID_STATELESS_VP9_COMPRESSED_HDR,
>    500			},
>    501		}, {
>    502			.codec =3D HANTRO_AV1_DECODER,
>    503			.cfg =3D {
>  > 504				.id =3D V4L2_CID_STATELESS_AV1_FRAME,
>    505			},
>    506		}, {
>    507			.codec =3D HANTRO_AV1_DECODER,
>    508			.cfg =3D {
>  > 509				.id =3D V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY,
>  > 510				.dims =3D { V4L2_AV1_MAX_TILE_COUNT },
>    511			},
>    512		}, {
>    513			.codec =3D HANTRO_AV1_DECODER,
>    514			.cfg =3D {
>  > 515				.id =3D V4L2_CID_STATELESS_AV1_SEQUENCE,
>    516			},
>    517		}, {
>    518			.codec =3D HANTRO_AV1_DECODER,
>    519			.cfg =3D {
>  > 520				.id =3D V4L2_CID_STATELESS_AV1_FILM_GRAIN,
>    521			},
>    522		},
>    523	};
>    524=09
>=20

