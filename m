Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776AF6D56B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjDDC0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDDC0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:26:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8397A1BF8;
        Mon,  3 Apr 2023 19:26:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id fb38so20500265pfb.7;
        Mon, 03 Apr 2023 19:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680575160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GV+hV7KhmzvbLD6bA1TpCyCxEKdI9ig9FNwBHbqzqAk=;
        b=gF++eYVQj/QhT4YRC10xcYjqVGowbz89W0FfMaiLVZH9INQxLhYsjhWGWUlstBp83x
         qUnQNwSiYPeQMsAEhIwvDlCGcoaukqsPIAp0UROZe0qslHdQ+CdSIi2oV80byDJDIBNH
         lc3iHFwzJaBzEGpn59jIn2sMd5gBY4wrTnYEpSaFW+xFVczCn+wmduF87wCnjEkwOWg4
         6yWMmLLFqVVRWvpHo5GcH8HuLZERrZmt+DYCC8PN5sk3lLEkslliIv+4LoDIzigm5Scw
         iEAXLBtn9jb/eI8YrYaTXf//N0+MxXKmtjk3m4UW2whY41EM319uyvB6B0LQeLoRgENL
         6g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680575160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV+hV7KhmzvbLD6bA1TpCyCxEKdI9ig9FNwBHbqzqAk=;
        b=ZuIgpvZ9gEEpZJfDShJJs6zBA33kGAGz2klY2dJ/c297NCDzNIMD7C/zCy8K8a1eqN
         EqJTov54bPvzc3po8p6URw+WdK27KUKx5AyxfIIO7ZeGqnK4WmeW3L8YlEdBI2++K3yd
         lCZmCreW1e4ygOi/wasRfYzBEAd7xFIqZGKmjYkPjJ9zV75PYAkK0egotoTIRN6gW2YX
         gDdEUCYObKrfHexUABGb/Zn/t+i/jd/MbM4U02igYlKHlCGrJGfgxxywBlJA5IIisW67
         bR0MYxxNhfB5odnJ4N9OpNiJ9K8nnsmtsQVidwXiuqjxcQtsftMN2RrdsaJFkKcQ4AQ2
         IMnA==
X-Gm-Message-State: AAQBX9fbyCgHiUa23P+alpfNfRh7L+eWJe8WiKcdBnJXS6Izs7KpmWNJ
        LEjM7jzu6t/lyrB3CMnTwGjStNDC5iqqSxZnIec=
X-Google-Smtp-Source: AKy350Yxjttr3dQjWc6G82Cc+c/rAPio9mc/+lxtvochgWgVBGhvJY5y1fh3YPkEW8/F0cL+M+O+hwebCjoSteKuRA0=
X-Received: by 2002:a05:6a00:240e:b0:625:c832:6a10 with SMTP id
 z14-20020a056a00240e00b00625c8326a10mr371528pfh.4.1680575159973; Mon, 03 Apr
 2023 19:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230328072537.20188-1-yanyan.yan@antgroup.com>
In-Reply-To: <20230328072537.20188-1-yanyan.yan@antgroup.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 4 Apr 2023 10:25:48 +0800
Message-ID: <CAJhGHyBqQSZ=SnPS+=k_EbFQbHbh=0YccmQzzO+Q23n=S2GJ4g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: update kernel stack for x86_64
To:     =?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?= <yanyan.yan@antgroup.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, =?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>
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

On Tue, Mar 28, 2023 at 3:34=E2=80=AFPM =E6=99=8F=E8=89=B3(=E9=87=87=E8=8B=
=93) <yanyan.yan@antgroup.com> wrote:
>
> Commit 6538b8ea886e ("x86_64: expand kernel stack to 16K")
> expanded kernel stack for x86_64 but left the wrong documentation,
> update it.
>
> Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
> ---

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
