Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01D25B8941
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiINNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiINNhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:37:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7EE237E9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:37:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m3so2446764eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PkC8kFXO3jlM8WLLDky2O765UdWNM37n3pqNL4x9fvQ=;
        b=ddAZngo0FdDKlKnJeSZ3XyxY8ns9ns3WyBhLdO2yZT1Cl3aLr7DQbNu7sAt1cLJWFn
         Ty2M01ofHUhDycR3ahgDjtwMSGV3LYCCGd6DuI8FhVZaH721oPzV1jLg4E9kZzJrcq+M
         3ZQnEZ+4k5tR8UXEd39xlNfjYlSA65qYvKfgkVUV39AjROoqQ1Yj10EnCAzAiQLZg1P5
         7Sg6LJvqtz8FCBhO5RO9ZGB8B/s4wjrtVt65CIHcucudAoIOcjy4Rc/zCvLGZTTFAKoM
         Z8SKerqiM3cyjzmSHBEU9gs6QHAgnm30YRHF+R1yTAk7c63poirc3gzplIv+4fQdEn/O
         PCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PkC8kFXO3jlM8WLLDky2O765UdWNM37n3pqNL4x9fvQ=;
        b=uG7WRcCxl7CmxEqzhD3fGEj3Iaq8E5+8/pd9ZDGpu+jnV4jqpLbHnYq743G7HZYTO7
         ovM7ARPUrmQ2uDxliRPSn1IIcq6CMpxp4ApQGXzBlXSojIFhpVOC3VadFPC2o5WCxM0m
         17AEixc4ZSDFy0bgQFl5AV3xZrQv9i4dkc61XaH7b0LmJ6U+NksQBfqpMy+l+w/LLm/1
         SR8ELeAmMm0AOqS5/CK04rk46yrFm094dWx6dyLvnCUleD66m+fD51YSSkdBDT+oSUbZ
         Q08eFVL/SfR1NwbtbFfKZxNKQH5u8g9US7WpWbekE2qESYjofVrhx/nxiM5o91b3lvW0
         nBzA==
X-Gm-Message-State: ACgBeo20yyyNtPfaMddH3tJCH37qSelKPk+W2Se9Wie8XKGPCFhC0RLZ
        R6jjyvunvI2NUEQrMHQSv3Fq0qaoaHnagGENL9cFhw==
X-Google-Smtp-Source: AA6agR6zTJpXDs1mbNIDy3e6GHNIMO9LRrZLm8QHRCn3HOg5busq2bmEtje3trdhWeFhX7HAXczaoGjQJP8pkIAtdoQ=
X-Received: by 2002:aa7:d6d9:0:b0:44d:e1b7:d905 with SMTP id
 x25-20020aa7d6d9000000b0044de1b7d905mr30714192edr.32.1663162626125; Wed, 14
 Sep 2022 06:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com> <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com> <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com> <20220906220901.p2c44we7i4c35uvx@pali>
 <YxfMkzW+5W3Hm1dU@google.com> <CACRpkdZh0BF1jjPB4FSTg12_=aOpK-kMiOFD+A8p5unr1+4+Ow@mail.gmail.com>
 <CAMRc=MdrX5Pz1d-SM2PPikEYw0zJBe6GCdr4pEfgBLMi1J9PAQ@mail.gmail.com> <YyHQdN14bI4WeCKp@sol>
In-Reply-To: <YyHQdN14bI4WeCKp@sol>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 15:36:54 +0200
Message-ID: <CACRpkda=BKafP7W4SPm5La2WtqdNvjcjHoLp9oD8Zq5PYHCweA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 3:00 PM Kent Gibson <warthog618@gmail.com> wrote:

> The key distinction is whether you are describing a physical or logical
> value/state.
> High/low should be reserved for physical.
> Active/inactive describe logical.
>
> (I personally dislike "deassert" as it is a manufactured word that feels
> very awkward.)

I would certainly trust anyone native Anglo-Saxon to say what is the
best word here, so I will happily fold on this.

> Changing gpiod_set_value() to gpiod_set_state(), while leaving
> gpiod_set_raw_value() as is, does not reduce confusion - at least not for
> me.

Sloppy of me, certainly these would need to be renamed
too. The _raw being high/low and the logic accessors
active/inactive.

Yours,
Linus Walleij
