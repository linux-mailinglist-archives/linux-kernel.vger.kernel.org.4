Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3176C6EF92D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjDZRTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjDZRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:19:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79D83C0;
        Wed, 26 Apr 2023 10:18:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-504dfc87927so12468120a12.0;
        Wed, 26 Apr 2023 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682529524; x=1685121524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ONW0oJVWSoUBVfiqHRCVrTCeWcgXxbQuXXe0i/cIxeg=;
        b=QCP4pjsI+KMpErUv2KHP+WFJKiDCSOb9wfSOlME9HPtVT3YQrve5xDxLMYVqCYREb3
         q7vMsOJtORD84C7fU1fHgEKvvcHbwEPUDTkcy3b5Z0xge54ZGyYAwk5MJFseEXy4cygR
         c2XF5/N9BoxkpmcpQ4Nk2ZpdQwMVglqkO4Cp8jvtL0gNCemBbn4AxR5nSHk0cL9uQ+Vz
         lv08QTyZJh/qtFKE7aIHN8+TbLsOqqVd0mX0utlV0SuR/1A+WXtIf7p3B4iA4pBGRa2q
         RZAIv4C6CzzJWBIou8jibQK4kcEV4fZypFH+mqdsSfl1DKGFJmplXiU5IBVyvhetqABH
         W+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682529524; x=1685121524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONW0oJVWSoUBVfiqHRCVrTCeWcgXxbQuXXe0i/cIxeg=;
        b=IoVJgjZxLd4qViVk47avb5WdtsHXheu+mTIZSxpR2vX6M4g3hpepIEtSBZfaUEzxEc
         NVmDFmwTeWgnDnTFenISHjtjfkaEgdzmRlX/0mWGv2ODD5KjXE8dLwvzVZnpiH+kUgyj
         J4I4TNVovB8nnUr3d2Bt5CeZtCPP3NUBY5sKZknnoAqPFU2c6Xtie0aTA/TEbRPBkrVw
         RjYabJGBuf/Cw+It48D5pSarZc36F7h29blcVQsOWFfVzSs3MixcaUmvMqHZE7igcJMz
         Uw3Ccl9fy6mfEyjqV9oLcPg3+Ai8loX1mV7vTDImn8t/K6gUv/UYqNpEQFqHkBL1tGJA
         xYKQ==
X-Gm-Message-State: AAQBX9dXE7PjEbe2Z8jMMBzceWtK3loPAOnVt/+1G/pso5pvW5GMkly4
        ozwOjG76u9tHD3yPivF/8F4ROgZcU0Ba768c4x9v0CZtqc0=
X-Google-Smtp-Source: AKy350Yw9Kt6V1tkerg378jcGQk1TLSJq2gv6qOGyIQwcfUjI33mP8mWEEbwHsOa53OK3u/FVUJ/2WAml4WU7nLTln8=
X-Received: by 2002:a50:ff02:0:b0:506:9220:b149 with SMTP id
 a2-20020a50ff02000000b005069220b149mr19104739edu.26.1682529524373; Wed, 26
 Apr 2023 10:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <ZElaVmxDsOkZj2DK@debian>
In-Reply-To: <ZElaVmxDsOkZj2DK@debian>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 26 Apr 2023 18:18:08 +0100
Message-ID: <CADVatmOVqyQE7LDDu7xgfbsOFnQJEzBRqxeL5-i8W-_drR8OYw@mail.gmail.com>
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 at 18:07, Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The latest mainline kernel branch fails to build xtensa, mips, arm allmodconfig
> with the error:
>
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: In function 'mxc_isi_channel_set_inbuf':
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:33:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
>    33 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: In function 'mxc_isi_channel_set_outbuf':
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:51:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
>    51 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:66:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
>    66 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> git bisect pointed to cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")

Also, riscv allmodconfig with the error:

drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:328:12: error:
'mxc_isi_pm_resume' defined but not used [-Werror=unused-function]
  328 | static int mxc_isi_pm_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~
drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:314:12: error:
'mxc_isi_pm_suspend' defined but not used [-Werror=unused-function]
  314 | static int mxc_isi_pm_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~


-- 
Regards
Sudip
