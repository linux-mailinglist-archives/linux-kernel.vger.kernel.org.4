Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF76749F4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjGFOpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGFOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:45:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AF61732
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CHQ8hr8v36RUyE6Io+JdxgB9ql1UaYrgMKiJJ9a/AXs=; b=rlWLPNqN6pXF19kxSMviYejBej
        sSr2dDOibt5FRbmZ5PUguwcwFgrfASMwtJzJDrj3mGJmKbe7hH1++3+Ve7aXU5U51/u5IRHhLBbJX
        pAqtA7oJJAEdUJCW9G0RI6NZlMBYJQHWJdNqVD03xOr3ssKVPUbjNLs4chYGtk9Af3oIPpLHJUNnT
        c6jQD7BrUYQC3kwWvjeTaAtERxV0EGBGKS2uXJEvjMBDIcSo76I7i0vuwx1sEsIihjY+SipllfRlS
        jJTWzAL5BvDPh2B2zzJ+EYe6BNeMeE/LANVBApsArGS6cKjs3nMmJ+TBD2dTMeMn5GqCWjvpbm8xA
        fDSH31zg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHQEA-00B993-OR; Thu, 06 Jul 2023 14:45:02 +0000
Date:   Thu, 6 Jul 2023 15:45:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Ming <machel@vivo.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] lib:Remove repeated initialization
Message-ID: <ZKbTbqfsFRJ5VXSj@casper.infradead.org>
References: <20230706140314.9999-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706140314.9999-1-machel@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 10:03:01PM +0800, Wang Ming wrote:
> The original code initializes 'entry' 
> twice in line 3229 and 3232, which 
> causes duplicate initialization issue.
> To fix this, we remove the initialization
> of 'entry' in line 3229.

mas_next() has a side-effect; it's not a pure initialisation.
Fix your tool.
