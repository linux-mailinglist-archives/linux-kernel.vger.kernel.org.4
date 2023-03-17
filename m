Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A736BEECC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCQQsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCQQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:48:11 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3FA2F0F;
        Fri, 17 Mar 2023 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RI9NuZEA4fmn/KgwO5DGGynKUXx3qEwdTDpn6ekvb4s=; b=tKwsYNfkMN4xhPo9EBFfI2iN46
        b3LnmPJaBxcthXHGd2CN+oeiyCO7pA2y7D3BX3I1JFdrlgBT/HnrQREzwKLPTjDpJhg0l3e2ya00R
        78zY+fa2e5Yn0tTW8L/sB17PvmRT0WjuG7Ny2PV82moUT3xSmsPFwLuWL/RTB3uk1GBJYDmxddxzf
        EzSfmexP0BRed/lpZronEahapVRYhOKcwKiDyFLLPue8hz8U9e+Bf5mWUiMgNHzioSJ1zBNduM4l2
        At3V3oB6XrBMPbHu+vPp6XgxB/gXsKt6k3AwR8bPvwhEXvY/p/Ejaeg9hHAwq2c3/Xn7oXnAJHuwL
        FhiQJwqw==;
Received: from p200300ccff1235001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:3500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pdDEf-0007sD-KQ; Fri, 17 Mar 2023 17:47:21 +0100
Date:   Fri, 17 Mar 2023 17:47:20 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, max.krummenacher@toradex.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] ARM: dts: Add Tolino Vision
Message-ID: <20230317174720.66a8e5d3@aktux>
In-Reply-To: <58cbe88d-4ac3-c283-e16d-a0c84e04c850@linaro.org>
References: <20230317081618.2387407-1-andreas@kemnade.info>
        <58cbe88d-4ac3-c283-e16d-a0c84e04c850@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 10:16:42 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 17/03/2023 09:16, Andreas Kemnade wrote:
> > Add a basic device tree for the Tolino Vision Ebook reader.
> > It is equipped with an i.MX6SL SoC.
> >   
> 
> This is v2, so you need changelog describing changes against v1.
>
Sorry, I have forgotten that:

- improved commit messages
- s/grp-something/-somethinggrp/
- reorder compatible property for touchscren

Regards,
Andreas
