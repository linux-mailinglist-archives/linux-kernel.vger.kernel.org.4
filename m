Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E69736961
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjFTKfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDE8CE;
        Tue, 20 Jun 2023 03:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94CC161188;
        Tue, 20 Jun 2023 10:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F1CC433C8;
        Tue, 20 Jun 2023 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687257303;
        bh=mSNmNKjU1+q7lSL0XI4fm9/XsSbvmqYX9+lrHnaptR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebr5UIF6mTBrOZiECk/zFRlWZNbul9E0LOL9hUl4Ct0NEEc4cdiTFvWPiU3mYflgK
         EnkvOuQsA+nsoNTAI7e1Q14dQ3d7d0N0t0r6rgR6LfBMLxgb4q+7pF07K6OtmuW6Ga
         qkmpXcV0bdCbXvT+bhyU/r62yiNKKMBx1PfcpNYPISDLb46SZBLz6rnr/ZoOIAQrPV
         E5OlhMMrpQaMNUwXD/+M71ox8PRNyLSniDL795rg/+oI6sHALQh0auzYvaJM5wE/IT
         2Xep04M9xLotJ9c6yQh62O58oPqc3+wdWvZoeZfwbNPovhEaVjPp2NxrTSj1s2nDtI
         fxvkEAJz65s6w==
Date:   Tue, 20 Jun 2023 12:34:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, jack@suse.cz,
        jinpu.wang@ionos.com, dchinner@redhat.com, hare@suse.de,
        trix@redhat.com, bvanassche@acm.org, yukuai3@huawei.com,
        willy@infradead.org, yi.zhang@huawei.com, dsterba@suse.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangerkun@huawei.com
Subject: Re: [PATCH -next] reiserfs: fix blkdev_put() warning from
 release_journal_dev()
Message-ID: <20230620-baden-antrieb-23bb65a2ac86@brauner>
References: <20230620111322.1014775-1-yukuai1@huaweicloud.com>
 <20230620042359.GA10255@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230620042359.GA10255@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 06:23:59AM +0200, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This needs to go on top of the FMODE_* cleanup series in Jens tree.

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
