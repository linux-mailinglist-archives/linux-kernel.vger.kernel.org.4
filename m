Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82C728322
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbjFHO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbjFHO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:57:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63BD1FFE;
        Thu,  8 Jun 2023 07:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8389D6127C;
        Thu,  8 Jun 2023 14:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E811DC433D2;
        Thu,  8 Jun 2023 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686236230;
        bh=4jvw6/WUJ2q8p/bP+rspcHDv743jTfh1uzy4i5Wqk7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvWfhG/l9MbVzRBetNjpXEBfMnX1EyKf+/IuD4JN0cgRPPxsFV6okmgbTycWIcNpr
         mRhFL+JSe5PuRWXMaTVGtXXvR3WQqnB6Z0ZdcvrLFIbT98MFTVEU+ecMbl1rvUzIag
         RZVbsm2vwjNmXVw0HdCQFqbOm3kG4GmKcwyrZ5aa5/04xeRHfm+PcrrMBXs1M2HCTx
         uFmMaD3ALAK2AzeZ/5lydcwqeQpgH+JJzVFFyuB43zXlcSc8joA210eAFA2aEFNCET
         xVMs0f0ZvgDxT3b74X7L0KsVR1W2grswPWU3y7Rw/fDU1kJmIRsJSGhTjbuhsqvs3T
         F9+LCi6a+zhIw==
Date:   Thu, 8 Jun 2023 15:57:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: cht-wcove: set function cht_wc_leds_brightness_get
 storage-class-specifier to static
Message-ID: <20230608145705.GN1930705@google.com>
References: <20230530234748.3641630-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230530234748.3641630-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023, Tom Rix wrote:

> smatch reports
> drivers/leds/leds-cht-wcove.c:144:21: warning: symbol
>   'cht_wc_leds_brightness_get' was not declared. Should it be static?
> 
> This function is only used in its defining file, so it should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/leds/leds-cht-wcove.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry, you were pipped to the post:

https://lore.kernel.org/r/20230525183317.129232-1-hdegoede@redhat.com

-- 
Lee Jones [李琼斯]
