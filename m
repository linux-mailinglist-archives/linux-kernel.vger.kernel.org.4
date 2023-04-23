Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB116EC184
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDWR6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 13:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjDWR6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 13:58:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0D9E60;
        Sun, 23 Apr 2023 10:58:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so6279957a12.2;
        Sun, 23 Apr 2023 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682272690; x=1684864690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHsL9MQVPFQ34BbrwIo16wX4/j6whiAao+LaFJLRPH0=;
        b=Uwb4ivR/3kXWhWz/vDu6RE4t7bgqv1gyR28OwaiNgcSfA74vOUDK+4jybyiq7LYfyr
         TVzdUJ8Iv5bGlYN8U+d6At4msno+SN1dVnPxFC+BP2C0bEBgJyLnWrpiiqfOss6auw8+
         ljj3ZBX9jYfuGUrgLSI7kc92dw3CAH2nRUPD7oL2Aujl4Kr//cFa4CRm5LI/acmOpiqf
         lIjEl+8PJ2DRMoBrStF9fFheFOogplgRN29ytqP6rkPuGUErBMTINvG2N6y+ZOBQq9WQ
         WRuJ7L2c5O1O0FcNg78OMHbRgxJLzKQxqoa/Xtap8wC8oD7Gka9OszagYqljUaMX0vxf
         mKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682272690; x=1684864690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHsL9MQVPFQ34BbrwIo16wX4/j6whiAao+LaFJLRPH0=;
        b=ZiYSd/itTXEiyrGNaeiw39rIpOa7tiKShqj4/FEeRn8/JuGV1SX/Rqa9oeDfxxcB89
         pUlkvxOR2f3NLBHcdXjRoq2HhT8JeJiB0qjcPcfbkU6T+4QiVw3TeZ30J5wh1W80OaB3
         2K/dHrpW84XKk1ts+At9awXvgBZvipjsN3sDpM5VKRz2Q304/wD/sK3AhJh7Cagtm+qn
         /0tvzqedk0ynIxM2vutnKZDSVKzbzcs6P0PVk4q3dXYZSCboqSp6QJAVWv0qLzpgu2Uw
         HFx4RjLe+sN1wdlHKrDfnk0YzqdWS6lxD2tqVlnfX/Og5Ilsklid0m9l8rSkZOvrw5hV
         I0TQ==
X-Gm-Message-State: AAQBX9fLtomHPVQ0LUNLnV+9RSnBYminbCfHlwK4bz/OHc0Ir1pLTA/F
        TkBapweArFeY9V2r9BrpJtdgldshSZrtmu68jgU=
X-Google-Smtp-Source: AKy350apnvEC+ae+CMrevYIxaPwh5rSXT9cKmlYoq3MCQp5mEsXbkdnvU8ZOMbfPlQSldniQwmmPib5M4yspogPqnN8=
X-Received: by 2002:a17:907:1c86:b0:94f:81c:725e with SMTP id
 nb6-20020a1709071c8600b0094f081c725emr11010176ejc.59.1682272689794; Sun, 23
 Apr 2023 10:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230421223211.115612-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230421223211.115612-1-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 19:57:58 +0200
Message-ID: <CAFBinCB5Stfhv5Z_q0r4WC63PJDWW0Vt7yauByNCRp2rz-BpmQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: amlogic: add missing cache properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Sat, Apr 22, 2023 at 12:32=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> As all level 2 and level 3 caches are unified, add required
> cache-unified properties to fix warnings like:
>
>   meson-a1-ad401.dtb: l2-cache0: 'cache-unified' is a required property
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
