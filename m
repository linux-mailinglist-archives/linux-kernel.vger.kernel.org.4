Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789E86F8993
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjEETju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjEETjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:39:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF4A44BB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:39:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559ffd15df9so32704387b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683315578; x=1685907578;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vP5gc0jP5Nq0PvlH/6e4YxmE8pZhkvAmwd41SLEAWGk=;
        b=NLIhXnABItNxLVUp1LT7XOZ/0y8JLbVnhMOKPCqdZHtspOfxmuvGCtrzKwaS3s/DLw
         wUv36a2F9ZBXOaKv2zAEofk3eBuWrpCBjKEH33lJ39E6XcgTSc+Q5jTZkJGRwtnjXMrY
         yvwxYYZKHv44NqtEplbdWsF+p6bakIopKoHQ9aWh/oCMacZrAbA+JP6n++CIAohvaPAR
         8IhKUXFUY3Crn6hJp3zzo9AYJjX8H8ZdZ0TygWA8q0PHJnz5OuibxIzXIFGAdM+F3LY3
         kLg0tuwU8zJuJ/N58oFTCgjnWknIisTVRd+70H5mTs5tUza5KZrhYOz74gqALv/T8lzs
         htYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683315578; x=1685907578;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vP5gc0jP5Nq0PvlH/6e4YxmE8pZhkvAmwd41SLEAWGk=;
        b=jdBJr8vX1gagl0v21n/gBk3owh9PMZDxvTzPFfiJq9ILs+bAR2bfpby7+nIvE8Nq7o
         1nOqXB5h2X67QAIkZ3q/XlH8uxF8KTdS1El6sVP/a8yeik1QmLuImAZrr47HNOKZMCTE
         C1UYpfZm87ngPPfItHclWxsBcfHM0B4si/R8HwEhdVK5Xzk4sal8pBKskFJX3jmkDER5
         QThC2E2Jtfrmb9LQiGS4r5/5qmV61LYrKAuHP8B5DmVmCxdCzL7wDiYzM33xnLSp9Wft
         Oo7BHafj2ZkpRfzDNF6y8KTZKm9WEebcgSBFBa3pHx6UYEjEGafExe/OLIRbe6M0SDak
         R16w==
X-Gm-Message-State: AC+VfDzIq+eMoz/9iigJQPHpSFh5MjKPAWXxfoNbSgQbNhqLcGCml9FP
        PNCK8WTcJGPPaH6BiGUNk0zGIywxAlGxkFbJoQ==
X-Google-Smtp-Source: ACHHUZ7wrbQNtf8LAm7N1ZKLRhbM/jqUgoFLojgUD4NsfPJp8cWkF8aIXerX0oH6O+Q38jpadAumG84IMwrUtVu07A==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a81:b1c4:0:b0:54f:17b6:f30a with SMTP
 id p187-20020a81b1c4000000b0054f17b6f30amr1524114ywh.4.1683315577740; Fri, 05
 May 2023 12:39:37 -0700 (PDT)
Date:   Fri, 05 May 2023 19:39:36 +0000
In-Reply-To: <ZEM5Zq8oo+xnApW9@google.com> (message from Sean Christopherson
 on Fri, 21 Apr 2023 18:33:26 -0700)
Mime-Version: 1.0
Message-ID: <diqz8re2ftzb.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     david@redhat.com, chao.p.peng@linux.intel.com, pbonzini@redhat.com,
        vkuznets@redhat.com, jmattson@google.com, joro@8bytes.org,
        mail@maciej.szmigiero.name, vbabka@suse.cz, vannapurve@google.com,
        yu.c.zhang@linux.intel.com, kirill.shutemov@linux.intel.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, wei.w.wang@intel.com, rppt@kernel.org,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        jarkko@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hughd@google.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBTZWFuLA0KDQpUaGFua3MgZm9yIGltcGxlbWVudGluZyB0aGlzIFBPQyENCg0KSeKAmXZl
