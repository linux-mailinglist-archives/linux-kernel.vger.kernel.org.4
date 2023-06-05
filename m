Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACF7224B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjFELgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjFELgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:36:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC735DF;
        Mon,  5 Jun 2023 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685964977; x=1717500977;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i4T6wDft4HeohTQF8IPAJyWm7IEXte3wK8OmY48VPqw=;
  b=ncfomuVxKuqJcJEvCyMrZd8F6y8qoNw5fCwhTcmu5trp5GQ+OKA8ApPD
   i4AiAPspYKqE5Scl+CMSzrnxDIl0UX6jvwJP1qAkT4bU3HqzY6CCjj2wy
   vUvgZbaJtsQSxSWrmc/WJkzoqCWbgCeA6FGsBDBSDbSU1htOzkVxc1gwD
   kdhQBGW8nJ++nGIvgGGE3lJ1Xs6X9SeJr2LxUlDA1YVjc3b3/mXVS1wb6
   YnwFDquId1gHxA9H8+/5OERZzzRMSoP3CR/9Ef9AfpwDCTq0xj2MyejZ/
   pldHBjpFByXD4iwhyiIrVEiUd2f0N5K0wExAPBdy7kq58DRtDEtqZJbuv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="335963380"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="335963380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="821162765"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="821162765"
Received: from gfittedx-mobl.ger.corp.intel.com ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:36:16 -0700
Date:   Mon, 5 Jun 2023 14:36:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     SungHwan Jung <onenowy@gmail.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: hp-wmi: Add thermal profile for Victus
 16-d1xxx
In-Reply-To: <20230604173023.4675-1-onenowy@gmail.com>
Message-ID: <bb58b1be-4ced-2367-1412-7019f57c3d3b@linux.intel.com>
References: <20230604173023.4675-1-onenowy@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1225296555-1685964977=:2703"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1225296555-1685964977=:2703
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 5 Jun 2023, SungHwan Jung wrote:

> This patch includes Platform Profile support (performance, balanced, quiet)
> for Victus 16-d1xxx (8A25).
> 
> Signed-off-by: SungHwan Jung <onenowy@gmail.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1225296555-1685964977=:2703--
