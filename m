Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D1728584
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjFHQlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjFHQlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:41:17 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2D135B7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:40:28 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bacfb7acdb7so911781276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1686242420; x=1688834420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwnQ7gMh3uF6spn3zYJa58b55y9bAxiBUmqGszFwGVo=;
        b=lV8Oq9jr+qs5CBBD4k99wi7E6Erg+3UMqQO6g1CLrP6DZMzZcC8mo1C1/edmWtYSgm
         SHXhqE8CsET658KeeX2HFIDNBg74QRHOtn02txcoeaUVJE2rvZr7EhLHCrbOx0Ua3VmM
         ENXiR/wro9HlowHjylthoBK1osBPztl8Hy/eeH/A7ifXmBtdsDwk4sBH5n2ZddovlXzg
         DqeBSS/l/vGkw/Exb+DFzTJbnhlwpEtFKj1ozLzw0uRHJBcs7Sdet0YJCIc9ZVRGu6j/
         84PO5q77AiiKBp/NCxKjc2sfz6WZT9zcV00JlijBVVwuo9whKudvvP76GJ/dz80+8DYT
         39xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242420; x=1688834420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwnQ7gMh3uF6spn3zYJa58b55y9bAxiBUmqGszFwGVo=;
        b=IWfy1e+KN4tkdlQyDrhTGiwcY9t3v3XskqD0PwuY4JK1kK8b/Za3ImU+BjuavuU3jD
         c5X4vrc/Kv0aNkKx22dgVT/DJUrvbJ4iBpWySh9kBbzEFDm5RROZUnMkIJvw/TBL5vac
         KE60UXoe73oI9wWHpg0OeoyEICldPGrRuD8lwenEV0ZL6gziw+wMNikeRErAemtUL5FA
         d2PfNIdoTo2vTRjKjKtpRp0cvOUHZ/pDKl1Mp/F4344aB0XoH/U3tJatDQc/TOIKZung
         esIEfSWU/19fGa/Ot9JufYY6wDwNsCfUMUzLihavs9dVX4nwqDHcpVNThQKhDJKIWKGS
         xdYQ==
X-Gm-Message-State: AC+VfDxCBYh2o+5giXbLvMW21Ux5P2CJzYTtVdg9J+q+O2NvVqQItBuH
        3U6yGrdgmdjgLU0mGeQ29j4DXoomAid1J6U17KLdew==
X-Google-Smtp-Source: ACHHUZ7AhZn88bGMPHCodPlvz7TYoJYekWOxx3DkGp98MOcvdzej8YJDk5M7zt3LTY6QweM05oWxl2WZDOFPXYaXAio=
X-Received: by 2002:a81:5c86:0:b0:569:4fc4:62fe with SMTP id
 q128-20020a815c86000000b005694fc462femr283806ywb.12.1686242420111; Thu, 08
 Jun 2023 09:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230608072903.3404438-1-lee@kernel.org> <CANn89iKtkzTKhmeK15BO4uZOBQJhQWgQkaUgT+cxo+BwxE6Ofw@mail.gmail.com>
 <20230608074701.GD1930705@google.com>
In-Reply-To: <20230608074701.GD1930705@google.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Thu, 8 Jun 2023 12:40:09 -0400
Message-ID: <CAM0EoM=osXFK7FLzF2QB3PvZ+W4sr=pnPD5jG1FjrzSbw-emWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
To:     Lee Jones <lee@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 3:47=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 08 Jun 2023, Eric Dumazet wrote:
>
> > On Thu, Jun 8, 2023 at 9:29=E2=80=AFAM Lee Jones <lee@kernel.org> wrote=
:
> > >
> > > In the event of a failure in tcf_change_indev(), u32_set_parms() will
> > > immediately return without decrementing the recently incremented
> > > reference counter.  If this happens enough times, the counter will
> > > rollover and the reference freed, leading to a double free which can =
be
> > > used to do 'bad things'.
> > >
> > > In order to prevent this, move the point of possible failure above th=
e
> > > point where the reference counter is incremented.  Also save any
> > > meaningful return values to be applied to the return data at the
> > > appropriate point in time.
> > >
> > > This issue was caught with KASAN.
> > >
> > > Fixes: 705c7091262d ("net: sched: cls_u32: no need to call tcf_exts_c=
hange for newly allocated struct")
> > > Suggested-by: Eric Dumazet <edumazet@google.com>
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> >
> > Thanks Lee !
>
> No problem.  Thanks for your help.
>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
