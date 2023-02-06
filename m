Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D8868BF38
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBFODX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:03:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90BF28D3A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675692112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WkZbQDy++TbR+nJjGfW1Qx+BDYAbmOjoD8BAG4wJE1E=;
        b=bOc9ioZJqwV5EHAkwQfnGOIzd8tSALRiIguQuswDlkT2SdUx1+aT1FsEv497ldFy+im2bG
        2LNIxzIlFhNHkVqyi61plU2koqaiRy4UXQLmyG6hgnnzBycmPTpjDyF6Ydw0dH0a6jPfho
        rLFxkhQpx7unUfnAjraCMZnRmeXqK/c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-SVQkEjvgOEGJJsWVuEzg7A-1; Mon, 06 Feb 2023 09:01:49 -0500
X-MC-Unique: SVQkEjvgOEGJJsWVuEzg7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D06D1281724D;
        Mon,  6 Feb 2023 14:01:41 +0000 (UTC)
Received: from plouf.local (ovpn-192-160.brq.redhat.com [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92BAB2166B29;
        Mon,  6 Feb 2023 14:01:40 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
In-Reply-To: <20230127064005.1558-11-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-11-rdunlap@infradead.org>
Subject: Re: (subset) [PATCH 10/35] Documentation: hid: correct spelling
Message-Id: <167569210023.2843115.12634410926456959304.b4-ty@redhat.com>
Date:   Mon, 06 Feb 2023 15:01:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 22:39:40 -0800, Randy Dunlap wrote:
> Correct spelling problems for Documentation/hid/ as reported
> by codespell.
> 
> 

Applied to hid/hid.git (for-6.3/hid-bpf), thanks!

[10/35] Documentation: hid: correct spelling
        https://git.kernel.org/hid/hid/c/2f7f4efb9411

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

