Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41B17168A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjE3QFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjE3QFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300CC193
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD1A9612BF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1068C433D2;
        Tue, 30 May 2023 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685462714;
        bh=yCDzj21CfLVCh4y4uoYZaN75mx/cS0V7OtJmKLAFe+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShgBWPIljj4Cdznri16BxvBNTVdb5d9+D0F7I5DpWjURu4SoEGgk/vx3bduTOml0n
         tBlmh/UJVXV2LwY84cZuU6yZIULhnomuyVn4SUB8FkcYREMQFxWHTLBwl0F41e7GHv
         KlhzlM4KBu4/x8r6DbjwtJDIFmKz63AbDMgnUN1LUj1FH05xZOQQuP3bNnhjqzrCJB
         eRAxXCLO/eXXQGqgqaph0BFkBRFWaS/m9xXPHd9UENXf5qUrfDBzdJt1ru0oxxvZe2
         6CFTbvD7sR4ACfbmcdHzbqoz4lUfhTcEFkcLHZrF+AQCkdoLMb9eeC8f/HW+t6fCCx
         CfHi+h9dSDmhA==
Date:   Tue, 30 May 2023 10:05:11 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "min15.li" <min15.li@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: fix miss command type check
Message-ID: <ZHYet3BBJ+PQ0cxo@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230526090834epcas5p197a90228102b26759f9b957c50d3bb6b@epcas5p1.samsung.com>
 <20230526170656.55303-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526170656.55303-1-min15.li@samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied for nvme-6.4.
