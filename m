Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F5363BBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiK2If2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiK2Ieu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:34:50 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F610DC9;
        Tue, 29 Nov 2022 00:33:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B069368AFE; Tue, 29 Nov 2022 09:33:18 +0100 (CET)
Date:   Tue, 29 Nov 2022 09:33:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] elevator: repalce "len+name" with "name+len" in
 elv_iosched_show
Message-ID: <20221129083318.GC24762@lst.de>
References: <cover.1669391142.git.nickyc975@zju.edu.cn> <d96b45ef44f240db39d985661ba306eb7bde77d0.1669391142.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d96b45ef44f240db39d985661ba306eb7bde77d0.1669391142.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:53:13PM +0800, Jinlong Chen wrote:
> The "pointer + offset" pattern is more resonable.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
