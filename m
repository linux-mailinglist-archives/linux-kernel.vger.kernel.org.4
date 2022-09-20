Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D2B5BDC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiITFHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiITFH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:07:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FD95A896
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 22:07:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B45AB8247A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627D5C433D7;
        Tue, 20 Sep 2022 05:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663650445;
        bh=WNlXwAPY8FBdZQqXGzfXldNGu3sjnE8sRYLAPAEeiXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfFEJq8aE0p6AR22uKE8vqWus7qQ6F8NWKWjRp5ETGa2o9pCPR06KNAv1OfIBjiPA
         LhipuBoY25BD5aOBhAsXbUvFZk61gR0RUX47keNytFRhhJ0Nc6BZoIdqk/7tDVG+jo
         1ARqsFBYxsjYiEYkzbpXXN6PQubj7g2rkMbMLjSbN+IVUGgS1QnYHw7JAefAT53JuO
         NlTe4Vb8DcPwYaKQUXUA8DT2sJ3waFfzGhgHQNEP0mHoWOjvoPcMjuw7vtW45H6uAe
         T0DnYjFhy1HJIMxIgnHEI89jWe0EDsn5VAZeFa0yJVMs3YCOSPGQRjTFDRylRaPioh
         kS+03BhNXhh2w==
Date:   Tue, 20 Sep 2022 10:37:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] soundwire: cadence: Fix error check in
 cdns_xfer_msg()
Message-ID: <YylKiGoIt4tkJWxQ@matsya>
References: <20220917154822.690472-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917154822.690472-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-09-22, 16:48, Richard Fitzgerald wrote:
> _cdns_xfer_msg() returns an sdw_command_response value, not a
> negative error code.

Applied, thanks

-- 
~Vinod
