Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056CA750A46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjGLOAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjGLOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:00:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F6710CB;
        Wed, 12 Jul 2023 07:00:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso84217005e9.0;
        Wed, 12 Jul 2023 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689170421; x=1691762421;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwBA6CgC/uSWwgysf9itlxsD4ci1tHALzPKkAgebLIk=;
        b=nzBtO/tTreuHkaSg8fsmex2z01A3jTBVz5BYmCLBaOKK8UpmigesIYHZBbNV2F3fUv
         vJdnAapY4APjKKP+9/rmFjtawAPdjbHnVNb4lh+lopJ+3P4aijA5Tr95wdIyCqyk40vr
         b3MnQVXo/0Zj710PhEU/YLcW5cViZfLTh0wj2d8H5suZHhhxtejfJaxVaYJ1hAw+rJ/V
         uSwUWo+loigI+FKGX+PTV4GYsP0EWoXevShhDTDbcGMMHgDTbj8532fAyEpLkXh0h8km
         63pq5NTHGgroUfKe64sFwNEbaf3hHrQR/LeI6GSidazJTrIrh3X4I1s6dZJlTmovozPj
         3HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170421; x=1691762421;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wwBA6CgC/uSWwgysf9itlxsD4ci1tHALzPKkAgebLIk=;
        b=lXAxe6u9cXwRp/8c78BSErFgA76sMLuDnS+ICN4K007LmWKYAVB0TFJCsxQh3ZdTF1
         1gDoD2Ksk1fgdVPNtjQuGf5k5zlAzRYqgPfylpSDGfXlYssXGF+L8XXHr2OT2bXpNEic
         cPHklwZxCUsG0dcRH5OwGQ0gqNspwzXXGtYdb0A2cs8H3BF/MabSMC9dKFDRKcmCEZwA
         IWjpWF5JwTV1w8LzPotjxhZrfN77dKEPl48n7KiUc4Cj/PJj+8MFCpbVVPAtKo6pe7Ot
         oqRetUGUxvSzNTC0nOWd6KIvcTekaiSZbPh/qRD6Tshq1vHGr6a5GQFAn6d6Iiuru3K+
         XjaQ==
X-Gm-Message-State: ABy/qLZpJRz7iPqEnhfwQhbZAt4xinjx8wXt9YoTz6NJnNQ6GulQyls3
        tIuVpXKXDNG0ScBC1Jc7UwA=
X-Google-Smtp-Source: APBJJlFvnpQKOvU0aobzPw3hMQLbsfLRGV5h6VkWcrOUeWACf5DxRZADF7vQ5lsCh/oTJ22vnfnZOA==
X-Received: by 2002:a1c:f709:0:b0:3f5:fff8:d4f3 with SMTP id v9-20020a1cf709000000b003f5fff8d4f3mr22648888wmh.7.1689170421080;
        Wed, 12 Jul 2023 07:00:21 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b0031411b7087dsm5201659wro.20.2023.07.12.07.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:00:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 12 Jul 2023 16:00:20 +0200
Message-Id: <CU08XUB327HO.3J4AY0JF2ZRL3@syracuse>
Cc:     <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] drivers: wireless: mt76: fix parameter check in
 mt76_register_debugfs_fops()
From:   "Nicolas Escande" <nico.escande@gmail.com>
To:     "Minjie Du" <duminjie@vivo.com>, "Felix Fietkau" <nbd@nbd.name>,
        "Lorenzo Bianconi" <lorenzo@kernel.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>,
        "Sean Wang" <sean.wang@mediatek.com>,
        "Kalle Valo" <kvalo@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
X-Mailer: aerc 0.15.1
References: <20230712130005.15809-1-duminjie@vivo.com>
In-Reply-To: <20230712130005.15809-1-duminjie@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jul 12, 2023 at 3:00 PM CEST, Minjie Du wrote:
> Make IS_ERR() judge the debugfs_create_dir() function return
> in mt76_register_debugfs_fops().
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/net/wireless/mediatek/mt76/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/w=
ireless/mediatek/mt76/debugfs.c
> index 57fbcc83e..d9ba70013 100644
> --- a/drivers/net/wireless/mediatek/mt76/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
> @@ -109,7 +109,7 @@ mt76_register_debugfs_fops(struct mt76_phy *phy,
>  	struct dentry *dir;
> =20
>  	dir =3D debugfs_create_dir("mt76", phy->hw->wiphy->debugfsdir);
> -	if (!dir)
> +	if (IS_ERR(dir))
>  		return NULL;

Check the mailing list this subject has been discussed many times...
I believe the current state of the art is to remove the check altogether

> =20
>  	debugfs_create_u8("led_pin", 0600, dir, &phy->leds.pin);

