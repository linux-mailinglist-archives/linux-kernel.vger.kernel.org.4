Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF0B5B660C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiIMDPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiIMDOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:14:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D94D7F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:14:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01EAB612F3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6552EC433D6;
        Tue, 13 Sep 2022 03:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663038880;
        bh=8JC/B9JZUQhenRRvDd8NvsyFCs8a+rvxeJIV+37n1uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtZYL39qCjhggC/pWxPskSbkNP9uuCWLQsmbY86AyzgIQI1wSDl44In7gsYviKI7r
         fXMFfAjRX3YuOLKlG6ALd4JKE/LS7+MRhxnQUcJvVWN1etoGDLdtNQIkqIHkA/j86O
         9wykrI1aDhVGequLO2di0gvdT00AKSeniPcGvP9OP+C5gzZMBWmH5vdjgLVTkNKaZZ
         mIg7q7MZKW19PwBK+wWxbqkIP+GtM1HgbI1qOLwc/KnIQASSAIn0/J5U2vwJuMFr5r
         rOwkmu9+9SJ0QmFAK2P7EDDAEEpFmbk7KBIbZT7z2xtbkTCvxK9JGdMQLmlzXrp6zH
         447bSZ6Wpje/w==
Date:   Tue, 13 Sep 2022 11:14:37 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jameson Thies <jthies@google.com>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Notify the PM of wake
 events during resume
Message-ID: <Yx/1neGOF+0jsqvz@google.com>
References: <20220912224745.2716345-1-jthies@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912224745.2716345-1-jthies@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 10:47:45PM +0000, Jameson Thies wrote:
> Update cros_ec_report_events_during_suspend to notify the PM of wake
> events during resume by calling pm_wakeup_event.

Could you add some more details about "why"?

> Signed-off-by: Jameson Thies <jthies@google.com>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>

I didn't see where the R-b tag comes from which has been attached since
v1.  You shouldn't attach the tag even if the patch may have been
reviewed somewhere but not in the mailing list.
