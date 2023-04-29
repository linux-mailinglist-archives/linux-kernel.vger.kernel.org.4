Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB626F2513
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjD2OcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjD2OcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 10:32:12 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000BD171C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 07:32:09 -0700 (PDT)
Received: (Authenticated sender: support@spotco.us)
        by mail.gandi.net (Postfix) with ESMTPSA id 0FB3BC0007;
        Sat, 29 Apr 2023 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spotco.us; s=gm1;
        t=1682778728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=1xbFI4Se7nLAB8/+nItG8XskUHBTH9Ux+dXv4rsaHhk=;
        b=DCmfZXC8ocolN7E2w2r7FCkYGWPJGiL0dS0LxN9dCcUZ0cFHQnV9Q0TdKHxlP4j3EPYNpQ
        iCqT0jSiIx1jG254laT/1G0/2c3MdmMsbkLqzekuo+wSvNaS6EcXjNQMD7WlgtOVgQBt4F
        XzfkBHYAEFLjzCKPuHf+ecLUj8fWhJ0MBMcPbA4lNfCfB6u3QXMPqyKsQcYsTds1Okgm49
        wbd1TyEJ4a5WDwf+J3Y2j9paAflkx+18SqwqKUNXdIEm+6AGY8kFEInSaAPJ2EZtdjxMXx
        8S7sVeFCEwlZlO8fz336yxAS0QrZT90L3edLUXUv4UPac0pRY8Fu2uDWcEDWzw==
Message-ID: <e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us>
Subject: Re: [PATCH v2] mm/mmap: Regression fix for unmapped_area{_topdown}
From:   Tad <support@spotco.us>
To:     liam.howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rick.p.edgecombe@intel.com
Date:   Sat, 29 Apr 2023 10:32:02 -0400
In-Reply-To: <20230414185919.4175572-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reintroduces the issue described in
https://lore.kernel.org/linux-mm/cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@sony.=
com/

Linux 6.2.13 can no longer successfully run the mmap-test reproducer linked
there.

Linux 6.2.12 passes.

Regards,
Tad.
