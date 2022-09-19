Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0126B5BC5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiISJsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiISJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:48:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93C912AFD;
        Mon, 19 Sep 2022 02:48:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y3so63212351ejc.1;
        Mon, 19 Sep 2022 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kSzXHO4r9aLTZbu0HWFtQT6MR1swYs8Ir+cNV0IOQfo=;
        b=jEgDZlWLM1zjSQF2MtVuLNjDpnsgPQXkhtAowdbRu2e2BZNSYbLFRNJI/0xTpwwmtn
         asfLCk6j7tmw3dzYzotj5fQCJUCCFEOJOHnnlaogTryms++arNfj2pCE3m/YRzHwJ8zL
         /LLABhr0k4JYF8RoMnxCi2wZcz+r8as0c3WUeB9Gs1r5t5154PO86g27HuVs/TaB/iDM
         Hqqp4zUZ0Ddc3dF/UIHiYtYMlV2UhpdoAHkt3O9KtwtoON7HU7qjkRkq1pXLU9QlhEaC
         Kat3I4oupiZ0FV47IQA2Ut6wrBEPzyLI3bOnoCyPbNVypCzMDVrUV8ifvnaOiB4IvuQ6
         a21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kSzXHO4r9aLTZbu0HWFtQT6MR1swYs8Ir+cNV0IOQfo=;
        b=4PcqwSaMP35mWvJZ3i6yAyBA9npxNZhaEeKg3ZSJBpbUXzbAO/eCIPe0IYvSRFyBn/
         cmVdZrdPbNfKtwAI/L+lpo8yxqtSJZ0kb+MRnfJoDBkxd5r1zCqXV72bBjtjqrCfwGme
         zHGn9iNJZftbbgnZ0zI2IC9wSz5VtRZvAMiKbjbcE8gekT0jblBSYe8ONR16s/Mzry3U
         8M4Zt9zVdVB6TPgl5KHpyMSupKbpnrj18XQMwQQdn0Pk3PKHqQ6MbCuJzlNc7UeLSfog
         idcPYhKONYuU2FOfufXyYzDP4zPX3RFm9Z0b+X2+LEFPfjo990m0juTZUci+2cKLGUGk
         JJig==
X-Gm-Message-State: ACrzQf05huo3hqXqfFa2GTODX9pEC4k3eEKUgP0coNBD9ROjgd/FyRf7
        JZZ4/UaQxPY+fNPpVEYIyhke66eUlxt3RwYn5ZQ=
X-Google-Smtp-Source: AMsMyM41WS0z7Q+C9EkEd35uB6rMtaV5C2bzXz0+TJcbwQBodw38hZWq67v/Gi0DfRyW20XD+4I71EriUfD1MTSIsmA=
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id
 ww7-20020a170907084700b0077ff489cc25mr12072416ejb.80.1663580899150; Mon, 19
 Sep 2022 02:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
In-Reply-To: <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 10:47:51 +0100
Message-ID: <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Sun, Sep 18, 2022 at 10:04 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Wed, Sep 14, 2022 at 3:43 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > WDT CH2 is specifically to check the operation of Cortex-M33 CPU so
> > don't enable WDT2 by default.
> >
For consistency I'll drop enabling WDT2 from the RZ/G2L{C} too.

Cheers,
Prabhakar
