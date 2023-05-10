Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF76D6FE4D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjEJUMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbjEJUMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:12:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF3AE57;
        Wed, 10 May 2023 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=yt/SgfNHFPPKEqm/TapniQmvPSvHMYvIL3rCl5jRo8o=; t=1683749530; x=1684959130; 
        b=QyhS8AmudU31KYoDjcf8Cx+FwyDo54EYwwzu3/8I+Wq2ZN/DVsQ+S0/A6wSWNU+QqkYeLda2skO
        NNXeyjwzhH6Soh3gr8jmbfPmd3i7dkJR+qg/zoIA4oHkplUv8Ru5s719HShCBPpJo0EmRtVN489v4
        Ia1bvvi6cVbWGS+qgBAcALUIQm0f+Nholj9MWl9Mu7uWr+Odo8MQX6xN8oZ2jB6Xh47SSrgssDITL
        /Rj+OEcBjCqt5DPlCF64lp4adWBZkLnwqh++11HsJxwJ3wK0b+drqWt99bogf01dzMc+S+ju2yDtM
        4abvGNzQ/LOKa6IYWLTyyY4cFhr9/Fv4ASZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwqAS-005aH5-1n;
        Wed, 10 May 2023 22:12:08 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH v2 0/3] wifi locking simplification
Date:   Wed, 10 May 2023 22:12:02 +0200
Message-Id: <20230510201205.308542-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rationale etc. didn't change in v2, so see
https://lore.kernel.org/r/20230510160428.175409-1-johannes@sipsolutions.net

In v2 I dropped the workqueue locking patch and consequently
made new wiphy_work and wiphy_delayed_work things.

I kept the pause/resume for the workqueue because not that I
had it, it seemed simpler than keeping track of "should it be
paused" in a separate bool variable to not queue the work when
it shouldn't be ...

Still just serves to illustrate things, I didn't really test it.

johannes


