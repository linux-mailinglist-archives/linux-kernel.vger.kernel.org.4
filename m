Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1082968990B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjBCMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjBCMuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:50:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034639B6F1;
        Fri,  3 Feb 2023 04:50:03 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bk15so15005076ejb.9;
        Fri, 03 Feb 2023 04:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FbZNAOe9nE81wTBy38C/SlzlxO15bflSJn2t1Jhsuek=;
        b=kqUUVtiNYDQ5ecq33zNLQ0Xo5ua4Mw4bn00uOyV54r3+RbJR1hGAJfHVz0jHdqLxrH
         C5jpGb3mEVttAaZyDvnXod+3rsuvLn7xxEk8MFP392dv+m9kprrJ9mS8WqfX0QURoOEr
         AyZcToVBJTxL8wyTTrC1K+m0pck/IelaN34BCXN8Y3CwhtRlK/ugXwNQh6Yzl4fDvgFW
         2HsFFMz6xa+2o0wzLQ6kBCXBweMzcpuxV0MdvM9RTchLBSjr7z4XqIeEhvVcI0XR80tJ
         RmKqtEETejsHWHOAYv2jRETG+MalCYnfxp/l+sAx2m8cyWT5DMXJIHGpsEG1N5HecqNu
         dRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbZNAOe9nE81wTBy38C/SlzlxO15bflSJn2t1Jhsuek=;
        b=K04fDgvRDEu2HG8yXTHn2sXyjAxORTVFlpFWCc3CmRYbUxch5CWBYsnBdZgOPZ+tFd
         /3qqv+mSoQWHO1dalok4fBdxWn64SJqN6pro2bPStrexHtfwfMqIX7Tx7iIN8vPcfnek
         4dQsWrKHbWVXwG7Ua4410xSb1s8o9g1tkxQE3AUnNj3m3JkVdkBt/7i9bPhFjzkDFHT8
         haiTjHCvN2YNnqxFg9qfadnXecGL8QQC61NGPomn7PF+tNy+xnWmsTKSIIZRLGS/4lKz
         rOtdol0+8O/zAi35NBXTxnN2pHmx1FS6+/11lDGC2n3iqVMFrFCCA2sozDOfETEUtdTC
         kvLg==
X-Gm-Message-State: AO0yUKVbgpbqzNBGievd3295lh8t6bYKZMnDjCI4ofX1SIeDf4/IjxIV
        tZhwlDy8r81nod09OpWo4g7X4iuL4sEzcEY/DJ4=
X-Google-Smtp-Source: AK7set/lLw5qKlYgxvFzlbq0RE+e0TydGKJ8gIqi8HeKsmGXug+2HhfugxOcW1hg+A2Qc//LrEfpUgZu8BaRBLuDRZY=
X-Received: by 2002:a17:906:139b:b0:88c:1d3d:6fab with SMTP id
 f27-20020a170906139b00b0088c1d3d6fabmr2957579ejc.299.1675428601583; Fri, 03
 Feb 2023 04:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 3 Feb 2023 14:49:49 +0200
Message-ID: <CAEnQRZB4ZLWcz-2jqZ7UDFxc60U9BFu_QuV9AvRYdqvC=Y-zwg@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] remoteproc: imx_rproc: support firmware in DDR
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:26 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V2:
>  patch 4 is introduced for sparse check warning fix
>
> This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware could
> be in DDR, not just the default TCM.
>
> i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
> initial value could be got from firmware first section ".interrupts".
> i.MX93 is a bit different, it just needs the address of .interrupts
> section. NXP SDK always has .interrupts section.
>
> So first we need find the .interrupts section from firmware, so patch 1
> is to reuse the code of find_table to introduce a new API
> rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
>
> Patch 2 is introduce devtype for i.MX8M/93
>
> Although patch 3 is correct the mapping, but this area was never used
> by NXP SW team, we directly use the DDR region, not the alias region.
> Since this patchset is first to support firmware in DDR, mark this patch
> as a fix does not make much sense.
>
> patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing .interrupts
> section. Detailed information in each patch commit message.
>
> Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK

Hi Peng,

Few observations:

- bugfixes should come first in the series.
- in case we want to patches to be pushed back into stable releases
please add "Fixes: " tag.
