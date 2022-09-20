Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20035BE066
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiITIjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiITIiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:38:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476F6B651;
        Tue, 20 Sep 2022 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663663031; x=1695199031;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9ncUnQaz6hGQ12Cfhs2Iqdzf8lbhCz+Jwy0A7Sr0wfs=;
  b=V7sPmyA9vdqPZ5jdF4eksRDyzI3FNuDglXgnPbvW4pacY5TLJUkUe0X9
   TL/bkqhDxMHU5zxKnsbubbgmxKRp64bxvgbAZFxe9FJvG5CKfchKa4zzM
   fNuVsBfeVDAbzUOaXSYXHqnsH7tFkNTyqe/zPH9tqh99Am8UJR0nAxUEE
   /02XLot2TfbJGwWVTxW/GL4RPvxI4+rREcDUcrlR1vtVNOP2+VTIip03D
   HYIAWBJxHCoH7lcxYuX/Qjzt7ivBs4T5w4PDcp5lve6g8ylg8WTPGGqLZ
   k7M5U5eV+q73qfWvKW0jJcNvjpWHQDcWjyf+7eC5tYqesu/oOX8VOV7Gf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="300455097"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="300455097"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:37:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="569995860"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:37:09 -0700
Date:   Tue, 20 Sep 2022 11:37:06 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/10] tty: serial: switch mpc52xx_uart_int_{r,t}x_chars()
 to bool
In-Reply-To: <20220920052049.20507-7-jslaby@suse.cz>
Message-ID: <5918019-2abc-acd4-7171-54ad2a81854@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920052049.20507-7-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2142333720-1663663030=:1766"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2142333720-1663663030=:1766
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> mpc52xx_uart_int_rx_chars() returns unsigned int.
> mpc52xx_uart_int_tx_chars() returns int.
> 
> The both results are binary ORed to the "keepgoing" variable. Unify all
> three to bool as the only interesting value is whether we should keep
> looping (true/false).
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2142333720-1663663030=:1766--
