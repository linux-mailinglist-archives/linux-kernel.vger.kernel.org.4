Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511D76CFFFC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjC3JmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjC3JmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:42:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4756E93
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:42:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x17so23754284lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680169337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k+ftPu1pOQhWJUqmpZoNXnka9ZSxidu9TmOjrsgsRc=;
        b=ImBZjcN6EHm/FQr3czBlAuWIJeVX+PlaicLsHzO61GZjBUXjieonAJsgRnFybWa2Sb
         tTxYFWfb2gllA7JO2j26JzZo4eJcepeWT2a8ab7uDhn5JGCXJo/ki/AASSeS6ho9KJ4Q
         y3HjCd9cS4iUpgnD1yIzv0QfV2lpRS2nrRQN5C/6hfScWU4BCfjIC+ge3hQ9GkPujLJq
         wyW7CxoUZrEYpSqpnRvJkLD8Ac7r7j4Wqz/2FHdvO88T1WJDZAwMdGa7ZFJHzViybs5b
         l4WNMWfM2uW9QCMIZRCV6JnZQ4Srk04esGEO8lKebnNlM07bhZNSakF0TPWP7BcZTSkh
         ehVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680169337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8k+ftPu1pOQhWJUqmpZoNXnka9ZSxidu9TmOjrsgsRc=;
        b=seLeVrTQsoDCPyscIUD8HNXHwZX1UnPV8/LCVQ9c3S4FuOsV7N0OlgSU8OMHdp3jBn
         qodvJ8zEHRDHj3JlZT3Br8Fm61kJuwhsx+UWwzK1j3Yr9dm2KoDrOaBj/7zPySF9BxQ7
         0NONzx/CP4bGlRZr01hoTwbXKXNClgbChdWikKSfTEJogMi+yf3tnIz36u/6MCp0uKay
         a7F4BIJOlSnPFz9b6OThRqsmDAHWMejyd6SJk6J3QCd/m855v2OVhC5QBojKUON6Po74
         ZDFWN59iq9nB6W5yapAj74rcxaEOfxrcNABEIu+yj34Lzo7kFsqBRSQdQSruUbSqkvNx
         w3GQ==
X-Gm-Message-State: AAQBX9eWNCUah+ndzYjXqHmfN7JAp4QnQIImiWxrKlAWmaelMUFvqYcI
        FFbLnbnR7aapm1qUhDcdGBfEV+7kxdCsBTRVAZrrr5fu
X-Google-Smtp-Source: AKy350aA2hRcKGMpD5L8ZSuM0W1ha9Ld0y2KHoHT5geFAS/zx0W87IbxWa+TjhaBL3smiced1VzNWBc44g/MloUnGIs=
X-Received: by 2002:ac2:44d9:0:b0:4d5:ca42:e43b with SMTP id
 d25-20020ac244d9000000b004d5ca42e43bmr6463457lfm.4.1680169337074; Thu, 30 Mar
 2023 02:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <1680086855-7989-1-git-send-email-zhaoyang.huang@unisoc.com>
 <ZCRRaHHKVt7fpvmD@cmpxchg.org> <CAGWkznFRHbYv2ev3FU10zapka_6MDQ+g_-b0jufzqcAEAKUqFA@mail.gmail.com>
 <ZCVXFLA+sarzGG18@cmpxchg.org>
In-Reply-To: <ZCVXFLA+sarzGG18@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 30 Mar 2023 17:41:55 +0800
Message-ID: <CAGWkznEdSaZRritHazo301Zyaage_R_4Grr4m8EirH7j8_-oOg@mail.gmail.com>
Subject: Re: [PATCH] mm: mark folio as workingset in lru_deactivate_fn
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 5:32=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Mar 30, 2023 at 09:38:48AM +0800, Zhaoyang Huang wrote:
> > On Wed, Mar 29, 2023 at 10:55=E2=80=AFPM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > On Wed, Mar 29, 2023 at 06:47:35PM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > folio will skip of being set as workingset in lru_deactivate_fn.
> > >
> > > Can you please elaborate why that's undesirable? What's the problem
> > > you're fixing?
> > If I am correct, folio will skip being set as workingset when moving
> > from active lru to inactive lru, which is performed on every folio in
> > shrink_active_list during normal reclaim.
>
> shrink_active_list directly calls folio_set_workingset(). The function
> you're editing is used for things like MADV_COLD and truncate().
Yes.
>
> It sounds like there is just a misunderstanding of the code, not an
> actual problem.
Isn't that a problem? As my understanding, MADV_COLD could be deemed
as a stimulation of normal reclaiming which turbo the folio towards
eviction, while the page moving by it should be also delt in the same
way(PG_active has been cleaned)
