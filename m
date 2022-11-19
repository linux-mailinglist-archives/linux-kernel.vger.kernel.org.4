Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716FC630C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 07:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiKSGdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 01:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKSGds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 01:33:48 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED1748F1;
        Fri, 18 Nov 2022 22:33:45 -0800 (PST)
Received: from pyrite.rasen.tech (unknown [IPv6:2001:268:c210:aac1:54ed:fa5d:b703:111a])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B9D3749;
        Sat, 19 Nov 2022 07:33:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668839623;
        bh=Ic82wUkZuLtGFavTFu6myb5mSBksTXz8qGgcf1Ma+h8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpOhL2sbe2n0TAY0Pz5xQPEHawykiv47TbHLlg/aFa1G5QPNWo/aYpwHXckBE3q1e
         WearvTYAR8U0LFWjLgjInOveUezMfJVX9h7zyxw3c7IVFe+cSPxtoHKlHXGQyDF1/D
         KzqDs2OFuyB+h7xaje0m0LfffojbjlV04y96VOfo=
Date:   Sat, 19 Nov 2022 15:33:32 +0900
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v3 02/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP
 example
Message-ID: <Y3h4vBWJRr7NkoPm@pyrite.rasen.tech>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-3-paul.elder@ideasonboard.com>
 <166877740033.1426068.13359373358036408238.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166877740033.1426068.13359373358036408238.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 07:31:19AM -0600, Rob Herring wrote:
> 
> On Fri, 18 Nov 2022 18:39:19 +0900, Paul Elder wrote:
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Add an example to the rockchip-isp1 DT binding that showcases usage of
> > the parallel input of the ISP, connected to the CSI-2 receiver internal
> > to the i.MX8MP.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  .../bindings/media/rockchip-isp1.yaml         | 72 +++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/media/rockchip-isp1.example.dts:199:18: fatal error: dt-bindings/media/video-interfaces.h: No such file or directory
>   199 |         #include <dt-bindings/media/video-interfaces.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1492: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221118093931.1284465-3-paul.elder@ideasonboard.com
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.

In the cover letter I mention:

"This series depends on v3 of "dt-bindings: media: Add macros for video
interface bus types" [1]."

[1] https://lore.kernel.org/linux-media/20220615221410.27459-2-laurent.pinchart@ideasonboard.com/


Paul

> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command.
> 
