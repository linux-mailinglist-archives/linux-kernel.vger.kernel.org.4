Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5360C9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiJYK0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiJYKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:25:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBC733E05;
        Tue, 25 Oct 2022 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666693455; x=1698229455;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Wg6aEGHEdId7S6JpiQW4fRhbxjFPUgrJCGjNAjCIf5Q=;
  b=Wm1WAn020M62bhrFyduBWHFrH1IZ8Ei9M/wKYOBppFWaBPz9pP079PBJ
   ACD8Sl7uVxhu1lCSgz1gWZl8niP0Rx5Mq+DFQpe2uyw+FOKKbPgwXXq04
   3HSp8s9JD2KQTIcJZUMZL1YMjCf2DlMlilYqOxX1yEMm7EVi2dYPMMUb1
   3uoIweVgwS06I+UKb+oURVWnycqs9vCZA/huDy6eGKez0qRgat8Tzklrt
   vxdM+MbECeLxHoDaq4WjVGlGyX1T5w0Hg1KdSMs53atrX6v9T8ZQF4CzQ
   5lXmvHXyd/jpRgN22FavU3+wzhctuT/S0XvkDQU/fYV0Ib+U40rNKZVG7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287359574"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="287359574"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 03:24:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="631584636"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="631584636"
Received: from pweidel-mobl.ger.corp.intel.com ([10.252.44.62])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 03:24:13 -0700
Date:   Tue, 25 Oct 2022 13:24:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tty: n_gsm: add parameters used with parameter
 negotiation
In-Reply-To: <20221024130114.2070-2-daniel.starke@siemens.com>
Message-ID: <4dded9d2-a67b-94b4-752f-3bbdf9e1c3@linux.intel.com>
References: <20221024130114.2070-1-daniel.starke@siemens.com> <20221024130114.2070-2-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-410768071-1666693456=:1638"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-410768071-1666693456=:1638
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 24 Oct 2022, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapter 5.4.6.3.1 describes the encoding of the
> parameter negotiation messages.
> 
> Add the parameters used there to 'gsm_mux' and 'gsm_dlci' and initialize both
> according to the value ranges and recommended defaults defined in chapter 5.7.
> 
> Replace the use of the DLC default values from the 'gsm_mux' fields with the DLC
> specific values from the 'gsm_dlci' fields where applicable.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-410768071-1666693456=:1638--
