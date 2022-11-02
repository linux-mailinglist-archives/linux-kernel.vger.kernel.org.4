Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF316167D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiKBQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiKBQLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:30 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64C2CDEE;
        Wed,  2 Nov 2022 09:11:22 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n83so19657946oif.11;
        Wed, 02 Nov 2022 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMjYtLPQdk4k4exRzx1++JFQEjlm3E6Ooszo7YLrAmA=;
        b=YkoMxrzgOzObQ1f1AQWermP6aRAMBxCVFdMmyaHzOTeZdtelfAESKiSIoV7kj77E+L
         FTIkkriNPRtcD6CsHVUvxp1BM4/3GdHunszANw/koj97LixLFuphPtTERaQk3+dbAqCw
         KipagSfLhrJT86JB/5YZNpquZy6KPER7d+Wc+5ls6kdX7kCKPEtrvMZ/MHv5yvbB75VX
         aU88ms7Xjeqihyb0ExWs7VnJj0lFqqt96zTgIEE2W619V9smJhuW4oUZA54ExzPWVWKa
         vUExZ6florDuPnSi9edzg/cQEAXZHnKivN1QvtxYHqottcJuJqIKCnSohrqJGqM/UwCu
         VXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMjYtLPQdk4k4exRzx1++JFQEjlm3E6Ooszo7YLrAmA=;
        b=VhHAs3etjMQo95zaAb7s5RTFfFrRoJq32YhhXJbMh/LPwNiDVO7GxKL+kzaRg8ibyF
         Ff6QujAwQRtaIr9ibG75VVbnbhFaz37zH/O602ysMNgRSbd72BnDCP1wB0yp6/Fi96na
         HEyaHV7YgTr5WinTANc9cxEcF6xnxiVBzm2gUag0d3/rV5dtIskqQ5TeHrZkjuhqTKuO
         yLr2GBi8y/QNHocb/D9vgN8tO3xSV2Fw20rhlk/FM7/BALIG7jWnK+iwsk0yd0yuYZ7Z
         JiyNWZ+mXYonD6oIp1yRvErASJ75hO6wjhtArom5fVd6qOplaZtbgsIvhihVaVXQwhAE
         jPuw==
X-Gm-Message-State: ACrzQf0K10AZVaUHjeMgbBR6+YW9Qtr9jpbHbUCowFYJHOpJQf7gRePz
        AxZEbmNhIx9T6eUbCfySFUELTJxRnF+flri8bbA=
X-Google-Smtp-Source: AMsMyM59WbQ63bOK+8OGXBf3SLltf4ei4Oo8m8seRlp+EZkh24IHmapsiryJkmixwkTmQ1eeqhOn0KsvVt1S8ZNa3jc=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr13779461oiw.96.1667405481362; Wed, 02
 Nov 2022 09:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <Y1trhRE3nK5iAY6q@mail.google.com> <Y1yetX1CHsr+fibp@mail.google.com>
 <CADnq5_Mod90O=tN26+Yi74WPYxpVtss+LG_+_HZyFv2EtzR+MA@mail.gmail.com>
 <202211011443.7BDB243D8D@keescook> <CADnq5_Ou9HnZjQx5WaAZW+iu24g_eS2hh25xhExeQjdMOXYfCQ@mail.gmail.com>
 <202211011538.B7548FDDE@keescook>
In-Reply-To: <202211011538.B7548FDDE@keescook>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Nov 2022 12:11:09 -0400
Message-ID: <CADnq5_PxjyL9kqdge-SOMkjLk176sPbSxM9Ng+N8f_-zj9NMqw@mail.gmail.com>
Subject: Re: [PATCH v2] [next] drm/radeon: Replace one-element array with
 flexible-array member
To:     Kees Cook <keescook@chromium.org>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Tue, Nov 1, 2022 at 6:41 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Nov 01, 2022 at 06:09:16PM -0400, Alex Deucher wrote:
> > On Tue, Nov 1, 2022 at 5:54 PM Kees Cook <keescook@chromium.org> wrote:
> > > Does the ROM always only have a single byte there? This seems unlikely
> > > given the member "ucFakeEDIDLength" (and the code below).
> >
> > I'm not sure.  I'm mostly concerned about this:
> >
> >             record += fake_edid_record->ucFakeEDIDLength ?
> >                       fake_edid_record->ucFakeEDIDLength + 2 :
> >                       sizeof(ATOM_FAKE_EDID_PATCH_RECORD);
>
> But this is exactly what the code currently does, as noted in the commit
> log: "It's worth mentioning that doing a build before/after this patch
> results in no binary output differences.
>
> > Presumably the record should only exist if ucFakeEDIDLength is non 0,
> > but I don't know if there are some OEMs out there that just included
> > an empty record for some reason.  Maybe the code is wrong today and
> > there are some OEMs that include it and the array is already size 0.
> > In that case, Paulo's original patches are probably more correct.
>
> Right, but if true, that seems to be a distinctly separate bug fix?

You've convinced me.  Applied.

Thanks,

Alex

>
> --
> Kees Cook
