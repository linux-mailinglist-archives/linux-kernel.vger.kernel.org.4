Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A74F6E308D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDOKaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:30:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C27C421B;
        Sat, 15 Apr 2023 03:30:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ec8143400aso364568e87.0;
        Sat, 15 Apr 2023 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681554600; x=1684146600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf5kBrHHAquO9tTTXJJNq3KA4F/3xZQlU3y8nwKtzZY=;
        b=mTL5rjdi3lwF+8L3TrGB4cnbYvpNPkaiqYzPIU2ibMXZNI+brOk/v1nQCJRrKL6T+G
         UIB0438M9uKn5UJJVPOZv+Is6urzbh0ahLN39PQlfU/aG1I/GW32VZ619j2nDw8rojPi
         GwcOJ4LRSaOW8VWlU9sUkksv38tsPOOUzzWXQ59jzvyDuH7Npn4Ul3zbhSz2Gn90AvzN
         aqfUrpYFmNvydAl3NgIo79qaYpnja3s0k4Tx/8OoEq/0TLuE4eKyZePUL3tlwGnlZlZC
         sEnlNg9uWI3pmF45KQJYPAGTBkSBCQN3PbYdYDGNZE6Ii+bX1HerDiTFPOCNwXEclJ7E
         UWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681554600; x=1684146600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf5kBrHHAquO9tTTXJJNq3KA4F/3xZQlU3y8nwKtzZY=;
        b=EA8yeYF7i62+R2+93mMjYTwVpZfw4/4sfiAIG8atlqeQcO0UWP99KfnsToLyUMsynJ
         sZFUshw1NsBXLfb0f1FxJjF/0lb1/KrxUUYC6207SYqhJRWEAZvQWkTKxQ3ZuCsAqsjh
         9z3nOOHr36ClW6YVUdTZM0jf/vYA972X4zf+q4XUTCqk76wM1nxZCSQGFg469FbkLM+I
         k7PaXucZwKixVwm4x7v0ZyvRT9/tFgwOarERsI8eOJaWvQrhWu3GVXYIkWQYgT11bJ06
         XOwzkGyAgV218kLGt9sMZNwYs0QgxrATg7d0Gs6EIfxqN0MrjUgCeW5Fwyxr+ZYSjyti
         akJg==
X-Gm-Message-State: AAQBX9eYw9fJS81sUT0jdIAJdN3RR8bShTsarEZ6O7ufucuD0JNWihJY
        IXXDvhGzSZu4Vd6oQm91E9sR6sMN+E/6T6yxqGE=
X-Google-Smtp-Source: AKy350Y4mZo9R6GywEnBykaletNodZgw01NzVQS+lZb6P86QJ0T7PT5Pt0CC6t9Llo9xgu1q/QfBKJ6jj5bBbfXILT4=
X-Received: by 2002:a19:c50f:0:b0:4ec:8e50:5032 with SMTP id
 w15-20020a19c50f000000b004ec8e505032mr503319lfe.13.1681554600517; Sat, 15 Apr
 2023 03:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <7c00f4f8-5bdf-4fa6-d9f0-141cf88c9ec9@nvidia.com>
 <20230329162145.147395-1-akinobu.mita@gmail.com> <c57uedevavvjwlcvgxfv453dfiy4cgq4f23dscu5dy77sujgw2@pb6fyyfov5se>
In-Reply-To: <c57uedevavvjwlcvgxfv453dfiy4cgq4f23dscu5dy77sujgw2@pb6fyyfov5se>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 15 Apr 2023 19:29:48 +0900
Message-ID: <CAC5umyhVXdRN570SmcvMNtW-xL38siQ38PeYHrJgATxHyU4g0A@mail.gmail.com>
Subject: Re: [PATCH blktests] don't require modular null_blk for fault-injection
To:     "Shin'ichiro Kawasaki" <shinichiro@fastmail.com>
Cc:     chaitanyak@nvidia.com, akpm@linux-foundation.org, axboe@kernel.dk,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023=E5=B9=B44=E6=9C=8812=E6=97=A5(=E6=B0=B4) 12:05 Shin'ichiro Kawasaki <s=
hinichiro@fastmail.com>:
>
> Akinobu, thanks for the patch, and sorry for this slow response.
>
> On Mar 30, 2023 / 01:21, Akinobu Mita wrote:
> > I'm trying to allow configuration of null_blk fault-injection via confi=
gfs.
> >
> > This blktests change changes null_blk fault-injection settings to be
> > configured via configfs instead of module parameters.
> > This allows null_blk fault-injection tests to run even if the null_blk =
is
> > built-in the kernel and not built as a module.
>
> It's good that the three test case can run with built-in null_blk.
>
> >
> > However, to keep the scripts simple, we will skip testing if the null_b=
lk
> > does not yet support configuring fault-injection via configfs.
>
> Hmm, it means that blktests coverage will be lost on older kernels withou=
t the
> configfs support. Before this change, the test cases were not skipped on =
older
> kernel with loadable null_blk. After this patch, the test cases will be s=
kipped.
>
> Can we cover both the new and old ways? When the null_blk set up with con=
figfs
> fails, we can fallback to the old way with module parameters.
>
> For example, null_blk set up of block/014 can be like this:

OK, I'll update the tests and give it a try.
