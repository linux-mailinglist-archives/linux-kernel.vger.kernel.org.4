Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F8653099
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiLUMMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUMMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:12:30 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE672AE2;
        Wed, 21 Dec 2022 04:12:29 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d2so10183638qvp.12;
        Wed, 21 Dec 2022 04:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQf5YLAPimW4Vw+lXekg7aGz4djtucNpOLvkhBsL8fY=;
        b=MyQgM3oNihULVPGYU+e06vCoKN5a/flzi84nvSKLIPFKcbzcABA4S8BwGSUlcCFOqV
         lN6w6ZsEZXlcfEW7+9JzAj9olv9B+iRhJqSS6o4J98blKQEAONcNLrPZgv0EjvdexRUe
         VI71fSP+yaZulhoFSxLRfWc2fYAtpwW9ih9lIQ5twYPhaHOVyvFFZcSKDnf+GAFEom0F
         HUr0r2oKpdHe/gGWq15oVcgfOKwTIdNIMrtQsFMNzRhh5+xVrifksmFa3DhPOlqRug1H
         ZfYrVkbSjtgcCalWzdy2xgW1pk+1mVtWsxmPGAd92n3Cec8qi7Zu/bRWP2fwDAA+zu4Z
         MMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQf5YLAPimW4Vw+lXekg7aGz4djtucNpOLvkhBsL8fY=;
        b=LKWGXWxHHLpKf4mLgzS8nGcZy93O2++NyNJlnc41UOTQDOa2Ug6M3iDRmrtUVXH9FS
         cMEMjM5RrdlY11tF0OIE6lqSJ2rd1uluL7Bb5L6X+wXsCHkG3dCxOraG5DuFUc4UcqmC
         +/jCQuzZurRcEYIkk//2RkME7QpIt+2273XMw6XkqDuHoi9DNXSFi0dL+XTPIUoT0pbu
         JJZzABMuSiZpFSEd1HVx6dwTcfi3zdIqpdaamz1diPizNCvniSSJOosEtNuCLc4RcTom
         GS5Xf4CsdqRfqqav1LRObngPIq4hkWAH/sRIHuVrZ8RuM5bqg7XP017MpkYx9CVAy+xf
         ohew==
X-Gm-Message-State: AFqh2komHGmre9ZCfcrPOf7AR0ZIq+Yify9fMTufAQMHkdz8RtAhT7GS
        Ahw8YxUO7qBnG1WSkTBQ1VDJlplEksBES6BNrbUdBhOKDj1sd7W+Jtxbgg==
X-Google-Smtp-Source: AMrXdXs3I6lQEOnWGKd4HpQBGugdIGOO6wFs7aYgVIashBCALecxPLc7OZbV9+5OFuIdu/AX2jtgr+AY080gTizJnOY=
X-Received: by 2002:a05:6214:a91:b0:4bb:7998:fed6 with SMTP id
 ev17-20020a0562140a9100b004bb7998fed6mr69417qvb.86.1671624748724; Wed, 21 Dec
 2022 04:12:28 -0800 (PST)
MIME-Version: 1.0
References: <Y6KfFEChA67E7oX/@VM-66-53-centos> <5a7907e3-f79e-5de9-ed1b-ec24ea52c437@linaro.org>
 <CAMmci2UgwqDyPPJXwGRsMW1Y1Cy2c6LMybk+7v7pGz-LtYzGTw@mail.gmail.com> <2673859.iZASKD2KPV@diego>
In-Reply-To: <2673859.iZASKD2KPV@diego>
From:   ty <zonyitoo@gmail.com>
Date:   Wed, 21 Dec 2022 20:12:17 +0800
Message-ID: <CAMmci2XoF0M81mVt8zko3D3G2oTHq0ia_nZ9CPX9Xz20j92c9Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
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

Hi, Kozlowski and St=C3=BCbner,

Thank you very much for pointing me in the right direction.

> So how did you solve the comment "Does not look like properly ordered.
> Don't add stuff at the end of files/lists."? What did you change to
> solve it?

> for context sorting order in that file is alphabetical by description

I finally got it. It should be put right after the "Elgin RV1108 R1".

> You do not wrap at 75, but at some other place. Just put it to editor
> and check where is wrapping (count characters).

The original message was:

>  from: DHDAXCW <lasstp5011@gmail.com>
>
> LubanCat 1 is a Rockchip RK3566 SBC based
> is developed by EmbedFire Electronics Co., Ltd.
> Mini Linux Card Type Cheap Computer Development Board
>
> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> Signed-off-by: DHDAXCW <lasstp5011@gmail.com>

The longest line is "Mini Linux Card Type Cheap Computer Development
Board", which has 53 characters. Or ... I should use the whole line as
much as possible? Then I see why I was doing wrong. It will be fixed
in the PATCH v5.
