Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDD67FC5B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjA2Ca4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjA2Cax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:30:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6E5234C3;
        Sat, 28 Jan 2023 18:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zA38YMzjpalk5LMI/syb7IIPcIWJIaeVFFL9YzUdJWw=; b=qaPG+KfCNoXPyS9+3Oy7TM2F04
        Nejzniaw6RdAeUqJb+GNMGRLTYxevKwY2aUSTIZ4LRR8nWWUa2mYlUBN0Vpc9O3zwWnyMlZxFsJFP
        w9wTMUYON+g8VezA4cnanlahejw+wDb1zPUVYTCpoPruqc3TvBhZ3Szf+2338yUIZxo/CeIEUVCDy
        JwUIyavipCfoQIWM3NEG0k1uSEoA/ZKkg3utH0PknOCNwBpnc96VkzETPo2k83bsLvEStlHganyXS
        X3HOeUltcRcAM34IVNbPpYqeENnKq+zqf2Ogx3zYi7glp1kofFzalRuaS3TyYMKIAfUa4b1vIhShh
        CB9ZIk4w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLxSw-000ucg-5K; Sun, 29 Jan 2023 02:30:46 +0000
Date:   Sat, 28 Jan 2023 18:30:46 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] module: replace module_layout with module_memory
Message-ID: <Y9XaVtrNOxTGRJMJ@bombadil.infradead.org>
References: <20230126233606.1317794-1-song@kernel.org>
 <20230127204011.GA45594@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127204011.GA45594@roeck-us.net>
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

On Fri, Jan 27, 2023 at 12:40:11PM -0800, Guenter Roeck wrote:
> That is the only failure reported by my test system.

I thought your rig does some form of boot / runtime tests too?

  Luis
