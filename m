Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A3F5F479D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJDQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJDQb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:31:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C58D2F3AE;
        Tue,  4 Oct 2022 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=c2f/IvwYYABYZVbIQp9qWgy/qVUR3KaPTanuyp3TFpc=; b=HusjNIHidkEeqrr0rB0KQc7xSz
        R27LxyvHHhj6CttXEnl9b+cP7vLpuTugR9/RzkaUoSu7zJqaAXdTOLkkjTqunPkmpajobgoeYO1g1
        mIBFfnncOKELGw4SI5wPCEOENayis6n1E/wmlK2mrOCgggFkpyqCyPZ391JiCY0rYVMpjJP0/LIPr
        +43s+SedMlOv6wXUzVexG0M+neQLfTn49GNvKtCLbQgexjphS8EEzeF1U6zpRakGEDi1TeJIVdy1i
        MScrajHrI1KyPm62adPZEu+3s25VotezamF2GtFOKGfFdKkCgDhI9Q5hxTcEdMkcxppUNxtp+CDAu
        OMh+k6tg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ofkpF-00ADKW-Qk; Tue, 04 Oct 2022 16:31:21 +0000
Date:   Tue, 4 Oct 2022 09:31:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: remove redundant module_sysfs_initialized
 variable
Message-ID: <Yzxf2VlLaknhRdic@bombadil.infradead.org>
References: <20220929121039.702873-1-linux@rasmusvillemoes.dk>
 <Yzty2iIZgv7NQrqL@bombadil.infradead.org>
 <4f4a62a2-4395-420f-0a20-e84c06b8c3ed@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f4a62a2-4395-420f-0a20-e84c06b8c3ed@csgroup.eu>
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

On Tue, Oct 04, 2022 at 04:35:43AM +0000, Christophe Leroy wrote:
> 
> 
> Le 04/10/2022 à 01:40, Luis Chamberlain a écrit :
> > On Thu, Sep 29, 2022 at 02:10:39PM +0200, Rasmus Villemoes wrote:
> >> The variable module_sysfs_initialized is used for checking whether
> >> module_kset has been initialized. Checking module_kset itself works
> >> just fine for that.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > 
> > Looks pretty sane to me, thanks! I'll queue this up for 6.2
> > as we didn't get a chance to spin test this for 6.1 on linux-next.
> > 
> 
> Maybe you can mention that this is a leftover from commit 7405c1e15edf 
> ("kset: convert /sys/module to use kset_create")

Sure, did that.

  Luis
