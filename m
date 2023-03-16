Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212B06BD611
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjCPQlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjCPQlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:41:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FEFE487B;
        Thu, 16 Mar 2023 09:40:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69E57620AC;
        Thu, 16 Mar 2023 16:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18EFC4339E;
        Thu, 16 Mar 2023 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678984836;
        bh=fgyKwRL/T1cLqthLNrN4XUnF7P+4QZwjgQbMtSXajt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EF0h1Jc+CTaVADE0xVeymNEt6MOkX17wDm5ADUo9qyqsLhqLF0S0x5Obe6gGFwPsL
         0hRHMnoP0PeEDdULtGtDDAu1rkjZUS8L7UBrArJ8YgK1x8Me7pXS3pQCJqTECrPjc+
         isGDOTCpmEF18JTjng/rHlNMobvengRsf/gb8+uSoVXnspKpJy8KOyaltSFcbYjXdN
         mMDBpvrVDZmwTM2hBZwiT9U+Yry1jgCMiEE7f8RoryTpgJEJR0CJRQrgg745J44ClM
         sIU2M6OoxcW+5c/m50lnuuH3Q/DxoOCRERiKXvfi2JaHLXWJMUolCo2xs1IsAUeZp6
         4nGeEgV2OyK/w==
Date:   Thu, 16 Mar 2023 16:40:31 +0000
From:   Lee Jones <lee@kernel.org>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: add binding for aw200xx
Message-ID: <20230316164031.GX9667@google.com>
References: <20230314120252.48263-1-mmkurbanov@sberdevices.ru>
 <20230314120252.48263-2-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314120252.48263-2-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023, Martin Kurbanov wrote:

> Add YAML devicetree binding for AWINIC AW20036/AW20052/AW20074
> led driver.
>
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>  .../bindings/leds/awinic,aw200xx.yaml         | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml

Applied, thanks

--
Lee Jones [李琼斯]
