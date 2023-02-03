Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF201689173
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjBCIAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjBCH7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:59:32 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E95E23124;
        Thu,  2 Feb 2023 23:59:18 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 0315C120052F;
        Fri,  3 Feb 2023 08:59:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1675411155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khrZK9ZkbJkIdQ3hGKeEDzwdsTA9VD8W9jb6PMY8w9M=;
        b=Q+6HZm9OCmTFAtNsLwFmH1zdMRuQRg/kQyQIIytco7yt3jj84VW8jVYi7n1rpd5124qq4t
        eIjbBOe8AGZeOIfAX0odKtT8mIm299rqLfT6ALV3sbPIPvhhOBhIsfNZssRWq5UxG9MLkf
        lz/C4y+Hmn1Re1k5GYCYGl+Z+PH1Sa4=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     tj@kernel.org, axboe@kernel.dk, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH -next] block: Revert "block: increase BLKCG_MAX_POLS"
Date:   Fri, 03 Feb 2023 08:59:13 +0100
Message-ID: <2666358.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20230203081357.1385168-1-yukuai1@huaweicloud.com>
References: <20230203081357.1385168-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On p=E1tek 3. =FAnora 2023 9:13:57 CET Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>=20
> This reverts commit ec645dc96699ea6c37b6de86c84d7288ea9a4ddf.
>=20
> This can save some memory, because after commit 0f7839955114 ("Revert
> "block/mq-deadline: Add cgroup support""), there are total 5 policies.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  include/linux/blkdev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 41a41561b773..c6861c7fdad9 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -54,7 +54,7 @@ extern struct class block_class;
>   * Maximum number of blkcg policies allowed to be registered concurrentl=
y.
>   * Defined here to simplify include dependency.
>   */
> -#define BLKCG_MAX_POLS		6
> +#define BLKCG_MAX_POLS		5
> =20
>  #define DISK_MAX_PARTS			256
>  #define DISK_NAME_LEN			32

Last time I asked about reverting this change, it was suggested that we may=
 keep it [1].

[1] https://lore.kernel.org/linux-block/1dc051a8-4d59-8137-2406-f74026b170b=
d@kernel.dk/

=2D-=20
Oleksandr Natalenko (post-factum)


