Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713D16F8D55
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjEFBHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFBG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124CF10E6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A5B6641C7
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 01:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB138C433D2
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 01:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683335209;
        bh=UEmzadnfn7+/6cZeDjikdevPjT9T7IYVnjcaT9lRak8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eBR2693Lkf2GJv6J3m5AIrAU1926dHM8NkD6Apkpq/NY+XtfL4g7QFLybBAquY4W7
         pDMjOg5t6C6lKyiEOI7nMWrFtkZKO3ApD26AcMg7AI35G4eYUPQpHWiKS2O9DJwPw7
         EN3EQRlc6YZgudWLIINLj68B3JEbwo1QXfytX+J5U5zt94BJsS0N2EJFhEMZ/eXWAt
         n++JEKoXvE9MlRmAQat9b196ulnToza02G72MBckZ8IgFwyjYtovAGqSx1dmhWUTfM
         xk4QZmqYdZOQWMBMUrd2ptVdZ6A7GsSPfRQO5D5kFSrWyVxEdqmEel8d15tB0oqfAX
         GLSjIHp2eiGBg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-192adab8f0eso2137655fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:06:48 -0700 (PDT)
X-Gm-Message-State: AC+VfDxY2DWOU34QmQWmn8junQjja/EtU+eK7ONM27KAdq2r4duDAwt3
        Ge+H7lYr+9jwwYTkKTHumzdEyGkNsVvriBtvMq8=
X-Google-Smtp-Source: ACHHUZ60qg4+wWWnFhmcxT/U2Cqt34csJhDM3qhOq6rpVeCAaIFBJfLe0cRmTbVezoq81ynKjMd825k0hPycTmjtPYg=
X-Received: by 2002:a05:6870:d895:b0:17e:a21c:8983 with SMTP id
 dv21-20020a056870d89500b0017ea21c8983mr2109271oab.57.1683335208139; Fri, 05
 May 2023 18:06:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:981:0:b0:4d3:d9bf:b562 with HTTP; Fri, 5 May 2023
 18:06:47 -0700 (PDT)
In-Reply-To: <20221105153135.5975-1-dengshaomin@cdjrlc.com>
References: <20221105153135.5975-1-dengshaomin@cdjrlc.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 6 May 2023 10:06:47 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9zOgsdsRTLYRxw8B0O25LdsX-Yn6FM8u1LJdpH+tB3eA@mail.gmail.com>
Message-ID: <CAKYAXd9zOgsdsRTLYRxw8B0O25LdsX-Yn6FM8u1LJdpH+tB3eA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: Remove unneeded semicolon
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-11-06 0:31 GMT+09:00, Shaomin Deng <dengshaomin@cdjrlc.com>:
> Remove the unneeded semicolon after curly braces.
>
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>

> ---
>  fs/ntfs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 001f4e053c85..6165fe7d0ac6 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -1612,7 +1612,7 @@ static bool load_and_init_attrdef(ntfs_volume *vol)
>  		memcpy((u8*)vol->attrdef + (index++ << PAGE_SHIFT),
>  				page_address(page), size);
>  		ntfs_unmap_page(page);
> -	};
> +	}
>  	if (size == PAGE_SIZE) {
>  		size = i_size & ~PAGE_MASK;
>  		if (size)
> @@ -1681,7 +1681,7 @@ static bool load_and_init_upcase(ntfs_volume *vol)
>  		memcpy((char*)vol->upcase + (index++ << PAGE_SHIFT),
>  				page_address(page), size);
>  		ntfs_unmap_page(page);
> -	};
> +	}
>  	if (size == PAGE_SIZE) {
>  		size = i_size & ~PAGE_MASK;
>  		if (size)
> --
> 2.35.1
>
>
