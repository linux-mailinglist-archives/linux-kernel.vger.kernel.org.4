Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2886F6B5152
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCJUBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCJUBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:01:40 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66100126F07
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:01:15 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id o199so4602828ybc.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678478474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0d1xsr+DN56cc9eqodWxWKDt8Iv1tRk/OI0c43Ndtg=;
        b=LAaS3pGI1Osaw4DtM3xeC30oH8sKranbYZeTuX8Vzg49M1/mogrhIPfN2T0wDRdeeE
         5xXqWispLmk8ataNHf89gxmqI1sRX90bKlCMDkQ2rQuuRZZVIjkRXT7wuexDjrnlzxOp
         SL5Ml0goazrs5/ZxLvoGhlAzOQKWoNmxzP6wCtgJE/SJWvkluD2j+q5vKMNd6Ds4/8kV
         lHg/ZptYboP8N1F6NUu1GyUuTFBQlZq+edJNQNiutMdBmaSTndrAgaqshELwMh/yT/Ym
         4XY4QVmbeXeGdC96syMjBHY+EN1FojDTRGonTCLATsANiI3gsl5/7t4egfdmjQb+kfA5
         yWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678478474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0d1xsr+DN56cc9eqodWxWKDt8Iv1tRk/OI0c43Ndtg=;
        b=3+1xeguXi825+VpNc+mt/tEMvvWc6Dyec3QEO/6IFpVLXmH4Rn9ck2xa3PUaxxYG6i
         JptNeaIir8lP5e0VX5Z/4uBbQvmZJY06mO2XneolzmCzNmzUdGOgQpu8KzECA+N8V1BB
         YH1gppni+KOKdQrc8uAuAlHCX+eGeBA+CF5pDd7HGtP1swMZKssqecgQzqNKo+wDUz+v
         f0Hp82LprS9r+XVXlsjWlgZvgpXP5EVz4auM3rf9GpMWGlhp3m4wTAzJESH0EJfmhe9I
         Xxu5O1KFw1Z5OW3UHBzBUbh7AIdawyoM1ZfLyT6k98PdyKwo5MFNteTuD+ROv8FuMBJd
         j4+g==
X-Gm-Message-State: AO0yUKWL60AxPhDXbY3Zb12Bu6t4hV78obqpRDi50jmOUDWXQXDwYsOm
        ZSya5zteWztU5/ZV5SnGpyRF1T9ThU1csJv1Rzsg4Php0Py7QBqAERo=
X-Google-Smtp-Source: AK7set8PzWChg34BeGJ/K5IA6aQA2R2lLiu+Zi+vILRV/LYxe7V78GhtoR7rdp12bBuHtALcNwqoV++zKjgV3CrYDl4=
X-Received: by 2002:a05:6902:4c3:b0:a6a:3356:6561 with SMTP id
 v3-20020a05690204c300b00a6a33566561mr13400434ybs.1.1678478473984; Fri, 10 Mar
 2023 12:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20230310184201.1302232-1-ajye_huang@compal.corp-partner.google.com>
 <0456bd4e-cfee-b863-e02d-98084b5da0f6@linux.intel.com>
In-Reply-To: <0456bd4e-cfee-b863-e02d-98084b5da0f6@linux.intel.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Sat, 11 Mar 2023 04:01:03 +0800
Message-ID: <CALprXBamM-M-YdyfX9dQHp_AQAovcqzL5H4rMPsZPXS426+VgA@mail.gmail.com>
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

On Sat, Mar 11, 2023 at 2:48=E2=80=AFAM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> This sounds good, but if the intent is to have BT offload enabled across
> all ADL skews there are still misses, e.g.
>
> .name =3D "adl_mx98357_rt5682",
>
> Can we please try to add this BT offload in a more consistent manner, or
> add a comment when this is officially not planned/supported?

Hi Pierre,

The "sof-adl-rt1019-rt5682.tplg" for this "adl_rt1019_rt5682" sound
card also need to enable bt_offload, this one I will submit to SOF
later this weekend.
ex, topology: sof-adl-rt1019-rt5682: add bluetooth offload uses SSP2
link -- https://github.com/ajye-huang/sof/commit/09dcbc3cc1617df652944299c6=
3082f1936dea6e

To be more clear, I think we can add a comment in the commit message
for mention " The related "sof-adl-rt1019-rt5682.tplg" enabled the
bt_offload feature", is it ok?
