Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D8C72626E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbjFGOLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbjFGOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:11:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAAF10D2;
        Wed,  7 Jun 2023 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CYN3JV4C5kd/yOFkWrn3x1lniaR0lnn6zZT43JbjRgE=; b=ZEj94KvyIzIoBGuBCeLfmfip8l
        t6qQB/2VL78OQc2MiDnSEUNIiHQTeAmcCBqtA29+rme5swYIVRmAyFjZ5vVr3thAp/oa+eInId5/7
        GiCg41o0J83sicQexKw1hH2zn/z1UDfd/lpdd2bDparMKHloQ8LSb+U9mNqRWqz35ULpW9xPoju8b
        8KEcPVW7T+HZCXuRuUDVkPyLoUi+1PPgQO455bRKCvNBAUlBB4rotepuZUa3JZQKJw1sKFBXLhHVm
        +mPtVj2hKIxxwj2jqrGBR/9dopfVM3lsQy9qwQQKIwnVagWXn/WnNTu19RcwS6jPnBAiSF/e+s7e+
        /7xZIzbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6tsG-006DED-19;
        Wed, 07 Jun 2023 14:10:56 +0000
Date:   Wed, 7 Jun 2023 07:10:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, paulmck@kernel.org,
        bp@suse.de, peterz@infradead.org, will@kernel.org,
        rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
        wyes.karny@amd.com, jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: sd: support specify probe type of build-in driver
Message-ID: <ZICP8GFjPSu7rOjv@infradead.org>
References: <20230606051217.2064-1-iecedge@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606051217.2064-1-iecedge@gmail.com>
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

On Tue, Jun 06, 2023 at 05:12:17AM +0000, Jianlin Lv wrote:
> When SCSI disks are located on different SCSI hosts within a system,
> asynchronous detection can lead to non-deterministic SCSI disk names.

Yes, as can various other conditions.  Your code better be able to deal
with that.
