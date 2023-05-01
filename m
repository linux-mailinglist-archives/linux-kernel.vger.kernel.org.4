Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC676F3132
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjEAMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjEAMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:50:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4A10FA;
        Mon,  1 May 2023 05:50:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f32588c13so423029766b.2;
        Mon, 01 May 2023 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682945408; x=1685537408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dABiBso+HJ8wbQPnpMB1lKn8XcVP8XIEpgDNlp7gUc=;
        b=rnfgZH1FpvexC1G5XeLqKbBeMTF/Rjf4/BqneDMfwGyKvxd0Nl7sTkZ45a6HT4HZXH
         U/f+4gWb1XXZ+IE+0Zml02ZN9Gkym/5joLaVE7pkLyL2rc9aLn1rzuJ5itIHq+XAZ5L2
         jX1zRse9ArnwXheUwM4UkICWLvGqcKqd/zDCQ1ol0jy31U9IMAm7Do0RxUg5/bBnGAOJ
         tCp79hYvWdmmDm3KBtpJgSwip3kbp9mSpciADlqBymev59SSlh7Toz7lRgY0W59relNk
         SyXzyKoz/1GQ31nGzgtdqmGurXwKPS264NQdCRkuMJKgUrkrx8wSwoZ6tYtJrDa+TOR5
         hDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945408; x=1685537408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dABiBso+HJ8wbQPnpMB1lKn8XcVP8XIEpgDNlp7gUc=;
        b=MPsUHnYRnlnR0Ahf+NmlTUFrV958w5OSSThJRaQm9u7HzLYIsg8EDylk2Rt7VVZp4y
         tQugvpHhrkZuDMYX5jHoufux4LSYQJwlgMhcojlM7Im6V8OUQmWq7gXkUTseukfPjktF
         bsgoZxriZ2dEvqaYxwbebcwstimmM3noHhSO3h1wBGoUIpM0Lr1eiCnxuR7MSrd6xOC6
         biVRVSDMdeBFi+tl8Un+AloGXfDtpd3BMqCJLZuLv4xyUB66cCY2rqPtNXgmP3vvvT8o
         rGBSTb/ydqUbjo/+gXIC4JF9/bB3YJhLpFaY/Zup10ANHb5E283kZrELJwwPHrZzoNg7
         YvSg==
X-Gm-Message-State: AC+VfDx9eZ2aeGKnqefS7Y/6EUZiOgBQ4O46Fez8cuWUGvGh+JGt4pPU
        M140EtvADPd/E17ASsTr3ApuTkNYYIw+cAJxaeo=
X-Google-Smtp-Source: ACHHUZ6kh11W0vvs/KuiRs93O7irLs7t1SO5gjsf+KvsgFcR+jdEXoXqUkKdz4U5edwWwHpfJ5sXtMLeYlbB8v+cOOo=
X-Received: by 2002:a17:907:3d9e:b0:94a:44bc:31e7 with SMTP id
 he30-20020a1709073d9e00b0094a44bc31e7mr12596705ejc.60.1682945408003; Mon, 01
 May 2023 05:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230426102922.19705-1-ddrokosov@sberdevices.ru> <20230426102922.19705-6-ddrokosov@sberdevices.ru>
In-Reply-To: <20230426102922.19705-6-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 May 2023 14:49:57 +0200
Message-ID: <CAFBinCBLgKG2CL66z2+qF2mn--xLw75QkcNigwme4D2jmLBFuA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: meson: a1: support USB controller in
 OTG mode
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

On Wed, Apr 26, 2023 at 12:29=E2=80=AFPM Dmitry Rokosov
<ddrokosov@sberdevices.ru> wrote:
>
> Amlogic A1 SoC family has USB2.0 controller based on dwc2 and dwc3
> heads. It supports otg/host/peripheral modes.
>
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
