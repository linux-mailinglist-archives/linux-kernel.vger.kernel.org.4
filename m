Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06306AC314
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCFOVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCFOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:21:07 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11AF34036;
        Mon,  6 Mar 2023 06:19:51 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id e9-20020a056830200900b00694651d19f6so2490733otp.12;
        Mon, 06 Mar 2023 06:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678112258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=voEN8gET+7DiUcyJQtCG0y4HhLJdTYcLogFd10E8rrc=;
        b=jEq/ashKzXcjAsHUrZsxHmSfodeOrA1neOKOBXbu/ZfnQr+sFhmgIHqbU2o7mV3aSV
         B5B2N9vjVC+20KpC1YCN2bKxqLAqZO2vRgYyMWiyuhObthLY1VZOQD4utxF0r/qP8/9q
         HUTaFD2YwJ5W3Qx6t0+7Aky40oVmhiDjSrgVkHHB53967ja1l8PvRO9sg04KFEbEBeHX
         Y5jX/DiuqK0EVsAc1Z4g3JDnl5K6O05c1KgSpOvhdUn00qpodfnnvdnZemXDIcuu9ghu
         lErNN4+gLVyBuD3QcVQoXZMSSJ15cb7Kf376ogFZSx7Zm3/HY48Mqhgtvr19mEhLB+3a
         nhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678112258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voEN8gET+7DiUcyJQtCG0y4HhLJdTYcLogFd10E8rrc=;
        b=1fHg0q/k6sKh6OicW4TEHGKGoMNx8ychJSL4KmDvBJZtLS4BAN8ppV6eAWO+hL+EoL
         YYZxTqPxAY3T/jnHeP+Or+x7zDOizK4c5Y4mdUnRp37EtsMDNlbgGgZ/mOnPQL69UIFh
         kfQHIEeznIOOqW+yUrugUTnKsVx+KmI5XhQZ84F2xo7ydy8fa0M0vG8pStoAMtdgwGVS
         O9YJAswShWWj6/pzXt9ii5jbzahuZ3hRRkitCzgGYEm561K2l2FZYpYTOhk1ygB3f6ku
         1PpLJjf+ETLIciYqpcWyMpK4/cKDFZ7o6xqPE/uUcUOqfaXH16TE9jDOKQwkswx35xxW
         QhEA==
X-Gm-Message-State: AO0yUKWunOfjukV0g7+bJF8J4Y9qeUTCth6IpSiXCJiePJr7htwCEG4+
        qZVTxVkRt0PuBXi/2CiFXKa8GXumYg3iBjEitao=
X-Google-Smtp-Source: AK7set/d3V10QGAOVH0x9a7k8hdACyp9ie6Qu3VysSW6Jhcs32oGP3s/xpbqNZ6TCg8IkG0+wiyaJ3fxnmczf1DQxVs=
X-Received: by 2002:a05:6830:2464:b0:693:d8a3:1f15 with SMTP id
 x36-20020a056830246400b00693d8a31f15mr3295162otr.6.1678112258230; Mon, 06 Mar
 2023 06:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <CACRpkdayVLTT0x6hfnwvL-Atafkj8PRw5uwe7Wic3jtn+X-axA@mail.gmail.com>
In-Reply-To: <CACRpkdayVLTT0x6hfnwvL-Atafkj8PRw5uwe7Wic3jtn+X-axA@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 6 Mar 2023 15:17:25 +0100
Message-ID: <CAMhs-H91yT_Fvuis6dVRaunMKajEcF+GwXUb2pdrtWyEFbt2wA@mail.gmail.com>
Subject: Re: [PATCH 00/20] pinctrl: ralink: fix ABI, improve driver, move to
 mediatek, improve dt-bindings
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     arinc9.unal@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 2:50 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Mar 3, 2023 at 1:29 AM <arinc9.unal@gmail.com> wrote:
>
> > [PATCH 00/20] pinctrl: ralink: fix ABI, improve driver, move to mediatek, improve dt-bindings
> >
> > This is an ambitious effort I've been wanting to do for months.
>
> Good with ambitions :)
>
> As long as Sergio is on board and can test the changes and as long
> as the DT maintainers do not explicitly disapprove, I'm game to merge
> this.

For sure I am :-). Changes in code are pretty straightforward. The
real big change is just a split of mt7620 and mt76x8 in two different
files. But the split looks good to me. The other bulk of changes is
just moving files around. If DT maintainers are finally ok with the
changes I will try to make time to test this series in a rt5350 SoC
based board I think I have somewhere and on mt7621 SoC based one. Most
of my ralink boards are based on mt7621 so I don't have more platforms
to test this pinctrl changes :(.

>
> I guess you will respin on top of v6.3-rc1 when the first round of
> non-RFC feedback is collected.
>
> Yours,
> Linus Walleij

Thanks,
    Sergio Paracuellos
