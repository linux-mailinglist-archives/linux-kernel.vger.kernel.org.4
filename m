Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729E0714BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjE2OSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjE2OSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC69AD;
        Mon, 29 May 2023 07:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A41961AC6;
        Mon, 29 May 2023 14:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A3CC433EF;
        Mon, 29 May 2023 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685369910;
        bh=qtpoWinoDtek/CJTzXjRcfiz2zyP5qmWf/SqPGdUZTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoPxVFPIEo6GxI+yiXTOZT4gKuMclf8ipxJS5+hCEv+Pfbm748coE5vgIquHXmOi5
         +2HCPaeqOM5ME69ep9iaffkMYQ6X4O4exABd6aV5vYtmnGit7axgLYDoUKlDwyHy9C
         w/vNh4RB/4DNAQ7jCeU/ZYP2RIGsiFVSuVv3399Q=
Date:   Mon, 29 May 2023 15:18:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Message-ID: <2023052917-juicy-calamity-4b35@gregkh>
References: <20230524104754.4154013-1-rajat.khandelwal@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524104754.4154013-1-rajat.khandelwal@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 04:17:54PM +0530, Rajat Khandelwal wrote:
> IOM status has a crucial role during debugging to check the
> current state of the type-C port.
> There are ways to fetch the status, but all those require the
> IOM port status offset, which could change with platform.
> 
> Make a debugfs directory for intel_pmc_mux and expose the status
> under it per port basis.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Does not apply to my tree :(
