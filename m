Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9190A65DD18
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbjADTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjADTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:50:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455441C923;
        Wed,  4 Jan 2023 11:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dXOO6VXneOIxNOLNW7wWA7Y2ym3zeR+6MUrPi6myvSo=; b=A0Mxp63Uhf+sZNZDImRe6aE92A
        R2d4bKoiGcfsJtwG+UA1FoQSrV8A06HFJyFGcAMG/vHmfUte0jxUVf4sZ0+uJgHs0g3EObaSgibz/
        QGwR6kZBdBHdRgD8v0AaQZiUPmzUsTMiJ0FlZl1KhILLRaND///0nNR+jrUWru6YHg4xKHLpaA9F8
        O5WfZ1Oym/+ADF4amYne4cHoQeWtDZRkaBDGncnjbOqbAa+XhoyjgG2G4vLGnE0SoMEV2VihRmVb6
        vCDQoEHeVSXDXR8pGSM61mvUd68khCVUTnnK/y5WWCY4/n3Hgi/JVlLOYsbQho73WNylidcPlZUNE
        RnH28+Mw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pD9mQ-00Bafi-17; Wed, 04 Jan 2023 19:50:30 +0000
Date:   Wed, 4 Jan 2023 11:50:29 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave@stgolabs.net,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl_test: remove nvdimm requirement
Message-ID: <Y7XYhYdf0NEEdZAZ@bombadil.infradead.org>
References: <20221219195620.351544-1-mcgrof@kernel.org>
 <63a21774a3e03_1bf2294bc@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a21774a3e03_1bf2294bc@dwillia2-xfh.jf.intel.com.notmuch>
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

On Tue, Dec 20, 2022 at 12:13:40PM -0800, Dan Williams wrote:
> Luis Chamberlain wrote:
> > There is no need for NVDIMM to test CXL, so remove this
> > requirement.
> 
> Are you perhaps running without the new nvdimm pmem security test?
> 
> http://lore.kernel.org/r/167105505204.3034751.8113387624258581781.stgit@djiang5-desk3.ch.intel.com/
> 
> ...again these types of mismatches are expected in and around the merge
> window when linux.git and ndctl.git get out of sync. I would skip
> running cxl_test for regression purposes until around -rc2 timeframe
> when all of the new code has settled in both repositories.

No, since one can build CXL without NVDIMM it seems this is a fair
change as well.

  Luis
