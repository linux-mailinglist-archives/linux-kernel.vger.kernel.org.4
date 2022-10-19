Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92450604752
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiJSNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiJSNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:36:18 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C119D111B87;
        Wed, 19 Oct 2022 06:25:01 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id h10so11322677qvq.7;
        Wed, 19 Oct 2022 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mFfOKrSEeL0UXwzGyKKR42maVOfwYSJrO2jpz4ISm5g=;
        b=oEb/9UFJVJ1DUie0yjY5fT10G5iGBi0uUTPP70ketsbo4umyLVGdnx3d/aZGpfvxcF
         Ib2oM8O1Q2imo4lcvh1OkFbrYSJtb3p3bpigOqIsfAw6vN0VZG3z+0jSOA9S2R3yVPPZ
         9PqT88//f3CB3MFe/9oQW0cbCmiOxhX4ihi5MLoZ1ZAxcmY3GSNVeuJ91b237Q9xYZbD
         BjkZ9Rz7N9zJ/kqcoEUTpZ/PjTWOsv9LznK3wTGVnS0Rz0/2Jbc9h7pzuOiKIefLyd7m
         sFQWyH/l6G9cNVyjudR0OQk75nMRAOmyl9yolOsSegJs7/Bziy1M2U6WdNtV/dChGFZm
         JAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFfOKrSEeL0UXwzGyKKR42maVOfwYSJrO2jpz4ISm5g=;
        b=QLj3he3ie8pR6yjDTg/mwPDcKoU9gVOw+QhQ+b5P+NTyDuPS+V2rQaEm6v+Km4fhaq
         NbV9wENS6LGMOHJOY8mOHveZqzCBmU5BizzaPVTeOWLli4OylNZLa+PFBcCGAAWffU1H
         bOWo+oR18sAFyS6v9+/v1YkhTyuX+KONgsjeWbrjq2ps8M9/MRza1HWQU37+r+WHdwZ/
         Psh1YSDAMFM0y5XPa7/4xYw895yWVALnfzzgJvZZw0RtQV03iyTS2D6Z/mNSDbraSpnq
         F/vqwor0OGuibUQuF4RxgNlzVWfSBwbYJHRhpovbDo+TfjtTIgTsQVZruKUkQpONUsdJ
         6YIw==
X-Gm-Message-State: ACrzQf1uzez4MvKBBS9Zz45jcsbVRSHa82iVIzLXSY2N3MVmPOH4Z007
        7pwbq2qLLb7VvQNNM+Uu4uZ5baRDjt0XHshHEic=
X-Google-Smtp-Source: AMsMyM7UQ1cRInwO7QzwiBVaRqvuznwLkROtbTi4bEX3MStqpQ7bM3v6mjbOepnYFYET36f9YLNkXOR8KwzQnvCkV78=
X-Received: by 2002:a05:6214:29ee:b0:4b1:c1d2:6635 with SMTP id
 jv14-20020a05621429ee00b004b1c1d26635mr6490797qvb.82.1666185821613; Wed, 19
 Oct 2022 06:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221019125254.952588-1-mitja@lxnav.com> <20221019125254.952588-3-mitja@lxnav.com>
In-Reply-To: <20221019125254.952588-3-mitja@lxnav.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Oct 2022 16:23:05 +0300
Message-ID: <CAHp75VcCORhVefBoQgnbe+aRJfJHfJ7PTk=Xr1eQaEYFsdJvLQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: iio: pressure: ms5611: added max SPI frequency
 setting to the example
To:     Mitja Spes <mitja@lxnav.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 3:55 PM Mitja Spes <mitja@lxnav.com> wrote:
>
> Added max SPI frequency setting to the example. It is now honored by the
> driver.

Is it possible to add a constraint here? So the schema validator will
issue the warning / error if the speed is too high.

-- 
With Best Regards,
Andy Shevchenko
