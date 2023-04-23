Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7822E6EC174
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 19:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDWRoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 13:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWRow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 13:44:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC72D10C9;
        Sun, 23 Apr 2023 10:44:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so492189766b.1;
        Sun, 23 Apr 2023 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682271890; x=1684863890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2eZs5d+yVYnpxqNGueuhOSq99ZCnZL+HNxoe/Z4agM=;
        b=rjqeblxUeHVA3FZXcGzBaljlFy+iD9hOhIVMbswTw1D0Fs7UgxpMc31Yrc7WS0WGEZ
         JcrwKlogGIp/aGiRxV3PAzhb9BhxPNRFIc3j2pdAvrLUOjPu+zdusbH11OXaua1HjHOr
         8Kqbe8c/e1TAQpv+YqZgt4chohNPwserwMyXfU0lBm/lKpSFwEAfqZy/tyDyD0Rbm/W7
         6R3WzmTBOwMpYMQHQp208GwYRvXw79xZGDOld3dyyi7rnv8Nz6vckPLwqGQJw0AG2h9r
         ME57w1b/0sd2ur9wSPLsQ/iaT6r1Kk1Hry3OC6Qy5OeXevjepT+H+hsKOVJbsS90KICX
         yXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682271890; x=1684863890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2eZs5d+yVYnpxqNGueuhOSq99ZCnZL+HNxoe/Z4agM=;
        b=Fx95Xxma/4xHuQE29hc3jGt8Ip/h4iQH2fsQJM0nL6tOIR4QH3yfTVbl4YANIJoYM6
         bCwQ9DQVEXvuhKMkqStbA9Gsb3WfZjXKSdyaQbaLvav9qR8A6aV201gCQyE+/UIEugWM
         NvH36t4Kphc1GxU9rwujGYjRwyxFdDNrerZsgt/F1mSOIVEhiIo8zmxHLdyixt6FioGU
         HlpIAlXRwPuu6o8BOPkwcNabYl92EqT7hSmVhiqWRTerpX65Ed9NnBMYAYoBg85Yk4jf
         t5riBHhJZiHW62sCgJh3l6GhUu7TW4J5XePOFun8mQfgBCrp2LjlO8KrQXO7t6o9IKl6
         KC6A==
X-Gm-Message-State: AAQBX9cOHGJ/7xzuU7wsVA/xMPwaB5VWjJkfyTgSVuv3EmVNSye3rYDU
        9zH5iJ0yDd/99yRo9rKebEG1vJQVgbBmPP49wL4=
X-Google-Smtp-Source: AKy350Yo/Wifs+wSbwTN2k3fAqY1hgLXvfYw6V6t8pAvGLfxaJWtmONvcwDW+X7DbaDJ74PlKE59PJasQPemi3Dnt5E=
X-Received: by 2002:a17:907:8a18:b0:94a:5c6d:3207 with SMTP id
 sc24-20020a1709078a1800b0094a5c6d3207mr9914041ejc.44.1682271889923; Sun, 23
 Apr 2023 10:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru> <20230418111612.19479-5-ddrokosov@sberdevices.ru>
In-Reply-To: <20230418111612.19479-5-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 19:44:39 +0200
Message-ID: <CAFBinCBF-KPxjG=uXQL9WqY+NPhFp1sXH43qM3t+LLRP9oEBkQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] usb: dwc3-meson-g12a: support OTG switch for all
 IP versions
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        mturquette@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        hminas@synopsys.com, Thinh.Nguyen@synopsys.com,
        yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
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

On Tue, Apr 18, 2023 at 1:16=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
>
> From now, the Amlogic A1 USB controller is capable of switching between
> host and gadget modes based on the status of the OTG_ID signal or via
> manual USB role change.
> Previously, only the Amlogic A1 IP version did not use OTG support for
> host only mode, but this is no longer applicable.
> Therefore, the 'otg_switch_supported' option can now be removed as
> it is no longer required.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
