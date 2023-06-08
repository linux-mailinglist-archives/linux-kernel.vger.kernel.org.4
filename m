Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA2727F01
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjFHLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjFHLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887C22D7E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DB146189F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA0FC4339B;
        Thu,  8 Jun 2023 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686224444;
        bh=fMlsmt82Ib7I6t+N+Wk5ayBUVMcy6ID8LIVIDHkBIHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDHZ/TRjhfhSoHxwc7qdBTvYyq4Eru1PzhV0+/2rLTQSkd5iPYbt6a5tj3wF3T1oR
         WPIXbDC5B63ZUI8omlWMWG3DjpK4f+Wc8kzkEsVTaUXfBZlfhe+Tk9zYxG4FiZJfgW
         22hO1RvaJbMIUm+/84HAONphUhcY0MIHLCRpiKoiloQ5/BLSRLI4smBnEf97zUOMsK
         5ZWxZgQKAXiq3cyRJIfh+zDvJOUbqI6xNA5YIQ3TaHrt166ydZ0BvnuTrnhoLngPt7
         rbWhSn53iaRl0qHTFhEriTUZdIKQG0XMHYiJ6GGyznuST1p4gSOTZI8KUrtXVHrhTR
         nnTyVP9TnLZEQ==
Date:   Thu, 8 Jun 2023 17:10:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: debugfs: Add missing SCP registers
Message-ID: <ZIG+OJ4P6t2KIgKK@matsya>
References: <20230607020632.1030309-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607020632.1030309-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-23, 10:06, Bard Liao wrote:
> From: Uday M Bhat <uday.m.bhat@intel.com>
> 
> SCP registers needs to be updated to accommodate additional
> register entries as per the Soundwire 1.2 specification.

Applied, thanks

-- 
~Vinod
