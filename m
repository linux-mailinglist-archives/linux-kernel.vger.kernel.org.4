Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF1638ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKYNFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKYNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:05:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF222A721;
        Fri, 25 Nov 2022 05:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669381519; x=1700917519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6g0bJ/FBSCVfAfA0k+zJtZGzCj3vKWV3MnuMYshHXSs=;
  b=TGFCFfSQzbS1eYtwC7gfngWdI4qCfcShKnd4zspiNjC2iaBiK/EsUU8+
   ZsX0GuR8xcpqgWOhAxxZnIUhrYUnmAQHO8WtDxcakR48lh+nanMt397RA
   WLXt7ElD2FA482IGbvuQQHIMWOuiyov+k2rZLUexhB7Th9pw+FqB9mfmh
   HPo5ac3TltsZ8wOzXnJR4bUUVb6Fubgjl50LchUPjCKvj5kHbWhtVtw/C
   hcHfZND/zoj+bpwYvaNz5KLxySw9Or+pXikhY/PgHsMk4bRM2+0hyh48A
   E/iqkvT6uiEM+3VR0Ws+bj7bBnfJ9Rb2tqzcBAnwFRvL2TJKtU/45sO93
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="316300758"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="316300758"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="706064016"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="706064016"
Received: from dpotapen-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.50.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:17 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/6] serial: Cleanup literals
Date:   Fri, 25 Nov 2022 15:05:03 +0200
Message-Id: <20221125130509.8482-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert plenty of register write literals to use the proper defines. In
most of the cases the defines already exist but a few new defines are
added too for combined sets of flags.

v2:
- Fix EAABLED typo.

Ilpo Järvinen (6):
  serial: 8250: Use defined IER bits
  serial: 8250: Name MSR literals
  serial: 8250: Cleanup MCR literals
  serial: 8250: Add IIR FIFOs enabled field properly
  serial: 8250: Define IIR 64 byte bit & cleanup related code
  serial: 8250_early: Convert literals to use defines

 drivers/tty/serial/8250/8250_early.c |  4 +--
 drivers/tty/serial/8250/8250_port.c  | 47 ++++++++++++++--------------
 include/linux/serial.h               | 10 ++++++
 include/uapi/linux/serial_reg.h      |  5 +++
 4 files changed, 41 insertions(+), 25 deletions(-)

-- 
2.30.2

