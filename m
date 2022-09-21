Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091B25C0472
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIUQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiIUQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:41:25 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02409F747;
        Wed, 21 Sep 2022 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=R5DvtxfBWtIUBpI/zONUaAQWxDz5fu53gfEEzEochf0=; b=jQgovrUI7EqLaHdOi4ZWyudUeP
        LsW15jfO1aBCFrixVNhTFa7b/6OGuDldGvQ8CtkqqgJSWHf/wuozQO9WoeR+dBrd1vTJg5wDAC+3Q
        qV2/H49M6b3fFFk+ONqqi7MsjilRV2WYnXgK+TZ8JJ3//SO41G3rmIYUF02lJTzh50ykubol4bY2A
        GVFCNbLX+13L2iRmldXGiw0gZLbIcplKV3c1UsJUnMX0HZPbfComHZXIaVqkMxFzrR2bSDGeh06/U
        gp3+G9UO6RmRBqx1PCMGmHXb2MGx+kK4mRPbSKVnUGn0hBau1d7vm1U2EWcTuuzwNQYFXo+XtNYIH
        N/MtMY2g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ob2aV-007DSB-NO; Wed, 21 Sep 2022 10:28:41 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ob2aV-0007mX-29; Wed, 21 Sep 2022 10:28:39 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 21 Sep 2022 10:28:36 -0600
Message-Id: <20220921162837.29867-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 0/1] Updated MD_SB_CHANGE_PENDING fix
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

Here's the updated fix for the MD_SB_CHANGE_PENDING issue.

I've run my tests on this change on a branch along with Yu's
series for a few days now, and it seems solid.

Thanks,

Logan

--

Logan Gunthorpe (1):
  md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d

 drivers/md/raid5.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)


base-commit: 673164f606ec776de795c15396faa80288c523d0
--
2.30.2
