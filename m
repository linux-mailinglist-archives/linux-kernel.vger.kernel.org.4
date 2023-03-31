Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0E16D2150
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCaNPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCaNPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:15:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27E11A94D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44D4262918
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E54C433EF;
        Fri, 31 Mar 2023 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680268530;
        bh=LUbAsg5ttocyiJL1QbsovywDIOC9eC4ES6W8XYgAYq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gF71sGrU8nNLHX0uOSq/zT4uGi02EfQ8/tCAyUM9GdNIK+vxt/1BclR8V2FYGKGIt
         +zIYoPWOgRZ99NJtt5BCDVd8MkxHSjvDF0mWzmJQh525Q9XqmSjxn2ec8sTGsJW7MF
         KlIz2B/kM+2SVwhJ9bwAfmXYnP6A0FnSCm85g06gIRYsOS+0ksIGVvqsbsbnM16SJI
         HNjll00kF3+9zLV1mnbE8rB3DDYAQO3UITZWyhfJu4y/ftURAngiYcWw2ShpVAtt3A
         iS/p6wOXSk+BCXGJamh7TqodHmC/3L+owdkSdfYy0B1dEvBYbL1b3iXlndciFi9Ybl
         6SAI5BiMkzSdw==
Date:   Fri, 31 Mar 2023 18:45:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH v2 0/2] soundwire: stream: uniquify dev_err() logs
Message-ID: <ZCbc7omBvGNLuCcZ@matsya>
References: <20230322035524.1509029-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322035524.1509029-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-23, 11:55, Bard Liao wrote:
> There are a couple of duplicate logs which makes harder than needed to
> follow the error flows. Add __func__ or make the log unique.
> This series also changed some uses of "dev_err(bus->dev," where the stream
> may depend on multiple managers/buses.

Applied, thanks

-- 
~Vinod
