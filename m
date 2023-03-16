Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126966BD4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCPQMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCPQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD31C88BC;
        Thu, 16 Mar 2023 09:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7925A6207A;
        Thu, 16 Mar 2023 16:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62262C433D2;
        Thu, 16 Mar 2023 16:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678983128;
        bh=s6ea33uVEzel6jOwLIy4TqBJDhyoJ3mgEjQZx1n8+Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nhy6Q4NFzxlOeDueFXvy5tJwavt1r2RRSlxgGtqrpGrFYIUNIHNlJl9kA9uTNK+xG
         D8YtjvyrJRWfSFPDcCKjxCNKFoqf5Wl2pclfHOoC1TbYD7KD7BWdjudbfzU6P+JBrS
         wTlz2m4ZibgnjSw8qzpI9UBx2xB4q2+Ea+m4sXnC5Iw/pavMfbpzy/92ublAApCTDI
         ivjfNPBCfV3pitotlNMSeopRLXJR/YtHV91DbDKvTZEC0iJrrVO4/mthzI2UbZS6kv
         85mk47XmfoUDUvcc5vrvdwTcFJmMCr/14adCxVJsLBIFGwYJCqj2mHhrMJEQRXfm92
         u4o4hCv4qmGVA==
Date:   Thu, 16 Mar 2023 16:12:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: arcxcnn_bl: drop of_match_ptr for ID table
Message-ID: <20230316161203.GR9667@google.com>
References: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
 <20230311173556.263086-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311173556.263086-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023, Krzysztof Kozlowski wrote:

> The driver will match mostly by DT table (even thought there is regular
> ID table) so there is little benefit in of_match_ptr (this also allows
> ACPI matching via PRP0001, even though it might not be relevant here).
>
>   drivers/video/backlight/arcxcnn_bl.c:378:34: error: ‘arcxcnn_dt_ids’ defined but not used [-Werror=unused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/video/backlight/arcxcnn_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

--
Lee Jones [李琼斯]
