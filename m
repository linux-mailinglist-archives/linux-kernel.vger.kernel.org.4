Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3EC71340C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjE0KiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjE0KiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:38:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE22124
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 03:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2B1760670
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 10:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EE6C433D2;
        Sat, 27 May 2023 10:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685183888;
        bh=JNsRIsRjL/8M1yvZ7uGK5oXUYuFpKrOFRM3AqzsXLYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5miuFCM+/3je+DB5zjAJcaNeWueZc60AAV1IKmvNtbTbjaYJmGl0irXHeF9CV40L
         UBDPdzjzJTenGyR2CEgdLZXIu/f9JV2oxtdstDpaLZc2h4F9Ij0aq/IZtUqCrniCJK
         7pbkIEhwG8ZBS4BNjloK6qwvoSoBwcn/QVAxt8bvqGOVwNqkJl9gY3NmxN8jaz9ACn
         Z9pt66qg+nxdseTn7YIQPcA3MKlOony+SbVU1u/cHHWsT/1UpMDzKEkXoYLzTdG747
         qZWEWD75V2lYnloxdAfMz3Dxb5kf0ixNHlLsCm+KQkNC8qiWhIIQiYKrFaqvwnHjFY
         DRSULoWRSWjnA==
Date:   Sat, 27 May 2023 16:08:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: dmi-quirks: add new mapping for HP Spectre
 x360
Message-ID: <ZHHdjJ+XyZzVYzX2@matsya>
References: <20230515074859.3097-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515074859.3097-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-23, 15:48, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> A BIOS/DMI update seems to have broken some devices, let's add a new
> mapping.

Applied, thanks

-- 
~Vinod
