Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF104666E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbjALJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjALJol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:44:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D23B1DDE6;
        Thu, 12 Jan 2023 01:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673516529; x=1705052529;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xbMAyidOCWMfF0EUAGtsCu/QnTnIwHL8t0BUKbedv0Q=;
  b=W3NrEFd1wDSzIryanZDRyfajarL4k2guJEhjkjkL/cNI6mg2TGPSk1AZ
   QbVbaD+zHQeA1NPeXkBftMPZk59IyaSYurIvxc7ef5tMsreQUDyR/BAiT
   u6ALSxH5veSTrE6mtN1WpmlJmeuE94ZREkbZHdbX9980I3iVLkIzJ5xT7
   Mq3CEwdD2vQF8wrrTVkEHaqGybU4vePkn90c9gpJi+sRoMi5sDbeiFHFr
   uLJW8WQ1SlO7AoUAXQUkR0Wy09LZ4e3wv+yYuYsFh6FqVaXPm1w5/Xq/o
   ouOsa8izoaQ58M99f2/bax2ebR+1MSDiozCrgt+Atk208WdgGqdHJBUQi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409898768"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="409898768"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:42:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659713883"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="659713883"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:42:07 -0800
Date:   Thu, 12 Jan 2023 11:42:05 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, Kees Cook <keescook@chromium.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] tty: vt: remove struct uni_screen
In-Reply-To: <20230112080136.4929-6-jirislaby@kernel.org>
Message-ID: <48c6dbb-7f42-33aa-c62f-e04a198a63@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-6-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-153673084-1673516528=:1665"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-153673084-1673516528=:1665
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> It contains only lines with pointers to characters (u32s). So use
> simple clear 'u32 **lines' all over the code.
> 
> This avoids zero-length arrays. It also makes the allocation less
> error-prone (size of the struct wasn't taken into account at all).
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-153673084-1673516528=:1665--
