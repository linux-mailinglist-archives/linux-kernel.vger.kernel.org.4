Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA80716451
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjE3Og3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjE3OgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:36:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99871C5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:36:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5CE1B68BEB; Tue, 30 May 2023 16:36:11 +0200 (CEST)
Date:   Tue, 30 May 2023 16:36:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     arnd@arndb.de, hch@lst.de, andriy.shevchenko@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] misc: enclosure: remove get_active callback
Message-ID: <20230530143611.GA10069@lst.de>
References: <20230530140223.13994-1-mariusz.tkaczyk@linux.intel.com> <20230530140223.13994-2-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530140223.13994-2-mariusz.tkaczyk@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
