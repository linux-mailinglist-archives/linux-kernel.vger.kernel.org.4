Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64338663D53
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbjAJJx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbjAJJxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:53:31 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1A1C920;
        Tue, 10 Jan 2023 01:53:30 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id e205so9542320oif.11;
        Tue, 10 Jan 2023 01:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO3i/JFAZGPvFKgP2nF/h6yMDU8gV3ISOFiQVax5MVg=;
        b=eU4uzg6gGopIIhQIug9MUu1cY/zQNs5gN/zcwR1XlKUhvlgdi/taxNDKQ21kUnvn+A
         Qy/Cj7aqhPR+xs/6HBZPHdURoCEfdDJxrDq/C2QYnEEYr4UpAWBaSIp01MddkvnNRwNr
         rl1R5nZtC5rurjQN3VqTx0hgONcAsN5i0agB/3LlXk9cyb20pKeZi+7gjAmUvAQhlGdE
         azQ2PCGKUK7z+lTyJ3E4MHfZ4MJs/wdoHQAUwm0ugpgcmhegWvHNd1Ualsb3WYTcw48y
         KVjXbW/CQLRt/n72dp+mWrGEsDLYfwfIl0PX42vkABb7lO0byHfsioch7rxftajFFLm0
         y82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO3i/JFAZGPvFKgP2nF/h6yMDU8gV3ISOFiQVax5MVg=;
        b=oPJWVfq8pXcN8mw28sqK3SCyP0DweggVXWpPk9FHQXFmGJxMJxQMUWd0qWDlrIDRp7
         GcqcLALnfoddTKWoB1zhxP0IciP5C1LN0NGlJ2i40Xm6trvqTi99GmCCpnW2nODZCRg5
         rKePKUpaIJFCHTQfjalbSbzsMlhrHqCmwuybMd6s8XapZR0F/RQTYDWV5QNRFxFproJ/
         qRGm6s553DRS/au5VBHG9rsou4Hs64HNVORkbh05ITtzDDJpzHpbfhbBDayNjzI6+v4X
         WR1wRXiub4J7gRwQ3zmYREUKVH/s0VBPnk5y3jT+K2rPG0ccq+5uw6s+ZKNDCEAmGu8x
         ZZWQ==
X-Gm-Message-State: AFqh2kp4zYFD8NJ1HgyLtgoDdh2NDBdd5wpS3Nkj/JQxSnbAQlY2p1fC
        r1PnDX5R7hrz9p6NclQRYi0nOhP1Riv2Rjj1bx8=
X-Google-Smtp-Source: AMrXdXtSxqsCKninILNfFmyMIYYPAGjJiUEeKoGfpR9EmJ4QOUq/Vuetkbbwf4X4jo6Mni9q9bCqFKASxptmn+ag6fo=
X-Received: by 2002:a05:6808:1b06:b0:35b:d102:75bd with SMTP id
 bx6-20020a0568081b0600b0035bd10275bdmr3391507oib.178.1673344409444; Tue, 10
 Jan 2023 01:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20230109123216.4974-1-fengqi706@gmail.com>
In-Reply-To: <20230109123216.4974-1-fengqi706@gmail.com>
From:   qi feng <fengqi706@gmail.com>
Date:   Tue, 10 Jan 2023 17:53:19 +0800
Message-ID: <CACOZ=ZW5vpaPpFsQ64nSE3kinUhGDBeDey7odvnGeZFEKys32g@mail.gmail.com>
Subject: Re: [PATCH] HID: add KEY_CAMERA_FOCUS event in HID
To:     jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>, benjamin.tissoires@redhat.com,
        rydberg@bitmath.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop more


Qi Feng <fengqi706@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=B8=80 20:32=E5=86=99=E9=81=93=EF=BC=9A
>
> From: fengqi <fengqi@xiaomi.com>
>
> Our HID device need KEY_CAMERA_FOCUS event to control camera, but this
> event is non-existent in current HID driver.
> So we add this event in hid-input.c
>
> Signed-off-by: fengqi <fengqi@xiaomi.com>
> ---
>  drivers/hid/hid-input.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 9b59e436df0a..22cca3406b5c 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1105,6 +1105,7 @@ static void hidinput_configure_usage(struct hid_inp=
ut *hidinput, struct hid_fiel
>                 case 0x0e5: map_key_clear(KEY_BASSBOOST);       break;
>                 case 0x0e9: map_key_clear(KEY_VOLUMEUP);        break;
>                 case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);      break;
> +               case 0x0ee: map_key_clear(KEY_CAMERA_FOCUS);    break;
>                 case 0x0f5: map_key_clear(KEY_SLOW);            break;
>
>                 case 0x181: map_key_clear(KEY_BUTTONCONFIG);    break;
> --
> 2.39.0
>
