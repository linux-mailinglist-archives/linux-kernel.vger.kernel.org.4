Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B276B0481
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCHKeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjCHKdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:33:17 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D24685A6B;
        Wed,  8 Mar 2023 02:32:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ec29so32899807edb.6;
        Wed, 08 Mar 2023 02:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678271568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyG27hmmdGEC33zsFYNJRUpKDEX1YUKuCFWkh6OnkCM=;
        b=jYiTqkgLG9l2iKrOZlApJHAOgaGXFW2IOGJ1E5OWdxwy42Ev4hgQGlItUgB3XfXUX/
         9pmXSFvhL3SLwKr3tUVgTjUrBA0ygtpEB+Ait/mRz96/mwNMzUm45Z3oOmCP/y2Vn15j
         3tLg1M7jWFNFpMqdO6lK3xqXDAUjLwCHMjZ6fxz/2QLgBLY89eUidMPx40lCsw7LvQp4
         qZJxzGaHoCqOcq1wXVWo6gmugASBCoIGPnASr6IVywEKNc+FTb6q0rD05scnLBUe0Gi8
         XvxgBvZhJOZza/kjiWOWtlr6NVtu2aHi4qYYOsOny4ZeCF0V8UoDL04b3scvqxdFwidR
         ASQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyG27hmmdGEC33zsFYNJRUpKDEX1YUKuCFWkh6OnkCM=;
        b=ks1l1wv7bk5Di2oMtyvrQQ0R1mB7BSB21b7MpArnXEmIKZwwGpmn8fM38ZP7DdQ0gI
         KPvNtP0Uin7YIHpAJLxHHkw7YvIqA+aBprnHX7mch6lgPGdNRWWKGxMUUus86X7YYZK4
         Hj056MdZAc59ueZM6tN/EAwvR2UM4UU67Xw5yOwxAKNTDO7ThBeGl7nEVc1FgVVm1nzh
         uLA79qDTiCwoQc0iU+674Rk/mS3eiEltsYbt/VADxlAJVDTdpzt/s2YaeYOcgTDjZE4r
         DNxrpTGBo5lJ3U1rLJueIZVoXveUULskp9VXCrPE9yf7xc9JMTsy1MsHUKQ2IPsutxNy
         452w==
X-Gm-Message-State: AO0yUKXMzzZUFJmZzZ+d7aMJcFKNKRyZUKaEAuD5qTleBa1MBi4BJvOd
        QYZqOceRxgfRRUMP9KTPW9aJ94WOgoYuhjw1zYQ=
X-Google-Smtp-Source: AK7set+RRz4fH6efg5NYY/uQFtVNE1ICc63H0bjAHi/ooc2bm0E2YBL3Zy1OUrA9TLU+lmzz/Nml00+UWMnVKY+aDkk=
X-Received: by 2002:a50:baa7:0:b0:4ac:b832:856c with SMTP id
 x36-20020a50baa7000000b004acb832856cmr9758665ede.1.1678271567782; Wed, 08 Mar
 2023 02:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20230308094024.14115-1-clamor95@gmail.com> <20230308094024.14115-2-clamor95@gmail.com>
 <559c2588-e586-b4fb-97f8-5fe25bb79607@linaro.org>
In-Reply-To: <559c2588-e586-b4fb-97f8-5fe25bb79607@linaro.org>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 8 Mar 2023 12:32:36 +0200
Message-ID: <CAPVz0n38LtyAqBP4GfC003xzaW78FaZ91zjdTNe46ormL5RY=Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: ina2xx: add supply property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

=D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 12:27 Krzys=
ztof Kozlowski
<krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 08/03/2023 10:40, Svyatoslav Ryhel wrote:
> > Add supply property.
>
> You have entire commit msg to explain and give background, but instead
> there is just sentence duplicating subject. And since you did not
> explain anything, we have questions... like: INA238 does not have VDD,
> so this does not look correct.
>

This is why a regulator is not mandatory. If ina238 does not have vdd
then one who needs ina238 may omit this prop. How about looking from
this perspective?

>
> Best regards,
> Krzysztof
>

Best regards,
Svyatoslav R.
