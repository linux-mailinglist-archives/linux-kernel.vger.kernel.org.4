Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0F71091A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbjEYJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240762AbjEYJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:39:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDE1E43
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I5oO1kYNE9YxQL1kRyl5TeIb0Whiv9SASuKrYcI+4Rw=; b=k7MzC2bWdWGnYPFe3s/UOdXynQ
        ogKLXdVFzRcqdoM6gzeNj3sex6GLjvuL+IKmPmE/wHnovyC369Td6EcTl2wQ3N1czpwwUHyWwSHi8
        dPfq6UpBondbKh6XgINXqqv4EEvKEDPr22ByFCnZu8FKVhOW1m7PwB0gIBZCV/lKmmP1KShwISrMt
        4YF846REwk/fLsfAPU9cNlKrzbINM/9AYnhucdb5i5d/eKyriuLqkQNxppW8VnH25iIIh4yrDO55F
        UNtwaOjVZXKVB9j62gheHfYaGeii/2+RnY8VViZF/Q4PrKy3JicOZLMTX4BNIAPr7EooIg6vTvHd1
        n5qNDLsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q27QW-00GAiX-2v;
        Thu, 25 May 2023 09:38:32 +0000
Date:   Thu, 25 May 2023 02:38:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     arnd@arndb.de, andriy.shevchenko@intel.com,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH v2 1/2] misc: enclosure: remove get_active callback
Message-ID: <ZG8smCMmhIFkGYXu@infradead.org>
References: <20230524111231.14506-1-mariusz.tkaczyk@linux.intel.com>
 <20230524111231.14506-2-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524111231.14506-2-mariusz.tkaczyk@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 01:12:30PM +0200, Mariusz Tkaczyk wrote:
> +	/* The value of ecomp->active may have been updated by edev->cb->set_active(). */

Please don't write overly long comment lines.
