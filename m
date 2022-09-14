Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B622A5B88AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiINMzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiINMzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:55:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8B41ADB7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:55:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m1so22057706edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=o9bsMPChreu51F+DpvXf/8dl+XA0syeIceqw0TCSPRE=;
        b=iVCIe/V6cngaoT3RK5U1+Szzb05njaWIlPKBzXipO+DpKseYlL8EBxX/sfllpNyiy2
         qW75G4OIsnrjGS3EtmE847+Wa/ZFk/TSm+OEk71U6bf+K2n1MeAnWV+X6D4o4YkNd1UT
         2VyPqm3RitaCWi1ZOBBWNUM4JlN84zYlP9PquZ0+b9OVi8dOOwHAxL+HtQ9XnnvJoFJ+
         rlt5g5bHUQTyiI6qDYyIW9KzHaxN3HC9Jy1X3O48RXbfMkjy4Hw1rJJpO21f8ghbD2Ez
         Pg4569RDUJ7qGLnc9rjbX1mXeq4sCy+p1qE10H5LXbU8bPYB5gEn+9CT1zkX6zikTKoV
         XWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=o9bsMPChreu51F+DpvXf/8dl+XA0syeIceqw0TCSPRE=;
        b=j6vnRye6hvGgwQHpgBQbyht3O7PBLdLuPnh4shHrsjLQd0kkv6vmljwWJbyX1e0HPe
         /1zDwbih8M0hQ1tw7Cq9PvuxkkxugRO2WrODKqbEWdlpFk3z5xEouIaepqAhtzw01J9E
         qlaiqUWsDBpnTRVudQODfit5i9Z2rGgkUWDpyhU7CFN4hr16tqirzg7z+3T9vUCoIRbR
         cpCNLdS4b01PMB2LaALwg0aubmC6GUr7ZLJF7JX014b8N2YHi83tY31DmsZOWuXqRGSc
         mUR4exX4SuHd9uImBNYobIrIsaVBdaXa1mg2kqDWatLpxr2cNT/D6wsY8/U7kPV7A9TW
         GAvQ==
X-Gm-Message-State: ACgBeo3vJ6ETn8ME04uTAFaBRvCaX2QAsRw17f9zTGnJndGQt3tKD7kr
        JLXbrfK+LL+qBgTtTdQLBLKcVKih0clXNUy9Snv7vQ==
X-Google-Smtp-Source: AA6agR6kZD9JXsB4SrCbxYC3E8ILxvnVxqjQ3570ruXYKWkhtbdMpwIGhCypPfHA5kXBOpAXuDD6YMeLm/q1TYaqHI8=
X-Received: by 2002:aa7:d6d9:0:b0:44d:e1b7:d905 with SMTP id
 x25-20020aa7d6d9000000b0044de1b7d905mr30553355edr.32.1663160116189; Wed, 14
 Sep 2022 05:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220912092440.21011-1-chui-hao.chiu@mediatek.com>
In-Reply-To: <20220912092440.21011-1-chui-hao.chiu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 14:55:04 +0200
Message-ID: <CACRpkdYgAv_XM6-b8mQMT0xB76JgwgxriEVwPj=9cHyLVJVUiQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: update bindings for MT7986 SoC
To:     Peter Chiu <chui-hao.chiu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:25 AM Peter Chiu <chui-hao.chiu@mediatek.com> wrote:

> Add wifi pins in the description and set 'maxItems' for groups and pins.
>
> Reviewed-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>

Patch applied.

Yours,
Linus Walleij
