Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07A16DD6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjDKJ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDKJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:28:55 -0400
Received: from out-12.mta1.migadu.com (out-12.mta1.migadu.com [IPv6:2001:41d0:203:375::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BFF272D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:28:53 -0700 (PDT)
Date:   Tue, 11 Apr 2023 11:28:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681205332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=herqdWTSpQzIg4qxrA3Oi6bo3dutKqr8QPmPpf/XCig=;
        b=XrEy6Y82J+f6A5SrwL6EnMQ1YyNXk9Irj2fGdVsvyJYveUSX3YYzS6HiVSkYCaOvlqZZh4
        wQ1KG/AKUbmtPvGIm0YVTIpyfkTDynWwxr5mVPf2AjT5HzTy9mcs7PJrG8lLRWqNHP06Jt
        mYB0rFw1kJJD5kZBvsbg7ArSPx89Qfs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH RESEND v2 0/2] panel-simple: Add InnoLux G070ACE-L01
 support
Message-ID: <20230411092849.GB4993@g0hl1n.net>
References: <20230201-innolux-g070ace-v2-0-2371e251dd40@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201-innolux-g070ace-v2-0-2371e251dd40@skidata.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 08:50:15AM +0100, richard.leitner@linux.dev wrote:
> This series adds support for the InnoLux G070ACE-L01 7" 800x480 TFT LCD
> panel with WLED backlight.

Friendly reminder for this small series 😉

> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
> Richard Leitner (2):
>       dt-bindings: display: simple: add support for InnoLux G070ACE-L01
>       drm/panel: simple: Add InnoLux G070ACE-L01
> 
>  .../bindings/display/panel/panel-simple.yaml       |  2 ++
>  drivers/gpu/drm/panel/panel-simple.c               | 35 ++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> ---
> base-commit: c0b67534c95c537f7a506a06b98e5e85d72e2b7d
> change-id: 20230201-innolux-g070ace-fda21c89efe2
> 
> Best regards,
> -- 
> Richard Leitner <richard.leitner@skidata.com>
> 
