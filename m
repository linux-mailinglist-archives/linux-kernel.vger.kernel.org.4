Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF58641C1E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 10:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiLDJnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 04:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLDJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 04:43:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9C21834C;
        Sun,  4 Dec 2022 01:43:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A648360DDE;
        Sun,  4 Dec 2022 09:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65563C433D6;
        Sun,  4 Dec 2022 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670146985;
        bh=ayAELCv0ewXrcFaKhq8TH08re9I7mHzABBsDF+aJCJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xu1wzlZWAIH4oQW29HXXoLGKkcn/6/8mI6PIjoLstFFDTEjVNte3keK4669XnonZw
         gc+eS+ongGAcnelBnQwvgUzissf0tKgBTFAwbJbHjvzZC00PMZAaTmTBZBFXWzVeZD
         2RoebkYYtYKL4+ZRsff7WGI8XF24moRI5vIXSosM=
Date:   Sun, 4 Dec 2022 10:43:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v3 3/3] usb: typec: maxim_contaminant: Implement
 check_contaminant callback
Message-ID: <Y4xrpgCTqV4yAplp@kroah.com>
References: <20221204084844.3573800-1-badhri@google.com>
 <20221204084844.3573800-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204084844.3573800-3-badhri@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 12:48:44AM -0800, Badhri Jagan Sridharan wrote:
> +EXPORT_SYMBOL_GPL(is_contaminant);

Sorry, but this is a horrible name for the kernel global namespace.
Please properly prefix it to show exactly what subsystem this is from.

thanks,

greg k-h
