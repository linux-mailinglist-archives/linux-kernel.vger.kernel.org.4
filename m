Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A05727C9D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjFHKTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbjFHKS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:18:58 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339032D44;
        Thu,  8 Jun 2023 03:18:51 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-62613b2c8b7so3848796d6.1;
        Thu, 08 Jun 2023 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686219530; x=1688811530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JzDRQTu2anAKOCuvweNwOte+Ov7P3GHzZHTA5KX5ug=;
        b=f1RmXunUiHGTSIsuVcre+IzVmQEWHea2gNeRTSZGgVcchXFgtzbBkhSnCXp+Op00k/
         TKTDtSU0limW12t2pyeMhDIMB1FzmYeQo/vwfCikG0D0j512swlirIHEr8too/tdwmkx
         VNv5EzO75Jdi1AxOMuY4x1m22ItFVgLgIJ7Hp5vMvXqFGQ/UF2MMS3I4imL6bk1wS+Rf
         EH5GpHcCzM9hgnm98yMbwvkrdy17f0cOgxJtpHpo5zRIVIF9z4zKAL4+7aD6XgjNSIpK
         DhecSzCMcNw6C7Me+KOvBCcgDBiLKHTBbYyFrgQwHs8lw8uCTv3An7yKZCflARzXSKg9
         glFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686219530; x=1688811530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JzDRQTu2anAKOCuvweNwOte+Ov7P3GHzZHTA5KX5ug=;
        b=Nh8p9qAaOtlI1aeNeF0TJb6XqH58sLE6koKYLA2UYjvF3rJCIMcxMkOB4h5iNbwjK8
         PebSGk/b6d463/coAFqsUT/ets+Cx1fFPgemNH/qQStV5CJYkAR765CStvu19+Lzr0Pr
         kPWhkucaU7XlfZoo8OOvRbncOdRSKmEfpZ8SYX94wFAOehGQOKzg+IeaiHaAjtFHwbjb
         J3UU2jkhRAImYcZ5hi9lsKyyDFEtvEoqDPoHicg62Wzkfo3tV/PrJWq76jz3v/OsRw+a
         5yKOZI/wAF9kCGr9b6G0aO3jCOS6ODTrLCMdudXLFJopdLx05XGhkvWFzPOLt5FKpRQC
         EWCQ==
X-Gm-Message-State: AC+VfDwpspVGjomPddDOlWZRUzG92H6gqK803VfXaBsOdpKwllQS/FwI
        DaFg7zxCN3hrzxxejbz8iBMxuiM2vrT+TR/wiPggbNOT1iKmsg==
X-Google-Smtp-Source: ACHHUZ4NbFlpJAlJsnscvhzWPTZs3jrylTldJVtKj9rsnv5BZUFnJ8aIjGi0lQsuJUOETLSX0IDqNEU/8aI0N603AYM=
X-Received: by 2002:a05:6214:27cf:b0:61b:5afc:d4be with SMTP id
 ge15-20020a05621427cf00b0061b5afcd4bemr1145940qvb.7.1686219530280; Thu, 08
 Jun 2023 03:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230608072819.25930-1-zhuyinbo@loongson.cn> <20230608072819.25930-3-zhuyinbo@loongson.cn>
 <CAHp75VfrPX=VsXMry0Dg_Y4zgt59S=uY=rxCZzv8fBvr_w+i-g@mail.gmail.com>
In-Reply-To: <CAHp75VfrPX=VsXMry0Dg_Y4zgt59S=uY=rxCZzv8fBvr_w+i-g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Jun 2023 13:18:14 +0300
Message-ID: <CAHp75VfUg6wq1xSpGsQFQpYbK+tkA3NJBCjBMte6sB7fQBBvrw@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
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

On Thu, Jun 8, 2023 at 1:15=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jun 8, 2023 at 10:28=E2=80=AFAM Yinbo Zhu <zhuyinbo@loongson.cn> =
wrote:




> > +       ret =3D readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SP=
SR_REG, loongson_spi->spsr,
> > +                       (loongson_spi->spsr & 0x1) !=3D LOONGSON_SPI_SP=
SR_RFEMPTY, 1, MSEC_PER_SEC);
>
>                        (loongson_spi->spsr &
> LOONGSON_SPI_SPSR_RFEMPTY) !=3D LOONGSON_SPI_SPSR_RFEMPTY,
>                        1, MSEC_PER_SEC);

Actually the last should be USEC_PER_MSEC, as the parameter is in microseco=
nds.

--=20
With Best Regards,
Andy Shevchenko
