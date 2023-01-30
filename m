Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7313680348
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjA3AS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjA3AS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:18:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC3D1205E;
        Sun, 29 Jan 2023 16:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1VIXC3V0JmO0GeZD2AnbP2Pjnz4uxAWVNZ8fJcXVk9E=; b=fvHCdZk+k9JjnKHeEV7loTMsxI
        WDYfO2B/XpRqNW0tZ6zESZJMF0iyGEzqO84qmKtO1NJJgv2/YaaUJDCJWC6KVuMXbOuGtNv2OYN6m
        13c45pakxw6EugPe26aOgnBuXqRq8byTE7HzGdQqLMJssf/Lc6E8iva0z99aqazGn4IA0PCFuph/0
        eN8qECVtwdSS75godsC+Sw9Z+VDkuH74cBL5rk+QOq8E7W/o1VwWiD9NUCJhatkv5jARReHe/UAXh
        AGUeoHvxNQraBTFaJKAlzX0KnaYcTZ16fQ0RHDODdVhBpN9ZxVy++mtgbtXnMh1dy7HUt4zBNUPw8
        Hr90AOCw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMHsK-0024bs-6t; Mon, 30 Jan 2023 00:18:20 +0000
Date:   Sun, 29 Jan 2023 16:18:20 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] module: replace module_layout with module_memory
Message-ID: <Y9cMzMQpRy21CFP6@bombadil.infradead.org>
References: <20230126233606.1317794-1-song@kernel.org>
 <20230127204011.GA45594@roeck-us.net>
 <Y9XaVtrNOxTGRJMJ@bombadil.infradead.org>
 <20230129153501.GA304461@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129153501.GA304461@roeck-us.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 07:35:01AM -0800, Guenter Roeck wrote:
> On Sat, Jan 28, 2023 at 06:30:46PM -0800, Luis Chamberlain wrote:
> > On Fri, Jan 27, 2023 at 12:40:11PM -0800, Guenter Roeck wrote:
> > > That is the only failure reported by my test system.
> > 
> > I thought your rig does some form of boot / runtime tests too?
> > 
> 
> Here are the detailed results:
> 
> Build results:
> 	total: 155 pass: 154 fail: 1
> Failed builds:
> 	powerpc:ppc32_allmodconfig
> Qemu test results:
> 	total: 504 pass: 504 fail: 0
> 
> It does run boot tests, but it doesn't test module functionality
> (it doesn't try to load modules).

Ah bummer, but thanks the tests!

  Luis
