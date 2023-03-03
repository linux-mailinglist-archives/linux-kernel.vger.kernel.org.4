Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF76AA422
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCCWV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjCCWVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:21:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047425D88F;
        Fri,  3 Mar 2023 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2rrU4JGBpShgskTSBHc/nYvc1ml5hRcK6NcBFOAKl3A=; b=oo/fTpjt0V/pywMdrslgA6ituO
        WfjaSr72fTwZKCDldArmqJzpscaQI4qJR+swEivUWJUb67LlNNMALg5h/g7YkX5xsCtWfGBbyMcpZ
        27G/FpcCx0VgX6RMiPxAqqf2BJBI1W3Ih6T+2UC7KffL65AdiIdAYlnSGXD4dy0WZhRynTuLw+D+A
        B5auxe6bYtkGo2ItQul63af678MU364H3Din+xqc/9gUwGc144C5WbJ8xSYc+j38+4CHdr4BVFhxh
        fY3Wku1IP67vcfYw777K/IT5qa3KfIjUPyvRzjBzstlYkphl/AIqxmT019S3AbfNV3metnixn8D8G
        +dBLQBCQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYDXn-007hPT-7I; Fri, 03 Mar 2023 22:06:27 +0000
Date:   Fri, 3 Mar 2023 14:06:27 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v3 0/2] dyndbg: let's use the module notifier callback
Message-ID: <ZAJvY5IiqTh4WXgm@bombadil.infradead.org>
References: <cover.1677861177.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677861177.git.jbaron@akamai.com>
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

On Fri, Mar 03, 2023 at 11:50:54AM -0500, Jason Baron wrote:
> Hi,
> 
> Jim Cromie hit a BUG() while toggling jump label branches in a module
> before they were properly initialized. This isn't currently an issue,
> but will be as part of his pending classmap series. Seems like we
> should covert to using module callback notifier for dynamic debug
> anyways to match other subsystems and remove core module code.
> First patch is just a cleanup.
> 
> Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@xxxxxxxxx/
> 
> I've rebased this series onto modules-next tree. Although the first patch
> is a cleanup entirely internal to dynamic debug I think it's a nice cleanup
> to have as part of this series.

Thanks! Queued onto modules-next.

  Luis

