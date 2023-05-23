Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5370E529
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbjEWTNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbjEWTNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:13:10 -0400
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A48186;
        Tue, 23 May 2023 12:13:04 -0700 (PDT)
Date:   Tue, 23 May 2023 21:13:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
        s=202107; t=1684869183;
        bh=XgkS5pfGBfgomQ2cX19qkCcg9pnvL8wSIaYZhPPBet8=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
         From:from:in-reply-to:in-reply-to:message-id:mime-version:
         references:reply-to:Sender:Subject:Subject:To:To;
        b=pQPCCM4Fns7ROoCDiQD3WKrYv0oGXOfFCNjsVJSCcUJNekVqKNn1xvxXHS4lZVF47
         yxlQikX1u66o8ckseZ2d3KhHi+W4NqzJi3rCjllXXrsfJb7/u7vREsbcWnNsZkgkqU
         VaXwmPlEHjbw2lIHkkA9OjBTRCai5RXNXg1VBz0E+06RAqDO5Npv7Z41d33+frOMI0
         oqRR3XSeUZ0w8XMuoAetbi96jvOlmQaycZuE7hF6C/qHFc/2yRTNBO6S5LeeZb8pt8
         q1ngHyV9e9ht9kfzsDBpXy7IJ7p1SRN3ulkesTahmjmHgMluHFjOKVwJZJtGHIla3T
         ks30XpBOnwABA==
From:   Markus Reichelt <lkt+2023@mareichelt.com>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.3 000/363] 6.3.4-rc2 review
Message-ID: <20230523191302.GC4058@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230523164950.435226211@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523164950.435226211@linuxfoundation.org>
Organization: still stuck in reorganization mode
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.3.4 release.
> There are 363 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 May 2023 16:48:37 +0000.
> Anything received after that time might be too late.

Hi Greg

6.3.4-rc2

compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>
