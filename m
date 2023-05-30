Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22971635B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjE3ON5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjE3ONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D19EFE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D433630EB
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1BEC4339B;
        Tue, 30 May 2023 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685455984;
        bh=/UJDrMEFpBwl4/IycRYuBQqR/J8yidIWp4To2yuNJFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjJKbfLjLybK5h4UYXcP+3YhCW5SMzOQphTt7FNwwVcLGn4Uoczg6GbOJz1FL/ePf
         UE7kv5sNfKH34FoZsEoHcjSYS9kmsNPxe3xRgVhsF8cSE8b0qNE1PQBagsSJZUXXna
         yZoVROZOT/YrSsMN0fiRe2bL8vZGE7k/qgVpcJKeLeIABtvoMLnf1iV5hrqwZL5Hxg
         2R90YRjPaYplnUPHQu6rYYyHy0hZKFOZ2HTQtAhKEHOKT0JkNKd09fz7poA5FSrdms
         Pgto37pmCZbo01+nVNU9xi/pTi/RUF/Sk2edSMDJTaklr1ZdX7X61p2wFKI1YNK8VL
         j9/BMStvw9jSA==
Date:   Tue, 30 May 2023 15:12:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, yc.hung@mediatek.com,
        tinghan.shen@mediatek.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: SOF: mediatek: add adsp debug dump
Message-ID: <12f075ba-6886-4916-a62f-8fb004eeb4c9@sirena.org.uk>
References: <20230523025933.30494-1-trevor.wu@mediatek.com>
 <20230523025933.30494-3-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HZx043a6O9IOGZFz"
Content-Disposition: inline
In-Reply-To: <20230523025933.30494-3-trevor.wu@mediatek.com>
X-Cookie: <Manoj> I *like* the chicken
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HZx043a6O9IOGZFz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 10:59:33AM +0800, Trevor Wu wrote:
> Add mt8188 and mt8186 .dbg_dump callback to print some information when
> DSP panic occurs.

This breaks an x86_64 allmodconfig build:

/build/stage/linux/sound/soc/sof/mediatek/mt8186/mt8186.c: In function =E2=
=80=98mt8186_adsp_dump=E2=80=99:
/build/stage/linux/sound/soc/sof/mediatek/mt8186/mt8186.c:483:56: error: =
=E2=80=98DSP_PDEBUGDATA=E2=80=99 undeclared (first use in this function); d=
id you mean =E2=80=98DSP_PDEBUGPC=E2=80=99?
  483 |         dbg_data =3D snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUG=
DATA);
      |                                                        ^~~~~~~~~~~~=
~~
      |                                                        DSP_PDEBUGPC
/build/stage/linux/sound/soc/sof/mediatek/mt8186/mt8186.c:483:56: note: eac=
h undeclared identifier is reported only once for each function it appears =
in
/build/stage/linux/sound/soc/sof/mediatek/mt8186/mt8186.c:484:56: error: =
=E2=80=98DSP_PDEBUGINST=E2=80=99 undeclared (first use in this function); d=
id you mean =E2=80=98DSP_PDEBUGPC=E2=80=99?
  484 |         dbg_inst =3D snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUG=
INST);
      |                                                        ^~~~~~~~~~~~=
~~
      |                                                        DSP_PDEBUGPC
/build/stage/linux/sound/soc/sof/mediatek/mt8186/mt8186.c:485:59: error: =
=E2=80=98DSP_PDEBUGLS0STAT=E2=80=99 undeclared (first use in this function)
  485 |         dbg_ls0stat =3D snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDE=
BUGLS0STAT);
      |                                                           ^~~~~~~~~=
~~~~~~~~
/build/stage/linux/sound/soc/sof/mediatek/mt8186/mt8186.c:486:58: error: =
=E2=80=98DSP_PDEBUGSTATUS=E2=80=99 undeclared (first use in this function);=
 did you mean =E2=80=98DSP_PDEBUGPC=E2=80=99?
  486 |         dbg_status =3D snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEB=
UGSTATUS);
      |                                                          ^~~~~~~~~~=
~~~~~~
      |                                                          DSP_PDEBUG=
PC
/build/stage/linux/sound/soc/sof/mediatek/mt8186/mt8186.c:487:57: error: =
=E2=80=98DSP_PFAULTINFO=E2=80=99 undeclared (first use in this function)
  487 |         faultinfo =3D snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PFAUL=
TINFO);
      |                                                         ^~~~~~~~~~~=
~~~

--HZx043a6O9IOGZFz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR2BGgACgkQJNaLcl1U
h9Avzwf9FLeppnZUZA1Mmi2j/Dqy5Rxq8OrPGUDqqTTdwOLmJC6luZkDAsRedhwW
MsBawXkxc2BfO4ytooYHkRL9BcUiQ/ZgZ1wHkH/bpJJdKW+qQjiSUN9jG5qZAPIl
rte+OUXbWHcXGdnfGqLGT7QGzCwr9mSsmqWCVdQcKsR2rT9Xs/Guh9DjQlTICeb5
a+cRmthy1DPKwBu/QFT6J53w7mgWpRzby6qxkP2KFCAiY+QgCFjR2onFVnzEurT6
GzeNZdW2+U8A9nStkaXQbyrqqYaZXMvZS3w0sdinJv3LjUnknGqPVuxMU1h4nEAl
aLnuYTOkWcXKcWSZ+3/8Yy6wsv3weQ==
=qgu/
-----END PGP SIGNATURE-----

--HZx043a6O9IOGZFz--
