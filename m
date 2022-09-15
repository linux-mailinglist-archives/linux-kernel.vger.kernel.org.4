Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF215B9C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiION4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiION4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:56:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F3961700;
        Thu, 15 Sep 2022 06:56:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l17so1521763wru.2;
        Thu, 15 Sep 2022 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ttVTobcerozJ0Qpoj1pMNzCZJWSC2cn6oDnQsoTO4Yk=;
        b=pSjYWnqqo/26XBSg9dVZ2nm15xV7jvJSoZr12r8ahlYYpQqY+8iOuXiAD0tmoP3X22
         G1Os0gc4T04ehMEV9GHG+11xHZjp5jUlm58zKxFU74XoO6H6iHYr1U//k6j2vLMpEyml
         W6aQATI4WZjAqxXcFLcpIZLW7K3xrtgBr6ggqsyIjlpevA1qwI9s2lhDoojygmBw+WyP
         CeAuR5RzdSk+T8VZjUYus2nKLFeOA0LGa65g5rJjxqdCAfwD+SQwfPwvAfjHWTyR5fl9
         9/FUM3kKWjxp6pjqwVoKMhe92t7zEKMUZlt+dpAeJKdmVw8FjudfxXWRud3ujbg2H0D7
         /Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ttVTobcerozJ0Qpoj1pMNzCZJWSC2cn6oDnQsoTO4Yk=;
        b=UJK4F9sAnjTWdNalufo7/kfp2YibQju3Go9dSrj81m1MWfRubar/izSp2VncTCWa9+
         2TQtpHd8n7GE9Bef2KbFjUyGnrmWkyibpLs5osJsTzn7iSD6sErN7QWWg+9jHJld02u1
         hb9NVkYAVJcXHR0cwgID5lt3K2O1UIYstaGLsOliSk4opp6TGO1Vc3rZV9f46YyoAHTw
         5jGjN1SUu5Ret1Yr/Av44idgfqJvwWVdGq6LfjZMpxYyw0dLwYADn3Wad5Qun1kwSKvG
         laE67571Xs1LceXodC3YwFOnswom9LpdIo+uf/M/xc7eRCM6T+p1IFpNs4Fi3phNrnDP
         A7fw==
X-Gm-Message-State: ACgBeo0gQ2HVtYDR+p1Xbf1H5igJ9UtiZgAOO19I7zMZFOlYD+987lLI
        fi77ywXWqgKejdMQAUt566rtN7XW3++lGXpGG5nC6RZCnws=
X-Google-Smtp-Source: AA6agR5ZTPI4AZK4A+FrjJmuKe4UDMj77dCsdAcnrftEdV9Wb+vy01c8PVlahsQwkc/FtgZV41i6mnQLg1viHqD/MEo=
X-Received: by 2002:a5d:4dcd:0:b0:228:d1e4:9cf1 with SMTP id
 f13-20020a5d4dcd000000b00228d1e49cf1mr23421819wru.182.1663250197399; Thu, 15
 Sep 2022 06:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <1663157936-5010-1-git-send-email-u0084500@gmail.com> <20220915134353.GA1168381-robh@kernel.org>
In-Reply-To: <20220915134353.GA1168381-robh@kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 15 Sep 2022 21:56:25 +0800
Message-ID: <CADiBU3_6dXf1TUv9f7HbFfrqsfMUmT1Ejve6+O6OGnmTtxzpEQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: mt6370: fix the indentation in the example
To:     Rob Herring <robh@kernel.org>
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        cy_huang@richtek.com, linux-mediatek@lists.infradead.org,
        alice_chen@richtek.com, robh+dt@kernel.org, lee@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chiaen_wu@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B49=E6=9C=8815=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A9:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 14 Sep 2022 20:18:56 +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Fix the indentation in the binding example. There're two redudant space
> > charactors need to be removed.
> >
> > Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Since v2:
> > - Add Fixes tag in commit message
> >
> > ---
> >  Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
>
I'm not sure about the rule.
AngeloGioacchino said I need to add the 'Fixes' tag.
I think it might be important.
And I immediately submit the v2 patch and add the 'fixes' tag.
So patch v3 and add 'Acked-by' tag?
