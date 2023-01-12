Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6022D666E72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbjALJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbjALJkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:40:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE4A13DC1;
        Thu, 12 Jan 2023 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673516195; x=1705052195;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7ZNS4mER3bzhCFOFqqOMkYzJWFuPBgbS3pJOvPtksOE=;
  b=Rb19AFKBXauI6eUjwM6QE3pizgT6d4wtsRuUwRMfQ3jR8H/162BF82bK
   HhvtOUANDx0XFt/C1GewWIMMyRH1c5TdHxKQttfqIVpX28BDAYuBjR3NU
   0Z1iOORS3R4W0uuQVtOfV9u0GYDqqXbD4ZTA7QXeu/Cz8yuOcJKs72NA0
   NUmOcR/zQvMjVRoLAEKBWm62sbS/G4UTqZP01rf+V37rwP5MrmOiVWUJU
   E12dnG1ehlJaxPOY9xeTrVRdiCOQZ5JavDXaJUr2JKC/ccHeZ1jmkbnaK
   RfKTBGiRNj+KHkjpY/y1SVw4vt5L8W5QIQyVRcmI1CQR1fSTeef20k5Gq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324891972"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="324891972"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:34:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="721047065"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="721047065"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:34:22 -0800
Date:   Thu, 12 Jan 2023 11:34:20 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/11] tty: vt: remove char32_t typedef
In-Reply-To: <20230112080136.4929-5-jirislaby@kernel.org>
Message-ID: <fb363e72-b85-c20-4b95-e4fce2dad46@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-5-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> It boils down to uint32_t, so use u32 directly, instead. This makes the
> code more obvious.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/vt/vt.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 3ae0212f1aa7..86c18522231b 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c

> @@ -550,7 +548,7 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
>  		 */
>  		row = (pos - vc->vc_origin) / vc->vc_size_row;
>  		col = ((pos - vc->vc_origin) % vc->vc_size_row) / 2;
> -		memcpy(dest, &uniscr->lines[row][col], nr * sizeof(char32_t));
> +		memcpy(dest, &uniscr->lines[row][col], nr * sizeof(u32));

Btw, could this be ... * sizeof(**uniscr->lines) instead? It would seem 
slightly safer here.

-- 
 i.

