Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C126C68B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCWMoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:44:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993B9F5;
        Thu, 23 Mar 2023 05:44:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s8so12988942pfk.5;
        Thu, 23 Mar 2023 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXmlvLRJ51Nle/Ky2eOAKThFkxJdMZbTvZ2YQbmyQz8=;
        b=SeyHkP0Cn/bQrStFgTFC2vHqvc601yVmm66VWV1gIpdTaIhV9QvrVxdOmjYVdqRJ8g
         GsUrO/AgBwaqBE6+cKNoggFxH61sGleodXOS2XFkipMsSnq/ri5cv20AdYc6STd8tI3E
         Y7siJY8+Ct8OP5pJaUZMmRXsdPzDwc0URaMfH5wcYkPdAsuWX/kBONeR5iil+c+wvqtY
         6Do1gAjUAAT5gPxUKRIizM6FuEL/kqmNeGme7U0Bw8+wAK8muZ8eC6/IxbV/QsahQqAg
         3lTi0G8MIoh5k17CWlvucqBpEEE1/QXnBFx9itVJwrW0/yobAZxefLDyXsyeTt1owhI5
         4ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXmlvLRJ51Nle/Ky2eOAKThFkxJdMZbTvZ2YQbmyQz8=;
        b=X8xLJw6VQJ8799rcz32XuXBT8+uStXfezBXqY5/iI/oIpRc3EEKDLoWMMKN9WExq0g
         Cxl3hEuS+NBISxuQcAJXE/LUE8WSyIPYHnkmMAqQRrr8bI5Qz2KqJ1Hv++duDA2YZONw
         xtcRMmxybobh7Pmo9TAD8y1tK3UYaXMAHphgU1TSzTvkPTSxe063QK+zD/FQhKhd3t20
         9EsKSa+emEOQpEktpogLvbsqkoSxNkrn+eUEeFIX6GSpjzfJkmLlVhxS/B3R0EQnrkuD
         MCKECP4qY2LyXrz57uykEuumQ99Eux6XWQxTDjd3wrboq+yaMBXgdZN5CkLStAuWRmEs
         8fHQ==
X-Gm-Message-State: AO0yUKX9byZa6NkUH5UKPzlV1FO4fSOLi3bqD1uHqlkJW25nw3mKF9Yw
        wceqN2M2bht6pcTRqNj+lOoIfQtJiig1o1wXSUs=
X-Google-Smtp-Source: AK7set8U+DV6iePDNSCo7WZl7ClEPMTiCN56f3lUNNeKuIRHlLOKAKYh+bmi5nnLMW4QiYH3cSgfjHnAnoeD4pUcSZo=
X-Received: by 2002:a05:6a00:2b1:b0:626:23a1:7b8a with SMTP id
 q17-20020a056a0002b100b0062623a17b8amr3590611pfs.3.1679575461080; Thu, 23 Mar
 2023 05:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230323123807.11882-1-cnsztl@gmail.com> <20230323123807.11882-2-cnsztl@gmail.com>
In-Reply-To: <20230323123807.11882-2-cnsztl@gmail.com>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Thu, 23 Mar 2023 13:41:50 +0100
Message-ID: <CAEwRq=pwWrXAuHMBaWzZE7cxmVMGuX=eqi5Esjxpe-jPXWF+0w@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add doc for FriendlyARM NanoPi R2C
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Yan <andyshrk@163.com>, Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Mar 23, 2023 at 1:38=E2=80=AFPM Tianling Shen <cnsztl@gmail.com> wr=
ote:
> -      - description: FriendlyElec NanoPi R2S
> +      - description: FriendlyElec NanoPi R2C/S

Maybe do like for the following one:

>        - description: FriendlyElec NanoPi4 series boards

- description: FriendlyElec NanoPi R2 series boards

Regards

--=20
Vincent Legoll
