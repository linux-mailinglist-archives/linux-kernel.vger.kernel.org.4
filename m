Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9D674DDF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjGJTLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjGJTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:10:58 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3C51BE7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:10:27 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-79702eee5a8so1098735241.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689016220; x=1691608220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgH9bF19P9qYpMUHf3fyLYC3kSHrwYWcNQb61WkbBZM=;
        b=Vq6UPox4lPif5+gZBUK67g6LMD1TrK55l2nw0aD1kQj6CrQU75rL3OkeKstIaTW+k3
         g5okbcseJqWyHbjqk5tXX+SU9k/63P4kMMCvsd+cvTZ6Fjlm7S3Hl8ZBGysF+9ug85Uw
         B+HGFKaHOkZ/xmCH3UmQoZaEQStjNdr0bdgyF13tXSsU5vKuc5xQ7P30MDukQDiAIRE6
         yMmGOUXBqr9RIbR0weNg2MOSf0Le3kMyXf0WWfomiX5CnsQ4gpd5CsCK8DblqI89eQI7
         0Rv11udrWvi1MQeSWav9uZ3yRvhDb31QrKCBPtSByef5zq2rHfZ0F1mPMmw/CIlFKuCm
         ADkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689016220; x=1691608220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgH9bF19P9qYpMUHf3fyLYC3kSHrwYWcNQb61WkbBZM=;
        b=TO11bRdGQopUgid/vPkJR/QDX/FkxqQ5e6ORgF5EeLA3wx6Ja7CQHGAFID6oqTleTv
         PKWNvEUuBOJnEkMgoShLzQItkKgqIbO9Uz5k23tT083P9j9Bv8BH62lmhoGTsXGToK0A
         R0Q5RRhn6p+4kSWcqYaEE1Zh2RddrthHShv5Y7qVmzOdStRcZz20H/XjxDMQpClUnzrn
         us4uXb6zH2Xm0l4OIPStJfC0E5j4IoHbGU094dMLXlDvFkHutwS8aXSO2DqG5ajxkO5+
         61bHeVcI6V6FbbYUTl2qR1rJSnHtT+q1qy9UmXIQzv0VZ6dA/OVDXyA7niT567koyC7L
         7hgQ==
X-Gm-Message-State: ABy/qLbYT/GAVdaX/zsSu9Z0sRNwoMHA5KFjgZo/lqsiGepV+Zv4ZwfW
        iZwM4R2uOMS4s4ra5UqCTrdakeFeWEL5WwkFtrB4Pg==
X-Google-Smtp-Source: APBJJlHXLYWRAK1TBPKRFK/U6CdwCO/hIgM870hTN2HBPd2woVKEs0qGvIqr0RD5faSdTjY9gqOFBzI0QfJO5AnH+i4=
X-Received: by 2002:a05:6102:2845:b0:443:874b:7d60 with SMTP id
 az5-20020a056102284500b00443874b7d60mr5970316vsb.26.1689016219912; Mon, 10
 Jul 2023 12:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230306211237.14876-1-asmaa@nvidia.com> <ZAZrKPw38ERSbzXg@surfacebook>
 <CH2PR12MB3895877A81288A737B702129D730A@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3895877A81288A737B702129D730A@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Jul 2023 21:10:09 +0200
Message-ID: <CAMRc=McBXyzdCqEBi9ymVHL09xKzWOhjWKpE6xxzhVJotqnngw@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 7:26=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Hi Bart,
>
> Could you please add this patch to the tree?
>
> Thanks.
> Asmaa

No, because it doesn't apply to v6.5-rc1. Please rebase and resend to
my current email address.

Bartosz
