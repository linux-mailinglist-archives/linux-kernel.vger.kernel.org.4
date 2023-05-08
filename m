Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406A76FB40A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjEHPoQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 May 2023 11:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjEHPn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:43:57 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B1AD2D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 08:43:29 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id E480B401BD;
        Mon,  8 May 2023 15:43:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 430332002E;
        Mon,  8 May 2023 15:43:03 +0000 (UTC)
Message-ID: <1802c0990c8928a430f32d5396d9bc403821551b.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Drop realname for L: entries
From:   Joe Perches <joe@perches.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Vasile <acvasile96@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date:   Mon, 08 May 2023 08:43:02 -0700
In-Reply-To: <20230508144135.1450524-1-u.kleine-koenig@pengutronix.de>
References: <20230508144135.1450524-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 430332002E
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout05
X-Stat-Signature: ccjitddhoqoj7pw3tywqwencgpng6kau
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/P5CpkNWW06aar9BQCuMfqKhwperiBE3k=
X-HE-Tag: 1683560583-715271
X-HE-Meta: U2FsdGVkX1+kWSkxLYDh0I/86yfx9Nc+rbbG6LECZsAcZVgN/nvWjkNtjxwpUJIdS3w8sgSjeadqUv+ds9ANEQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-08 at 16:41 +0200, Uwe Kleine-König wrote:
> The format of L: entries in the MAINTAINERS file are expected to just
> contain the list's email address. get_maintainers doesn't cope well, if
> a realname is specified:
> 
> 	$ scripts/get_maintainer.pl -f Documentation/devicetree/bindings/display/arm,komeda.yaml
> 	...
> 	 (open list:ARM KOMEDA DRM-KMS DRIVER)
> 	...
> 
> So drop the realname (and the < >).
> 
> Fixes: ab6911b73493 ("MAINTAINERS: Add maintainer for Arm komeda driver")
> Fixes: 6865788f5ad9 ("MAINTAINERS: Update entries from the Nitro Enclaves section")
> Fixes: 3affaa5a7ca3 ("drm/afbc: Add AFBC modifier usage documentation")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> who will apply this patch? Joe?

Andrew? Please apply.

I do suspect though that these are non-public mailing lists/exploders
and these would be better as M: entries with names.

> Best regards
> Uwe
> 
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..ae1d8e140a67 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1669,7 +1669,7 @@ ARM KOMEDA DRM-KMS DRIVER
>  M:	James (Qian) Wang <james.qian.wang@arm.com>
>  M:	Liviu Dudau <liviu.dudau@arm.com>
>  M:	Mihail Atanassov <mihail.atanassov@arm.com>
> -L:	Mali DP Maintainers <malidp@foss.arm.com>
> +L:	malidp@foss.arm.com
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/arm,komeda.yaml
> @@ -1691,7 +1691,7 @@ F:	include/uapi/drm/panfrost_drm.h
>  ARM MALI-DP DRM DRIVER
>  M:	Liviu Dudau <liviu.dudau@arm.com>
>  M:	Brian Starkey <brian.starkey@arm.com>
> -L:	Mali DP Maintainers <malidp@foss.arm.com>
> +L:	malidp@foss.arm.com
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/arm,malidp.yaml
> @@ -14825,7 +14825,7 @@ F:	arch/nios2/
>  NITRO ENCLAVES (NE)
>  M:	Alexandru Ciobotaru <alcioa@amazon.com>
>  L:	linux-kernel@vger.kernel.org
> -L:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
> +L:	aws-nitro-enclaves-devel@amazon.com
>  S:	Supported
>  W:	https://aws.amazon.com/ec2/nitro/nitro-enclaves/
>  F:	Documentation/virt/ne_overview.rst
> 
> base-commit: ac9a78681b921877518763ba0e89202254349d1b

