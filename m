Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30781605ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiJTLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJTLZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:25:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9181B136406
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mz4/41ovfPNH44d4JltM/ocdDyNoH81gWz9uQdJMsTU=; b=0zS+gLdQ2Oz+IcmSJ9YOQvLNNA
        sKvrrPR72R4yBOftrnT6MHyi3qBHFtFC6LPdjAzyZOhDuapeSIwF4f4qgBpUZh6bzxJSnxKXrs8Jc
        ZYZhvu8OAwZ+xS+EQud3jcFIevkRzdzr2ng5Bs1Bm6tjAlHILF52+ilP4WSMVzB6qE6YFOCgGNHQg
        gQ4uBPVfS1FBV+UQ2Jmiqk81TJuc3DwHfzz+OaS6/y1sWk7C7+8GPRAkWI7ogrbW+R6Ji8bI1qaLN
        l8zVzol3qS5JTOly+bjUWDNHI9KZXu6esbTrnqP1y//cien/d12rzNY29Odsa6d8Ae9+/dIa5hIuq
        nLu4l+Vw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTgR-00E3TC-M0; Thu, 20 Oct 2022 11:25:55 +0000
Date:   Thu, 20 Oct 2022 04:25:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 7/7] vmalloc: Add reviewers for vmalloc code
Message-ID: <Y1EwQ3PzWdWFo5tH@infradead.org>
References: <20221018181053.434508-1-urezki@gmail.com>
 <20221018181053.434508-8-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018181053.434508-8-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 08:10:53PM +0200, Uladzislau Rezki (Sony) wrote:
> Add myself and Christoph Hellwig as reviewers for vmalloc.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Christoph Hellwig <hch@lst.de>
