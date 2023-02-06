Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5789C68BE3E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBFNb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjBFNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:31:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0375166E6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675690268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HarKdxk7DvaGEsAWYYTgcrj4rWOc2IzWJT3yxXhosx8=;
        b=OIkiPFRl8EaiwAPwtSs12s7iB6HKxJUdA4k5A9sLouMlGqO4bkmarjtNZeIbl83mfgsCSq
        w2Nlmysf0jVaRz9Wl7TSZUzxFac3WGcg1oA2sXnXOYegIjIO2ItyZt7XH/ylYC0KwQqlId
        NhiQMhj7eN9OUN7WFkmK47v5gggdGek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-Z9Gh4cnQNcmeymjtrOAD0A-1; Mon, 06 Feb 2023 08:31:05 -0500
X-MC-Unique: Z9Gh4cnQNcmeymjtrOAD0A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 493BA800050;
        Mon,  6 Feb 2023 13:31:05 +0000 (UTC)
Received: from plouf.local (ovpn-192-160.brq.redhat.com [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CC7F492B21;
        Mon,  6 Feb 2023 13:31:03 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Xaver Hugl <xaver.hugl@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230203220850.13924-1-mario.limonciello@amd.com>
References: <20230203220850.13924-1-mario.limonciello@amd.com>
Subject: Re: [PATCH v2] HID: amd_sfh: if no sensors are enabled, clean up
Message-Id: <167569026389.2830974.15427186949245425470.b4-ty@redhat.com>
Date:   Mon, 06 Feb 2023 14:31:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2023 16:08:49 -0600, Mario Limonciello wrote:
> It was reported that commit b300667b33b2 ("HID: amd_sfh: Disable the
> interrupt for all command") had caused increased resume time on HP Envy
> x360.
> 
> Before this commit 3 sensors were reported, but they were not actually
> functional.  After this commit the sensors are no longer reported, but
> also the resume time increased.
> 
> [...]

Applied to hid/hid.git (for-6.2/upstream-fixes), thanks!

[1/1] HID: amd_sfh: if no sensors are enabled, clean up
      https://git.kernel.org/hid/hid/c/7bcfdab3f0c6

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

