Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE186F890D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjEESwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjEESwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:52:41 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2B82074A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:52:32 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1929818d7faso19366813fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683312751; x=1685904751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQlh7hwy8Rr71ndzr8IXQ2O4Z+8GiQ3wjDKifhmGZKk=;
        b=E8J9EkJmCdiaIbLv9WeS4FyBHdjAGW1ivVH922O6IG/KHQ+GWABODvcLsbrsOjlX+8
         jmz8FucV+1MjreVT7ePMPY4TPRmFVSUMdil40ELN5pFNuKGcOPMGfmylPneeSXFMgGlJ
         Sc0MqwKXM6O2gt7cuKfeCzJF8rgxG/o5MHjaWql39tLUC76hdIl3ixhJJcegbXJsMBPr
         MqhTHdbTiFZ/bDFYcI5avxssz1+OREpwhkUzsw3YXZo83yCikWNWKoyGQ2NCOENdvxNk
         wHOuj2/TLQOu1ujieikwh2oMlaCisM5kXuce7/4NcgaucFclyfLV49abP5f5fg5sK1e2
         wBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312751; x=1685904751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQlh7hwy8Rr71ndzr8IXQ2O4Z+8GiQ3wjDKifhmGZKk=;
        b=RpoL/vCKcPxY+QWcIO2Txw9+OpyJzR6QdrAk/5qTzjd99lteKHoP+Es/2SWlNn7dHX
         HCzN3BtkOPEZ/0cEmd1fa2/yEZR8npupJXmiNRSON+th/OsnURs0q2aJToHqC2okIi1n
         zVMn75ttmv0qwD8UiDinyfYBn/RiA3sC4nEm1R+/WlxAxs0CQIxmPbwzJoL/jcgT+iD6
         w4LEmNvvnSMMv6f7Ru7gMT0el97vJcGWHU6wrlIBu1BuZfDZ6sv1hHE/aHRC/KbSrYTf
         FHqn2vPevDS+KK4B8R8IIgqj5mNjgtRAkWADWUrfvdAAsufY4jkGTyIhb3Lb18sZ835Y
         KYew==
X-Gm-Message-State: AC+VfDwnGGbfhP0VL3pGnHQrzb7At9mv/pmxY/S39cf99gEBXck/zVNX
        ySv6LqeKjt8HwKx7uH4IAYqka0fWWK9FvIT6Nn1wUXkZ
X-Google-Smtp-Source: ACHHUZ4KSAMKrpB7g3tdha8+8kCikJkc+x2QDoGbrD2V+fMbOCekB2puciNwrRCx5znIv93cIN0qfUOUl0POUWAqZmE=
X-Received: by 2002:a05:6871:809:b0:192:6deb:f704 with SMTP id
 q9-20020a056871080900b001926debf704mr3329406oap.18.1683312730700; Fri, 05 May
 2023 11:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230505073731.5348-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230505073731.5348-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 5 May 2023 14:51:59 -0400
Message-ID: <CADnq5_OoAwf1-+2BaTPt8y_RJLbzTTZ+D7=tpeQx-Mf9XGgvAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unneeded semicolon
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, May 5, 2023 at 3:43=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> ./drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c:146:2-3: Unneeded semicolon.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4871
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd=
/amdgpu/nbio_v7_9.c
> index 24d12075ca3a..a331a59c49e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> @@ -143,7 +143,7 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdg=
pu_device *adev, int instan
>                 break;
>         default:
>                 break;
> -       };
> +       }
>
>         return;
>  }
> --
> 2.20.1.7.g153144c
>
