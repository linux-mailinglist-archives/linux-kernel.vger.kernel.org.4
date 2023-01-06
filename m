Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05466005D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjAFMkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjAFMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:40:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536B4687A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:40:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4E65424A8F;
        Fri,  6 Jan 2023 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673008802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wh5xyDBHV8fkWq0+1QQR3mYomHcc7+MxORZJ1rFfnCw=;
        b=LdGJVy1xEl97Sb2hltrGnPy3oXDlAcRdLGhCRCGoktKEQjCp8Se3attqVjxLfVVLQJwVYn
        N+RjnN9DY3qwRRzGD+3jWtAPP1/HwfqMuQldk9+FA0KdF+xEnXNc+oPhI7MVY7HTtdfHpw
        z3t8inHfHsY17RfUaBhcpK5Jv4JlIks=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F7DE2C143;
        Fri,  6 Jan 2023 12:40:02 +0000 (UTC)
Date:   Fri, 6 Jan 2023 13:40:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kthread_worker: Check all delayed works when destroy
 kthread worker
Message-ID: <Y7gWoZJaymhvNNIx@alley>
References: <20230104144230.938521-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104144230.938521-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-01-04 22:42:30, Zqiang wrote:
> This commit add a check for delayed works, when destroy kthread worker
> if there are still some pending delayed works will trigger warnning,
> this remind caller should clear all pending delayed works before destroy
> kthread worker.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
