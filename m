Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9375BE231
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiITJi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiITJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:38:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56F66A70;
        Tue, 20 Sep 2022 02:38:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id 13so4762523ejn.3;
        Tue, 20 Sep 2022 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=1ACvBNS/BmPcZghXQgeH0xRzJtAbKL6tPXfSnoaBoJQ=;
        b=XaP21kFUG88BKe4RytNxQVkBU7oeorpYQLBbWW8pNETJyNJU75ehFxaxDGf+0huQDv
         rUBLuaEXXfRGUstiD80bGBRlXZjbt/cxnv/XoeGRw8rRUghQahgn12j3d6Y/0RiFEC0I
         VVPRibKngjYq+nrdJZ3+Lm7DReCnjK68y3hnNghoisv4bGa7DMGSEs0xa+M8nrPVW1sr
         Mt0EeTfCRUb1K7Uq24FD8PlwV5zN9zMSR2IgRLStmP7ctig9UO2K/uA7NSF531JNK2Oq
         fpeD+kQ9llFF4fa4rluiPET0zpWoU+gXPR6nY/8bMb3Tys7zMQR15zEE4/ltmPDv/2c3
         t5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=1ACvBNS/BmPcZghXQgeH0xRzJtAbKL6tPXfSnoaBoJQ=;
        b=r5/k3w2Azqmr41DIIv0mkzRvFWEEU9NrbRuRrYak+ElJWjoVhwSWwoiuqtXasbBJEm
         77iFF41aZ+DlLgclu1tW/33ADHzPuUU+yT9jgT+M37kTkqxvyEnUj9M8YnajcR6FI6iR
         pG4EzBd8VRFKREu0o2yAF0+TRq2Z7l+Ghz5+gtFNsHep0yYVqOa6Y1/GnhOgufQNSjQH
         BgNdChkodf0zEXnJs/X+GS/oCUHhh8p3ZsjLl40kjaG0QhSMyFztkRqsknqRfwnSuJEE
         Ad9TdcFjWNbdAbHfyfOKqo2TD2k2/nG1uCDxP79dxmi/pGlOb2bO6TAXTJx+KuBn+dgY
         v/gw==
X-Gm-Message-State: ACrzQf1weE6z7ooatcxWo4YoHVtycC6mxGif5SiQKJulplGf8yGYAcam
        boVeW72h6miQnkFve0aRZBQ=
X-Google-Smtp-Source: AMsMyM5DKlUx30EnlT+m8b/NyFhKRw1MZqDFyfqzrrGCGN0FvzidzIvezsle0sfFHUcjRwmF5tByHA==
X-Received: by 2002:a17:906:9756:b0:781:bc50:abe3 with SMTP id o22-20020a170906975600b00781bc50abe3mr1976678ejy.291.1663666702457;
        Tue, 20 Sep 2022 02:38:22 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id e6-20020a170906314600b0073ddd36ba8csm553544eje.145.2022.09.20.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 02:38:22 -0700 (PDT)
Message-ID: <87e6fdb49d9d76c468712e1b42cbc130273b5635.camel@gmail.com>
Subject: Re: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
From:   Bean Huo <huobean@gmail.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>, James@vger.kernel.org,
        E.J.Bottomley@vger.kernel.org, jejb@linux.vnet.ibm.com,
        Martin@vger.kernel.org, K.Petersen@vger.kernel.org,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean@vger.kernel.org, Huo@vger.kernel.org, beanhuo@micron.com
Date:   Tue, 20 Sep 2022 11:38:20 +0200
In-Reply-To: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arthur,


On Mon, 2022-06-20 at 15:26 +0300, Arthur Simchaev wrote:
> The bsg driver allows user space to send device management commands.
> As such, it is often used by field application engineers to debug
> various problems,
> and as a test bed for new features as well.
>=20
> Let's not bound ourself to hard coded descriptor sizes, as the new

UFS descriptor size is no longer hardcoded (defined in the driver), the
size of the descriptor is reported by UFS itself, check the latest
kernel.


> Descriptors that supports new features are not defined yet.
>=20
> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
> ---
> =C2=A0drivers/scsi/ufs/ufs_bsg.c | 28 ++++------------------------
> =C2=A01 file changed, 4 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c

This UFS driver is in the wrong location, I assume you are using an
older kernel version?

Kind regards,
Bean

