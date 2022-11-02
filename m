Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D073616CAE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiKBSlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiKBSlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:41:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97B7E0C8;
        Wed,  2 Nov 2022 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a0QsxHnHaVdr7Z/zTUS3MGyhibIGFKVlfjPe/j6Bv18=; b=FDUztCQqNhOyI6cGVyHvdapFKc
        sp22jfxIEbeHnut8nwsxubwjNsuqV/UG4PoMCMcC5IxC5nU2S0yjzdvcqjazyh/3PBZB87dm/ApKT
        10GK3hXzaZmAU0ICl7cg+UMcWrwL0MKkF7evcHjkT7E7EKiPdtU2NroepW52odmcrVi9SQp7ZpVp9
        EcxbdWhHjvyVaPAkKPK/xpSLD8S6A+CECjdZuKXC+rrgUojTP9toiG9VR6DUMwKmlUag3NKarcQjN
        dBAotbMFv0+MP7LCA+NWQ95GEoynflhyMU7oAOeUZisqB95dMiwawi1a5S/XXmVhzQdHtjiU5gC1h
        zHi0PCCw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqIff-00DBqt-TK; Wed, 02 Nov 2022 18:41:03 +0000
Date:   Wed, 2 Nov 2022 11:41:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 18/30] module: Use kstrtobool() instead of strtobool()
Message-ID: <Y2K5v08yIDNk7sNW@bombadil.infradead.org>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <bb37ff26b0c748d0ca883d8f301190cd1177aad2.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb37ff26b0c748d0ca883d8f301190cd1177aad2.1667336095.git.christophe.jaillet@wanadoo.fr>
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

On Tue, Nov 01, 2022 at 10:14:06PM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
