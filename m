Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5874B6D5DB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjDDKlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjDDKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:41:01 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DA11BDA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:41:00 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id k17so38054009ybm.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680604860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iwzxcbPB4/3rI7150D2ESWEJjPWEtJtDQ2Zs7FQqEt0=;
        b=SUFUspxs2Cp1C8kUOGZYdY2Zvb4y54hXE/8HnGNxANyC2PDp+d1Q7Hr0T9zeT6oW00
         DUi0fT9z66wuS+lE1crsbq4U+qVbo3fgPKBw002TBoyayhmG5rq8XA19PhlnzJ7f2oEJ
         Vc3ahi76OMDKAU0vLklXduGXmDF+/Nuk8tFF9H/hINrhnYrq5xwJOENWTmAzTBvlFiWT
         S6DVslWaWnsZE3PCRsPm+R8dAKYQ11JnSbwpVxPnQSIqvpAPsf7b3/u31mBjIoOo6ZEf
         UfY40lpgwP/g71UOXfoJXMTV2Juu/HgU28QGP3GqR/Na5sSsubESlyHbih+iNT2M10Yz
         oVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680604860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwzxcbPB4/3rI7150D2ESWEJjPWEtJtDQ2Zs7FQqEt0=;
        b=yZ6tnkx1VfPEZkxu0V58Q5ivhlk9GgHuPpYeWmo64K3M8bNvGManbwCWY3OGm6PEFN
         gZEIRMgD35xQOErT2NPhiVQzRGtB9SJNggATJEtlHQeELCYovkxiHxbOMqqcZ+nh5hdO
         D5HFpH0kzT3rYpJq1S3LNbPiHmUymwwTY4tVlztT6nSW6v24u5vV2izrFqFOGHEkpL8I
         ebxqQO5usaGyZ2nAd1cTULvvONqVsdOWVfcwRFJkMSLBzCCiglmwvwAqIxVKKoAlqKKW
         hUWY4cMSaST4gesQmJ42/dpssJ5Zqzs3wwRurHz/Ln9qCuegvH9qnYHbmG2QoXpI9zq9
         Aw3Q==
X-Gm-Message-State: AAQBX9d5DA2oGPDM4vXWMckXUxVzlx5XCu9ZB6RYIKA39iFh/X9smbYW
        +Ttp84ydTyjEHkHBNxvHaAwsDeZ20nrzPROI1CYY9g==
X-Google-Smtp-Source: AKy350bZ9UZGq0HiTB71Lay4t1LWQkCqgaAqqLPnMGi8vARxIVQ4/GlwkNrGcd5OS9PIrjqQ2KdjmOcuOat5Z7oaiwc=
X-Received: by 2002:a25:d0e:0:b0:990:b53f:933a with SMTP id
 14-20020a250d0e000000b00990b53f933amr2425696ybn.60.1680604859787; Tue, 04 Apr
 2023 03:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230403122738.6006-1-zhangpeng.00@bytedance.com> <CAG_fn=UEah3DLYm2yKxBKg=L=Qc_PSnrKhZ2==snbw05XAtVZQ@mail.gmail.com>
In-Reply-To: <CAG_fn=UEah3DLYm2yKxBKg=L=Qc_PSnrKhZ2==snbw05XAtVZQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 4 Apr 2023 12:40:23 +0200
Message-ID: <CAG_fn=VJwtnn8zu8oOZuG2rNUM46Rvz-36oEfVJiCsyeee8unA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kfence: Improve the performance of
 __kfence_alloc() and __kfence_free()
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >         /* Apply to left of object. */
> > -       for (addr = pageaddr; addr < meta->addr; addr++) {
> > -               if (!fn((u8 *)addr))
> > +       for (; meta->addr - addr >= sizeof(u64); addr += sizeof(u64)) {
> > +               if (unlikely(*((u64 *)addr) != KFENCE_CANARY_PATTERN_U64))
> >                         break;
> >         }
> I am confused. Right now this loop either runs from pageaddr to
> meta_addr if there's no corruption, or breaks at the first corrupted
> byte.
> Regardless of that, we are applying check_canary_byte() to every byte
> of that range in the following loop.
> Shouldn't the two be nested, like in the case of the canary bytes to
> the right of the object?
>
Please disregard my comment. This loop is fine, it just speeds up
finding the first corrupted byte.
