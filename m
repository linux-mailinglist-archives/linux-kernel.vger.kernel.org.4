Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29468C456
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBFROk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBFROi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:14:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67C180
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675703639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSe69sBoGFb+EaphbnK9uhzhRzn3kUGhad0XCdDnNY0=;
        b=BaJ6iQaawl0An5KF+fvbM2DVu7GrPcf4R3+mHy4vKxKDLzbcugsEQvi6WdgbN3gecVF6kb
        ZMdmoWxtaGmxCFZ4FPGmZ5YamUYzgFadJXpKOWaiugnYzGOPfQJViFpelzNz/3gjtzajkW
        NXFQ0jr+fBU8IurvDOPoYS5nv774gd0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-aCZIekwANT26FerVm4BdFA-1; Mon, 06 Feb 2023 12:13:56 -0500
X-MC-Unique: aCZIekwANT26FerVm4BdFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E58B81871D9B;
        Mon,  6 Feb 2023 17:13:55 +0000 (UTC)
Received: from plouf.local (ovpn-192-160.brq.redhat.com [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3149B51FF;
        Mon,  6 Feb 2023 17:13:54 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     jikos@kernel.org, Luka Guzenko <l.guzenko@web.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230120223741.3007-1-l.guzenko@web.de>
References: <20230120223741.3007-1-l.guzenko@web.de>
Subject: Re: [PATCH] HID: Ignore battery for ELAN touchscreen 29DF on HP
Message-Id: <167570363471.2894697.5963789107129435683.b4-ty@redhat.com>
Date:   Mon, 06 Feb 2023 18:13:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 23:37:41 +0100, Luka Guzenko wrote:
> The touchscreen reports a battery status of 0% and jumps to 1% when a
> stylus is used. The device ID was added and the battery ignore quirk was
> enabled for it.
> 
> 

Applied to hid/hid.git (for-6.2/upstream-fixes), thanks!

[1/1] HID: Ignore battery for ELAN touchscreen 29DF on HP
      https://git.kernel.org/hid/hid/c/ebebf05a4b06

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

