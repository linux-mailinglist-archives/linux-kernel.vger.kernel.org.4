Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5132A74B301
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjGGOZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGGOZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:25:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459B91BF4;
        Fri,  7 Jul 2023 07:25:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51f64817809so169850a12.1;
        Fri, 07 Jul 2023 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688739933; x=1691331933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQpNcExAidhzmAX5mqxwLcDsKlQH76X8tAmxgxEbLeo=;
        b=l5seuOELr9PbN56mqnFpaie+nQdyY1U6mLT8l150oxhmcxmxMqg3eKPPJr4PGBq427
         wKT4yw9vd5loszISHhtN++aOVV5UA384h9mSgydVrKshsS7eJ11kGlhWwufK4TkRRWoO
         GpGBjlliXyldKCd1aWrfeQPqzbENOxkkdrDRkl4NCLRbWzLQA8FGGi2NA1z6yF4ybHM8
         BFRooaMtnd8Q+amOhNewi+F813WJabQJC2CoyP6hrA+ShSLAJRzFS55hvHbPUBDODLhs
         lcHo4/RVsiWuNk0cq4OQSBIF18WHBl1sEZWzBA6tfFdcIvhk1TfElJO8oQ4PZTz4WfZv
         OBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739933; x=1691331933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQpNcExAidhzmAX5mqxwLcDsKlQH76X8tAmxgxEbLeo=;
        b=Zk9U5321TKea13GaYPKUvO0Q8liY2+swUY6QauKy8iXJGW0ev5zpO1QAHx+oDe92Cv
         yrPsN35GbBsTXpu5AKvElCl54RgQNDrE5loiCvAwhal+w3Y+5xBJHBLxW2UPIwrme1w2
         ZxjpVJwZM5lSMppN1fFWcvyi57CwYXjJAucRU34LYLAklEbFQeWH+mDYQus/2B9Q3ory
         QuTrRbhZa05IwLGotRxbwodJJZRJ14p5P3KT7tlhinPLsOeD6YLuUF94y9Iyw6Ufz+wm
         O2WD97uxw+TM7d8HgHD6XDWsa4+acdl+PagnosJKX2jTh5xDX85IO3ivBQGEqeY8XNqx
         a46Q==
X-Gm-Message-State: ABy/qLbyef/wAqJdFKjEJPk1Zv2lnxcMN3RgIH04+DVq2sn1JpBhgp0E
        NnKyVW9wFYjXeVRF75zk8IUGNLZRF0beoBOBLh4=
X-Google-Smtp-Source: APBJJlESBbs9wkXuxpVQznKynwcE2DrR/fZtA95YOu2obH1Joa40EV6F61/CS41emPirlQMCL8XsVTkoPNSgohWR4Mc=
X-Received: by 2002:a05:6a20:54a9:b0:12d:77e:ba3 with SMTP id
 i41-20020a056a2054a900b0012d077e0ba3mr6417452pzk.0.1688739932697; Fri, 07 Jul
 2023 07:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org> <20230707140434.723349-7-ulf.hansson@linaro.org>
In-Reply-To: <20230707140434.723349-7-ulf.hansson@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 7 Jul 2023 11:25:22 -0300
Message-ID: <CAOMZO5Df5bHGy6-kTKwysSe6Kp7e2HNn+uhOD2E6MT+cDkS07A@mail.gmail.com>
Subject: Re: [PATCH 06/18] soc: imx: Move power-domain drivers to the genpd dir
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        linux-imx@nxp.com
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

On Fri, Jul 7, 2023 at 11:04=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: <kernel@pengutronix.de>
> Cc: <linux-imx@nxp.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

A commit log explaining the motivation would be helpful here.

With that added:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