IHN0YXJ0ZWQgcG9ydGluZyB0aGUgc2VsZnRlc3RzIChib3RoIENoYW/igJlzIGFuZCB0aG9zZSBJ
IGFkZGVkIFsxXSkuDQoNCmd1ZXN0IG1lbSBzZWVtcyB0byBjb3ZlciB0aGUgdXNlIGNhc2VzIHRo
YXQgaGF2ZSBiZWVuIGRpc2N1c3NlZCBhbmQNCnByb3Bvc2VkIHNvIGZhciwgYnV0IEkgc3RpbGwg
bmVlZCB0byBmaWd1cmUgb3V0IGhvdyBnbWVtIGNhbiB3b3JrIHdpdGgNCg0KKyBodWdldGxiZnMN
Cisgc3BlY2lmaWNhdGlvbiBvZi9zdG9yaW5nIG1lbW9yeSBwb2xpY3kgKGZvciBOVU1BIG5vZGUg
YmluZGluZ3MpDQorIG1lbW9yeSBhY2NvdW50aW5nIC0gd2UgbWF5IG5lZWQgdG8gYWNjb3VudCBm
b3IgbWVtb3J5IHVzZWQgc2VwYXJhdGVseSwNCiAgIHNvIHRoYXQgZ3Vlc3QgbWVtIHNob3dzIHVw
IHNlcGFyYXRlbHkgb24gL3Byb2MvbWVtaW5mbyBhbmQgc2ltaWxhcg0KICAgcGxhY2VzLg0KDQpP
bmUgaXNzdWUgSeKAmXZlIGZvdW5kIHNvIGZhciBpcyB0aGF0IHRoZSBwb2ludGVyIHRvIGt2bSAo
Z21lbS0+a3ZtKSBpcw0Kbm90IGNsZWFuZWQgdXAsIGFuZCBoZW5jZSBpdCBpcyBwb3NzaWJsZSB0
byBjcmFzaCB0aGUgaG9zdCBrZXJuZWwgaW4gdGhlDQpmb2xsb3dpbmcgd2F5DQoNCjEuIENyZWF0
ZSBhIEtWTSBWTQ0KMi4gQ3JlYXRlIGEgZ3Vlc3QgbWVtIGZkIG9uIHRoYXQgVk0NCjMuIENyZWF0
ZSBhIG1lbXNsb3Qgd2l0aCB0aGUgZ3Vlc3QgbWVtIGZkIChoZW5jZSBiaW5kaW5nIHRoZSBmZCB0
byB0aGUNCiAgICBWTSkNCjQuIENsb3NlL2Rlc3Ryb3kgdGhlIEtWTSBWTQ0KNS4gQ2FsbCBmYWxs
b2NhdGUoUFVOQ0hfSE9MRSkgb24gdGhlIGd1ZXN0IG1lbSBmZCwgd2hpY2ggdXNlcyBnbWVtLT5r
dm0NCiAgICB3aGVuIGl0IHRyaWVzIHRvIGRvIGludmFsaWRhdGlvbi4NCg0KSSB0aGVuIHRyaWVk
IHRvIGNsZWFuIHVwIHRoZSBnbWVtLT5rdm0gcG9pbnRlciBkdXJpbmcgdW5iaW5kaW5nIHdoZW4g
dGhlDQpLVk0gVk0gaXMgZGVzdHJveWVkLg0KDQpUaGF0IHdvcmtzLCBidXQgdGhlbiBJIHJlYWxp
emVkIHRoZXJl4oCZcyBhIHNpbXBsZXIgd2F5IHRvIHVzZSB0aGUgcG9pbnRlcg0KYWZ0ZXIgZnJl
ZWluZzoNCg0KMS4gQ3JlYXRlIGEgS1ZNIFZNDQoyLiBDcmVhdGUgYSBndWVzdCBtZW0gZmQgb24g
dGhhdCBWTQ0KMy4gQ2xvc2UvZGVzdHJveSB0aGUgS1ZNIFZNDQo0LiBDYWxsIGZhbGxvY2F0ZShQ
VU5DSF9IT0xFKSBvbiB0aGUgZ3Vlc3QgbWVtIGZkLCB3aGljaCB1c2VzIGdtZW0tPmt2bQ0KICAg
IHdoZW4gaXQgdHJpZXMgdG8gZG8gaW52YWxpZGF0aW9uLg0KDQpQZXJoYXBzIGJpbmRpbmcgc2hv
dWxkIG1lYW4gc2V0dGluZyB0aGUgZ21lbS0+a3ZtIHBvaW50ZXIgaW4gYWRkaXRpb24gdG8NCmdt
ZW0tPmJpbmRpbmdzLiBUaGlzIG1ha2VzIGJpbmRpbmcgYW5kIHVuYmluZGluZyBzeW1tZXRyaWMg
YW5kIGF2b2lkcw0KdGhlIHVzZS1hZnRlci1mcmVlcyBkZXNjcmliZWQgYWJvdmUuDQoNClRoaXMg
YWxzbyBtZWFucyB0aGF0IGNyZWF0aW5nIGEgZ3Vlc3QgbWVtIGZkIGlzIG5vIGxvbmdlciBkZXBl
bmRlbnQgb24NCnRoZSBWTS4gUGVyaGFwcyB3ZSBjYW4gbWFrZSBjcmVhdGluZyBhIGdtZW0gZmQg
YSBzeXN0ZW0gaW9jdGwgKGxpa2UNCktWTV9HRVRfQVBJX1ZFUlNJT04gYW5kIEtWTV9DUkVBVEVf
Vk0pIGluc3RlYWQgb2YgYSB2bSBpb2N0bD8NCg0KWzFdICANCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC9jb3Zlci4xNjc4OTI2MTY0LmdpdC5hY2tlcmxleXRuZ0Bnb29nbGUuY29tL1QvDQoN
CkFja2VybGV5DQo=
