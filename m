Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EB26FF60A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbjEKPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbjEKPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:33:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391BE559F;
        Thu, 11 May 2023 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TFdTw592d1WOTkLZRizlwyL3RYF/7jsd4eJ+YyPPK5g=; b=W8G6bqUyJkrX6o82ZtqnkGRhIf
        7iIWW4uYNY8T9ARlE3uCP1Q7afdudYlX+ztWxRPYAp/wf21EgDlQOgP+ptVwOWH3eeMfuMD4nINs8
        aeissJYzFk6I3ZnXlTMi9MawsP0h4/j+/FtNXWIqFk8FF903X3wYOYsfPdBr+bFyr9WZ7PGP8oWdp
        +K5vT1ZMrJcfZwv7vTLBAVvuvPJkJ78Tx2jlFVvDTa1iFwoi5Gj65rxO3UWjmFhsccwmLR7oAwyFl
        SwfXTihdMyKBnvjBC+MS39AG6viKWbHL1SlLNkY4ZUD24Uv/ap6KQw2J7t4Es9kA6fqVpvvRShet1
        pNmWejwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1px8I7-009Dji-13;
        Thu, 11 May 2023 15:33:15 +0000
Date:   Thu, 11 May 2023 08:33:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org,
        stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/2] block: make the fair sharing of tag configurable
Message-ID: <ZF0Ku2b94mYtZDxO@infradead.org>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-2-ed.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509065230.32552-2-ed.tsai@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 02:52:29PM +0800, Ed Tsai wrote:
> Add a new queue flag QUEUE_FLAG_FAIR_TAG_SHARING to make the fair tag
> sharing configurable.

Why?
