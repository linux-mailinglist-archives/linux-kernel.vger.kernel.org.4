Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB067419EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjF1UxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjF1Uw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:52:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BEC19B0;
        Wed, 28 Jun 2023 13:52:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991aac97802so30959266b.1;
        Wed, 28 Jun 2023 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687985575; x=1690577575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgeY2wMTlgSvSCHlBTmqcDVwb3LQt8lStfqknJt83hc=;
        b=Bk92WbZWXeWJgE7UYi3lAHkDWOXeYToZo6eT7612Xktiol6XwJRZ+vex9GjU/tylsm
         HUhUO62zUSFp8YULcBzMFgC5QnPifRld0IRjnZThPy0XrWq+2nsOFEkyzg4/ls2Ol1Y7
         aGUWxuTnOIbBsCCv6bTrPpzJdSfiSoKVOO9IIqpvDxSPMNVD5Y8dISywU0IuPitP1WJ2
         q/5umI+RIpQsD/Wbnz18usohiQQIb7Bz5InXWi7ncR4KpnD1QmcP9k00HgjUDa8wE5t/
         3sgjthC4HQ2X5dRooMbYpoNimVZWoL/4HMTriQIgy7PJRC0y6sIwobwdYFbDOZ8p/sjo
         QTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985575; x=1690577575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgeY2wMTlgSvSCHlBTmqcDVwb3LQt8lStfqknJt83hc=;
        b=l5kL44pJ4vQ+gDTi0mIzkA6dB2W5E/2IJKFudH5bztRnIbHx1hkVtDfhRTgDcB7CZY
         LQBhOf1a24Mzc0iXhR6JHKsuYvvsly+H3lrkBUQW4d5kPFabv/ajcPoEh/8PCsyAYwyP
         b9vUoPvuVddFQbQwRR37RwQ3HCCXKXNzj6mWauBRCkGk0x2ck6q6vQc+AL+5K7Z8UkbU
         ZbBCg2X92GgbpKGU3tYWEyIHAW0B8P27AS2eSKtOa+HBHavxApsSfN03b9KxsZXhI87e
         YDCpuXicT4xM+fseo4E3zpwtXXPWghuKYLOo4CxyBALlBrpne3tNIwdiN9paTCg4KUWg
         iHSg==
X-Gm-Message-State: AC+VfDxvkALpX9ReJy3fRryTfLs8avMgvUYWxjhZWFFrZc7/WeekXwK8
        kuL7Ve9OOd1KU9wpd5k8l9YA03Zuj1KZGHPnVqs=
X-Google-Smtp-Source: ACHHUZ4pX5s00tN7NpkfZtIaiOzk1W+h0xunJeYGl14FuxeQc1OTu2WFYSJu033zkhlooHSNZRWQYI8basMEmtDLOGw=
X-Received: by 2002:a17:907:a058:b0:992:48b9:84ef with SMTP id
 gz24-20020a170907a05800b0099248b984efmr3718883ejc.29.1687985574952; Wed, 28
 Jun 2023 13:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230628091533.3884385-1-huqiang.qin@amlogic.com> <20230628091533.3884385-2-huqiang.qin@amlogic.com>
In-Reply-To: <20230628091533.3884385-2-huqiang.qin@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 28 Jun 2023 22:52:44 +0200
Message-ID: <CAFBinCDvtFXRDQoim=_b94cHmiQLBAZHmeK0GJBfB4nixyBgNw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: interrupt-controller: Add support for
 Amlogic-C3 SoCs
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:16=E2=80=AFAM Huqiang Qin <huqiang.qin@amlogic.c=
om> wrote:
>
> Update dt-binding document for GPIO interrupt controller of Amlogic-C3 So=
Cs
>
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
