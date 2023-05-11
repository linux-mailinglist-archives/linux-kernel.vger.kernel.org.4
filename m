Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FE26FF335
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbjEKNkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjEKNj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:39:56 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2710E44
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:38:55 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9e6ec482b3so10864759276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683812314; x=1686404314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUnqXRzBOhveOIpqDcwC7nsIl2ocjdjKERR1GWcB3Ts=;
        b=FipM+ypoVPe8Xx8VfnTBmVOBwl9PDxqw2SxjPqFGN2y+D/J3QvOUKDVdwSCTMyN3iF
         d0fsMLS7+1QHOLh79vMDtS7Gzc74Zxks9owOFqYeM1eCeZrbz0Zhm/gRj0C+JcNGNHsR
         jvSx19jJNCjOzJIFH9M6LwlmyNwlMNPYURhHUZzXqXfMZ/ea5HnCZqXAOYJb5oPHmnUU
         aRQ1hH13ujoMsNcX+vfdq3CYuxZa0adZmPod10DOVuyPVs63E5lUF5JYV+VSs+lk29n7
         /5VndbVw1ASb0YuqxgPNqk17/q8lidwnjjB3fNiksTGhnnjTtTBQQFCM3rSan32fpOE+
         1yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683812314; x=1686404314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUnqXRzBOhveOIpqDcwC7nsIl2ocjdjKERR1GWcB3Ts=;
        b=BTKKDAP3bRcSjI94PwH2jT+Cwr82BdBzNaDxmK7eNRxOn+GKgrKGUQPUxlEY41ZpDh
         RpdUNdPy5Ct0Ob438UCB4ioxO6mHQJQLfffST2eatS0mVEXpLo2WUGsUow5TcdgOMUG2
         hi5rHuv2K2qcaukwE9Glvytg534PU54t7mnsu87SEygPzwSPGK1PAkPACeCrdtolByCs
         jlUvUt9+zcorgK4dG74FF8ZoppMenX1EHqHBQhwLzD9s0mI+OTD53ZLAyVRl9jwMKiOA
         eUz/Krc9DSeay9pRdtVE3sFRiO021SaXs64rqwtnFGS+TXjHP4D4z8T8ZT4yhFkR0/Pn
         /xeA==
X-Gm-Message-State: AC+VfDz1k2jLbsfAKJCRHRmgxIE4OQNVY2Uf5EiWgM1uTkrF1bm/utta
        qFPWbERG9+ot09TP9h+hPQBLPGXxFvWEkPmV9P6N5w==
X-Google-Smtp-Source: ACHHUZ4YvXMBKvbTdA3WQDhmjRorxhecX2zhL92+p5FotauXBp2ZXPqxJMjHzHbciqZpaYgckIg6pnvmRtv6uOIFo98=
X-Received: by 2002:a25:26c6:0:b0:b9e:1fd4:5050 with SMTP id
 m189-20020a2526c6000000b00b9e1fd45050mr22584982ybm.44.1683812314148; Thu, 11
 May 2023 06:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230123151519.369158-1-krzysztof.kozlowski@linaro.org> <168380903252.184807.5434491458801772510.b4-ty@linaro.org>
In-Reply-To: <168380903252.184807.5434491458801772510.b4-ty@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 15:38:23 +0200
Message-ID: <CACRpkdanhYRtZZunV8UuF3yVc9NVqv3DDfQQTF5=ecLgQJ0VhA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ste: align UART node name with bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 2:44=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On Mon, 23 Jan 2023 16:15:18 +0100, Krzysztof Kozlowski wrote:
> > Bindings expect UART/serial node names to be "serial".
> >
> >
>
> Applied, thanks!

Sorry for missing to send a pull request for this for v6.4 :(

I actually have it in my tree (along with some other stuff)
and was planning to push it upstream, but this works too.

Yours,
Linus Walleij
