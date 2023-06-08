Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146BA7286A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjFHRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjFHRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEE02D42
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898AA60B56
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD27C433EF;
        Thu,  8 Jun 2023 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686246686;
        bh=nLJPupqcLGY2QcJeGQy4/qiw5WaljuqP39nJCPo8QQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TtSMYwLIIplRPFD43Q0n+OTq5cU1Q6uJBACdo2LiwWfPRi/tWHTMS0BZL3546Hbvp
         GlTumisv5Maws1aOitjZqivXnhl339/NLno2Foku/z9xrji7xyj3nhQLcHsl+CBVOM
         qzYMfu3rC7RbI6PZvC73rVLRFGECtW2FWTrBiC9ONIGKp2g0/Ik0niA4mtjFGsCHfa
         W4OrApkPoPMMKX9GnyQVqxrP5x8T0bH3S6I1EBJ7vBDBeJnSzB6M/4eql7uWcglBZG
         Pj7ta6UYDSPBtq/bDFm9Uf+K75DXyXlfvm4TOYpOUul+cvWSzhoRQOBFOB+jUtDnkb
         xlRiolvMsRH5Q==
Date:   Thu, 8 Jun 2023 18:51:21 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     krzysztof.kozlowski@linaro.org, conor@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: stpmic1: add pmic poweroff via sys-off
 handler
Message-ID: <20230608175121.GN3572061@google.com>
References: <20230602062426.3947116-1-sean@geanix.com>
 <20230602062426.3947116-2-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602062426.3947116-2-sean@geanix.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023, Sean Nyekjaer wrote:

> Use devm_register_sys_off_handler() that allows to register multiple
> power-off handlers.
> This will allow boards using the stpmic1 to power-off.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  - Removed superfluous function
> 
> Changes since v2:
>  - Removed the devicetree option to turn the power-off functionality on and off.
> 
>  drivers/mfd/stpmic1.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
