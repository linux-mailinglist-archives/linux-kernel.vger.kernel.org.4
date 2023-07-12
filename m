Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752F4750A65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjGLOCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjGLOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:01:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C31BD7;
        Wed, 12 Jul 2023 07:01:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3094910b150so7621311f8f.0;
        Wed, 12 Jul 2023 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689170483; x=1691762483;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLoUCPxnupfNO6uLn5EK6KmWZhEjry+QHiAYeyrmQL0=;
        b=qbC/Mua1AagtqfeuNO0IRxyeEFL79/IlJPeKTpbOltK7AOHH9AGUtGjDM3uaY/g6r4
         m0F8Dwy020eqoHWaJK+xU1v7Y4riqAARXF1A8bkJeq5Nh1lWPsoEFBagfnpyWJNKXFsg
         GQ00XKuuhnZ/tlUWKDKIUojgJaLoX3NPFug8u9cOSQs9KFcskp+1+o1/+U1jiedFil1o
         mxd8hU3Yy9N2XrkwWFbn3D0GLNHhYku50aM6kvPscgJnj0XweWA8cTAA5e+VwsqkW3ab
         PgJmfTGfwjesI0jDrxFiAnGSPUmyBDOhgCUl6JFbktse6sRJVkfG5ZeE15R5pr+z/1vF
         5ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170483; x=1691762483;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oLoUCPxnupfNO6uLn5EK6KmWZhEjry+QHiAYeyrmQL0=;
        b=Pm4xbGZcfwlu2OH8Ti6sY2BJCfRWcsRqHGTbRfKnXkkGCsiZhS27tUh/lWk1xWUC8f
         y2VsE57NvLl5El2PPE1eGCFBUxRLzyCSNGpgU05zzKLwtJ+0MjGsdk5RC2VX9G34N19H
         AUYMpZIRTDdY9eu93IoZbrH1WVnSzptoAWXNs1cFExLSj+rhiFvtvdexnmwbyEy4jw4d
         ZOBmrCMT/WhX+fF1L1ARghkUPn7/2gdkeblnVASEDEoIZNFwFISmwEJ1b0poOgw56PPY
         3GGhU2wphAFWGf0y030/IrWzizhPmpQukYXgQ3AktABpfd3PMjPtBm2FsIBYOuHu+Db0
         JNBQ==
X-Gm-Message-State: ABy/qLaWk2YvKqwSsE2Mo9Jv7U/hkFZhbKHXhKowXgr9r0NsG53ZFKNl
        l+twjVcRxK9e0GdfeDXEzpM=
X-Google-Smtp-Source: APBJJlE1qCq6jKSx9GKM45xt1xi/FuXENuug5kURGhSzKoUhs0C5fn216+TKtnHYHTfhQhIPy8WB8w==
X-Received: by 2002:adf:e60f:0:b0:314:3742:ff0e with SMTP id p15-20020adfe60f000000b003143742ff0emr18373589wrm.52.1689170483245;
        Wed, 12 Jul 2023 07:01:23 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id q15-20020adffecf000000b003142439c7bcsm5174167wrs.80.2023.07.12.07.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:01:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 12 Jul 2023 16:01:22 +0200
Message-Id: <CU08YMZ7867W.ITLC05RV2R69@syracuse>
From:   "Nicolas Escande" <nico.escande@gmail.com>
To:     "Minjie Du" <duminjie@vivo.com>,
        "Gregory Greenman" <gregory.greenman@intel.com>,
        "Kalle Valo" <kvalo@kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "open list:INTEL WIRELESS WIFI LINK (iwlwifi)" 
        <linux-wireless@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
Cc:     <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] drivers/net: intel: iwlwifi: fix two parameters
 check in iwl_mei_dbgfs_register()
X-Mailer: aerc 0.15.1
References: <20230712131407.16462-1-duminjie@vivo.com>
In-Reply-To: <20230712131407.16462-1-duminjie@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jul 12, 2023 at 3:14 PM CEST, Minjie Du wrote:
> Make IS_ERR() judge the debugfs_create_dir() function return
> in iwl_mei_dbgfs_register().
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mei/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/=
wireless/intel/iwlwifi/mei/main.c
> index 54445f39f..e5d203a62 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
> @@ -1888,7 +1888,7 @@ static void iwl_mei_dbgfs_register(struct iwl_mei *=
mei)
>  {
>  	mei->dbgfs_dir =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> =20
> -	if (!mei->dbgfs_dir)
> +	if (IS_ERR(mei->dbgfs_dir))
>  		return;

same as the other one

> =20
>  	debugfs_create_ulong("status", S_IRUSR,

