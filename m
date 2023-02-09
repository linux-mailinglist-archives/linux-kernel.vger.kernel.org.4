Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01C8690BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjBIOfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjBIOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:35:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9665E1287D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675953268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tj+VEwHWs/D3ak3WmNY8517+aD6/AYNErgmjW5uQt0Y=;
        b=HERpo2qQc81nDka7MAlF5lo3PCedtEjrvVpvUu5g4FwD5MnN2a6w9DveQCFcX16mhDYhrG
        XEVnycjtGEM1+lRUBqhXHGSreA1o8+HxU49JKZj+G0oj7AHWZnRRNCtumWWoAQVvub/d0a
        uq/ztYfYkeDHtN51S+Pz0/RbGQGtgig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-1Hfth4TiNYmjQa8LrBcdEA-1; Thu, 09 Feb 2023 09:34:25 -0500
X-MC-Unique: 1Hfth4TiNYmjQa8LrBcdEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AB74801779;
        Thu,  9 Feb 2023 14:34:25 +0000 (UTC)
Received: from plouf.local (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AAC418EC5;
        Thu,  9 Feb 2023 14:34:24 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Walt Holman <waltholman09@gmail.com>
In-Reply-To: <20230207195051.16373-1-waltholman09@gmail.com>
References: <20230207195051.16373-1-waltholman09@gmail.com>
Subject: Re: [PATCH] Add support for Logitech G923 Xbox Edition steering
 wheel in hid-logitech-hidpp. We get the same level of features as the
 regular G920.
Message-Id: <167595326097.353878.13429962498257485005.b4-ty@redhat.com>
Date:   Thu, 09 Feb 2023 15:34:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2023 13:50:52 -0600, Walt Holman wrote:
> 


Applied to hid/hid.git (for-6.3/logitech), thanks!

[1/1] Add support for Logitech G923 Xbox Edition steering wheel in hid-logitech-hidpp. We get the same level of features as the regular G920.
      https://git.kernel.org/hid/hid/c/f1fc9fbc8394

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

