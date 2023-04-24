Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A886ECF7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjDXNpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjDXNpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF71F9762;
        Mon, 24 Apr 2023 06:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 445E26248F;
        Mon, 24 Apr 2023 13:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72104C433EF;
        Mon, 24 Apr 2023 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682343875;
        bh=zZXJgGMl6/f0fItT3nBXjNiIqbQ0XBRjsQOvwTglNNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X27iR8+w1KemsZo5J3YOH+CigkMNQPb/tS2fPxMT1Tz02BtbsqwzxscsLhl7nimet
         skNxdW/PrXzsZGofgK5UPHRgm/cdCztv7IH/RlTDpCw12AzWo6/FIZUjkJcO8zYqEV
         xGwPXKWGswvHcpADKLwx1tVQMJLKX/epJBM1TqvpaGoKPZnNFSp5BWHfhBD/Ka91VI
         f/O4evyS/zyByVDCi9Z5vY9Z22JKfz5QOuULgub1jAIS0CapYF6seVI9FBr7IG9gBc
         rrWk/yFHafT5IQPvLavobsC2o5nb8aRMiHpwZ49sY/eLdwVA5AYBcmjgdDLkYkBBvJ
         HIrN6XQNuhWOg==
Date:   Mon, 24 Apr 2023 14:44:31 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Martin Schiller <ms@dev.tdt.de>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 4/5] leds: trigger: netdev: convert device attr to macro
Message-ID: <20230424134431.GJ50521@google.com>
References: <20230419210743.3594-1-ansuelsmth@gmail.com>
 <20230419210743.3594-5-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419210743.3594-5-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023, Christian Marangi wrote:

> Convert link tx and rx device attr to a common macro to reduce common
> code and in preparation for additional attr.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 57 ++++++++-------------------
>  1 file changed, 16 insertions(+), 41 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
