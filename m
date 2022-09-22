Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51D95E6526
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiIVOZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiIVOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:25:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B189DF94
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:25:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A02868AFE; Thu, 22 Sep 2022 16:25:29 +0200 (CEST)
Date:   Thu, 22 Sep 2022 16:25:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: remove nvmet_tcp_finish_cmd
Message-ID: <20220922142528.GA28397@lst.de>
References: <20220922070616.41918-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922070616.41918-1-pizhenwei@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-6.1.
