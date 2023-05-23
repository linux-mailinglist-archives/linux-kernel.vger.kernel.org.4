Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD22270DD1D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbjEWM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjEWM6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:58:52 -0400
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C63DB
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=785; q=dns/txt; s=iport;
  t=1684846730; x=1686056330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yDlorFubPKPoVaNjdLRKgTvyCxkWTTZeKyLOc7P5DZo=;
  b=Jvt7sNj7v+pGKUKRsfNA4abP6nKzjPdzw2OlQ2f6Zw6/6SKyR810DJ+t
   JUWGODn2XajXbcI7JFuLwUmEgtrlCvirQ2dD/QB7LbA7E4Y5e3wpzug/A
   PT3ciYexEjefq+OYTjizuXi2qRECMoT4TLZGh7kAF/y75yHBGVXlQd/N5
   c=;
X-IronPort-AV: E=Sophos;i="6.00,186,1681171200"; 
   d="scan'208";a="61935907"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 23 May 2023 12:58:49 +0000
Received: from sjc-ads-7449.cisco.com (sjc-ads-7449.cisco.com [10.30.220.234])
        by rcdn-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id 34NCwnLE019193
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 23 May 2023 12:58:49 GMT
Received: by sjc-ads-7449.cisco.com (Postfix, from userid 1777032)
        id 02F59CCD0B1; Tue, 23 May 2023 05:58:48 -0700 (PDT)
From:   Marcin Wierzbicki <mawierzb@cisco.com>
To:     rogerq@kernel.org
Cc:     mawierzb@cisco.com, bwawrzyn@cisco.com, danielwa@cisco.com,
        kishon@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, olicht@cisco.com,
        sjakhade@cadence.com, u.kleine-koenig@pengutronix.de,
        vkoul@kernel.org, xe-linux-external@cisco.com
Subject: Re: [PATCH v3] phy: cadence: Sierra: Add single link SGMII register configuration
Date:   Tue, 23 May 2023 12:58:46 +0000
Message-Id: <20230523125846.2486926-1-mawierzb@cisco.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20230522172415.1668975-1-mawierzb@cisco.com>
References: <20230522172415.1668975-1-mawierzb@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.220.234, sjc-ads-7449.cisco.com
X-Outbound-Node: rcdn-core-10.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>On 22/05/2023 20:24, Marcin Wierzbicki wrote:
>> Add single link SGMII register configuration for no SSC for
>> cdns,sierra-phy-t0 compatibility string.
>> The configuration is based on Sierra Programmer's Guide and validated
>> in Cisco CrayAR SoC.
>>
>> Co-developed-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
>> Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
>> Signed-off-by: Marcin Wierzbicki <mawierzb@cisco.com>
>> ---
>> v3> - all reported comments were addressed
>
>:)
>You should summarize what changes were done.

Here's a list of changes:

v3:
- removed Change-Id from commit msg,
- remove unnecessary new line,
- renamed sgmii_cmn_vals to sgmii_pma_cmn_vals,
- renamed sgmii_ln_vals to sgmii_pma_ln_vals.

Best regards,
Marcin
