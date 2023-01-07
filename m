Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ABD660F56
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjAGOIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbjAGOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:07:53 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EF9B855;
        Sat,  7 Jan 2023 06:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YPpgZ7HqOt8u7N3zWjALtv8NDc76JuCmC+vYUpKHQ18=; b=8UOaHi1DtaTeFntHuAl7bzeS2i
        fD4HKloN8EUD64UqpiB8PMHfBccs4GlIrud7G7i5xFE9HMUHmku6W1MGws9Eg5Ykzsn5OwlhKxi4t
        pjKGPw2DRdLR6nX7u2+dNQiGLGbJCuDFD1PAwe1S02oR9PjlsAwMpuyLUbK+j+CVLTIdLPBCQI1zh
        MlZjFXHen8AIoNR/DjnjVzfqyIDw3OAHmUMBS7D76dkeYlQu7RrwhU4jPDOOw89qfyFOI9HhlBw50
        CgK/XdeP1O8xZGEw7RPi7mKSqFDGBTqf2bpx9uVpdPTEcFrqCy6cxjbBn+9qz58orvtEKxhDLRCbX
        eBPGpzxA==;
Received: from p200300ccff2fec001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2f:ec00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pE9rJ-000596-Ix; Sat, 07 Jan 2023 15:07:41 +0100
Date:   Sat, 7 Jan 2023 15:07:40 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible
 combinations
Message-ID: <20230107150740.0ba34aa1@aktux>
In-Reply-To: <123d1a56-8134-dc75-8b2a-b3836e727d4a@linaro.org>
References: <20230105213856.1828360-1-andreas@kemnade.info>
        <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
        <20230106203358.14878660@aktux>
        <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
        <20230107144336.2ecff4f9@aktux>
        <123d1a56-8134-dc75-8b2a-b3836e727d4a@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2023 15:00:56 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

[...]
> >> I asked to remove half-compatible. Not to enforce.
> >>  
so you are saying that allowing
compatible = "A", "B" 
is not ok, if B is not fully compatible. I agree with that
one.

> > well B is half-compatible, I (and others) have sent patches to remove,
> > but they were rejected. I consider these patches the way to go.  
> 
> No, they are not correct.
> 
Maybe there is some misunderstanding
"these patches" = e.g. 
https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/

Regards,
Andreas
