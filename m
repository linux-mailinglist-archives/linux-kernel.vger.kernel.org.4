Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938975BDEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiITHyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiITHxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:53:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929A362A88;
        Tue, 20 Sep 2022 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663660403; x=1695196403;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c5wGNva+z/eAqy7geS34VD+AgDQPYhwt6/OYktNs7uE=;
  b=gw0YMmrWnKL7TNUQYDDBPgWTUO9X0ygzDadIwaXNvVVsYmcSmRzfyATx
   8qbCU6UhXXW8XHOGA4KkckweP6YnAD7NYYeUoBJioJEmObHim81ifNz02
   WQaB7EsSPc9s4eesWN5Fz8mHM2FR0ZAdYzs+LID790/IkglH3+CpXjqTr
   6a8csEX6L04WuQzM010GIUKU6+aCuSSDO6glAeazTuE0zSfhQfoKIKD25
   c5z0TIK5SpqZ84mQr+KZYxBqNE0OV5C+QL/4zfyjju5B1B7QR3UeT2G4C
   9IjKKr2SfjkNcRz6US9RjTBTbg26W7AnOAm9V6n5XCYX89lsVSOVwp1Jm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="297218725"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="297218725"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 00:53:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="744426001"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 00:53:21 -0700
Date:   Tue, 20 Sep 2022 10:53:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 01/10] tty: serial: move and cleanup
 vt8500_tx_empty()
In-Reply-To: <20220920052049.20507-2-jslaby@suse.cz>
Message-ID: <a8172eb6-db1c-10e5-fd2-c1e051556c22@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920052049.20507-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-934469983-1663660402=:1766"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-934469983-1663660402=:1766
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> Make vt8500_tx_empty() more readable by introducing a new local variable
> and move the function before handle_tx(). That way we can reuse it in
> there too.
> 
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-934469983-1663660402=:1766--
