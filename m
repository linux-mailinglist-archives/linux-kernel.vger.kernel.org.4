Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB571851D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjEaOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbjEaOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FE3D9
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4465463CD6
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6B0C433D2;
        Wed, 31 May 2023 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685543902;
        bh=LPKZoXnaP9n7fA6tZ2KXkYUF58hwH/yfWOwuVvlNrXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaXdWQ7slUT73I8bldtWrehAhLSNujmxsHPm5UdL1j7BJakLn3u7sYFPudkS16uWB
         0a4vBhsyarnwB/FkrzznXMM88STEetM9Uqe1gohiNsM1Kaugz3pgMJtcGcNrooQJv9
         TwLmOzrP/63nDOtDVEsXdnAz0id0dhnI3rPlUey4=
Date:   Wed, 31 May 2023 15:38:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: Re: [PATCH v6 0/7] refactor file signing program
Message-ID: <2023053135-bubbling-commodore-3a7b@gregkh>
References: <20230321193341.87997-1-sshedi@vmware.com>
 <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 04:14:49PM +0530, Shreenidhi Shedi wrote:
> On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
> Can you please review the latest patch series? I think I have addressed your
> concerns. Thanks.

The big question is, "who is going to use these new features"?  This
tool is only used by the in-kernel build scripts, and if they do not
take advantage of these new options you have added, why are they needed?

thanks,

greg k-h
