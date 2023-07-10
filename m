Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF874CD01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGJGcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJGcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:32:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5900F8E;
        Sun,  9 Jul 2023 23:32:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 74C826732D; Mon, 10 Jul 2023 08:32:05 +0200 (CEST)
Date:   Mon, 10 Jul 2023 08:32:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, arnd@arndb.de, hch@lst.de,
        christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, shorne@gmail.com, David.Laight@ACULAB.COM,
        deller@gmx.de, nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v8 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <20230710063205.GA24478@lst.de>
References: <20230706154520.11257-1-bhe@redhat.com> <20230706154520.11257-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706154520.11257-3-bhe@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
