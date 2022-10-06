Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BB45F6BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiJFQi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFQiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64240B489F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665074300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VEpKybDwIIb0k1AUZxnrl1NRW+TcgE4ZiwpoFiD+2/o=;
        b=feRiN9ADIz6phUShvjIx7+UD1d5jfs/CKY+1mlYJUQ2VaEGEC8I4C6ffN6PZqS0ONjE4fe
        it1M2LypVay3NM6fvA3ANcErrGsrUwCACqsixpe4iuR6SUpR5pROO6j+oXJ+HQ8e4DEPBt
        RfVUOINlP1EvYaiaNnlHUQrxCitq3vA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-68-UHojKd6pOz6snj6iiMtWtg-1; Thu, 06 Oct 2022 12:38:12 -0400
X-MC-Unique: UHojKd6pOz6snj6iiMtWtg-1
Received: by mail-wm1-f70.google.com with SMTP id v125-20020a1cac83000000b003bd44dc5242so2845138wme.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 09:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEpKybDwIIb0k1AUZxnrl1NRW+TcgE4ZiwpoFiD+2/o=;
        b=8RwiVUWFb6Z/KV15d3Y0DMaQ4QyZSXSmKiYvz3WuGfSjpUf+QFCGIpqreVlsd7ISJ9
         EmyvUJFn4G354GHCVRaulaVm6wacgVpMfkbbi9P04i1wZGke8YEXm7dcOHVdw7x0Yblw
         O/DeuFSlXigtKF6PGW8kldcf4ShIEnS/cdtgbMK0STlZixIKdxJirEZ3oh0OTIDmQMKc
         qJbwlYvDHQPimZbQRGswWHlLvrp8d2rf/jF/6guNINx2C7ctRPW6ymMMtq6meNIn+sYc
         oWyNSHzwO1uyFzsZNPICbyy0YKTFZxHaTzT8KwjiVGKvoU9VWGtGteBv3SxV/QRRUbep
         f7xQ==
X-Gm-Message-State: ACrzQf3KyDqYsOIcuIP4LPc6S3I924ovFrYdNvwWJC2L42CcoiHLmOKG
        KhaxXIart2vuVYP2ALS+cFNZFQP3yVKlMZPbVmhpu/O6He/uCZ9CiKcnUbVRsnWIFwf7LapmjIq
        ON1ptp93TS1/0I4nRJWw2VX0=
X-Received: by 2002:adf:db03:0:b0:22e:47a0:c455 with SMTP id s3-20020adfdb03000000b0022e47a0c455mr623730wri.54.1665074290937;
        Thu, 06 Oct 2022 09:38:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sJaSmZC7Zqmac4HCz2ut86SBFfniEHgzmCX6xcd+GIkW+bX3ysIGJ1QugXtqltQcFmMbNMw==
X-Received: by 2002:adf:db03:0:b0:22e:47a0:c455 with SMTP id s3-20020adfdb03000000b0022e47a0c455mr623716wri.54.1665074290758;
        Thu, 06 Oct 2022 09:38:10 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d452d000000b00228a6ce17b4sm17974302wra.37.2022.10.06.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 09:38:10 -0700 (PDT)
Date:   Thu, 6 Oct 2022 17:38:09 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: "Unloaded tainted modules:" prints repeated wrong value
Message-ID: <20221006163809.6gzl23ylu36gerli@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <YzwraXZ3J0p7lch2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzwraXZ3J0p7lch2@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-10-04 15:47 +0300, Alexey Dobriyan wrote:
> I got obiously incorrect values of "pcc_cpufreq():1" on a clean kernel
> and clean oops (see below). Original oops is different bug.

Hi Alexey,

[Added Luis Chamberlain and linux-modules@vger.kernel.org on Cc]

Sorry about that!

Indeed, in the context of the module deletion code path, no module
record/or entry should be added to 'unloaded_tainted_modules' if
the module does not carry a taint. I will send a patch shortly.
The following solution should be sufficient:

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 7f8133044d09..af52cabfe632 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -21,6 +21,9 @@ int try_add_tainted_module(struct module *mod)
 
 	module_assert_mutex_or_preempt();
 
+	if (!mod->taints)
+		goto out;
+
 	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
 				lockdep_is_held(&module_mutex)) {
 		if (!strcmp(mod_taint->name, mod->name) &&



Kind regards,

-- 
Aaron Tomlin

