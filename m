Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AC56E92DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjDTLeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjDTLeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D26FA;
        Thu, 20 Apr 2023 04:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 408A56486F;
        Thu, 20 Apr 2023 11:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747F3C433EF;
        Thu, 20 Apr 2023 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681990354;
        bh=LXTS1IWw9HMpX4EjxCR8ikUfLOHf6yuqAUElBiEjCfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKLLDz8JSTWW6MdTDCXbPZYSeHjJSkcb4V2MI8YnVLPDjMsxESmi1pJvKaA62fupV
         hfcxSzqvE4YDwO5a6VFjZWJCXAw3/gS4AsRO25YLJsw0Mj53Jx6dyH0AajkjGRVpYy
         6/2hOUn61p+Nt19L5KaDbCqk6UUBMEDDznKod12+dZna+GOZp//Ciec82ozigkb1do
         7UZDZlGIgn1PTCq+YJ1O61/fZ00vlmW1KFSE3ibmyBdi+KmMtnlwhiW39RFnYQX/eN
         kA3/RUNlUXkSrcf+t4P2lNzghjmr3nWGWLeBfH0uMzgss4uOWOTOf1guiDuO7YCGd2
         hXDT1biwaoo9g==
Date:   Thu, 20 Apr 2023 12:32:30 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: pwm-multicolor: Simplify an error message
Message-ID: <20230420113230.GC970483@google.com>
References: <07d35e221faaa380fd11cd4597e42354c8eb350c.1681576017.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07d35e221faaa380fd11cd4597e42354c8eb350c.1681576017.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2023, Christophe JAILLET wrote:

> dev_err_probe() already display the error code. There is no need to
> duplicate it explicitly in the error message.
> 
> While at it, add a missing \n at the end of the message.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/leds/rgb/leds-pwm-multicolor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
