Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7916BE875
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCQLlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCQLls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:41:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A5426592
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F89BB82586
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9069DC433D2;
        Fri, 17 Mar 2023 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679053221;
        bh=WxvCZcLir7aYlJOEV9HMwK+4F7ycx7Q0+GqdewEw6Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYMRtHP7/6Nr1VRq458qDXRv25hSxEcBavs8LVVqCICDXZPuAnOOZXpCzwXXnKKe+
         Fx8HRTZ6q7jXwFYj70ouOJmFt6bcQxsVG3Usq1RChEeMZeNAYm98pRuDW3Lx5coFzY
         LL0yr/RRAeN2/zqJ8XQgg357WzxRcuOh+VQoF4Mw=
Date:   Fri, 17 Mar 2023 12:40:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Komrakov <alexander.komrakov@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, giometti@enneenne.com
Subject: Re: [PATCH v4] pps: Add elapsed realtime timestamping
Message-ID: <ZBRRozhyG7BauKnj@kroah.com>
References: <20230317074739.193965-1-alexander.komrakov@broadcom.com>
 <ZBQdWRHzakFLzSkb@kroah.com>
 <CAMedr-_ssg-baCz94ExMVTeXr2Qivzop1kEpx0S4PWuQdAiGaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMedr-_ssg-baCz94ExMVTeXr2Qivzop1kEpx0S4PWuQdAiGaw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 02:51:50AM -0700, Alex Komrakov wrote:

<snip>

Please fix up your email client as it is sending html email which is
rejected by the mailing list and can not properly quote emails to engage
in proper discussion of changes.  The kernel documentation has some
hints for how to do this.

thanks,

greg k-h
