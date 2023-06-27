Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CAD7406A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjF0Wve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjF0WvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:51:25 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E430C4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:51:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b13e2af122so3990705a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687906271; x=1690498271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LszDuwd0JI0HIewJamGQBtOvL8Phlguklg1GXeUghc=;
        b=ZTYm0x40ZLSTozo8OdUEDg6aP6VHAjEOKt9m8a0VBIjPKMsjmlIY1APoWlVbnY1h6J
         aZtv0BhxbvxJSxqbPds7nuadWCdi0PBCYA2iNGFfdOk1IqhFmHrIyRE9gQQMfdYS+HTk
         fErHPcxhdvdFNBQppWAgoB5zXa9h5PojIHov5akQnttxyiOJZlLX4RjAcHbirkkgc6eK
         UILitNX/PP7zfXjJi52fUfPegeCZDgv2Bm/sk5ldUCK6E3zbYZ5rwi+BRNMfftMbsELO
         r7CDVFXlUMe8FL7GLtVwmOxlS6WRyo9Hq8chC13ZxJ8LpqRgneIefylWnMov7kFaI21l
         kxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687906271; x=1690498271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LszDuwd0JI0HIewJamGQBtOvL8Phlguklg1GXeUghc=;
        b=dCNUpmhIHZsShxENxIrGn19U39AoN/aVc3Q2vT0EE7+R98ChNl6g3jiEHbYmfQacoh
         WcVaZJqnxUX+IyBtRdYT2HuyrvJimNXyJnLitBBcd1V1XX/wlTYheOQszcOcJwgC6q2i
         Tg0p3Fti+t0ZXGJknHTEPIAClyw/mOGJZqJ3tIk1iJyH0yoD6pU2NheptUPQ+af6fVc3
         /PuQbRTDbm4i5GySU7FYTMuosjBBk6E2EWeIhtvQ9hRjGdr/yR9hyjAUAufA9y4gT5H5
         svLI/upx7ewcLm6g0qQrnIwvF1B6BwC9GpzCDDjj5AoxpUZhU14Lvh2gzV7kILidWqwp
         vD5Q==
X-Gm-Message-State: AC+VfDxexHBxGnugaZrtYzeAWsEtxibco9jQ8iq73rqNoAnvulAoHRi+
        69M05VIhH5cJ1e4v9p021xDR3ks5DUAEDmXlFjkNjg==
X-Google-Smtp-Source: ACHHUZ47JJm2vI3qvxCQ6n+rlicIXi+ipR+Jw7Pls8XgO10xo3/Bb5T8+xNik6O7lNv/FyTOGt88gkiuaHQT3QevGS0=
X-Received: by 2002:a05:6830:1e96:b0:6b7:4aa6:77b0 with SMTP id
 n22-20020a0568301e9600b006b74aa677b0mr7005846otr.17.1687906271134; Tue, 27
 Jun 2023 15:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
 <20230531221955.GD102494@cmpxchg.org> <230e45e8-8cd8-3668-bbfa-a95212b4cb99@quicinc.com>
 <20230605180013.GD221380@cmpxchg.org> <f3f15b6a-8618-f755-f21c-4193c502e65c@quicinc.com>
 <CAJuCfpFB33GLbwvYspg966b6AGMopS3ca68hjL94kgpM7et7CQ@mail.gmail.com>
 <4543c4e5-43f1-bae2-245e-951437e4bd07@quicinc.com> <CAJuCfpE42OJZur-1u2hvvXmPkRdV1uOfK-Aqm2POmvrDpRwg0Q@mail.gmail.com>
 <70743150-dc85-1a1a-87ec-e3dd9f72c5d0@quicinc.com>
In-Reply-To: <70743150-dc85-1a1a-87ec-e3dd9f72c5d0@quicinc.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 15:50:59 -0700
Message-ID: <CAJuCfpHgC2=BebzdwcH3-bUR2VQ8=hti2d7YNwF_6ij-JLyOHw@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        minchan@kernel.org, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 7:31=E2=80=AFAM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Hi Suren,
>
> On 6/10/2023 4:43 AM, Suren Baghdasaryan wrote:
> >>> I can see use for that from userspace to detect incorrect madvise()
> >>> and adjust its aggressiveness. I think the API might get a bit comple=
x
> >>> because of the need to associate refaults with specific madvise()/VMA=
s
> >>> to understand which hint was incorrect and adjust the behavior.
> >>> Instead what is the opinion about giving an MADV_PAGEOUT_INACTIVE
> >> interface which does operate on a page only If it is on the inactive
> >> list and !PageWorkingset ?
> > IOW you want a less aggressive mechanism which can be used by the
> > userspace to tell the kernel "I think these pages won't be used but
> > I'm not 100% sure, so drop them only if they are inactive"?
> >  I don't know how much that will help when the madvise() ends up being
> > wrong but maybe you can quickly experiment and tell us if the
> > difference is substantial?
>
> We did some extensive testing on Android and this ask is not helping us
> much. I am really not sure if there is some other usecase that can
> benefit from this. So, for now I just stick to your suggestion of making
> the pages on the Active list as the Workingset at the time of pageout.
> >

Thanks for checking that. Your plan SGTM.

>
> Thanks.
>
