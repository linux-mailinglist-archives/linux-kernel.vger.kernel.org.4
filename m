Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0437161683C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKBQRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiKBQPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:15:08 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4BA2D1CC;
        Wed,  2 Nov 2022 09:12:28 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so8216226oti.5;
        Wed, 02 Nov 2022 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z7vIW2ZPdKtmwvSjnPCnyJNltgx5dmGmaEed71/1EzY=;
        b=LR6ZQXMJSJ0L4WINnpm9F0OvdWhXsPNOqWYN8PlsGouCRf7BqfwwWwk07fPirnSAD0
         jWjcIyLLDyq40aOTJCaEx9Wo+AaQpVsAPbIsk6U3UsVV2/KqpuYc9kJKdyH6BZgDTFVw
         XPJijFDbCfxAIU+B4TbcBE08wlsroXr5KHJ/eu4oHYI8hKw45ONqDX7bGNEOebfJUB61
         XmzOPDwjWMN9dgz3/Y4RNgJX87bClWeXL+symO7uPezJ6OjK/x51yn0GnhlTyXS1UKdm
         /ABvYrGYTgJbmx6KLjvAp9IYRn4WnXD7/bHuoOGPeT5d+Z4uVZhlTNH4HPAC5xF28J7X
         dF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7vIW2ZPdKtmwvSjnPCnyJNltgx5dmGmaEed71/1EzY=;
        b=qQiTv9fi8rmCeirTqIzhhIMRG9QP6HVGBoJzS3lI0s3X8gnSRlWJdBc10C6XsxBkzu
         zbOE9QPlo5KKCTP7nzhmcJTCCR+PPEo3J6xsJQ479Tc/8bwn7fpA9uMHS4r8xEDUkTJM
         YR2Zd7wnjtS1YVgGxO3grZNWr8hv2zxtiGJVnw/XKGZDckwq5DgqXk25VHSWpY5sBt6H
         NTWDeT2kk08DktTTzmEPVoY3RQuGmNDLa0TmAzbMV9ctACnNRWoKT+hOrHY8TZMw/ei3
         EtiO2IJbHYGfshZbsRjCzWDVk1eW1Qi2bxNKIdR6w/73nrhg1n+uf8EamLsC6DlT5gnH
         QmvA==
X-Gm-Message-State: ACrzQf3HNMfM/smhUVPaL15Elpr2XTYFOYhqIsR8B3LtsgeuH7v2mTXD
        gVk5TGLB+3+PvZT51o5pFndYgnMzsZoxfMLiXII=
X-Google-Smtp-Source: AMsMyM7Zuvi4mA7zyRQSf/ChuxdDKCxCX2EM1sE6SPy5eaAZxlItbrLR6mIvGbAnghWSCEFJp6Lq5z4DPcWB049mY24=
X-Received: by 2002:a9d:4592:0:b0:66c:6922:8629 with SMTP id
 x18-20020a9d4592000000b0066c69228629mr5232697ote.233.1667405547576; Wed, 02
 Nov 2022 09:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <Y1x3MtRJ8ckXxlJn@mail.google.com> <Y1yCRHgx15ZOiCL4@mail.google.com>
In-Reply-To: <Y1yCRHgx15ZOiCL4@mail.google.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Nov 2022 12:12:16 -0400
Message-ID: <CADnq5_NVpsFJdHfizqRxidXqN5CZJ-nQpqfEA3Ngd3viojjBXA@mail.gmail.com>
Subject: Re: [PATCH v2] [next] drm/amdgpu: Replace one-element array with
 flexible-array member
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Claudio Suarez <cssk@net-c.es>,
        Harry Wentland <harry.wentland@amd.com>,
        Grigory Vasilyev <h0tc0d3@gmail.com>,
        Slark Xiao <slark_xiao@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Oct 28, 2022 at 9:31 PM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
>
> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
> refactor the rest of the code accordingly.
>
> Important to mention is that doing a build before/after this patch
> results in no binary output differences.
>
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/238
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
>
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Changelog:
>
> v2: no binary output differences patch; report binary changes findings
>     on commit log. Res: Kees Cook
> v1: https://lore.kernel.org/lkml/Y1tkWdwPUp+UdpM0@mail.google.com/
> ---
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 7 +++++--
>  drivers/gpu/drm/amd/include/atombios.h         | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index 6be9ac2b9c5b..18ae9433e463 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -2081,8 +2081,11 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
>                                                 }
>                                         }
>                                         record += fake_edid_record->ucFakeEDIDLength ?
> -                                               fake_edid_record->ucFakeEDIDLength + 2 :
> -                                               sizeof(ATOM_FAKE_EDID_PATCH_RECORD);
> +                                                 struct_size(fake_edid_record,
> +                                                             ucFakeEDIDString,
> +                                                             fake_edid_record->ucFakeEDIDLength) :
> +                                                 /* empty fake edid record must be 3 bytes long */
> +                                                 sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
>                                         break;
>                                 case LCD_PANEL_RESOLUTION_RECORD_TYPE:
>                                         panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
> diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
> index 15943bc21bc5..b5b1d073f8e2 100644
> --- a/drivers/gpu/drm/amd/include/atombios.h
> +++ b/drivers/gpu/drm/amd/include/atombios.h
> @@ -4107,7 +4107,7 @@ typedef struct _ATOM_FAKE_EDID_PATCH_RECORD
>  {
>    UCHAR ucRecordType;
>    UCHAR ucFakeEDIDLength;       // = 128 means EDID length is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128
> -  UCHAR ucFakeEDIDString[1];    // This actually has ucFakeEdidLength elements.
> +  UCHAR ucFakeEDIDString[];     // This actually has ucFakeEdidLength elements.
>  } ATOM_FAKE_EDID_PATCH_RECORD;
>
>  typedef struct  _ATOM_PANEL_RESOLUTION_PATCH_RECORD
> --
> 2.37.3
>
