Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEC56F0CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbjD0UIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjD0UIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:08:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80785359B;
        Thu, 27 Apr 2023 13:08:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24bc5645868so799359a91.0;
        Thu, 27 Apr 2023 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682626091; x=1685218091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRywM9ksCcUtyGqUGbjhpe+w5v9xycaxXdAviafxUOM=;
        b=mOJo/ZDYuWDu6uLtGWJsPIeR0qM+RGhlJ+poGKx90S5LcJB5TQVWt1zG60kG3GXPD4
         K9CVOgzSZmZ93wlFIGWPr9Kf9Jt71f/fL8MGs7Z6qKEKh/Z/YTqWRgPuc3XYd9YoPsWK
         a0ljPYMl8Cx3VmXiIUUgeLvtl+4xgbNhfuT8AYlgTavVOHgFWKckDga1OM3wUumLihQP
         MHvY3B+d28Fjd4/7ITLlPLvFIQY0qpMFg4ZamViSeroyGD3w8oKHllWnpABLsYTRe75P
         N80VAf6yoI8hc/AmWQ3/78pKrFs5HwqgCalp2nBObRJkBHHeUidWU7duYQlFiakKgO3f
         ptOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682626091; x=1685218091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRywM9ksCcUtyGqUGbjhpe+w5v9xycaxXdAviafxUOM=;
        b=E/1iV7sWP3ayQLflHZW2pfw/E0b2lcBEAbgbo5/bg7u1N1jWQoDrjTQ3Ml485p1Nfa
         ZlJzGNhM5ip6x8SYeoW2WQ7k5+ahVl6hLHm5klT7klJLwTYNYbSRG0WAo6qpwqWdR8oA
         sagFGjKm9ffJIdmdtTrQAB6ptj1ImU5jlWoddVp1kfB0I5ahpyeqkjzxLfTvNFulSU+b
         hfJZYM9BabVyrHCx/acqjgwLeZ2dRv1fc2FOOT0Qo0wAuaI0Q5PolMgPRStn8Msrc3/f
         Hb7ytN9vfEtjKGRbF2dyTccp92fJg5yWrFXiMWUV+UfnPbfZ3VYMfCZ0ul80jZ4DwUuB
         z/lA==
X-Gm-Message-State: AC+VfDykb5yPqgbGlPdKc/Jw3GOn+NZBjHF3QRrIdU+FO03VYml5eRuF
        yaLnBxdievJiMwxA3g+I4T4xGkZUOd8v1UaDmvY=
X-Google-Smtp-Source: ACHHUZ7M8/g5xiGfWy0wlfvshlCUEbjr75XPes/muNHfy76Q9TJjoBLJBnY93+hI5Bj8Epbkd31q9EwxYzQ1KwU/BZ4=
X-Received: by 2002:a17:90a:34c:b0:247:2baf:d6f with SMTP id
 12-20020a17090a034c00b002472baf0d6fmr2770679pjf.0.1682626090841; Thu, 27 Apr
 2023 13:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230427195538.2718661-1-hugo@hugovil.com> <CAOMZO5CQeeme6uhb8NCzR2QADjkBM-mRC9-GUnmhLWSGo5MMoQ@mail.gmail.com>
 <20230427160608.f051241d750404939296f60d@hugovil.com>
In-Reply-To: <20230427160608.f051241d750404939296f60d@hugovil.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 27 Apr 2023 17:07:59 -0300
Message-ID: <CAOMZO5BNbRV1fLpwDZWgj9+gihHJBBGeZCvkF1tgm5GhwSn8LQ@mail.gmail.com>
Subject: Re: [PATCH] imx8mn-var-som: dts: fix PHY detection bug by adding
 deassert delay
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Thu, Apr 27, 2023 at 5:06=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:

> Hi Fabio,
> it uses a ADIN1300 PHY.
>
> The datasheet indicate that the "Management interface active (t4)" state =
is reached at most 5ms after the reset signal is deasserted.

Please add this information to the commit log and please add a Fixes: tag.

Thanks
