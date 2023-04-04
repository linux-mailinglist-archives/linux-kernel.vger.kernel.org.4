Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591DF6D57E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjDDFNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDDFNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:13:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE651739;
        Mon,  3 Apr 2023 22:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ut/HHiiQrH+6W0fyNTzlPLqVjwvFGjhl8TQKbK7Axd8=; b=cvt1TTlN26TF0cgb4rh3Co3+FV
        vgGt+d9nsNFdZA0OBl2JW2+f+rlG+bw3OzuT/xkbwMSNULqu2B+8kd4yd5LMOZpFrAU+FnDkfH50V
        Yi+7olMD/3cEKdoLb8h3Op0QIyT+VBhCVxx2yPsYSqhcNUPlKTY4NFa7HtTLBH0PtLjqYyD5CbD4B
        zGQVl7zby2llmO7PkNfUmL1BbJhHTToGJLPAvrMf9WXSjvIb8o7Ycb32CGIRr7hIJeYdm9SEnOZWH
        GNKOvNGAg7VM6ob196o6YtNtYB4kXJlsm4dlL+uIPFZxzebEU86GVqfKKnPUwn69aShqrqKHYL/Or
        bti9d84g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjYz4-0004jo-1I;
        Tue, 04 Apr 2023 05:13:30 +0000
Date:   Mon, 3 Apr 2023 22:13:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sarthak Garg <quic_sartgarg@quicinc.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_sachgupt@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        Brian Norris <briannorris@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable
 internal features
Message-ID: <ZCux+gsR8Nz4Epxw@infradead.org>
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
 <20230401165723.19762-2-quic_sartgarg@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401165723.19762-2-quic_sartgarg@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 10:27:22PM +0530, Sarthak Garg wrote:
> Define new ops to let vendor enable internal features in
> mmc_suspend/resume paths like partial init feature.

1) vendors have absolutely no business doing anything, you might be
   doing either something entirely wrong or use the wrong terminology
   here.

2) any kind of core hook not only needs a very good description, but
   also an actual user that goes along in the same series.

