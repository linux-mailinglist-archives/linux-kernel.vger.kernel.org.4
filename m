Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEBB6B560F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjCJXzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCJXze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:55:34 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825D7E91B6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:55:33 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536c2a1cc07so128617637b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678492532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6T67u9qiBnxZK6yM+YE+DE3Z4ixj9FN+kLodEfozavM=;
        b=RLWyNTcIDMRGSZ+TsJzdSAzJ6T/VlanZ3KjZiaA2sfAGKhQ2BYbFuyfBvU5J8CpToR
         IZ8Zf7BvaD6mFfZDk6FhKtNcH96fuMosd7vE0oLxV7UhuQKdPIt6MKTTmfXjW3fmcrkW
         rSr5z40iwsjAD3pA5oY0qSc7ymGgmFhcPJD9FL31mndm2mAorsL8W12ubC6fz24Cs/Ji
         rkO5p601WN9sGGdMwjExj0+SeJ7sUE7foH1RMwa+ZtKndOj6JFf90mkKumNzMxnVginZ
         cqvd94WXC+7AWF2VqDzQp7E7Au+9IrmmSZ8Be5aWLY8CAkoomT1acmVnPpKNw/MmMgF0
         4ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678492532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6T67u9qiBnxZK6yM+YE+DE3Z4ixj9FN+kLodEfozavM=;
        b=p1unXFTdDzz8zKwIMZU57qm5BIgNovcMPAreT7ST46FpZewaPXLY+sOKDuq4C3IKMS
         fIImXzhyDj0eI/h4dKRfIXiiqgCNPw9GtPAE/bvJhH/nc/z/P1EyCvmfLTwnrJlZ4Zem
         4yxxIqAwdRtHIt+e3WEAnsMK3LsVUIfqtfv+XzC6VahY1Ogh+yZss0mesIRxS+hz7/YW
         Qe3LObX3WwqhebRmVxrMUpoNRnpHo5M8/QA2Tjc7Gi7JXt4zSgYz+2/SWWXzbUGasOVJ
         PEbPCo/SvMO4pWGb2c3rrET9cqPZ6LunvEMJlPcsq1y0lFRQbilPGu5AttITBPLRa8DD
         UKVA==
X-Gm-Message-State: AO0yUKVEGsF3+jf5f3T3iI6v4lU409eyhqDpx/wvp9/LnVSXhEX3Dm0R
        JouElpPDLecp3Ch+CWwbUWkJMlChBWoIKpIlW51+MQ==
X-Google-Smtp-Source: AK7set+wPxRik1vLXVOjZi47R3V+MThG93j9VO8C8SGLknV/y5pCvR1I7B5rqUkSyw2LwpPfYM/GuR7RJVFVs34KesI=
X-Received: by 2002:a81:af4e:0:b0:521:db3f:9e27 with SMTP id
 x14-20020a81af4e000000b00521db3f9e27mr17774983ywj.2.1678492532641; Fri, 10
 Mar 2023 15:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20230310184201.1302232-1-ajye_huang@compal.corp-partner.google.com>
 <0456bd4e-cfee-b863-e02d-98084b5da0f6@linux.intel.com> <CALprXBamM-M-YdyfX9dQHp_AQAovcqzL5H4rMPsZPXS426+VgA@mail.gmail.com>
 <a5962d12-ccd2-79ea-27bc-674e0b3065f4@linux.intel.com>
In-Reply-To: <a5962d12-ccd2-79ea-27bc-674e0b3065f4@linux.intel.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Sat, 11 Mar 2023 07:55:21 +0800
Message-ID: <CALprXBYVFWDFkT5tnrj6Ef=+ibFLoBAnCnBHtZwSThDauN=uzw@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: Intel: sof_rt5682: Enable Bluetooth offload on adl_rt1019_rt5682
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, dharageswari.r@intel.com,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        alsa-devel@alsa-project.org, Mac Chiang <mac.chiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 6:46=E2=80=AFAM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>

> It's best if you provide a series that enables BT offload across the
> board for ADL, if that's the intended goal.
Hi Pierre,

  {        .name =3D "adl_mx98357_rt5682",
        .driver_data =3D (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
                    SOF_RT5682_SSP_CODEC(0) |
                    SOF_SPEAKER_AMP_PRESENT |
                    SOF_RT5682_SSP_AMP(2) |
                    SOF_RT5682_NUM_HDMIDEV(4)),
    },
The "adl_mx98357_rt5682" is the sound card of the google "Brya" Board proje=
ct.
Because the SSP2 is used for the max98357 amplifier, so SSP2
bt_offload can't be enabled at the drv_name  "adl_mx98357_rt5682".
(The hardway layout I2S port2 connected to max98357 amplifier)

The other adl projects that enabled the bt_offload feature were
designed with ssp1 for amp, ssp2 for bt_offload based on pins
definition.
    {
        .name =3D "adl_rt1019_rt5682",
        .driver_data =3D (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
                    SOF_RT5682_SSP_CODEC(0) |
                    SOF_SPEAKER_AMP_PRESENT |
                    SOF_RT1019_SPEAKER_AMP_PRESENT |
                    SOF_RT5682_SSP_AMP(1) |
                    SOF_RT5682_NUM_HDMIDEV(4) |
                    SOF_BT_OFFLOAD_SSP(2) |
                    SOF_SSP_BT_OFFLOAD_PRESENT),
    },
thanks
