Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B5710D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbjEYNTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEYNTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:19:22 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9446D99;
        Thu, 25 May 2023 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BiYBStJNOLDU6CVASAjjdQmOaxZ6ZXmr39+ac65rV2c=; b=xgQlUEJoApDfjNzRhAZ7nyE3w8
        XU78wFcub24VIs36AQ6Knnp4wy8htPszdMNdCkxvAy89Wj4Jj8gE2EGbhc7e5LSvDhdIkFgn5UcdX
        sMLInSML3Ay/xFAWVJ8l0j6z+7fp5g2aBp5omZ4Nc7jvjZzLy3oD36O1KX79g4UvQU7M=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:37108 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2Arp-0007ff-Ub; Thu, 25 May 2023 09:18:58 -0400
Date:   Thu, 25 May 2023 09:18:57 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     andy.shevchenko@gmail.com
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230525091857.612b591997faa964dfdfe1f6@hugovil.com>
In-Reply-To: <ZG84rnwh3XTdY-iy@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <20230525040324.3773741-5-hugo@hugovil.com>
        <ZG84rnwh3XTdY-iy@surfacebook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 04/11] serial: sc16is7xx: add post reset delay
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 13:30:06 +0300
andy.shevchenko@gmail.com wrote:

> Thu, May 25, 2023 at 12:03:17AM -0400, Hugo Villeneuve kirjoitti:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Make sure we wait at least 3us before initiating communication with
> > the device after reset.
> 
> ...
> 
> > +	usleep_range(3, 5);
> 
> I would put (5, 10) instead to relax a bit the scheduler.

Hi,
Ok, done.
