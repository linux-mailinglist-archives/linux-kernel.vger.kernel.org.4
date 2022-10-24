Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94ED60982A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJXCSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJXCS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:18:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4A27173B;
        Sun, 23 Oct 2022 19:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 965E3B80BED;
        Mon, 24 Oct 2022 02:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EAEC433C1;
        Mon, 24 Oct 2022 02:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666577905;
        bh=jon0JGTVaVcN9yndHotXJf/dtkBQbcoMcz/NXxTQY5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mA6aR5DyAEDhaw5e3ivDn+RCEmLN3jmHWkPRoJTVtgireUjtkLYtCcLAALGoYcKN4
         E40abTLLNxG23wR8sYGAWA3IRtP9HUE9/vSU0GUL3JR5Y8mqwgmasndEObQAWFGYOS
         By3OK9mJO4MfuZt4K5njV/gDbekJrj+/xRUoeUrQHLMtFEbMwOUwLUyM/8abdzZmDd
         txMsDOseTP+PYyNqrQ80z2O/Bb+srH3lICk4mVWQr8dwsGVqemQ/UdXAhUEZ8voYRS
         WLgwSshZ3jyr3QxGAdYqMrV598nZrV2bOjEMQ4l88kVQEQtCgI6pynINYUJdpBfJ76
         xOaCB6u/uuP6w==
Date:   Mon, 24 Oct 2022 10:18:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ls1021: correct indentation
Message-ID: <20221024021819.GB125525@dragon>
References: <20221002092004.68928-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002092004.68928-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 11:20:04AM +0200, Krzysztof Kozlowski wrote:
> Do not use spaces for indentation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
