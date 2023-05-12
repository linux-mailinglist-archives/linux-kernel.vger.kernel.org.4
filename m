Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6670F700FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbjELUmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbjELUmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:42:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF403AB8;
        Fri, 12 May 2023 13:41:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D567D68AA6; Fri, 12 May 2023 22:26:24 +0200 (CEST)
Date:   Fri, 12 May 2023 22:26:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/5] optimize some data structure in nvme
Message-ID: <20230512202624.GA21607@lst.de>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

the whole series looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
