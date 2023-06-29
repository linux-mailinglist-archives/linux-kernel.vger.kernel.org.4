Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1255B742498
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjF2LAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjF2LAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:00:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D377F10CF;
        Thu, 29 Jun 2023 04:00:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668842bc50dso140252b3a.1;
        Thu, 29 Jun 2023 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688036403; x=1690628403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNuvCv0VFWJ1T/BA1jgFsWK/sbewukgBLN8NThITlGY=;
        b=IJJG70VRTfv6SzZDiw5KgcGaeym0vz6jCVdSX8aL1AtgKYxIKxEz+FbieZyrRKMKt6
         XCNCfb6e0kP4qrLVYCOdleUjQ0iPjzq7WtSDVVd1E/SnYE0lqHji5iXyEH54McdjI3Q6
         aGP09g3gRxxOG3bTuanQqLSGUYvKcsHm5AbgJBGY2+BeZSDjm6FHWKrH5NokTFFFcK4n
         5M0DelgYVruwm87q4YsvLXl0PCpvA7mJRxPfLrw0EJJgh1S2hE6eMETfer+m2znDNGz+
         rx7t9Pn79B0zCEhWoBBcJnDez2ncEfQAzyDnYf6kYmZsBkPiLUqjN+/nFgPhNsy3lsLQ
         N82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688036403; x=1690628403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNuvCv0VFWJ1T/BA1jgFsWK/sbewukgBLN8NThITlGY=;
        b=KWzZCwbaT209fAl8th0nAIu0bNdo1MY7Ps4H5przFHLuXZn7iCGX490QCj7E08q+M5
         tr0r2OZPjO45NTSuDNTePbuVplXAZTPn1qdLhGBfMxlJpnJI3SgAMawHV5pfKKtkNUxh
         De7UL6S1IztOzZICZJDctxw9YSkkOLEhPD96S6XHgrgVaNH7BhbG7mp6yNeqe60P3ZA5
         TftvmETrxhDHSeicqhSrjTaqVTraFzgFouH4u3Wz+7jjLgH47AdDhzi7GMOBFzT8I5T1
         tuC6XZAGg+CoDGbVH6LYUFi+pcutHIdVlIP8/9VCyGmoOrPEjrGvFdmD19O01hGWNfcI
         HYjw==
X-Gm-Message-State: AC+VfDyL4H5W2iM4VnvmwvCC/BCia23SHtfiaTkp50aeXSmFovs8hG3H
        vK4Gh+TJxtuqjccALnQxG87xXwfeJY6ZfReYWoE=
X-Google-Smtp-Source: ACHHUZ4241Q0Xok00mtSesZ0ScAf8EpY8gqClpDPFmqvjMGqm+Sl0vzMI5IyImuqQIvVL0JNHSy7d4g+Mx22zwDE2r4=
X-Received: by 2002:a05:6a20:7295:b0:111:fba0:bd3b with SMTP id
 o21-20020a056a20729500b00111fba0bd3bmr45440823pzk.1.1688036403198; Thu, 29
 Jun 2023 04:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com> <1688002673-28493-4-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1688002673-28493-4-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 29 Jun 2023 07:59:53 -0300
Message-ID: <CAOMZO5DPHmm7YuHBfYHpx2-g4R6t1BQ93GBAZvyyb_rBz7+hFg@mail.gmail.com>
Subject: Re: [PATCH 3/6] ASoC: fsl_easrc: define functions for memory to
 memory usage
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Wed, Jun 28, 2023 at 11:10=E2=80=AFPM Shengjiu Wang <shengjiu.wang@nxp.c=
om> wrote:
>
> ASRC can be used on memory to memory case, define several
> functions for m2m usage and export them as function pointer.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Could you please explain what is the benefit of using M2M in the EASRC driv=
er?

A few weeks ago, an imx8mn user reported that the EASRC with the
mainline kernel introduces huge delays.

Does M2M help with this aspect?

Thanks
