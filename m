Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC65C68D9B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjBGNxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBGNxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:53:01 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D35F4;
        Tue,  7 Feb 2023 05:53:00 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id DC32B87;
        Tue,  7 Feb 2023 14:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675777979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WxcfI63mtIII59k4Jv/2QN4RreNK4p1T15pIT1Atjw=;
        b=tM0TuD2IQIBkvLNeFLTsFZoxK6Qs4r1/X3EcW8ciUVQyTNgVRb6i1aeh38dTOVULGdiMEp
        srUaINfujjIJwzcHCYRf0NLyDIsjCcGWsZ/SNih4fvMF7/bBQhO7n3MqgK2/w4ghbFWaWk
        QASnu59Yx4o6hlzvZFBXnJjdu9bBQVqGJeEg+kn2Hj4mPxyvS4Sra+gjh3E8QULcnMTTkx
        bQxHs33Cp3dWKIER+rlrGdHSpogO0HBicW471t+FdMLj/HhRPuQB0g8GB5K3/2m5NTekoz
        eY+L8VgT1qD317V3vHFIJfs3F+R6l0mkx8Lqu4uhqqbyFQ1jGTnK5mmR49839w==
From:   Michael Walle <michael@walle.cc>
To:     mauro.lima@eclypsium.com
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mika.westerberg@linux.intel.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 1/1] spi: intel: Remove DANGEROUS tag from pci driver
Date:   Tue,  7 Feb 2023 14:52:54 +0100
Message-Id: <20230207135254.2465816-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230206183143.75274-2-mauro.lima@eclypsium.com>
References: <20230206183143.75274-2-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Modern CPUs exposes this controller as PCI device that only uses
> hardware sequencing capabilities which is safer than software
> sequencing.
> Leave the platform driver as *DANGEROUS* and update help text since
> most of these controllers are using software sequencing.

Out of curiosity, what is hardware sequencing? Maybe this should
be explained a bit more in the Kconfig help text. Looks like the
dangerous was there because you can update the bios and that
could eventually lead to a bricked mainboard. So hardware
sequencing helps there? how?

-michael
