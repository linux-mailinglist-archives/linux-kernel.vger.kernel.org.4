Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2836A7FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCBKLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCBKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:11:35 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0AE2594B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:11:34 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id o32so21862958vsv.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F71E3UpzmFBCRVZxJQMTTJKMF0O4a9h4QSsqieYJImE=;
        b=g7ALksvYo4Y5TKYfVAoELDzniyk2kdOpFdcDy2wZYcUYgF9B0YYZ3EyzZEqklxFZfz
         /VbrBKfnf7SnMn3mLYBREX3gCLeuKepHs6Zfsz1fPQuEMd8OWru2wisGo0LiM5n7cC4L
         SKNQs/B07wKJAUVfe7KGVeiiNvs7Qw0HN4f1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F71E3UpzmFBCRVZxJQMTTJKMF0O4a9h4QSsqieYJImE=;
        b=MNT+d0anZTeSULAUBumk4QAA7wyLWwPJmSlvhyMZ+ZJ2nLbe5sNGMUwh5Xv6WcF4Bx
         pvijArdBrUX/wAmr9JHJHRe67TEq48Vtxt6b9EKY0Ke2du2ILDhgKN4G/QZIQsymnEcY
         89fD8atRdVOfDoIAzHU81xA+4nEpCxsLYhesd6aja5Vyl1TJa/iRYyoHBjUCMx0tuvlR
         pa2lL+qTOTf3JNymGDigmGk7GDwTeqRn2sFW+3JD7L2r2yceYu+qAWdNbS+NxVLtCB98
         5jbtXSaQXPEcVTtZTPrgebiuh3jdscQU2pMD97xCSuS+BD94RGGCBcWwKvhwkNnZGnZH
         9QSw==
X-Gm-Message-State: AO0yUKVLMOC/q/COJZbF86jvzp4Cc1zgEorF/kW7fotfzz4z6xEpYR1u
        i1I8kWb6cCawuHwFvOEG1QPOQdJy7G5IDcMiKHOHaw==
X-Google-Smtp-Source: AK7set9brXVjcK69n8TTB+vu5Ng4CHXF1hEN00ewd4DqV5LxyIHLb/HguPNsiBvcQP9E8DbdbmwQRPaCB8g2Nb+SMLk=
X-Received: by 2002:a67:dc95:0:b0:415:2063:e403 with SMTP id
 g21-20020a67dc95000000b004152063e403mr6316315vsk.3.1677751893351; Thu, 02 Mar
 2023 02:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
 <b4fc6bd8-e300-0f40-4216-8b99589c21cc@gmail.com> <895abaa2-5fd3-9928-4e53-86ce160fbad8@collabora.com>
In-Reply-To: <895abaa2-5fd3-9928-4e53-86ce160fbad8@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 2 Mar 2023 18:11:22 +0800
Message-ID: <CAGXv+5EPVhH-O+ZdoLeW4OZVcEtS824oracmu3jHTa8k-tEU0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] Enable GPU with DVFS support on MediaTek SoCs
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 6:10=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 02/03/23 10:36, Matthias Brugger ha scritto:
> > Series looks good but from my understanding has a dependency on:
> > [PATCH v4 00/12] Panfrost: Improve and add MediaTek SoCs support
> > (https://lore.kernel.org/linux-mediatek/20230228102610.707605-1-angelog=
ioacchino.delregno@collabora.com/)
> >
> > Did I get that right?
> >
>
> Yes you got it right - without the mentioned series, this one will do not=
hing
> at all (and will also fail binding checks, as the bindings are introduced=
 in
> that other series).

Please also let me test them on MT8183 and MT8186 before merging them.

ChenYu
