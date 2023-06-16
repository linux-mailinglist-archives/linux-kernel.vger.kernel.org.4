Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F07733286
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343845AbjFPNu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFPNuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:50:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277B30E0;
        Fri, 16 Jun 2023 06:50:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25e836b733eso536358a91.0;
        Fri, 16 Jun 2023 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686923453; x=1689515453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZSMsfjHYkbv48QukJ7afwamMn5a+T7mg3WCsl3VYqo=;
        b=pJEAs8F20r47QcdjnJY4KALVQvbGF86ucToy9Jp3IZXEn7edd5IdyV10zYoYBxW4RK
         n303rc21hGLzLafU6pVBA5c6oCPF9vBPdVcA6b5IDGgH7g5xqqdmwnON0wtHRsoy8vlC
         SlKw8XKBGX9Zh3eNhze9D0+Mcin+0iHqjyP8Ed4L298pa/TiY/NhSoNtmdBsrSKnvQ3S
         mYyIrH7hzgxeEO0ICUZ12H4GP/Pho0D5S6BjzuPJBI7Yzw90avLkl5beM+hAlT7D2vB6
         DQ1rpUASmrgucFfojxJ63xqGUZNWyNUnJ/9fhO6PuF2NAajFr6F46mIdiyg+C9FmE7Qq
         VrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686923453; x=1689515453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZSMsfjHYkbv48QukJ7afwamMn5a+T7mg3WCsl3VYqo=;
        b=GLNwsLK3Q3GfO936PJpArFJ3BU9sPMFz2TxifmGIh2y5SvhhzkRy2oqEE6OkXDswB4
         PADIkyzFxHkqI0E9hlJvWrvnp+S4qfsnBNycFgvImvjm5qgDe8e5Gci6bVOaEHlXiNur
         FMI1Hvsb4zs4pa/TyFJ7cc8IA5wdyaK1GbsKquS1z6AO0yUfTlduhRyeagj1wrg3Cql9
         ofaALOUFGlcHcaC2e985gNE5JkrsXzg4lZaW+zM0D1V1SAmCF4hGrnrJsYRpDmalF+PI
         wD2ctxcosOwRWhKvzdH/AZd14eeMR4MBAZT00zqxCIJSpeqSPc+wiw3CZ1fL5ZqsvOxN
         Mg4Q==
X-Gm-Message-State: AC+VfDzerkoyFYUpJsAsBZF2L5uh3vE8TpfiliTLS29y2Dn/IyarWwht
        aovpLuFAv/M72hoS7N8XC5h8dAUMtwcHR6/z/vg=
X-Google-Smtp-Source: ACHHUZ5K5CXGV94bxSHgTvSnRBnDdUt2EDVt6IkdoIxbkSmxIlctam5o5kYMV7oHVLeLb78IbPkgIqT9eHVcxVZEC6U=
X-Received: by 2002:a17:90a:1999:b0:25b:cccb:4b8f with SMTP id
 25-20020a17090a199900b0025bcccb4b8fmr1473411pji.44.1686923453255; Fri, 16 Jun
 2023 06:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230616062101.601837-1-s.hauer@pengutronix.de>
In-Reply-To: <20230616062101.601837-1-s.hauer@pengutronix.de>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Fri, 16 Jun 2023 13:50:42 +0000
Message-ID: <CAEwRq=qze2NV5emMdohTPKK_UfSVMa2wmPNS2c2zzNqFVdmK+w@mail.gmail.com>
Subject: Re: [PATCH v6 00/26] Add perf support to the rockchip-dfi driver
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
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

Hello Sascha,

On Fri, Jun 16, 2023 at 6:22=E2=80=AFAM Sascha Hauer <s.hauer@pengutronix.d=
e> wrote:
> - Add more reviewed-by tags

Can you explain how the Tested-Bys are handled, I don't see any patch
with those tags, not Sebastians, nor mine. Is the testing useful ? Should I
retest the new patchset ?

Regards

--=20
Vincent Legoll
