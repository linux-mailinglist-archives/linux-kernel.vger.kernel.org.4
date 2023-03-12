Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD12D6B654A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCLLO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCLLOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:14:21 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872081ACD7;
        Sun, 12 Mar 2023 04:14:20 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-69-167-nat.elisa-mobile.fi [85.76.69.167])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 29881814;
        Sun, 12 Mar 2023 12:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678619658;
        bh=esoQ0cbaM+JlB2dCfCmj/l+jfsi0kKRavRKVMZF10WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQrT9x7MB7ZDpgp9lpTAzAwJu//0SAKje+eGLQ0y1rluoLgQ/1ATZYUrvpXLgLrA/
         bYEbgRapqPF6DZk2JCJkju+FUNP9bRlNpY0GjRWmb9DV0DG4qDGRQvLG0e0t7ObAzJ
         gvCA1qyJaVGYAgPazkj9sJDsASjUdi03DbtqpVkw=
Date:   Sun, 12 Mar 2023 13:14:18 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v2 5/6] MAINTAINERS: Add Starfive Camera Subsystem driver
Message-ID: <20230312111418.GB2545@pendragon.ideasonboard.com>
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
 <20230310120553.60586-6-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310120553.60586-6-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Thank you for the patch.

On Fri, Mar 10, 2023 at 08:05:52PM +0800, Jack Zhu wrote:
> Add an entry for Starfive Camera Subsystem driver.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2e7ca5603c3..c67faea9f967 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19907,6 +19907,15 @@ M:	Ion Badulescu <ionut@badula.org>
>  S:	Odd Fixes
>  F:	drivers/net/ethernet/adaptec/starfire*
>  
> +STARFIVE CAMERA SUBSYSTEM DRIVER
> +M:	Jack Zhu <jack.zhu@starfivetech.com>
> +M:	Changhuang Liang <changhuang.liang@starfivetech.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/admin-guide/media/starfive_camss.rst
> +F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> +F:	drivers/media/platform/starfive/

You could also add the MAINTAINERS entry in patch 1/6, with just the
.yaml file to start with, and extend it in the patches that add more
files. Up to you, I don't mind much.

> +
>  STARFIVE DEVICETREES
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  S:	Maintained

-- 
Regards,

Laurent Pinchart
