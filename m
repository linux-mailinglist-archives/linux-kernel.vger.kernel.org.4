Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1665DCB5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjADT0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjADT0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:26:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EC8140FC;
        Wed,  4 Jan 2023 11:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sKWomM+DcEbhiY0ivILO1StCDQeKSlZpPZFC0Ved5Dk=; b=WeFKEIuFZ83ssPnlgRE8l2wiln
        /nfl56UD7X8x9yVlyKKCcCFzX1BayGOh1gIiBwBubKvpxVYTE2IH13PQEMvK40zVYJEKwOp+yFjVh
        2c2NvsMojxklTjgZmsEaiXWB9IxI2CGoa6GqEMntSKlpfQYiZIJf0GRdpEWon+LpAx8GbCdMircVB
        KQOZ9XVConm6UDSnPSh4DISZnkOrzx1WIYCmuZUqlqv5kvyi2g1ss51M87msMMBM1Q5l0UYNEaW/J
        uafnaTLf1UG3eokXQQfwzeTiRc9PA/hb5rUxxRUfh+AZAlaFXFPWortEGwZJjNsODH8ybbmTd6n2n
        V9+DBY7Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pD9OQ-00BRFJ-R5; Wed, 04 Jan 2023 19:25:42 +0000
Date:   Wed, 4 Jan 2023 11:25:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-kbuild@vger.kernel.org, alison.schofield@intel.com,
        dan.j.williams@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, lucas.de.marchi@gmail.com,
        linux-cxl@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Modify default INSTALL_MOD_DIR from extra to
 updates
Message-ID: <Y7XStqJcM3wYxUXf@bombadil.infradead.org>
References: <20221214231718.1002194-1-mcgrof@kernel.org>
 <Y5vvVTwt+FfxTUke@bergen.fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5vvVTwt+FfxTUke@bergen.fjasle.eu>
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

On Fri, Dec 16, 2022 at 05:08:53AM +0100, Nicolas Schier wrote:
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

I've queued this onto modules-next.

  Luis
