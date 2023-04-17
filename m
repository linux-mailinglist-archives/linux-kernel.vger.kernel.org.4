Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE426E5531
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDQXbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQXbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:31:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A36444B5;
        Mon, 17 Apr 2023 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JR9XQdl/IwMpkWgWz9eFmvYv3oi4xWhCddca5ohSf00=; b=WjcPgqyzkozndwKnTfngwJOMhE
        RODsXTEj0VB2kslKrfjQjcg1+bQqmbULJaLOv4IfvmRwOnNQyVyWXNlWHijtBNV6j6R1SZfgAK6qq
        JK5O4Q5iBUiq14RlKPcsTzB18wFH9XDGQYlKsRKKu/j/4wgFFlkk8LqlU4I94pE+WPeJzHMii+lPa
        +1sAnm3ph6p7te8GavGgR+jelttXQOhfgKH2/D1Qna+2lxvN4ZkXuSBWc+hm1m/kamWMky3uDV60y
        +p6iAY1TmNaE90EGdB5TOG2ZiQnjB8iEtAr6eoEmG1QdyXKp1xFWaZSGj7KYRhRNRSc+yvYe3LhHj
        4rULUbEg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poYJr-000PFU-1g;
        Mon, 17 Apr 2023 23:31:35 +0000
Date:   Mon, 17 Apr 2023 16:31:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: stats: include uapi/linux/module.h
Message-ID: <ZD3W17bPmajL1gb9@bombadil.infradead.org>
References: <20230417220254.3215576-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417220254.3215576-1-arnd@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 12:02:46AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> MODULE_INIT_COMPRESSED_FILE is defined in the uapi header, which
> is not included indirectly from the normal linux/module.h, but
> has to be pulled in explicitly:
> 
> kernel/module/stats.c: In function 'mod_stat_bump_invalid':
> kernel/module/stats.c:227:14: error: 'MODULE_INIT_COMPRESSED_FILE' undeclared (first use in this function)
>   227 |  if (flags & MODULE_INIT_COMPRESSED_FILE)
>       |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied this 1/2 patch and pushed, thanks!

  Luis
