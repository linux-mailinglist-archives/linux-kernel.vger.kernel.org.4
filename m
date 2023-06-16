Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B1C732794
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjFPG2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbjFPG2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64AC5277
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD4860F79
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1446C433C0;
        Fri, 16 Jun 2023 06:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686896709;
        bh=LDabtgOo2j1S5Mdb6D/SWY6U6r4qBrDWsMZ26M0NjyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+ifZNLhBIs0bLQRprA0wJst7xHgayyPBR1CJY+tULNpi8aZw/JEjzeYvNgD22VdX
         Dz1deQrSGq7EfzE3weZjanbrOx6ifZ9pLEKvk2ab5I9ZVHTFNTg+ZLj0halgMY7agx
         6djKIb5AyCnkNVB4hESH4xYSluxo8u9HBkhIfMR8=
Date:   Fri, 16 Jun 2023 08:25:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com
Subject: Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Message-ID: <2023061616-sacrifice-mollusk-737f@gregkh>
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <20230616055913.2360-2-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230616055913.2360-2-alison.wang@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:59:06PM +0800, Alison Wang wrote:
> Ethos-U Linux driver is to provide an example of how a rich operating
> system like Linux can dispatch inferences to an Arm Cortex-M subsystem,
> consisting of an Arm Cortex-M and an Arm Ethos-U NPU.
> 
> Link: https://git.mlplatform.org/ml/ethos-u/ethos-u-linux-driver-stack.git
> Tag: 22.02

What does "Tag:" mean?

> 
> Signed-off-by: Kristofer Jonsson <kristofer.jonsson@arm.com>
> Signed-off-by: Per Astrand <per.astrand@arm.com>
> Signed-off-by: Jonny Svärd <jonny.svaerd@arm.com>
> Signed-off-by: Lior Dekel <Lior.dekel@arm.com>
> Signed-off-by: Henrik Hoglind <henrik.hoglind@arm.com>
> Signed-off-by: Davide Grohmann <davide.grohmann@arm.com>
> Signed-off-by: Alison Wang <alison.wang@nxp.com>

If this many people signed off on this, it better be correct :)

> --- /dev/null
> +++ b/drivers/firmware/ethosu/Kconfig
> @@ -0,0 +1,24 @@
> +#
> +# (C) COPYRIGHT 2020 ARM Limited. All rights reserved.

It's not 2020 anymore.

> +#
> +# This program is free software and is provided to you under the terms of the
> +# GNU General Public License version 2 as published by the Free Software
> +# Foundation, and any use by you of this program is subject to the terms
> +# of such GNU licence.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, you can access it online at
> +# http://www.gnu.org/licenses/gpl-2.0.html.
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +config ETHOSU
> +    tristate "Arm Ethos-U NPU support"
> +    help
> +      Arm Ethos-U NPU driver.

{sigh}

With all of those people, NO ONE ran checkpatch.pl on the thing?

I'm stopping here, please go do that, fix up the obvious issues it tells
you about (hint, no SPDX line and drop the huge license "boiler plate"
texts)

And also provide a REAL configuration help text, 4 words for this is
just not acceptable, what would you do if you were asked to review this?

thanks,

greg k-h
