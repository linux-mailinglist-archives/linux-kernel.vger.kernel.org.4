Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847C96FBC9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjEIBrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEIBrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:47:15 -0400
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F19C40F5;
        Mon,  8 May 2023 18:47:14 -0700 (PDT)
Date:   Tue, 9 May 2023 03:47:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
        s=202107; t=1683596832;
        bh=dstsLuQXnH7F9+fQVKYy6/vWfTdCZ70XX93c1AnqI8g=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
         From:from:in-reply-to:in-reply-to:message-id:mime-version:
         references:reply-to:Sender:Subject:Subject:To:To;
        b=IKv78S4ieh8hpCfe+/HKGHYL9lCkglzfabsfUYYJETr/vgpI7qMt0lWYLXQUeHVS4
         DHxSItYpFKiJMliPWbPcAfVl4423wJ1IG8bR6xJEhOHh7IsnesLds5oNeBXbd2TOd4
         C7bBdggQUHmMS9W4mkpib9F08Wx8MVjfng7YBfHkObYDWPwcgqUCFVr60Y98xhYakS
         ZedqaKzr0AMCr9TNmNA45/Mk0JHcc0cXVcAbR9rtfdAS1kTL3epS5tPCnoNeR1Fy9Y
         FcCSZoPFjH2m6TBX3Hiq4MOV6n2429kuw21QTqAVtlrld3L3uI2Uyjs1q/JCQtjfa0
         WZdSBgiLPXjTg==
From:   Markus Reichelt <lkt+2023@mareichelt.com>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.2 000/663] 6.2.15-rc1 review
Message-ID: <20230509014711.GJ3369@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230508094428.384831245@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
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

> This is the start of the stable review cycle for the 6.2.15 release.
> There are 663 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.

Hi Greg

6.2.15-rc1

compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>
