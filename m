Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1805FCA10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJLRu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJLRuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:50:24 -0400
X-Greylist: delayed 1806 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 10:50:21 PDT
Received: from zuombrgn.myspeace.com (zuombrgn.myspeace.com [45.95.169.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80797FE77
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=myspeace.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=jan.cha@myspeace.com;
 bh=3r/0Fl2zSrk3z+Ch1RiHE+zuRGI=;
 b=WClxaor43amv1E/+FbI1KpTQMUu7DxgTnizVsIWCUS4iSm9JUBM9mRVpAwfNr5+5EXFDNkp0NCHx
   0DO+JkaC5SG0/Nv14ePuQFRXuO3Ks6ADYo0z4gZIuALvElOMMkW6V6AeshutsNZt8YJGCtQMImhc
   WQ7o50vfvDaEmlQ44/ejolzjTde4aE0H1wHswxCfhNzBlf8nLximNVVKnOGfvGegyCWjwyZab9Up
   kxhTfmqaWN6ytCAQZP4GQKbT6sLN2sBwlqFff59hAYElAAQk62wqLoQGi5OlrMQu03CGhgHmg5Ml
   oVirWBnvJMHTNqk90l1Xuv5Cz1nyhhwLJupuog==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=myspeace.com;
 b=UM0kxzxZkTdY6s0RBXcJj9hISC8J15lD4v6N3kMzrIXp9oSZlMWYpGCNbH8G9v0RdDgwhfZX6F5D
   zQ6QRhkyA37wTQz44/Be8G6v7ZxV0M1QYMjFxcPpeFsuvzlCagPALVgQGj/PFrVTNGrwVEJKFWje
   /LT3KuUthgFUFzhclqSCpw62f+JuW52Y0eDMKjgar6T2gg31JPkXiWlqtYPCDYGBV332/VimqF0s
   NcITCPG7CQMFnQqMFqSWk6CikPdQMNOvXsmmp7Qg0aBN0tZN4yWwkkHXdsqIrt4j/cVdcip3tTFf
   NYYJ8WhMn+ZNsPofET1qWrjZU2+h+OTLgfo9Ig==;
Reply-To: m.ayvaz@mayvazburosu.com
From:   Mustafa Ayvaz <jan.cha@myspeace.com>
To:     linux-kernel@vger.kernel.org
Subject: linux-kernel
Date:   12 Oct 2022 19:20:09 +0200
Message-ID: <20221012192009.8A913B86C328ECFE@myspeace.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOCALPART_IN_SUBJECT,
        RCVD_IN_BL_SPAMCOP_NET,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.7 URIBL_BLACK Contains an URL listed in the URIBL blacklist
        *      [URIs: myspeace.com]
        *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?45.95.169.87>]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6876]
        *  1.1 LOCALPART_IN_SUBJECT Local part of To: address appears in
        *      Subject
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

I was only wondering if you got my previous message? I have been=20
trying to reach you on your email: linux-kernel@vger.kernel.org ,=20
I want to share a business opportunity with you. kindly get back=20
to me swiftly,  it is very important.

Thanks
Mustafa Ayvaz
