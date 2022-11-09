Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1D622E89
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiKIOzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiKIOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:55:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E01EAC6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:53:57 -0800 (PST)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1DBE066029FF;
        Wed,  9 Nov 2022 14:53:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668005636;
        bh=Bwmp25Vc0VJj9gKQf9yBmHI7RP0F72aTQheIjTNTnN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CefQtZ9/iUrkCQOrrekZDe1R9GkHeMjGMzoijn3x30RsdXg6atVhFL1PW/2YpTJJH
         z9IU2+jg2wpbn0wc0w0ecTF0j+0JZrPAisHRNqO+hCitCKroEhujm9GpICyO9e9FtD
         Y75jl58UiGsANhY/uQsQ6AngDRIjobi7U0nbRg5/Fatan04Wew7wKJ2bYzDpVs3W1C
         VBi4M8js1zv3evIIOXqsXANd2+B1kfZmhfbAo96O7ATf8cebK7XFUqRkXObIY1ukJd
         ENSjKRi07iUHCKczdV6pFNVXUuIRSJ50Ohf6+9LGmsjQNAw8ZT1ELPFQcA0PUkkJHE
         i8+jgJyMw0/OQ==
Date:   Wed, 9 Nov 2022 09:53:46 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] arm64: defconfig: Enable missing kconfigs for
 mt8183-kukui-jacuzzi-juniper
Message-ID: <20221109145346.prybmdztzc6imdbq@notapiano>
References: <20221108232228.1177199-1-nfraprado@collabora.com>
 <06c4f370-715d-4c66-ad43-143b652af5ff@app.fastmail.com>
 <d9690b4e-30a7-75be-5492-98206c3ccd99@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9690b4e-30a7-75be-5492-98206c3ccd99@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:08:27AM +0100, Krzysztof Kozlowski wrote:
> On 09/11/2022 08:28, Arnd Bergmann wrote:
> > On Wed, Nov 9, 2022, at 00:22, Nícolas F. R. A. Prado wrote:
> >> mt8183-kukui-jacuzzi-juniper is one of the devices set up to run tests
> >> on KernelCI, but several of its drivers are currently disabled in the
> >> defconfig. This series enables all the missing kconfigs on the defconfig
> >> to get everything probing on that machine so that it can be fully tested
> >> by KernelCI.
> > 
> > The changes all look fine, but I would recommend not separating it
> > out into 13 patches when you are doing just one thing here. 
> > 
> > As a general rule, if you keep saying the same things in each
> > patch description, it is usually an indication that they should
> > be combined. Similarly, if you find describing unrelated changes
> > ("also, ..."), that would be an indication that patches should
> > be split up.
> 
> I agree. Descriptions you wrote are useful - they explain why you are
> doing it - but it got all really too detailed, just for defconfigs. One
> commit per one symbol is a bit too much...

Okay, thank you both for the feedback. Given that this is a contentious file,
splitting independent symbols throughout the commits seemed to be more friendly
to possible merge conflicts. But you're right that there's a single overarching
goal for all the changes, so I'll join them all into a single commit as
suggested.

Thanks,
Nícolas
