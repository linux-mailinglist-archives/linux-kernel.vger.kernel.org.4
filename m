Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F203866AE17
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 22:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjANVMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 16:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjANVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 16:12:07 -0500
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 13:12:03 PST
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B6902F;
        Sat, 14 Jan 2023 13:12:03 -0800 (PST)
Received: from [10.0.0.182] (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 61B26161F55;
        Sat, 14 Jan 2023 22:05:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1673730318; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rboyLfwQPa9ZAGj0jHfmjbOk3PhUIRPAdvErpdqd56k=;
        b=Qx8gdOU8bsj8JZwT3V/YwzCKDFfbg1IeU9t7fK49OOoYpHZ+Alpm2t0SU2GoeQe8dYv2FR
        JrxetXvyBsGtSSwjDCJk6YYRasBKZoL/Qp8iiStFgPp1A2YAOPz4A5ZbhN6O5NZbnSiFVA
        2GWLFG3HePYvCo9A6FQRCM1zUwOhES0=
Message-ID: <0fa6e2b8-0585-87a3-f255-5301774a6d9d@ixit.cz>
Date:   Sat, 14 Jan 2023 22:05:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Content-Language: en-US
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Reply-To: 20230106135338.643951-2-clabbe@baylibre.com
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v5 1/2] usb: serial: add support for CH348
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: David Heidelberg <david@ixit.cz>

 > +    int i;
 > +
 > +    for (i = 1; i < CH348_MAXPORT; ++i) {

One nitpick; it would be nice to have a "for" loop from C99+.

-- 
David Heidelberg
Consultant Software Engineer

