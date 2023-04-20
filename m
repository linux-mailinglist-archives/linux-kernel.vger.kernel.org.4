Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15236E994A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjDTQMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjDTQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:12:51 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3467A3;
        Thu, 20 Apr 2023 09:12:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4F72B732;
        Thu, 20 Apr 2023 16:12:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4F72B732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682007169; bh=hZ6Y1KhbKNKRcNYMkqAgLQX/1ccrylYOh6hnxsWWWwU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pVlg2gJ3KF+GNal5iXPKaDy33gqGnr59njtXiDkVX9A53h896lNpDgluoIFqgesUK
         EK1lr+YHn00gDJiVeqzle+YrSKYEdTt+7rjs5bFGA8E9+EtVCZuztJfymGlXhGOBOH
         tRjCvRvVPO7EaD1Rg5ldvo6y9T0cO6+/Rl72dujDTeDiYCXHW+XVSoQbIlojlvshZs
         EADaC1zjxyJP3nlSVYznXiKh7OkNTCRoAud5enONcwuu2FqVr9OhFoNK6MkG6zYN7U
         hxUjs27s044/oiAAC5RPb5P0YpEXkjTsYg+SBE0+RCojvkb/sViemC1wI8FOAvHwTO
         V3bSuz4iU2NKg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] Documentation/process: always CC responsible lists
In-Reply-To: <20230413165501.47442-1-krzysztof.kozlowski@linaro.org>
References: <20230413165501.47442-1-krzysztof.kozlowski@linaro.org>
Date:   Thu, 20 Apr 2023 10:12:48 -0600
Message-ID: <877cu6ttvj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> The "Select the recipients for your patch" part about CC-ing mailing
> lists is a bit vague and might be understood that only some lists should
> be Cc-ed.  That's not what most of the maintainers expect.  For given
> code, associated mailing list must always be CC-ed, because the list is
> used for reviewing and testing patches.  Example are the Devicetree
> bindings patches, which are tested iff Devicetree mailing list is CC-ed.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
Applied, thanks.

jon
