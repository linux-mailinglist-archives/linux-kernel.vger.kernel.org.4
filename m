Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B9B61EE62
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiKGJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiKGJLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:11:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB1B17068
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:11:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ED39B80E88
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615CEC433C1;
        Mon,  7 Nov 2022 09:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667812290;
        bh=ur3m8XTjWGanbIdV1M7CZKfN7rLxjtUgxCH7EPAmr+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXyJioX5vB62tgxOhSC8DT2i3wkNRMBbmgJC00TrXJ/vzvDzwdfk3lIdxtZ7Woj5r
         QyhM77RW/vCKsKpnddHxyN7TqsRS/ao0kJnulYRcZfdKjj0E6fdrws45GTWg1levrd
         qlaSlq7wnUEcw+VyxsPnVTYyjvWqgPBhscoOg/Z0=
Date:   Mon, 7 Nov 2022 10:11:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Clark <james.clark@arm.com>
Cc:     stable@kernel.org, Suzuki.Poulose@arm.com,
        Aishwarya TCV <Aishwarya.TCV@arm.com>,
        Cristian Marussi <Cristian.Marussi@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10] coresight: cti: Fix hang in cti_disable_hw()
Message-ID: <Y2jLvmF0GZ6yHY0m@kroah.com>
References: <20221102112003.2318583-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102112003.2318583-1-james.clark@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:20:03AM +0000, James Clark wrote:
> commit 6746eae4bbaddcc16b40efb33dab79210828b3ce upstream.

Isn't this commit 665c157e0204176023860b51a46528ba0ba62c33 instead?

confused,

greg k-h
