Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1759068C146
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjBFPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBFPZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB51029437
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675697095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMrMpaum3xXRw9wyBb9U8p+U4sgfQOo8YUTEpsLlkjI=;
        b=P3RA2w0h72uSuunQEdN9ZRCQsAPajlkUQDfracdpUVIWK7ywNNawC0nKffy0YqZq9gx2Hy
        +b1dsoSNn4EdU2i9uNTwaK4euoS2fAiTAuZdKLjApcFrCKPWazYaBIKu1GdmlmV2DolemH
        RI+gjjLoberE1ClKinSyYNE/j2sm5nI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-RXV3642WPYSgV_ih1SNTWQ-1; Mon, 06 Feb 2023 10:24:52 -0500
X-MC-Unique: RXV3642WPYSgV_ih1SNTWQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A33CB885623;
        Mon,  6 Feb 2023 15:24:50 +0000 (UTC)
Received: from plouf.local (ovpn-192-160.brq.redhat.com [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5BD1C15BA0;
        Mon,  6 Feb 2023 15:24:49 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221223-hid-dbg-v1-1-5dcf8794f7f9@weissschuh.net>
References: <20221223-hid-dbg-v1-1-5dcf8794f7f9@weissschuh.net>
Subject: Re: [PATCH] HID: use standard debug APIs
Message-Id: <167569708971.2863874.17142913182117804501.b4-ty@redhat.com>
Date:   Mon, 06 Feb 2023 16:24:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 21:30:19 +0000, Thomas Weißschuh wrote:
> The custom "debug" module parameter is fairly inflexible.
> It can only manage debugging for all calls dbg_hid() at the same time.
> 
> Furthermore it creates a mismatch between calls to hid_dbg() which can
> be managed by CONFIG_DYNAMIC_DEBUG and dbg_hid() which is managed by the
> module parameter.
> 
> [...]

Applied to hid/hid.git (for-6.3/hid-core), thanks!

[1/1] HID: use standard debug APIs
      https://git.kernel.org/hid/hid/c/3f16ba1c0768

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

