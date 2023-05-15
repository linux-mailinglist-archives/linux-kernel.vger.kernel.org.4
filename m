Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2C7032BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242627AbjEOQTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbjEOQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:18:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A096E95;
        Mon, 15 May 2023 09:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363D46202D;
        Mon, 15 May 2023 16:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05DEC433D2;
        Mon, 15 May 2023 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684167527;
        bh=ofL+sBmDU00qKVVpaS2uC/73jlaEQ7fpFiViTop8mSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svDtCZrp7xXzJCeNqbc16cztM0Qg+rLC3jBYeowCCi7ah1+M3djBCbgsghJtHU/S7
         I5DPpZ90DaK+L4bpdpCWmp7PaZ68jKVYCB6/Gz7FOYv/91csytsPoYTTugalIKN0sv
         rpiFxFhBKNfSPgnSosTGL5ZYVI3vjYrf4pSu+AInvCXA29NASDPTSP+zDg+dRT3b3n
         uckyupb5sQNLmNid/tU9hW0EHq1r0KNckYduYvIAbI6S8rbbG+EYoHVWuGCqjPj/Sa
         Z9UFmes7CgnbatXArp6kLaA2Ro1XSJPN4QRCCkC9bnduUolISCfoKWuCDcT0NpKOb1
         PpAwaU6m1KJkw==
Date:   Mon, 15 May 2023 17:18:42 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dylan Van Assche <me@dylanvanassche.be>
Cc:     pavel@ucw.cz, quic_fenglinw@quicinc.com, trix@redhat.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: flash: leds-qcom-flash: add PMI8998 support
Message-ID: <20230515161842.GZ10825@google.com>
References: <20230507172941.364852-1-me@dylanvanassche.be>
 <20230507172941.364852-2-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230507172941.364852-2-me@dylanvanassche.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 May 2023, Dylan Van Assche wrote:

> Add subtype for the Qualcomm PMI8998 PMIC to support it besides the
> PM8150 PMIC which has the same registers. Adjust the driver to recognize
> both PMIC subtypes as a 3 channel LED driver.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  drivers/leds/flash/leds-qcom-flash.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
