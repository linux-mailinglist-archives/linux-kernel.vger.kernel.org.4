Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89877143A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjE2FRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjE2FRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:17:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F19A6
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C61661028
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7509FC433EF;
        Mon, 29 May 2023 05:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685337467;
        bh=sh4pubmyXVQLpGpgSZtDf5EnBuwgelN/Cctaod7zKn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDX6G8p5IMAxh9JNKJUTvjXXlZdDtt9rXD8EDRgXuys/cs4Ps6eSzdiqeWbzIDw8h
         J2wwDJiZmHoMohiLRGsX9OuSSDLgQYZbLjs1rTWlRb8InhXoKoA7aFyrniVCssJ3IN
         2d10V1UIL4FH+9iza8dG6brjwUR2uSeG6zJVYV04/0oZkj4p80tCl8VbqeVSPDWSrU
         fvncktEUxQe22ek/0bS13uaxLs920Z8S5IQSdmPRGSPaNm4YqvLdDM4umg4B6Zvr6/
         O/31nfQ4ii0wUx8WkmyeLrUa95vUn6osd+PacSLXXBSl8B0rqDjaWvQHXUZTWFar/W
         KVGR0aSpB9Xmg==
Date:   Mon, 29 May 2023 10:47:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/3] soundwire: improve bus reset
Message-ID: <ZHQ1dmvFgifSU6X5@matsya>
References: <20230518024119.164160-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518024119.164160-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-23, 10:41, Bard Liao wrote:
> Improve bus reset sequence by updating programing sequence.

Applied, thanks

-- 
~Vinod
