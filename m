Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0823F65B267
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjABMvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbjABMvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:51:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711976467;
        Mon,  2 Jan 2023 04:51:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4230B80D36;
        Mon,  2 Jan 2023 12:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A707C433D2;
        Mon,  2 Jan 2023 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672663870;
        bh=z40E00opUPjuGNgqIdcCfR6E9dNW2Xcs3xWHouS6tLc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=V6K9sxb5QpN4I3CeUHdldimrqJU8R6TRtgIzTJsgG4uFuYZjmhZJKFY8/uL/jjnKi
         7Ve84Khd+1iPIGTbHyUyalUpUM3RiO7VLPoouy8p17Qlebs+4FbPIWGM2UFKN7odYT
         0Gzx6tzCKpv90ypqT2ctId64GxCkOIwLOVZ7i9JjxImQPyJ81vyDpQlU8rIYIpzoWK
         GPL2Z52Rhey5vWCMr5imPSZh/3gDIZ1nNNYwAMvKdBCZ3pPOu6SDkDbi/Gs6jHL3PO
         3ShDufFbV/862Vv414QUwAKQPMDO6zkKATREDNOlGpaXQXMciNsihYU/kXp2phN1B3
         1mR0au5GPtMvg==
Date:   Mon, 2 Jan 2023 13:51:03 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Xu, Even" <even.xu@intel.com>
cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: intel_ish-hid: Add check for ishtp_dma_tx_map
In-Reply-To: <DM6PR11MB26189BEF9321FE7E0D954821F4EB9@DM6PR11MB2618.namprd11.prod.outlook.com>
Message-ID: <nycvar.YFH.7.76.2301021350340.1734@cbobk.fhfr.pm>
References: <20221122134823.540-1-jiasheng@iscas.ac.cn> <c8e7fdb0e29b975537551ed6331f91b76e426246.camel@linux.intel.com> <DM6PR11MB26189BEF9321FE7E0D954821F4EB9@DM6PR11MB2618.namprd11.prod.outlook.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022, Xu, Even wrote:

> Yes, Srinivas, agree with you, the error handling should be added during allocation.
> Will submit the patch for it.

Thanks. Before that patch materializes though, I've queued Jiasheng's fix 
as a band-aid for 6.2.

Thanks,

-- 
Jiri Kosina
SUSE Labs

