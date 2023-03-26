Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476456C9271
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 06:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCZEwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 00:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCZEwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 00:52:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B1A5D9;
        Sat, 25 Mar 2023 21:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k4laSjkBcJxhCUWd9/xlCa2G+ceuEJhsw2vL5+Mj868=; b=Cm9iG/zhUPaHC/zp89uD/A1Mxx
        Zj6WjJdxlYa2ZZZtQ+mf0HLi8a7SnTYgcraNcTtIrt1ooeVIlZSb10wsqotP39KcEmG/tMAY0pVGT
        q19lRvT6XVQZBG/L2dHuwnR/ceQUyku5k7nVyTXRQg/PUI3UKd4ggvgSg8rXhco8hWLGMW0yS0nH+
        7Goym6I92iCM6cJVSkTBsGYTaxKErfaheLmhAmyU4ZD2nAPgd8JsAw+51eaYQ7Apx4eCUXpAO4IPp
        lQYaZ9IEMA56h1RN4wLK7HdYIr5l1F0rbWJcBSh8odATYCvE7JKcbJwrSPCtoAxj8IS5kfjJm5YKT
        qex4OmDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgIMj-008175-0X;
        Sun, 26 Mar 2023 04:52:25 +0000
Date:   Sat, 25 Mar 2023 21:52:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Message-ID: <ZB/PiZiO3zEdjDlI@infradead.org>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-11-nick.alcock@oracle.com>
 <ZAoGLhRpTr5f7AD/@kroah.com>
 <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
 <ZArc0ib697JIwKou@kroah.com>
 <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
 <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
 <ZB1p5zRp7rlGGuCP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB1p5zRp7rlGGuCP@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:14:15AM +0100, Greg Kroah-Hartman wrote:
> Again, I strongly feel that removing MODULE_LICENSE() lines from files
> that just don't happen to be built as a module is not ok as no other
> MODULE_*() macro has this arbitrary restriction.

Yes.  And it should probably have a use in the kernel by checking that
nothing license-incompatible ever gets linked into mvlinux.
At least until we can parse the SPDX tags directly and make use of that
instead.
