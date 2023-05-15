Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09AB702DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbjEONRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjEONRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:17:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1CD10A;
        Mon, 15 May 2023 06:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8299762462;
        Mon, 15 May 2023 13:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647A5C433D2;
        Mon, 15 May 2023 13:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684156662;
        bh=ptDRNornCJGXOlGr4nU5vrPyK26ECBlQszQEugZstUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iws3ptO9Y43Dk6Huf+l2QWXtv3DcWcG6tiJSo117mnlxgnUXpX9DIQWm2GgA35dow
         aUd+0SANkCLuUna5px+0qnwTMsaBBx+Cv9+aZdhEmZ/ivDLExQXbs/i72ZQQESqghj
         B789wdoeWb+9ic8yh9M3A0QKsplQj67+tN2MZ29vW5Ffdl5TeoQe7qlipSKIjFMvD+
         dAMc040gh6y4QdqgxL3u5lOTqpmxBdTIoZvx9diD2tkT74GJVrzQqDy4w77Nwg7AgY
         61tRB7ZPEBJ/kp1qbE/OBdF8Pd4e1f4CgNdRyN+Al0wCx3O2G8KHmsKtKdKIXGW8Gg
         EC9woxkEF1JsQ==
Date:   Mon, 15 May 2023 14:17:37 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: backlight: ktz8866: Add reg property
 and update example
Message-ID: <20230515131737.GG10825@google.com>
References: <20230428160246.16982-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230428160246.16982-1-lujianhua000@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2023, Jianhua Lu wrote:

> The kinetic,ktz8866 is a I2C driver, so add the missing reg property.
> And update example to make it clear.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>  .../leds/backlight/kinetic,ktz8866.yaml       | 29 ++++++++++++-------
>  1 file changed, 19 insertions(+), 10 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
