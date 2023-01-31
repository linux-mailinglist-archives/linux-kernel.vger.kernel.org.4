Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50341682F49
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjAaOcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAaOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:32:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8633AB472
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:32:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8AA9CE1ED3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8E4C433D2;
        Tue, 31 Jan 2023 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675175527;
        bh=rJ+uNOuQrzdunZzqcySeoXFaea1ZloJyPf+QawRvpS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1BDntP1e+/ITz86MA+vF/8mJqQLw8gYMEbeXboVoQP7KreTjYv34jwJtXBAYByVz
         weuFvKByctTawkcq8KGpfgN7QX7v6hlrgmv5PwpNeUltUUWmnmxWY30tCOKV8Xf5T5
         C4bJg024EhzlgboHsfiNdZO+Wl5vLJ+Kg3Jtol6ioHZTSI1VHA4ezzTSMZVP4Dc7fl
         LVCN2kfnyiXPk64xpEfGgoMkPT/OyCVoeV0NPRVcxyKA7T5eht4/aRt1EYdPnIkZkJ
         Tm5R4D+yyqLi5IEeMdOc4EoXZ+xJrqTGQKs33BLZVx0VLFzyyPCDtzZjrx9wFUPtFf
         e0Kl9eG5HthAw==
Date:   Tue, 31 Jan 2023 20:02:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH v2 0/4] soundwire: better error handling in deferred
 transfers
Message-ID: <Y9kmYxjhoOxRVI+l@matsya>
References: <20230119073211.85979-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119073211.85979-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-23, 15:32, Bard Liao wrote:
> This is a generic cleanup series.

Applied, thanks

-- 
~Vinod
