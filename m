Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A1E6F8982
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjEET06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjEET04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:26:56 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC7E1A5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:26:53 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-61a35fdf61dso10686286d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683314813; x=1685906813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ro+PQryLZOJM5OUIb5r4A2dnLf2HCWRpu2K+aKJJJo=;
        b=DWcwiRw0jv7cHw3V51vVQEq0ZakL9x0GuKh4qDURNfy/3TyYBFWd+N2L6/LyP6NpnS
         KejH6RxFkVetxFpTsc8J856/GdDuptEhsoPomIwFZkjxHD2lzt+7x0cby33ry1Qp4hvh
         GnYfDjt/VDi+KfE5cDZvvz/eCzcH5hkEVspGEWbeEs6MpaDIRxg8jXr8TBUtXhWKzI1X
         3YJCP7HaeE+DLk+xX7tj1E1YGZeHgCc7awhxHMf6Jr4Ty4tGehsKlIlrc4bK1Ek4nyhA
         v9l5jFPynOvuVqupHWRneTyPCVU8E/RTOVc5wusm8iJhbbg/S/rQYuO+VNdREZ06Kh7g
         oYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683314813; x=1685906813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ro+PQryLZOJM5OUIb5r4A2dnLf2HCWRpu2K+aKJJJo=;
        b=BwnJn/MID11HJmaT6jrdTvJNZHb35hOZdF9Ee+0+uqvj29IRQsPV4/DX2epf/sbvJ2
         iRgNr3n+It4Wanz29rHwza5AUP+n28GPbO341CbYEYbZfAMff+AXKcpm6Ir9rBLWzeVH
         GvyqMwdXl9NqzQ9xwtiHBee7CTMwfl8PZt+jzkYGjQCppSpdOBo9B8vZN+YAXOlUk/vj
         1pEpkl8L3grWfW+tZkXmSJmGcaO1xwcU9emOM06Tfy3PpMQQGqK1HKua/Hbx+6UpOcM5
         aNbo/7G4ceKiAYtDkwVWYrBBRjUxk8V3tpOZA1oI82G/rMIW781XFQ1TxB+RtDZQU/+p
         WGMg==
X-Gm-Message-State: AC+VfDyjDCQNjMUtAela3c0yeDG/fuV9NolfSTJqBnN8bKPXUjPO2LuC
        hhQNlOvFaUIfzLsWqtI2UfCqCTnh9j35kIC1oRU=
X-Google-Smtp-Source: ACHHUZ5z7+damzz+a/zr6hO9NJ48cEoYwtk33Qxx4KIkqzNlagT2sv4Yfwzo+OewEDet0ht2L5b1wUSe/rUGML8dZug=
X-Received: by 2002:a05:6214:5007:b0:61b:743c:34f6 with SMTP id
 jo7-20020a056214500700b0061b743c34f6mr4173404qvb.30.1683314812962; Fri, 05
 May 2023 12:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230505185054.2417128-1-nphamcs@gmail.com> <20230505121401.31826e1251fb8792fe64f675@linux-foundation.org>
In-Reply-To: <20230505121401.31826e1251fb8792fe64f675@linux-foundation.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 5 May 2023 12:26:42 -0700
Message-ID: <CAKEwX=PG9zx=vCBV-m2S0-LBS0EyUakOfpLxN3Zmr6god3nASQ@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to zs_malloc()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
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

On Fri, May 5, 2023 at 12:14=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri,  5 May 2023 11:50:54 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > Under memory pressure, we sometimes observe the following crash:
> >
> > [ 5694.832838] ------------[ cut here ]------------
> > [ 5694.842093] list_del corruption, ffff888014b6a448->next is LIST_POIS=
ON1 (dead000000000100)
> >
> > ...
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> Am I correct in believing that we should backport this fix into earlier
> kernels?
>
> And that a suitable Fixes: target is 64f768c6b32e ("zsmalloc: add a LRU
> to zs_pool to keep track of zspages in LRU order)"?
>

Hi Andrew,

For both questions - yes I believe so too!
