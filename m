Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1516A6077
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjB1Uiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjB1Uis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:38:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2003D12F11;
        Tue, 28 Feb 2023 12:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rjmB08qSudLVy5Oxuak4SVT499NNZ/1U705pw44O6iE=; b=vg9fQ3uflWT52xvz1H2rIYukn/
        DHBuAKB8FQO09JyJC1EiRllcuNa0girL/GvIKEl3yimfCpJryD/1RDUWUQqiENzwy+BtPp8QVKjdA
        BsRgN/idbzGFoIMoYUsJRrFZCuqQPfdJF/2pHbLhMXC9xxDjFi1gcooSvTU/paxhqU7rBC7kLGqvy
        sqPJ2xa36Z0Zk4xJ4j6H3/Iy3r9TC45RvJNiRIURa7vtMOJ52h+9ErUZTOlvDXUJGuQykzvCHVTYs
        gt20QMNscDJO46o4aDH7RYmHAxSycerTAY0x+Hxm5jdMX+YiNF9itFx8clmluCjo6jHc8irjIrVxe
        LuoBm7+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX6kH-00EDro-Gy; Tue, 28 Feb 2023 20:38:45 +0000
Date:   Tue, 28 Feb 2023 12:38:45 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dyndbg: remove unused 'base' arg from
 __ddebug_add_module()
Message-ID: <Y/5mVe3NErpZj45n@bombadil.infradead.org>
References: <cover.1677612539.git.jbaron@akamai.com>
 <855201dc0204a1428a79d415c97df2b6e11c95c3.1677612539.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855201dc0204a1428a79d415c97df2b6e11c95c3.1677612539.git.jbaron@akamai.com>
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

On Tue, Feb 28, 2023 at 02:34:21PM -0500, Jason Baron wrote:
> __ddebug_add_module() doesn't use the 'base' arg. Remove it.

It would be good if the commit log explains why the base became unused.
What commit removed its use? As of what kernel?

  Luis
