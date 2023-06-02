Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D3720477
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjFBO3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbjFBO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:28:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C840C9F;
        Fri,  2 Jun 2023 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685716137; x=1717252137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WVy5p5cRfegsMt/t1UOeCpDu3zopXuqagKjNaR5+xbk=;
  b=lEQrpctH1uOSkqLt4P22sZaXuuA7SEmzdaDa/42qrLAMpwH98qOQ8Kr2
   UjDVVz1Iq/5GEhmL1PnTumG0SwN5UvnXWWmLbZ1lyKW4Es5wUx0KRWocW
   2lGm9AFhK6DA6kcMBMKHm00zo5ntw7ZuBHipVXa5nez54MEapmCFkfOLN
   zrkmb4HUJ8ZGdOvHb9UCDnW/4UeZ+xa3OmrH5dT0KsTGwlY/xJwRIiDrS
   EmWQ61seQVE35pYcM0jeGOj2G1MGY2SyWEEtxFLR9vgaTTVou2midCji3
   FDpgaPhOnkWUAHKQjglskhtXYMBcA/1tYbFthcIMU2n6T+jEd8JTfHBfQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="419412131"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="419412131"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="797613693"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="797613693"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:28:55 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id B2629120B16;
        Fri,  2 Jun 2023 17:28:52 +0300 (EEST)
Date:   Fri, 2 Jun 2023 14:28:52 +0000
From:   Sakari Ailus <sakari.ailus@intel.com>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        Evgeni Raikhel <evgeni.raikhel@intel.com>, demisrael@gmail.com,
        Nir Azkiel <nir.azkiel@intel.com>
Subject: Re: [PATCH v4] media: uapi: v4l: Intel metadata format update
Message-ID: <ZHn8pC8FqFpmh6v9@kekkonen.localdomain>
References: <7e0e6a37eee28185ec2fbd4f1d42569c8da6726d.camel@intel.com>
 <944dd3c67fc7e9c1b8d6bd0491d61fdbb9489e70.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944dd3c67fc7e9c1b8d6bd0491d61fdbb9489e70.camel@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, Jun 01, 2023 at 07:08:46PM +0300, Dmitry Perchanov wrote:
> Update metadata structure for Intel RealSense UVC/MIPI cameras.
> Compliant to Intel Configuration version 3.
> 
> Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Same for "[PATCH v3] media: uvcvideo: Enable Intel RealSense metadata for        
devices".

-- 
Kind regards,

Sakari Ailus
