Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8FE69E1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjBUN5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjBUN5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:57:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548862A980;
        Tue, 21 Feb 2023 05:57:35 -0800 (PST)
Received: from ideasonboard.com (host-87-16-53-160.retail.telecomitalia.it [87.16.53.160])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2EA61519;
        Tue, 21 Feb 2023 14:57:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1676987853;
        bh=jpHQRZlW4o49GCucGmzwL3i5f+RGD1N3eNLklO3dM30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSeB7qlTK6/ypFDpsNffIpRKZZPgzlXRnQ9kzKubtuIjylKlAI33RX93Z2nxCPQKV
         yOfR/mEEa5e6DL8VIADtHan6aGv4RnZdXel6hA185qBKbbYWKhEwAETZXI+XlBn6re
         kXhJuEyVg8FV8SxFLv8r6l3h77XgZf6MNna/CI7A=
Date:   Tue, 21 Feb 2023 14:57:30 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] media: rkisp1: Miscellaneous improvements
Message-ID: <20230221135730.zyfg3ainjg7btfzv@uno.localdomain>
References: <20221117084217.3892680-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221117084217.3892680-1-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, Nov 17, 2022 at 05:42:14PM +0900, Paul Elder wrote:
> This patch series adds small improvements to the rkisp1 driver:
> - Add NV16M and NV61M output
> - Implement ENUM_FRAMESIZES
>
> As well as a small code cleanup.
>
> These patches have been sent before individually, so really this is a
> resend, which also bunches them together.
>
> Laurent Pinchart (1):
>   media: rkisp1: Make local immutable array variables static const
>
> Paul Elder (2):
>   media: rkisp1: Add NV16M and NV61M to output formats
>   media: rkisp1: Implement ENUM_FRAMESIZES

Has this series fell into cracks ? Support for VIDIOC_ENUM_FRAMESIZES
in particular is a relevant feature and seems not controversial at all...

>
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 64 +++++++++++++++++--
>  1 file changed, 60 insertions(+), 4 deletions(-)
>
> --
> 2.35.1
>
