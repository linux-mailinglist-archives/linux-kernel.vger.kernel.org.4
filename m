Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C5666CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbjALIqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbjALIqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:46:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F050E6B;
        Thu, 12 Jan 2023 00:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673513104; x=1705049104;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VgAA3FSZWvnl7G+96uNqBVYwdBg6lxe1ssfYb0gS8+o=;
  b=RZYH3fkTpImWQxL8o83xrPkfCzaVEVcNktqYHBaIcnO2Mopmhc63cW4m
   iqr/Mjl/Ie3qTXA50k9fkLSi0V/yUub6oD745odjdg9iEZCyIAUjEYqr9
   PwFxSX+lNHC/Lb99QTVN3nkDIS2nZmqBQfPCSIaDSfWrsHSK04gBUxmaX
   QSdz5tth8lKsm1rJXlCJjCNZzzai+NXhIjVj/p/F/NPwoS/oqI4g6BoGE
   tUMSH4yCWRGijT9XCg/XugrUc8HN2Y3ERYwWgr+mYE4HRTUfQ2lM102hT
   QhRcu5U3/MdkZ/tsbnUgUTBYX3gA00J4x16Y9aR9IzNhruwjGHvh5XGfo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="304024920"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="304024920"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:45:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="690046823"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="690046823"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:44:40 -0800
Date:   Thu, 12 Jan 2023 10:44:37 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/11] tty: vt: remove reference to undefined
 NO_VC_UNI_SCREEN
In-Reply-To: <20230112080136.4929-3-jirislaby@kernel.org>
Message-ID: <2f40116d-d336-dd70-364e-70a8d7eef9a8@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-3-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-410501574-1673513081=:1665"
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

--8323329-410501574-1673513081=:1665
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> NO_VC_UNI_SCREEN is defined nowhere. Remove the last reference to it.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/vt/vt.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 7e5baf9f8ad8..561c82e120cf 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -495,9 +495,6 @@ int vc_uniscr_check(struct vc_data *vc)
>  	unsigned short *p;
>  	int x, y, mask;
>  
> -	if (__is_defined(NO_VC_UNI_SCREEN))
> -		return -EOPNOTSUPP;
> -
>  	WARN_CONSOLE_UNLOCKED();
>  
>  	if (!vc->vc_utf)
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-410501574-1673513081=:1665--
