Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7E666CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjALIoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjALIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:43:59 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D81B3;
        Thu, 12 Jan 2023 00:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673513027; x=1705049027;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=moJdiCvkzK+PGHKwA8ucF5vW4Kl5qrfBNHhDw5qp86k=;
  b=mLQvqmk+8AHFkn7qhxbNNWKlVK7uu5+BQtFue85GQFhlS+0CvF4NsyQp
   i9E2/8Y/EeSvJSd7o7PVww+rGOT8emUZ62w8mRGq0JIJHHPWYBANKOTLH
   kUUcPygjeAK42Qywg6wls1F4NP3eY+8BfzZtkJFrRigLcXWrqoW55VSQK
   46+05Bvkx2MmrBZu+VX7FtwuauJM1V+oR5O1Fu0RChmPO/d1EXuqmNN4L
   56wl0FfzfegnJfXzIHRF41nlgcmxv1bSlptTJ7uvfnhZejiNlNq5u3vgq
   vgtM4srvqIi/kskBbRQJ5bGrimY5vTWgKF+Zb3Q2o1MJi1AZ5COiCBZvU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303346844"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="303346844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:43:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="765525297"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="765525297"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:43:44 -0800
Date:   Thu, 12 Jan 2023 10:43:42 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/11] tty: vt: remove vc_uniscr_debug_check()
In-Reply-To: <20230112080136.4929-1-jirislaby@kernel.org>
Message-ID: <7f5d6357-a4a3-f5ee-9a7b-2eb3329da1@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-42314877-1673513009=:1665"
Content-ID: <2f8d7abd-f775-d276-d235-cd76d8c26572@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-42314877-1673513009=:1665
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <3d932570-9c0-710-7189-7d51d1a5a20@linux.intel.com>

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> VC_UNI_SCREEN_DEBUG is always defined as 0, so this code is never
> executed. Drop it along with VC_UNI_SCREEN_DEBUG.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-42314877-1673513009=:1665--
